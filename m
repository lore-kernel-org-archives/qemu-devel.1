Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9608C33CB7
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:13:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B83C2063A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="P1t6gI6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B83C2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixhME-0001O8-OM
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 20:13:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhGy-0000uZ-SG
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:08:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhGx-0006BL-NW
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:08:32 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17129)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhGx-00069K-Ek; Fri, 31 Jan 2020 20:08:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580519311; x=1612055311;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=S5ikj43BW09W7DpWY91HdhEmZ2Szq/7wkspRnDe8aKg=;
 b=P1t6gI6/ntKlAlf1cTecKc3GFyq4nrIZsjoErDAFkd6AJIUdjbocElVh
 U+Bt4q7yk2UkMJ0VzzBhzUvH60vb9hm0lE/wid8A7OlP4bd1b6U1PaHkj
 1pSqHHbQbE/rtwXcanyHwxFOxuwytxagykVx6gTleeUKdxd5Z/YlaIdKb
 iVmIcrUpeuQC/X1W3kw1GJOutGQRPGEJan4FkGi3y5NJYyGaMGHwHqQOX
 IWLz7NnwPu38OhvwN2DuzICNivtMYVjrhIKhy6pEWncy0N4HDRPrJj0Fw
 hvUv3vfBVpnmV07nV6oTfSXGZK8hsos3AkZNNbDBTjiwkaCwxkaKTjdOF A==;
IronPort-SDR: 1+iZG5YcJB2GsKBow70vEOihcCmyi3h7lc4BtFLPE65r8Fz9HCPGg+uDQyLZgpbdr4LeR0IFJa
 llBhacrBLyErhHhiOfne49ELFRyO1r1ckboAYG/uNMOH8ZYJbq6IHRxkgSFWvi9U7KoNo6nfWd
 E4LyHB1HLiMvn5EiZgaBL8A4n0xaPUZRGlc+UNYwL5d/RLdTVWacboghTlJQDNhNF23IcrnJAn
 buZVg2Lr6+nHbkVY4g1uWOIcygWa6w6Svwkq/QRU5UHzz3EdMA7qGQJLdcUPFyaqTI9+g47Riw
 xZ0=
X-IronPort-AV: E=Sophos;i="5.70,388,1574092800"; d="scan'208";a="128872410"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2020 09:08:30 +0800
IronPort-SDR: 86F3ub2aInJaH7mA/oCkW8HHixJhcvuagzydjN/1oFXOlkxEJivFUuLRNhtpXU1LpkNVTB8f5l
 94mlfh77y5ftqgSMrA5LO/HKKhInz/JCfGhXm9IwhmbxsyntU3xJvU7JU13Kj033ZV9K1b7awX
 Yyh3HC7lwfr2jr8NU/8W2MhJPuelESLdmrlAdWssvaj5ehE1kVsDKYUFNI+rxvHScph9R5mfXg
 QD2TRA7ytSgVyv0YSIVMFSRirYJYtNlx0jvE+a87RTkEh5m7OX/IN86ekNmHbgzVnI9nVc0Mds
 WvfvlQ1GeCIlZ97uNh4ClmzE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 17:01:39 -0800
IronPort-SDR: NDA60NNVOTYqjShnHlAStl+fjUFnXwfBfhE/VLx8JLrMwhVAYEdoJZ+6hO1Sou7GgEQ/X1i2lE
 AYKiMxTZdcDAO8ePr55Fy1RI1eqxb59aI18eMr7OTiSBGikSFPKPAjYDTJw090tjwh+TN4rzLA
 7Xx89rvFtALnD7/uxehuAK25ltce9CMyS41kb0DlLB4TJka/BD0f+DSAVNoigFx0Pw8XcUuL7Y
 FE2Dk9VUKkxEuqD3N9j3u2AvAkNn4ThinE04yk7HWRoVllRBLjvTSnXTJ6FSeQw60wRPKm//GV
 f2k=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Jan 2020 17:08:31 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 07/35] target/riscv: Add the force HS exception mode
Date: Fri, 31 Jan 2020 17:01:54 -0800
Message-Id: <aa605609b28f811897f61d9b6a48f2ad6e396f0f.1580518859.git.alistair.francis@wdc.com>
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

Add a FORCE_HS_EXCEP mode to the RISC-V virtulisation status. This bit
specifies if an exeption should be taken to HS mode no matter the
current delegation status. This is used when an exeption must be taken
to HS mode, such as when handling interrupts.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  2 ++
 target/riscv/cpu_bits.h   |  6 ++++++
 target/riscv/cpu_helper.c | 18 ++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a9cbd8584e..42720d65f9 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -273,6 +273,8 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
 bool riscv_cpu_virt_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
+bool riscv_cpu_force_hs_excep_enabled(CPURISCVState *env);
+void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable);
 int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
 hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 2cdb0de4fe..ad6479796c 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -432,6 +432,12 @@
 
 /* Virtulisation Register Fields */
 #define VIRT_ONOFF          1
+/* This is used to save state for when we take an exception. If this is set
+ * that means that we want to force a HS level exception (no matter what the
+ * delegation is set to). This will occur for things such as a second level
+ * page table fault.
+ */
+#define FORCE_HS_EXCEP      2
 
 /* RV32 satp CSR field masks */
 #define SATP32_MODE         0x80000000
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 5844e543f3..1e28103500 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -100,6 +100,24 @@ void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable)
     env->virt = set_field(env->virt, VIRT_ONOFF, enable);
 }
 
+bool riscv_cpu_force_hs_excep_enabled(CPURISCVState *env)
+{
+    if (!riscv_has_ext(env, RVH)) {
+        return false;
+    }
+
+    return get_field(env->virt, FORCE_HS_EXCEP);
+}
+
+void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable)
+{
+    if (!riscv_has_ext(env, RVH)) {
+        return;
+    }
+
+    env->virt = set_field(env->virt, FORCE_HS_EXCEP, enable);
+}
+
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
 {
     CPURISCVState *env = &cpu->env;
-- 
2.25.0


