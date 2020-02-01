Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521DAC33CB7
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:29:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1800220663
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nOi/OGmH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1800220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixhar-00060w-Aq
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 20:29:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhJL-0005Zs-8B
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:11:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhJJ-0007On-Tc
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:10:59 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17129)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhJJ-00069K-6J; Fri, 31 Jan 2020 20:10:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580519457; x=1612055457;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KihjmNypTqRbDxvCtwnJEd0PLe0kA4hGw8Vblzk/wkU=;
 b=nOi/OGmH/eBtpDS3ZZXwU9twCPjWb4KuktsNoGc5Xwmf51ie3XKBuK0Z
 Djk8jYJwXYT4fNqTlCHkJXf4OG7l5WHBO1lDt7rsiBtvbGWYKw/fojTgr
 tK9Ffa2Gv75c8mEPdOCGL1IyPS+4dO8QkeNT8bxoinwvRIsknQLYBcE96
 4ZT35ZwntSFJhnIi/cEEQScKaXb5u94aqr7R5JOFTlIJcpHvYwNsl5CEk
 41l5RqhEJLhHW/lQxUM4eMYl+CS3FkfQrisw64ikHQmYSebHChOc0osrA
 tfUNv67zq7yiZ96LHZ/PvQNXIlEwYMrQOjTtJGj1/8z4/0SnEtNHCad/I g==;
IronPort-SDR: CnmQIbiJA4ahJatfelfvhTgdK8UUC74bbzZakO7enj8sO2/T+rXI77Wj4wE5ZEccVc9t+rbIPH
 yZ7FMhhFY/stqcn/GiowlLFLgP1e3G0gGmI+IlhOdOx1YPVgG9tsYIPflvjYU3BJ67CwqzyKg5
 ewz/ZjGgfIAk4t/p3ue0meEAsPepRjlys7RgLiQg2IpCASD05zgtGByJjlugrncZalIohPYfVC
 6fLrryLYn/owShUFVvhcYoHrzLDDm+p8Wb9nEn61DDOmESFuskDEgktzxD2WmERIX+4lPNUTyG
 wow=
X-IronPort-AV: E=Sophos;i="5.70,388,1574092800"; d="scan'208";a="128872501"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2020 09:09:42 +0800
IronPort-SDR: L5tn5dnUClc696b/mjwe6HVgXuDYecLhVNL+7mWFcY1xg4or09F24maMz+pSBMqhPKv25RFDQh
 WPRz6tXUFXjATXYUWD6pn5QyQP7THG5BWEyfYHaDiL5s12FAS6PnLPStpXzuKbdSsgsuusJ+pZ
 BDlAFuUBHiiD35gWo84HIIiYngmi59UReIHhlxT83/11U1Tm7mbJwFTRwwZJoOp41Y4AMKdxeV
 SzcX1fZYxtECZRE2vBSfIMc3nyRmCtywPZwBNatyzK4x/o21rqz+FBSBMqGctJYXOMswEl2OLL
 k6p58TLWlKAipXgpEYhoGPxc
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 17:02:50 -0800
IronPort-SDR: SSJlByHisbyhyQve6MkhUpiCzuHZO4//AaihwDmp20h4NkAKyfWS8/1oNDDLq7YSubR6B4DLgj
 Qwys1DPGArZQUlXDslkZqIaxWzGqsOIk/jh1ThDeKoVC5up6t77MczNX88pV/m962xdwLSVuwD
 rI8CZCCQLNRD0r6nmf0ahN8wHiqF/hVvOthXOlGVy/yWBkKYRZ4umvd3eJ12axClrus+R4Em0d
 9zjCJxfM2ZMVaDMPxE3Q7Vl85WaWUbRw+PGwsUV4RSSL3GstGS1c1jfweeqQbvLIMiliHauqGa
 bg0=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 31 Jan 2020 17:09:42 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 33/35] target/riscv: Add support for the 32-bit MSTATUSH CSR
Date: Fri, 31 Jan 2020 17:03:05 -0800
Message-Id: <b1650e8b542ebea1cf949dc2a66a4cfb46a2f49d.1580518859.git.alistair.francis@wdc.com>
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c        |  3 +++
 target/riscv/cpu.h        | 10 ++++++++++
 target/riscv/cpu_bits.h   |  3 +++
 target/riscv/cpu_helper.c | 17 +++++++++++++++++
 target/riscv/csr.c        | 25 +++++++++++++++++++++++++
 target/riscv/op_helper.c  |  4 ++++
 6 files changed, 62 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 44ad768a84..b27066f6a7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -237,6 +237,9 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #ifndef CONFIG_USER_ONLY
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mhartid);
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", env->mstatus);
+#ifdef TARGET_RISCV32
+    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatush ", env->mstatush);
+#endif
     if (riscv_has_ext(env, RVH)) {
         qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "hstatus ", env->hstatus);
         qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vsstatus ", env->vsstatus);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a8534fdf2b..6f9c29322a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -127,6 +127,10 @@ struct CPURISCVState {
 
     target_ulong mip;
 
+#ifdef TARGET_RISCV32
+    target_ulong mstatush;
+#endif
+
     uint32_t miclaim;
 
     target_ulong mie;
@@ -164,6 +168,9 @@ struct CPURISCVState {
     target_ulong vscause;
     target_ulong vstval;
     target_ulong vsatp;
+#ifdef TARGET_RISCV32
+    target_ulong vsstatush;
+#endif
 
     target_ulong mtval2;
     target_ulong mtinst;
@@ -176,6 +183,9 @@ struct CPURISCVState {
     target_ulong stval_hs;
     target_ulong satp_hs;
     target_ulong mstatus_hs;
+#ifdef TARGET_RISCV32
+    target_ulong mstatush_hs;
+#endif
 
     target_ulong scounteren;
     target_ulong mcounteren;
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index a24654d137..049032f2ae 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -135,6 +135,9 @@
 #define CSR_MTVEC           0x305
 #define CSR_MCOUNTEREN      0x306
 
+/* 32-bit only */
+#define CSR_MSTATUSH        0x310
+
 /* Legacy Counter Setup (priv v1.9.1) */
 /* Update to #define CSR_MCOUNTINHIBIT 0x320 for 1.11.0 */
 #define CSR_MUCOUNTEREN     0x320
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 10786a077b..e04545adf7 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -126,6 +126,11 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
         env->mstatus &= ~mstatus_mask;
         env->mstatus |= env->mstatus_hs;
 
+#if defined(TARGET_RISCV32)
+        env->vsstatush = env->mstatush;
+        env->mstatush |= env->mstatush_hs;
+#endif
+
         env->vstvec = env->stvec;
         env->stvec = env->stvec_hs;
 
@@ -149,6 +154,11 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
         env->mstatus &= ~mstatus_mask;
         env->mstatus |= env->vsstatus;
 
+#if defined(TARGET_RISCV32)
+        env->mstatush_hs = env->mstatush;
+        env->mstatush |= env->vsstatush;
+#endif
+
         env->stvec_hs = env->stvec;
         env->stvec = env->vstvec;
 
@@ -937,10 +947,17 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             if (riscv_cpu_virt_enabled(env)) {
                 riscv_cpu_swap_hypervisor_regs(env);
             }
+#ifdef TARGET_RISCV32
+            env->mstatush = set_field(env->mstatush, MSTATUS_MPV,
+                                       riscv_cpu_virt_enabled(env));
+            env->mstatush = set_field(env->mstatush, MSTATUS_MTL,
+                                       riscv_cpu_force_hs_excep_enabled(env));
+#else
             env->mstatus = set_field(env->mstatus, MSTATUS_MPV,
                                       riscv_cpu_virt_enabled(env));
             env->mstatus = set_field(env->mstatus, MSTATUS_MTL,
                                       riscv_cpu_force_hs_excep_enabled(env));
+#endif
 
             mtval2 = env->guest_phys_fault_addr;
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 2e6700bbeb..572a478e8c 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -371,6 +371,27 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
     return 0;
 }
 
+#ifdef TARGET_RISCV32
+static int read_mstatush(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->mstatush;
+    return 0;
+}
+
+static int write_mstatush(CPURISCVState *env, int csrno, target_ulong val)
+{
+    if ((val ^ env->mstatush) & (MSTATUS_MPV)) {
+        tlb_flush(env_cpu(env));
+    }
+
+    val &= MSTATUS_MPV | MSTATUS_MTL;
+
+    env->mstatush = val;
+
+    return 0;
+}
+#endif
+
 static int read_misa(CPURISCVState *env, int csrno, target_ulong *val)
 {
     *val = env->misa;
@@ -1214,6 +1235,10 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_MTVEC] =               { any,  read_mtvec,       write_mtvec       },
     [CSR_MCOUNTEREN] =          { any,  read_mcounteren,  write_mcounteren  },
 
+#if defined(TARGET_RISCV32)
+    [CSR_MSTATUSH] =            { any,  read_mstatush,    write_mstatush    },
+#endif
+
     /* Legacy Counter Setup (priv v1.9.1) */
     [CSR_MUCOUNTEREN] =         { any,  read_mucounteren, write_mucounteren },
     [CSR_MSCOUNTEREN] =         { any,  read_mscounteren, write_mscounteren },
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 804936e9d5..dca68fa96e 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -153,7 +153,11 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
         get_field(mstatus, MSTATUS_MPIE));
     mstatus = set_field(mstatus, MSTATUS_MPIE, 1);
     mstatus = set_field(mstatus, MSTATUS_MPP, PRV_U);
+#ifdef TARGET_RISCV32
+    env->mstatush = set_field(env->mstatush, MSTATUS_MPV, 0);
+#else
     mstatus = set_field(mstatus, MSTATUS_MPV, 0);
+#endif
     env->mstatus = mstatus;
     riscv_cpu_set_mode(env, prev_priv);
 
-- 
2.25.0


