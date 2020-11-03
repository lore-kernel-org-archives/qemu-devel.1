Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A67C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:55:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C3F020786
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Y5XsapLn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C3F020786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZyf2-0007XD-4B
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:55:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyJQ-0001PL-6z
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:33:32 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:14996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyJN-0001EJ-GZ
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604417610; x=1635953610;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PVCZQUTeCw2di1b+MS8hAMMWVCYqpu2LLmTnEQBfmSQ=;
 b=Y5XsapLn7t2iDM11OAifYwJFO4Xi060CFoCcRxLAwhrQ1IDE+R0qDak2
 Sxwl7aWde5JR5XqrzWpr4zaXqn9lv8Zg1JKOyby7eGIMhO4a+wCOh7+hy
 KbdS+XkHQkGpJKNZf5QA6fibocbYGcISzxOJb+LYFxnakjQTB//iMUGRa
 O+yWYvzbNUUQLQ4I7FAC10rwjyIB/Y6xFgqbGgXSJ3/E2qui+VpqHeKjo
 qjfBfU098kodCQNTF/9HeEVVCQKhZBrczE4OyLrXU+gV5bsMHK/TWlCJN
 qYAU+4aK5Ix+pjiV6wuRhHXJKu05BTGoY5iXPS8t6R0Z39gVUQckzNO0q w==;
IronPort-SDR: Gs3Dngyo5mJysqnta+SqGY0LCnrYRl3tYw6+X3iCRa8QD7K5poSHrUjNdKWomb1r2eU2n9Tf6r
 iLa7MUMz70IDM/gNQhkxAGS6SlbzsDTPKW5XaQEbHgcAG7lR70D77UjegZaFif0dvFSkl3MDxD
 /6wYYo49ljdRZiYqL+oGhr1+92kPj5z+dNO+TZfC8N2rv00So3RlG30ZK/m+TCBfagJZqNq4BQ
 O7mBSlirIv9eVeJ6q9C0EkVqTCJQprpiBqUunaa/o0sPZ26IbDgBHZgeSVR+tKtD4emH7HCuVq
 9kI=
X-IronPort-AV: E=Sophos;i="5.77,448,1596470400"; d="scan'208";a="152867454"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2020 23:33:24 +0800
IronPort-SDR: Zi4p46t85+hShEKgKVOdrahJwtWDpWfMEjQmftiU6bYzPHMd7uljgZVfcMC+Rhjv5wbzyc/0wq
 Yyt9oPiCQJh/v/C0QTEaQu65tZ7ycGffCmztLwqm5iidXW8WU5uGQl2mQOzJlMI+w1kUatpGzd
 W0DAC2+e8w4aRX5dV7znFrvobGYv9e6pQOryAGTlImgwpSpJwSln+G+yoIusfmsngtxC5PrvNR
 3KuY93oKYFCZDKO7SNbJArCwjKVu0kZFxBCci2nIn9zkYtikf1A6c4JPUW1If3dA0f8FCRbnaw
 ic3Zs2UpBfs+PlapQ167gUK+
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2020 07:19:33 -0800
IronPort-SDR: t5vYzcgZjs4mosSPNQ3ZPZHc8/wvMMfZndxWUn4rCMgDPc0J8xwWYmmNfya137FA4XOFlPy2XK
 fQiZOtd5WjKcFtWd1swgdb/jXUjXBr0yH8ZmkRFMTVd6C9GOfQpRTr4cHWoxxQ19+WEQ9lpQui
 YGKpry+YJheJss+nYihZpsAsxGndoqqVh68mhiHBQjVRXZQOyeZg1G1YicbGun98GF0nmYEXeZ
 EsCZ/OvHyApinNbBvdlR0Zmj7LZoJsESB+YKOLXt8KbffPp7oBxDHcE4K+xK8yr+SLseFi0gg1
 aYk=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.113])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Nov 2020 07:33:25 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL v2 03/19] target/riscv: Merge m/vsstatus and m/vsstatush into
 one uint64_t unit
Date: Tue,  3 Nov 2020 07:21:34 -0800
Message-Id: <20201103152150.2677566-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103152150.2677566-1-alistair.francis@wdc.com>
References: <20201103152150.2677566-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=569a91e0c=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 10:33:23
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
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Yifei Jiang <jiangyifei@huawei.com>, Yipeng Yin <yinyipeng1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yifei Jiang <jiangyifei@huawei.com>

mstatus/mstatush and vsstatus/vsstatush are two halved for RISCV32.
This patch expands mstatus and vsstatus to uint64_t instead of
target_ulong so that it can be saved as one unit and reduce some
ifdefs in the code.

Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
Signed-off-by: Yipeng Yin <yinyipeng1@huawei.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20201026115530.304-2-jiangyifei@huawei.com
---
 target/riscv/cpu.h        | 24 +++++++++++-------------
 target/riscv/cpu_bits.h   | 19 ++++---------------
 target/riscv/cpu.c        |  8 +++++---
 target/riscv/cpu_helper.c | 35 +++++++----------------------------
 target/riscv/csr.c        | 18 ++++++++++--------
 target/riscv/op_helper.c  | 11 ++++-------
 6 files changed, 41 insertions(+), 74 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index de4705bb57..87b68affa8 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -144,14 +144,14 @@ struct CPURISCVState {
     target_ulong resetvec;
 
     target_ulong mhartid;
-    target_ulong mstatus;
+    /*
+     * For RV32 this is 32-bit mstatus and 32-bit mstatush.
+     * For RV64 this is a 64-bit mstatus.
+     */
+    uint64_t mstatus;
 
     target_ulong mip;
 
-#ifdef TARGET_RISCV32
-    target_ulong mstatush;
-#endif
-
     uint32_t miclaim;
 
     target_ulong mie;
@@ -183,16 +183,17 @@ struct CPURISCVState {
     uint64_t htimedelta;
 
     /* Virtual CSRs */
-    target_ulong vsstatus;
+    /*
+     * For RV32 this is 32-bit vsstatus and 32-bit vsstatush.
+     * For RV64 this is a 64-bit vsstatus.
+     */
+    uint64_t vsstatus;
     target_ulong vstvec;
     target_ulong vsscratch;
     target_ulong vsepc;
     target_ulong vscause;
     target_ulong vstval;
     target_ulong vsatp;
-#ifdef TARGET_RISCV32
-    target_ulong vsstatush;
-#endif
 
     target_ulong mtval2;
     target_ulong mtinst;
@@ -204,10 +205,7 @@ struct CPURISCVState {
     target_ulong scause_hs;
     target_ulong stval_hs;
     target_ulong satp_hs;
-    target_ulong mstatus_hs;
-#ifdef TARGET_RISCV32
-    target_ulong mstatush_hs;
-#endif
+    uint64_t mstatus_hs;
 
     target_ulong scounteren;
     target_ulong mcounteren;
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index bd36062877..daedad8691 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -4,10 +4,10 @@
 #define TARGET_RISCV_CPU_BITS_H
 
 #define get_field(reg, mask) (((reg) & \
-                 (target_ulong)(mask)) / ((mask) & ~((mask) << 1)))
-#define set_field(reg, mask, val) (((reg) & ~(target_ulong)(mask)) | \
-                 (((target_ulong)(val) * ((mask) & ~((mask) << 1))) & \
-                 (target_ulong)(mask)))
+                 (uint64_t)(mask)) / ((mask) & ~((mask) << 1)))
+#define set_field(reg, mask, val) (((reg) & ~(uint64_t)(mask)) | \
+                 (((uint64_t)(val) * ((mask) & ~((mask) << 1))) & \
+                 (uint64_t)(mask)))
 
 /* Floating point round mode */
 #define FSR_RD_SHIFT        5
@@ -381,19 +381,8 @@
 #define MSTATUS_TVM         0x00100000 /* since: priv-1.10 */
 #define MSTATUS_TW          0x20000000 /* since: priv-1.10 */
 #define MSTATUS_TSR         0x40000000 /* since: priv-1.10 */
-#if defined(TARGET_RISCV64)
 #define MSTATUS_GVA         0x4000000000ULL
 #define MSTATUS_MPV         0x8000000000ULL
-#elif defined(TARGET_RISCV32)
-#define MSTATUS_GVA         0x00000040
-#define MSTATUS_MPV         0x00000080
-#endif
-
-#ifdef TARGET_RISCV32
-# define MSTATUS_MPV_ISSET(env)  get_field(env->mstatush, MSTATUS_MPV)
-#else
-# define MSTATUS_MPV_ISSET(env)  get_field(env->mstatus, MSTATUS_MPV)
-#endif
 
 #define MSTATUS64_UXL       0x0000000300000000ULL
 #define MSTATUS64_SXL       0x0000000C00000000ULL
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0bbfd7f457..dd05a220c7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -216,13 +216,15 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "pc      ", env->pc);
 #ifndef CONFIG_USER_ONLY
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mhartid);
-    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", env->mstatus);
+    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", (target_ulong)env->mstatus);
 #ifdef TARGET_RISCV32
-    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatush ", env->mstatush);
+    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatush ",
+                 (target_ulong)(env->mstatus >> 32));
 #endif
     if (riscv_has_ext(env, RVH)) {
         qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "hstatus ", env->hstatus);
-        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vsstatus ", env->vsstatus);
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vsstatus ",
+                     (target_ulong)env->vsstatus);
     }
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mip     ", env->mip);
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mie     ", env->mie);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 4652082df1..3eb3a034db 100644
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
 
-#if defined(TARGET_RISCV32)
-        env->vsstatush = env->mstatush;
-        env->mstatush |= env->mstatush_hs;
-#endif
-
         env->vstvec = env->stvec;
         env->stvec = env->stvec_hs;
 
@@ -154,11 +146,6 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
         env->mstatus &= ~mstatus_mask;
         env->mstatus |= env->vsstatus;
 
-#if defined(TARGET_RISCV32)
-        env->mstatush_hs = env->mstatush;
-        env->mstatush |= env->vsstatush;
-#endif
-
         env->stvec_hs = env->stvec;
         env->stvec = env->vstvec;
 
@@ -727,7 +714,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     if (riscv_has_ext(env, RVH) && env->priv == PRV_M &&
         access_type != MMU_INST_FETCH &&
         get_field(env->mstatus, MSTATUS_MPRV) &&
-        MSTATUS_MPV_ISSET(env)) {
+        get_field(env->mstatus, MSTATUS_MPV)) {
         riscv_cpu_set_two_stage_lookup(env, true);
     }
 
@@ -799,7 +786,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     if (riscv_has_ext(env, RVH) && env->priv == PRV_M &&
         access_type != MMU_INST_FETCH &&
         get_field(env->mstatus, MSTATUS_MPRV) &&
-        MSTATUS_MPV_ISSET(env)) {
+        get_field(env->mstatus, MSTATUS_MPV)) {
         riscv_cpu_set_two_stage_lookup(env, false);
     }
 
@@ -862,7 +849,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     bool force_hs_execp = riscv_cpu_force_hs_excep_enabled(env);
-    target_ulong s;
+    uint64_t s;
 
     /* cs->exception is 32-bits wide unlike mcause which is XLEN-bits wide
      * so we mask off the MSB and separate into trap type and cause.
@@ -995,19 +982,11 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             if (riscv_cpu_virt_enabled(env)) {
                 riscv_cpu_swap_hypervisor_regs(env);
             }
-#ifdef TARGET_RISCV32
-            env->mstatush = set_field(env->mstatush, MSTATUS_MPV,
-                                       riscv_cpu_virt_enabled(env));
-            if (riscv_cpu_virt_enabled(env) && tval) {
-                env->mstatush = set_field(env->mstatush, MSTATUS_GVA, 1);
-            }
-#else
             env->mstatus = set_field(env->mstatus, MSTATUS_MPV,
-                                      riscv_cpu_virt_enabled(env));
+                                     riscv_cpu_virt_enabled(env));
             if (riscv_cpu_virt_enabled(env) && tval) {
                 env->mstatus = set_field(env->mstatus, MSTATUS_GVA, 1);
             }
-#endif
 
             mtval2 = env->guest_phys_fault_addr;
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index aaef6c6f20..e33f6cdc11 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -446,8 +446,8 @@ static int validate_vm(CPURISCVState *env, target_ulong vm)
 
 static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
 {
-    target_ulong mstatus = env->mstatus;
-    target_ulong mask = 0;
+    uint64_t mstatus = env->mstatus;
+    uint64_t mask = 0;
     int dirty;
 
     /* flush tlb on mstatus fields that affect VM */
@@ -480,19 +480,20 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
 #ifdef TARGET_RISCV32
 static int read_mstatush(CPURISCVState *env, int csrno, target_ulong *val)
 {
-    *val = env->mstatush;
+    *val = env->mstatus >> 32;
     return 0;
 }
 
 static int write_mstatush(CPURISCVState *env, int csrno, target_ulong val)
 {
-    if ((val ^ env->mstatush) & (MSTATUS_MPV)) {
+    uint64_t valh = (uint64_t)val << 32;
+    uint64_t mask = MSTATUS_MPV | MSTATUS_GVA;
+
+    if ((valh ^ env->mstatus) & (MSTATUS_MPV)) {
         tlb_flush(env_cpu(env));
     }
 
-    val &= MSTATUS_MPV | MSTATUS_GVA;
-
-    env->mstatush = val;
+    env->mstatus = (env->mstatus & ~mask) | (valh & mask);
 
     return 0;
 }
@@ -1105,7 +1106,8 @@ static int read_vsstatus(CPURISCVState *env, int csrno, target_ulong *val)
 
 static int write_vsstatus(CPURISCVState *env, int csrno, target_ulong val)
 {
-    env->vsstatus = val;
+    uint64_t mask = (target_ulong)-1;
+    env->vsstatus = (env->vsstatus & ~mask) | (uint64_t)val;
     return 0;
 }
 
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 4ce73575a7..e20d56dcb8 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -78,7 +78,8 @@ target_ulong helper_csrrc(CPURISCVState *env, target_ulong src,
 
 target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
 {
-    target_ulong prev_priv, prev_virt, mstatus;
+    uint64_t mstatus;
+    target_ulong prev_priv, prev_virt;
 
     if (!(env->priv >= PRV_S)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
@@ -147,18 +148,14 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
         riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
     }
 
-    target_ulong mstatus = env->mstatus;
+    uint64_t mstatus = env->mstatus;
     target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
-    target_ulong prev_virt = MSTATUS_MPV_ISSET(env);
+    target_ulong prev_virt = get_field(env->mstatus, MSTATUS_MPV);
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


