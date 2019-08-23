Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E5CC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 23:55:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9BB120674
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 23:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C2FjOohc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BB120674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1JPN-00063I-BP
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 19:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JBp-0000fL-Ez
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:41:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JBn-00005d-EX
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:41:52 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50262)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JBl-0008WT-KQ; Fri, 23 Aug 2019 19:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566603740; x=1598139740;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RC1jpnfKpSPVNtO61GtMXn3UdcU0g2g0oxsZ5KiVCFQ=;
 b=C2FjOohcqTGRxr+9yquB62rW9/1OdrMdArOrmuSHPt58b4sG2JKiV41E
 qcwU2g8iBe7PooeJ3W3BlQ+sREVlOAM1+PGYXpL6Ymivozy6TgQ3CzcT5
 aoWInbMcdKNjoNvZ5bNysEzyvSwoj3BRpAFo7IwkXQSbe1vt1eMdkSw+o
 7nUa8bELS+a8+z7pyCh63opUPMs/WiTGCXYcdAjfQiF6D0pXU0cBqEmG8
 qNzqyk5g24lKUcF7IwQb8/SaI9G29Dn52A+r3EHhmILfHHI3DvFMImlSN
 aHeg0+t4VCEVH/6HM+C9qsTweMazCvpm4znnxTkhiOkTmUNG3UKZkpbw+ Q==;
IronPort-SDR: frVhyGMooABk6e2sKx7Qz7M40fEttSfkybV/LLyHMZqaj9870zDiItgkEmQLUVCWcPvREXQNT8
 loJHnPpgjfPQD/tW+4sKlDIOsMKZb7Ei9m4VF36FS1kizdiY6GrfG+GYZZ9JE74rxaXv1N2Szk
 pt4LhnddCyTvTqYMHv8VPAPVtmUHuE4Rh0y664JEwl9BZBX/waFut8fFXZIpUnasX+q+RUq3FW
 HGYC+doES2iu0NzhIm6D4twEvuT11PRgXVdeFkB7da+B4eqdJUxM/vjyo/JanMCh9mkmAO9/Rn
 IJg=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="217013889"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 07:42:18 +0800
IronPort-SDR: cU8l17LKy+3mhYy9lw06rUW0SzFegpWghGInp8pAadSzQSsU6WKbusj4rzxwC790ccapKFCXLO
 ay78r0FYh6RoESprE7kwX+Vs+SwcG8W3UYiihJsgnY0ZTEhgvugxu8qQUscJ8p9/qy/WzOSFV1
 Z+lDsdGZs4fq/uZe3rxFfAxZB+zoPikcMst88m/ZoTuyKsxhxTM9g7WLU5bMNsoSL2jX+1d0HS
 NkXH4yhDjvNYO66Wjon2b5hJBB9LGOFS9wHW2LUbYuHVn3SZ2wZEoCJR73/4vej+3OFzE3Q7bH
 +uGDyL223h28k1BFY+9iO3sC
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 16:39:05 -0700
IronPort-SDR: 3BQzKctzxbEg58BNiFyS/6JjbxPeI4mZBAm1PF6bLi4swOeD3FBLCXqALStNUancfwVpvCuhv9
 UoyRGa/ELAs4LI/GLlzol/D9styOIgmd9Dn/IK92s6lCgbc5TtqQdx2zrILmEkdsApvzUdQ2WE
 WtNif1bankygh7bHXmYPKHwDl2Vd/XoQFcOv8l4A1yDFSdm2+T8Z9DrVgdMZ6yxPPhi8LC7/Ks
 c5E2/Uee96WEXTbuMsC7VllRxGkNtMbvCwUQrBekLlScEl4uyAlJTu3wg06TtkMCY+cKG2Hm9d
 Cyc=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 23 Aug 2019 16:41:49 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 23 Aug 2019 16:38:07 -0700
Message-Id: <47e7fd90ce1d2373824799274376b29d751d56c3.1566603412.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566603412.git.alistair.francis@wdc.com>
References: <cover.1566603412.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.143.124
Subject: [Qemu-devel] [PATCH v1 07/28] target/riscv: Dump Hypervisor
 registers if enabled
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
Cc: alistair23@gmail.com, Anup.Patel@wdc.com, palmer@sifive.com,
 alistair.francis@wdc.com, Atish.Patra@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Dump the Hypervisor registers and the current Hypervisor state.

While we are editing this code let's also dump stvec and scause.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 target/riscv/cpu.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f13e298a36..be8f643fc2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -220,18 +220,52 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     CPURISCVState *env = &cpu->env;
     int i;
 
+#if !defined(CONFIG_USER_ONLY)
+    if (riscv_has_ext(env, RVH)) {
+        qemu_fprintf(f, " %s %d\n", "V      =  ", riscv_cpu_virt_enabled(env));
+    }
+#endif
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "pc      ", env->pc);
 #ifndef CONFIG_USER_ONLY
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mhartid);
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", env->mstatus);
+    if (riscv_has_ext(env, RVH)) {
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "hstatus ", env->hstatus);
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "bstatus ", env->vsstatus);
+    }
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mip     ",
                  (target_ulong)atomic_read(&env->mip));
+    if (riscv_has_ext(env, RVH)) {
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vsip    ",
+                     (target_ulong)atomic_read(&env->vsip));
+    }
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mie     ", env->mie);
+    if (riscv_has_ext(env, RVH)) {
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vsie    ", env->vsie);
+    }
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mideleg ", env->mideleg);
+    if (riscv_has_ext(env, RVH)) {
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "hideleg ", env->hideleg);
+    }
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "medeleg ", env->medeleg);
+    if (riscv_has_ext(env, RVH)) {
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "hedeleg ", env->hedeleg);
+    }
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mtvec   ", env->mtvec);
+    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "stvec   ", env->stvec);
+    if (riscv_has_ext(env, RVH)) {
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vstvec  ", env->vstvec);
+    }
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mepc    ", env->mepc);
+    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "sepc    ", env->sepc);
+    if (riscv_has_ext(env, RVH)) {
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vsepc   ", env->vsepc);
+    }
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mcause  ", env->mcause);
+    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "scause  ", env->scause);
+    if (riscv_has_ext(env, RVH)) {
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vscause ", env->vscause);
+    }
 #endif
 
     for (i = 0; i < 32; i++) {
-- 
2.22.0


