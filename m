Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABDAC282E1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:11:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1566020862
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NQ5B0mwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1566020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33606 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUKHi-0001GE-8o
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 20:11:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUK42-0005Im-R8
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJut-0004SM-1T
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:48:03 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:23091)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJus-0004RV-P7; Fri, 24 May 2019 19:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1558741737; x=1590277737;
	h=from:to:cc:subject:date:message-id:in-reply-to:
	references:mime-version:content-transfer-encoding;
	bh=FOZ5qxSOFi83IoijU4WlSRPh1QAki9KyRu0FsUUmoos=;
	b=NQ5B0mwQpHh+WGXQciUMbwCjg5w9/m6V0Wfek4HuYZDTfyZJiZQ2SmPC
	kZos4ltGw4mPKJl5Lq5GbSqGQHEvHDfOZFSc3d0OMgDHB3LYrwhujjszA
	DX3v8nhQUQ8gx5tVjPEBLnvp4hco+3WInIYo6lhHbaTrwEGv5J/xx1FnY
	6Q5BliIWWg6sTfryDSClrlYP1lpljfFG3b6WDGon/MhxkHY5kJd1Re/7D
	fewgW7JF6szP18m7ypsKlfUpG9I7yn1IWffX7VsrsLz/uBT9Dxk3kPHlJ
	qL2RivKoXIHBc/b7684Wz+aXXWNFtzrgeDHngHhS1gwVgIQpVghL+yS1k g==;
X-IronPort-AV: E=Sophos;i="5.60,508,1549900800"; d="scan'208";a="208574746"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
	([199.255.45.14])
	by ob1.hgst.iphmx.com with ESMTP; 25 May 2019 07:48:55 +0800
IronPort-SDR: 0nrW5Y8716OjCMK6bwuQuFYuJ/TZWIiCiR1686wrdJEBUWRoFfzvMf5nDz1JQ4QTjGPeR/FYg5
	l46gp9s93oDUZHEL5vjtCoOm/JqDwrru2qp99+t6CWh3FPiuYAFdp42BPL1wsq49ev8MvXFPCV
	JaPtQ0SuEbvi8+8i3hMwAKIyd7ebOHV+5Rpcrw3ost6/3/nypAjDVmKCy9LNhDKbjOubPRVFfN
	a7JWuboKkSMkI8A6oKljepBnI0Hr4oQpFe0GKFl5XpPLPoRcjLvZuohQzzsU2wCsxydAXtfR5j
	styanpQSWuWkH9sdsPQ07+u3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
	by uls-op-cesaep01.wdc.com with ESMTP; 24 May 2019 16:23:20 -0700
IronPort-SDR: H5y4FZT1AzMPJPTFs9NlXdoKraJXWK/8i9bCQRqmqpDKaUU9pSBUzY4bEVHjk7pRbyTFUxq39c
	FNu2u7VOj7fC81GdA9Qu1JhUBwkOajDqsg9+iD2rYFqC9a4/zUAZaPakXEEiH6b5KcUqcA8KYL
	cJy8uw566pKtnEzyLQ1buXAO8qiDXTdkrXx4aMqDFCknhkte47x1yu4Kl3HzEzHVHHepH7DLfP
	MykRPGVUoz1sQvQST2EawB/SEWuEOR7Geayou3QEXJarZSeB+QyBmQldCfmiQHqjKBJoe+/izE
	40Q=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
	risc6-mainframe.int.fusionio.com) ([10.196.157.140])
	by uls-op-cesaip02.wdc.com with ESMTP; 24 May 2019 16:48:01 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 24 May 2019 16:46:06 -0700
Message-Id: <8f3c0035f813d1294c77aa58238853274f631feb.1558741334.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558741334.git.alistair.francis@wdc.com>
References: <cover.1558741334.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 68.232.143.124
Subject: [Qemu-devel] [RFC v1 12/23] target/ricsv: Flush the TLB on
 virtulisation mode changes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
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
---
 target/riscv/cpu_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 0128546e6a..81f1cc83e5 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -157,6 +157,11 @@ void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable)
         return;
     }
 
+    /* Flush the TLB on all virt mode changes. */
+    if (((env->virt & VIRT_MODE_MASK) >> VIRT_MODE_SHIFT) != enable) {
+        tlb_flush(CPU(riscv_env_get_cpu(env)));
+    }
+
     env->virt &= ~VIRT_MODE_MASK;
     env->virt |= enable << VIRT_MODE_SHIFT;
 }
-- 
2.21.0


