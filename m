Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD587CA9EA0
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 00:45:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AFCA206DD
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 00:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="blkT/juY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AFCA206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOAD7-0001eM-Pq
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 20:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91J-0005Pc-1E
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91H-0004ew-Sk
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:29:24 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10433)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91H-0004DA-KW; Fri, 25 Oct 2019 19:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572046163; x=1603582163;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=e9FTCNGQSn8ALTPBkAOnbHvxJhruS8S5utjWhbO6qDU=;
 b=blkT/juYA/X8TcY1lKBHAJ4irv6lKecHd3k0AG7r1jsWnL6039VL94Mo
 FMKpzHOlzUlbco1vIpot86c1BlllEtQp7aa0UGZu32ZPVHUA+w7a5sM8F
 LLiD36xeTf+12JdxpZCqB67GnOAAxmsE9G94Wf9ktnW5ZyCNNThhAESSb
 eSDIhLhpigRgyoIMqzUNd5eLTYvZCliKFzq5Q/MNfv3zKj11bD522e9an
 x+6srmaehISCBL8SBFLJtuembdLThfo5h7UJrmTKRjRwTDAkO/65l4fhH
 nJlXqwcOisKT6kIft4fial4zZLPpa3RQICKrvOxyhTNoab843Gx/iUJJo Q==;
IronPort-SDR: 0Q4jLSwwYfEMXBLi8aECAmEp5eTtwoFE+YKWgN+8pGMUbeCOO1WDJhZf7YgrGdrJklBAkXuDLU
 H2AelZN/89QpaSyYEO1BXsNBQeRicjKYAwVoMwiq5vkT1M/f2oH7gnNh5odGC0wL/wTYG997pq
 iAUVAlxTW2rl76xWjWoO3h/iYKT3fgiP5E2Y1hcLzIyFT5j+KyVJyGZqwTpyiRYRZWWu+9K4dw
 Df0y4q1zqZfBgPKV5TOd4RDJzNyKUOFH8JiOB9jUQ946Z1rrsS10PcU+YgKo0XA/Bqj0e9QvjD
 jaA=
X-IronPort-AV: E=Sophos;i="5.68,230,1569254400"; d="scan'208";a="228520411"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2019 07:28:52 +0800
IronPort-SDR: Pcs272boPlS0gSwFJGCPnxgLfCFnjb7RyZ0rZwbZvzAxUTgyG7d45u2KvRSEQJFF8j+2urUZCt
 eETcESD7chnDGcoKGrOkVI7lAG0jVE4nZcMeyXa+d5oGWWoXMEKhwaIL4eOv1q4ivgVFzJM/9T
 hA8iwCt7CfIIPhjVYXLLYaZutXVrTbxCz27jLJOGmYTIS53gum8tRB2u+4yTuIW2WsNsWnn5DL
 mqSRZ6nAGpZtDTqGjBfBIgdU7wpXKpnpvEq+KEwCXtFBVVE4ah6l0b5XC0Ea6eXJDrHesoaq6p
 p+E8IyuDfxaEx804JpJn5Pp3
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 16:24:18 -0700
IronPort-SDR: RQsPsSTzEvp3GKqnNarXX8/O6qsYOqM3++Qe/3A5AO3jq5SFNsJ5zOQ883h3LAj/lFm5LjyE0u
 F+24shIJdPmhkC57E6BmqkByiaOlCX/6jcvGh3HfmGWNg+omLgckXZaHaoFoGBR9pger5xC/V+
 jVTI9utenYgUzApwMaA2pAicXi3EziU6rzbHf6eqbilhhcaJHBk6w6Dd7KPDiYM3FMDIFj0iHt
 ZJWZY6Vp4akv+pfVduo8lzTrZbTJc/6vifkeHMSw7wWYmlTkCMjHh1jrUkeMksHDE3R5dKM0t1
 wtk=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 25 Oct 2019 16:28:53 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 14/27] target/ricsv: Flush the TLB on virtulisation mode
 changes
Date: Fri, 25 Oct 2019 16:23:57 -0700
Message-Id: <ad856f89f6f0be30be0eb28560eb85f1970e6756.1572045716.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572045716.git.alistair.francis@wdc.com>
References: <cover.1572045716.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.141.245
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To ensure our TLB isn't out-of-date we flush it on all virt mode
changes. Unlike priv mode this isn't saved in the mmu_idx as all
guests share V=1. The easiest option is just to flush on all changes.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index bb4557df16..637e05996a 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -200,6 +200,11 @@ void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable)
         return;
     }
 
+    /* Flush the TLB on all virt mode changes. */
+    if (get_field(env->virt, VIRT_ONOFF) != enable) {
+        tlb_flush(env_cpu(env));
+    }
+
     env->virt = set_field(env->virt, VIRT_ONOFF, enable);
 }
 
-- 
2.23.0


