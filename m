Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C332C33CB7
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:10:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 172722063A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="j66htQbc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 172722063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixhIQ-0003ff-7C
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 20:10:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhH7-0001IU-VB
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:08:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhH6-0006FI-OZ
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:08:41 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17129)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhH5-00069K-Ca; Fri, 31 Jan 2020 20:08:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580519319; x=1612055319;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qGd7qT32AdFg6ETX1x7TTJd0eMuZuc3r+atPCoHmT2M=;
 b=j66htQbcJl9HIAcQYzpKWF8Y5+gEFgWtr8hE1SK126SURVTxR32zyDFD
 RCz1O+tBBE3uf6rEDPNRw7W5ssi8T4JL5ufWA5jfv7Uxq0uZGXD16hidg
 YUlACg6AA67/rXV1ft5f2t3dOldiAAPlQkbfQ6g2t3U+jnYEJHeuuoEuu
 u8AVXTTBIuGy/7BnZP6bChBD/AHhNF2s50jSFSH/+Pb8dmKlpNYBlxE+n
 EQHvz7OIZPXIGA6PhpC0rFmvaeZ2jlSUut6n6NRr/8F4n3k+CNa2EXLRp
 raX8pBd20+k4SWR7N72cecrr2nR9Q+a7Iw56uZqFpl1F66R8W/4pqUD1C w==;
IronPort-SDR: E+iN05315r6ly9k+DKPEh6aiEH0GICIRXyDeXQTf+kzCQy48JAetr2G0CIvAYn8mxn997Y8n48
 dkA8Gd1aCN/RrZahGk4C40Q208tFu5XndPnwccxu92z79sWJ+Dt7lgRfaD55xFpTqDythf4OMc
 pCmZp8+TnBEFLxB3W0O7vyIVetm1w3zn0kdlSyHtf0pDnJKbBQK/5cDiv/vr/79rjl86ZXfzxJ
 A1DLCv/VxbR7ivLlvnFjdQlfS8jONTro9/tVscJsCpx0JIKMsh3x57PALgO3K+H/BwiDUU2QId
 Spc=
X-IronPort-AV: E=Sophos;i="5.70,388,1574092800"; d="scan'208";a="128872431"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2020 09:08:38 +0800
IronPort-SDR: c0FrkWSiy4ljiqR8ciIo0OqqpBQrSA03qB8gEqywKDVPae6XUYBLjSyBDSJQ2SQhVPv7VU0X5J
 Xm5Sw78nQ+nDUacwTZJZ20LCUQmCgOFZX3ckOltnACwL51nz7c8q+CLP5ncmOzBtu81sYQYG8P
 yzz2VmfGqJUPwR6yyrft06u8Q04xQwZlSfVgiTc4QDwlEkSugc6QFB0Fk8ADix4K8gtIbYkM5D
 hTHyM3C+u29x8Ih/zX3C8xqijQIkz8d6/VzMHDGSQcAsFNJupdF40kNvqcpiKNm5uyzZsvEbrH
 iPFfrn4Uw5c1JoM+p1rvG7Fp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 17:01:47 -0800
IronPort-SDR: s043P9oOK3GOrB3H9HXgBrlaOg82m1YxLkCMDnjuyojzU6iFeVK5Rm7B6x1fkK1nYRCKqXDqtf
 N9BqhRaE4g6J7vru9ksxtHHVcHAaegRiVzGmXqE/TG4ZWdwvfNQOCsW9lQS6IBWKiLKLex8Sz3
 L21qjVKpQ2MoFhfcVzz5OGPDl+WwRafp3J/VskgJT9uuQN1nsFWtGrjhkNz4Zoko02vLSaqpHE
 y9kTGMmGt7RBwSJXYbFMdrQSccNoX3y7zLOovcoTX6h32orAR4/r/ZvViJRwsy33nyTUfy4y3i
 s/0=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Jan 2020 17:08:39 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 10/35] target/riscv: Dump Hypervisor registers if enabled
Date: Fri, 31 Jan 2020 17:02:02 -0800
Message-Id: <2549ce7b2a2646780b23200e11b4c072608e1ce0.1580518859.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580518859.git.alistair.francis@wdc.com>
References: <cover.1580518859.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.42
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Dump the Hypervisor registers and the current Hypervisor state.

While we are editing this code let's also dump stvec and scause.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f7a35c74c2..44ad768a84 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -228,17 +228,50 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
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
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vsstatus ", env->vsstatus);
+    }
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mip     ", env->mip);
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mie     ", env->mie);
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
+    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mtval ", env->mtval);
+    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "stval ", env->sbadaddr);
+    if (riscv_has_ext(env, RVH)) {
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "htval ", env->htval);
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mtval2 ", env->mtval2);
+    }
 #endif
 
     for (i = 0; i < 32; i++) {
-- 
2.25.0


