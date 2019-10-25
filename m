Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B56CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:40:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E0B521D7B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IzYh7nTS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0B521D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO9CK-0003YL-9H
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 19:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO90s-00052n-2v
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:28:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO90q-0004FS-1I
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:28:57 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10430)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO90o-0004CY-81; Fri, 25 Oct 2019 19:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572046134; x=1603582134;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RkqRFiZ2NZ94NDWMXf9YRLVxbO3l93rbLZrfnFMYQQ4=;
 b=IzYh7nTSW4uwgAgjcJb6j79kxfL0Z3D1tsUE6arOEAfY654Iihy12pIJ
 EPvRaUFRwe2RiAnNFqhSFpRn2VD0//4NJfabRZwJQslir88/23Svzk1DF
 X0Sl5WhsTSH50YuljgtcbeWg70VIw0/BCLYu9yDFYrVCVvfCOsvr7Hi5v
 C+QMeUH9yq5kvllIa/RKO0noA6jDRtcTUUfQA/lxjH3epmdiTgU4IAmEE
 jtyZj8nx3BdWqDtjDdamZ2ZrOaC/9iKEA9+0qHVXWmpRuoMCbXMRCK8ld
 f1cTrYGH1hZ0rrrcj8nATNh+MvYrPnR53Nrn5Wy3J+QbrifM7EqxfIx1n A==;
IronPort-SDR: 7OITCTKhPB+eeox5FRRIAT3iSSETKcJ/MbO6LrA2qUBhM8nyn7igmQa06IaznKzC4QmKBZTqEs
 kIy3gvt6/yLA/WQTgDvcdOVbWE2vBewy2UQKonybddoccL3dJ/IQD+pX//hP4yybZ7RH7G/K7Y
 2irjkPEU2/liktvMJY74fbHiYhCLEy86Zk5iWx2XcikR6wQRm6EtYT4sCPYd1jSf5jgN6SXRG6
 mNq3XvLWmMS8/S8zMTUuNb4078D1Z/FM2GgGkBhNgB8xzsOXCpbq5IeGgsmWFqZLGZzGDbaN9f
 ugs=
X-IronPort-AV: E=Sophos;i="5.68,230,1569254400"; d="scan'208";a="228520397"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2019 07:28:27 +0800
IronPort-SDR: BE4aCwb0A02r8vLrXfGa2mv6HGM0AxMPoP7BFcaEGeHD7tqEmDFQ5Lo3pp2573p4BF+gByPDgk
 eZ9WSYz2I274qkf3yfbRWdUQk9PGnNpiMl8gfC7ioooznZn2j78UaMZ9IkF3xD/LG7erXMsxam
 TQFM14NrEJwO7MbamX9MKU4noQWvjIAKwAhU+2LtE4s6o+ZRxa1twAWRyIAAsMOt1+3wj3MgNJ
 oJVo+kdmZsz32kqUTzT0WonxjQGUU83EOk3DCAOXCmmEBphKK/j/Sx6DX8q5KyFiytXD09Gc4n
 Sish1G6Pf0KciT8+Krhy0slP
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 16:23:53 -0700
IronPort-SDR: sz4g0rjbkX9cJUSbBEqhtQnYHpFFc7+5SJAqxoNRqk/Tt3QBIK7lGt8moreL0GukvY9qVMWi/e
 YRoLbdPSlX12tmtkB7FelPgM8U1unWXk4OstvpE/skcpCiYNQlWu3xuaDjp0QtD6bO7G3CNVnf
 NMk+KVx6F9MiKzrcLwKXzwJ09efllTPs/ImD8D/zx/8GtcI9pxpFbif7sEvZcfjgFeDHMAGXQA
 IBfclXDXNRYR9N2feQZoALDWB4R07i5DMRlcv9r/yRt1SOzQfSheMV52ltKJb6PYamJohTWq7l
 TPI=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 25 Oct 2019 16:28:28 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 07/27] target/riscv: Print priv and virt in disas log
Date: Fri, 25 Oct 2019 16:23:32 -0700
Message-Id: <5de7c9ef581760a5e77bb0e66109837d215ffff9.1572045716.git.alistair.francis@wdc.com>
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/translate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index adeddb85f6..8ac72c6470 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -810,7 +810,15 @@ static void riscv_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
 
 static void riscv_tr_disas_log(const DisasContextBase *dcbase, CPUState *cpu)
 {
+#ifndef CONFIG_USER_ONLY
+    RISCVCPU *rvcpu = RISCV_CPU(cpu);
+    CPURISCVState *env = &rvcpu->env;
+#endif
+
     qemu_log("IN: %s\n", lookup_symbol(dcbase->pc_first));
+#ifndef CONFIG_USER_ONLY
+    qemu_log("Priv: "TARGET_FMT_ld"; Virt: "TARGET_FMT_ld"\n", env->priv, env->virt);
+#endif
     log_target_disas(cpu, dcbase->pc_first, dcbase->tb->size);
 }
 
-- 
2.23.0


