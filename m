Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D41C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:35:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0CF4208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rza2IUJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0CF4208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW02L-00050Q-FX
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVzFz-00032F-6w; Fri, 23 Oct 2020 11:45:32 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:6193)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVzFu-0003ka-1n; Fri, 23 Oct 2020 11:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603467926; x=1635003926;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jda6uFyOihTzKaAVgRYuX/hf6RU8mxfJGD/+tT4Ywhs=;
 b=rza2IUJLWd7pRBQyH7EtDkHBEOZLmZyqavSOcLoLAVEanu4rae7MOBF0
 vBVfBE7Dci2TjFk8ewQmEAwT8849S5Kr3U19tanWU3urP97C8FpceEjO9
 cbg6xoPZ7tIlYh6M/KfjJc4fW8FcvPOIGLNDl8J0FUcmWfAPC8zPppSfO
 /vmUBPshuoYnkDYrgI3JwK4EXY2xF7YTbgIfPLEJIAnE/WCIn1EaRsTYv
 2cpmqpjFu6YdsXo6RBoiwUXtH89k8xB9qBRmFpzwbnpg90wZrznQ8h2GZ
 ilc1LYvwq5neiV0DqEdrFOW1FrNxn3gD3xpVO8WRg3AodcBBrApdFdgaG Q==;
IronPort-SDR: gzy9iNYFddtqeyYnTOAIqiUQ9WCu3nYP9qv3DZSz+PyEpjOtI9OpmsFCOpuM0sMntXTReflH15
 DdoGs1aFtsoNIvFo7lpQhhwsXUaM/6b9hwnDfL/X7ErZVG8AtMmyBt/ykwsTpRMP7Y4Z2VOgGC
 +EP/55XM9Y3PfebuVkiJNa8p98Z5Fzl0QdvHjerzfHBMERdYS3CaR+aeYGiBY1Y5lWltFoKifg
 JKq1DY4zF3DtHlaPXXztgfZfXizB3Wq8lSEEnjH4zB3R/AgpfTS2MhTHDQzAZrYPmAhbHPoM4e
 E8c=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="151960182"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 23:45:18 +0800
IronPort-SDR: izfu8yR+CLTCf0+zAqdC9ltaSufhP6UBPEw9F/ECVp8ivsxNZca8AN7o91ebhrorAWNHDa2dMB
 /7Tt/tt9+eiE76+MJjFgrFmSlkMNa7RpRDCEfl0LK/LMJ5jqVfpV5rTEBuFrRR7F2z+PoadfYq
 bGbGI8GVKP+teMtyTB1oG//VOOYS3Qou2U56v71bU1TDUZ18ty2WR6xA2srFLVyw3QOHc94Fax
 /OUMXSUhcAHiW+R/pWkO0SjkfziuCVQg8WrdZZKszimK8C6irmiBOHz2qbWzqD3hX7/UEoiSry
 SqMmBMUnDgfTOKaPX601eRyo
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:31:40 -0700
IronPort-SDR: XzTyfU6IdPRk8is2Opukr4FD1ubWonGCfqPowhLY67Hq5q8wb+BRjZvC06hJ0d4QobB3/xNV2j
 6RM6SFbx7dmxFZorA/N5juzmKolh35xgLfEDNghR8AXfB3C6SF5SohL3Z8J37YBwTHAltcc9vw
 XfiYeCmpb1vyqC9We7W1U87vNPCqKvLriuHg8LJCIdsF3dmkyqr7Q35hRUv1xEoMs93fcTAOYx
 kb9Yjc2N0nEcpVKP6kKb+lwe8DaK90VU5dlfqUFmp71+u15/CPnfpWq18aK17OpRKConLiznLG
 xA4=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip01.wdc.com with ESMTP; 23 Oct 2020 08:45:17 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 16/16] target/riscv: Consolidate *statush registers
Date: Fri, 23 Oct 2020 08:33:56 -0700
Message-Id: <ce9e33fdd36df39878df6657ecdc10e42c629b85.1603467169.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603467169.git.alistair.francis@wdc.com>
References: <cover.1603467169.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=558518344=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:44:34
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        | 24 ++++++++++++++---------
 target/riscv/cpu_bits.h   | 14 ++-----------
 target/riscv/cpu.c        |  7 ++-----
 target/riscv/cpu_helper.c | 41 ++++++++++-----------------------------
 target/riscv/csr.c        | 15 ++++++++------
 target/riscv/op_helper.c  | 11 ++++-------
 6 files changed, 42 insertions(+), 70 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8bde15544d..de864a947b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -150,9 +150,11 @@ struct CPURISCVState {
     target_ulong resetvec;
 
     target_ulong mhartid;
-    target_ulong mstatus;
-    /* This is RV32 only */
-    target_ulong mstatush;
+    /*
+     * For RV32 this is 32-bit mstatus and 32-bit mstatush.
+     * For RV64 this is a 64-bit mstatus.
+     */
+    uint64_t mstatus;
 
     target_ulong mip;
 
@@ -187,15 +189,17 @@ struct CPURISCVState {
     uint64_t htimedelta;
 
     /* Virtual CSRs */
-    target_ulong vsstatus;
     target_ulong vstvec;
     target_ulong vsscratch;
     target_ulong vsepc;
     target_ulong vscause;
     target_ulong vstval;
     target_ulong vsatp;
-    /* This is RV32 only */
-    target_ulong vsstatush;
+    /*
+     * For RV32 this is 32-bit mstatus and 32-bit mstatush.
+     * For RV64 this is a 64-bit mstatus.
+     */
+    uint64_t vsstatus;
 
     target_ulong mtval2;
     target_ulong mtinst;
@@ -207,9 +211,11 @@ struct CPURISCVState {
     target_ulong scause_hs;
     target_ulong stval_hs;
     target_ulong satp_hs;
-    target_ulong mstatus_hs;
-    /* This is RV32 only */
-    target_ulong mstatush_hs;
+    /*
+     * For RV32 this is 32-bit mstatus and 32-bit mstatush.
+     * For RV64 this is a 64-bit mstatus.
+     */
+    uint64_t mstatus_hs;
 
     target_ulong scounteren;
     target_ulong mcounteren;
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index db46739b1c..4b75d2766e 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -381,19 +381,9 @@
 #define MSTATUS_TVM         0x00100000 /* since: priv-1.10 */
 #define MSTATUS_TW          0x20000000 /* since: priv-1.10 */
 #define MSTATUS_TSR         0x40000000 /* since: priv-1.10 */
-#if defined(TARGET_RISCV64)
-#define MSTATUS_GVA         0x4000000000ULL
-#define MSTATUS_MPV         0x8000000000ULL
-#elif defined(TARGET_RISCV32)
-#define MSTATUS_GVA         0x00000040
-#define MSTATUS_MPV         0x00000080
-#endif
 
-#ifdef TARGET_RISCV32
-# define MSTATUS_MPV_ISSET(env)  get_field(env->mstatush, MSTATUS_MPV)
-#else
-# define MSTATUS_MPV_ISSET(env)  get_field(env->mstatus, MSTATUS_MPV)
-#endif
+#define MSTATUS_GVA      0x4000000000ULL
+#define MSTATUS_MPV      0x8000000000ULL
 
 #define MSTATUS64_UXL       0x0000000300000000ULL
 #define MSTATUS64_SXL       0x0000000C00000000ULL
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c77687ccb2..74c5ac5777 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -245,13 +245,10 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "pc      ", env->pc);
 #ifndef CONFIG_USER_ONLY
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mhartid);
-    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", env->mstatus);
-    if (riscv_cpu_is_32bit(env)) {
-        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatush ", env->mstatush);
-    }
+    qemu_fprintf(f, " %s %016lx\n", "mstatus ", env->mstatus);
     if (riscv_has_ext(env, RVH)) {
         qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "hstatus ", env->hstatus);
-        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vsstatus ", env->vsstatus);
+        qemu_fprintf(f, " %s %016lx\n", "vsstatus ", env->vsstatus);
     }
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mip     ", env->mip);
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mie     ", env->mie);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 62aed24feb..b109529ace 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -110,27 +110,19 @@ bool riscv_cpu_fp_enabled(CPURISCVState *env)
 
 void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
 {
-    target_ulong mstatus_mask = MSTATUS_MXR | MSTATUS_SUM | MSTATUS_FS |
-                                MSTATUS_SPP | MSTATUS_SPIE | MSTATUS_SIE;
+    uint64_t mstatus_mask = MSTATUS_MXR | MSTATUS_SUM | MSTATUS_FS |
+                            MSTATUS_SPP | MSTATUS_SPIE | MSTATUS_SIE |
+                            MSTATUS64_UXL;
     bool current_virt = riscv_cpu_virt_enabled(env);
 
     g_assert(riscv_has_ext(env, RVH));
 
-#if defined(TARGET_RISCV64)
-    mstatus_mask |= MSTATUS64_UXL;
-#endif
-
     if (current_virt) {
         /* Current V=1 and we are about to change to V=0 */
         env->vsstatus = env->mstatus & mstatus_mask;
         env->mstatus &= ~mstatus_mask;
         env->mstatus |= env->mstatus_hs;
 
-        if (riscv_cpu_is_32bit(env)) {
-            env->vsstatush = env->mstatush;
-            env->mstatush |= env->mstatush_hs;
-        }
-
         env->vstvec = env->stvec;
         env->stvec = env->stvec_hs;
 
@@ -154,11 +146,6 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
         env->mstatus &= ~mstatus_mask;
         env->mstatus |= env->vsstatus;
 
-        if (riscv_cpu_is_32bit(env)) {
-            env->mstatush_hs = env->mstatush;
-            env->mstatush |= env->vsstatush;
-        }
-
         env->stvec_hs = env->stvec;
         env->stvec = env->vstvec;
 
@@ -729,7 +716,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     if (riscv_has_ext(env, RVH) && env->priv == PRV_M &&
         access_type != MMU_INST_FETCH &&
         get_field(env->mstatus, MSTATUS_MPRV) &&
-        MSTATUS_MPV_ISSET(env)) {
+        get_field(env->mstatus, MSTATUS_MPV)) {
         riscv_cpu_set_two_stage_lookup(env, true);
     }
 
@@ -801,7 +788,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     if (riscv_has_ext(env, RVH) && env->priv == PRV_M &&
         access_type != MMU_INST_FETCH &&
         get_field(env->mstatus, MSTATUS_MPRV) &&
-        MSTATUS_MPV_ISSET(env)) {
+        get_field(env->mstatus, MSTATUS_MPV)) {
         riscv_cpu_set_two_stage_lookup(env, false);
     }
 
@@ -864,7 +851,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     bool force_hs_execp = riscv_cpu_force_hs_excep_enabled(env);
-    target_ulong s;
+    uint64_t s;
 
     /* cs->exception is 32-bits wide unlike mcause which is XLEN-bits wide
      * so we mask off the MSB and separate into trap type and cause.
@@ -997,18 +984,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             if (riscv_cpu_virt_enabled(env)) {
                 riscv_cpu_swap_hypervisor_regs(env);
             }
-            if (riscv_cpu_is_32bit(env)) {
-                env->mstatush = set_field(env->mstatush, MSTATUS_MPV,
-                                           riscv_cpu_virt_enabled(env));
-                if (riscv_cpu_virt_enabled(env) && tval) {
-                    env->mstatush = set_field(env->mstatush, MSTATUS_GVA, 1);
-                }
-            } else {
-                env->mstatus = set_field(env->mstatus, MSTATUS_MPV,
-                                          riscv_cpu_virt_enabled(env));
-                if (riscv_cpu_virt_enabled(env) && tval) {
-                    env->mstatus = set_field(env->mstatus, MSTATUS_GVA, 1);
-                }
+            env->mstatus = set_field(env->mstatus, MSTATUS_MPV,
+                                     riscv_cpu_virt_enabled(env));
+            if (riscv_cpu_virt_enabled(env) && tval) {
+                env->mstatus = set_field(env->mstatus, MSTATUS_GVA, 1);
             }
 
             mtval2 = env->guest_phys_fault_addr;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index b153cdfec3..7132a9bcd0 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -473,8 +473,8 @@ static int validate_vm(CPURISCVState *env, target_ulong vm)
 
 static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
 {
-    target_ulong mstatus = env->mstatus;
-    target_ulong mask = 0;
+    uint64_t mstatus = env->mstatus;
+    uint64_t mask = 0;
     int dirty;
 
     /* flush tlb on mstatus fields that affect VM */
@@ -507,19 +507,22 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
 
 static int read_mstatush(CPURISCVState *env, int csrno, target_ulong *val)
 {
-    *val = env->mstatush;
+    *val = env->mstatus >> 32;
     return 0;
 }
 
 static int write_mstatush(CPURISCVState *env, int csrno, target_ulong val)
 {
-    if ((val ^ env->mstatush) & (MSTATUS_MPV)) {
+    uint64_t val64 = (uint64_t) val << 32;
+
+    if ((val64 ^ env->mstatus) & (MSTATUS_MPV)) {
         tlb_flush(env_cpu(env));
     }
 
-    val &= MSTATUS_MPV | MSTATUS_GVA;
+    val64 &= MSTATUS_MPV | MSTATUS_GVA;
 
-    env->mstatush = val;
+    env->mstatus &= 0xFFFFFFFF;
+    env->mstatus |= val64;
 
     return 0;
 }
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 4ce73575a7..f9361e3af8 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -78,7 +78,8 @@ target_ulong helper_csrrc(CPURISCVState *env, target_ulong src,
 
 target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
 {
-    target_ulong prev_priv, prev_virt, mstatus;
+    target_ulong prev_priv, prev_virt;
+    uint64_t mstatus;
 
     if (!(env->priv >= PRV_S)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
@@ -147,18 +148,14 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
         riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
     }
 
-    target_ulong mstatus = env->mstatus;
+    uint64_t mstatus = env->mstatus;
     target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
-    target_ulong prev_virt = MSTATUS_MPV_ISSET(env);
+    target_ulong prev_virt = !!get_field(env->mstatus, MSTATUS_MPV);
     mstatus = set_field(mstatus, MSTATUS_MIE,
                         get_field(mstatus, MSTATUS_MPIE));
     mstatus = set_field(mstatus, MSTATUS_MPIE, 1);
     mstatus = set_field(mstatus, MSTATUS_MPP, PRV_U);
-#ifdef TARGET_RISCV32
-    env->mstatush = set_field(env->mstatush, MSTATUS_MPV, 0);
-#else
     mstatus = set_field(mstatus, MSTATUS_MPV, 0);
-#endif
     env->mstatus = mstatus;
     riscv_cpu_set_mode(env, prev_priv);
 
-- 
2.28.0


