Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC368C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:29:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5133D20449
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Cd9/7Gei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5133D20449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53858 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZNML-0002TZ-JM
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 18:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48366)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsz-00054D-Dj
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:58:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsv-0002XS-B7
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:58:55 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:5597)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsu-0002G5-1Z; Fri, 07 Jun 2019 17:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1559944732; x=1591480732;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jHGWOrI3wGAuNrgENIk31N1AZBJ2yxH/44gojLgYEe0=;
 b=Cd9/7GeiGT1Rro6ucqCQXFen9gjx7jwrwJxFWGaNeIdER5gegpXm/39k
 1QPxyiczTd5BjoXC68feQu6R6a9xX0wvgF38Jt1qCIbbXF1x5GPmwwaPl
 EPhQP6f2VLL7SK6DQCf4BHK2sKJHVR6lhINjlREfqzzCQQ9+SMwdeS0us
 EbA6KCIOedZ1YogY6rbbp5+4O9ScDyHGmVwbgcpMfjBAyRVYUcvGgBhyD
 +MHurWhtUtLaAIykK2EEFMLOkMpA9w1VxR8DVzvYbMnJXwKxYWPMH6Gn1
 5ckDsU0Qi0HLi0TxHYdFCnYnZ8dEyNt+N9X+VJEKHz3jOYG7AWqGBq6Pv g==;
X-IronPort-AV: E=Sophos;i="5.63,564,1557158400"; d="scan'208";a="110059666"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2019 05:58:49 +0800
IronPort-SDR: 7vEV49g4U+GO31vmUpVDrRgXO3LleKRHhyw54efXFLnV2Xv/V+Q+Sh32eWOfalN7gUH9aoQpDB
 nyjz9svDGNo5d80Z7HRvfVO1T7RXubdnYdvyp83U37kRvBlwFblIhTHTl52VBnYBJc+YGH1aYC
 hpIwAB+XJDmj4utETxfXPUp6TWlpRjo7JChGSMX6bXC8O/ET2tJbkYY5ylBwpKZCjnniWXdkpY
 fwJoCsset35uZhAOED/Q3kxx5xUZYn2dfWGgz7EjGlTow4eKr6m8l1lwGZZVY4UPPl41DhxWZC
 F8i/rqJB5EqImnKK7cpylO1Z
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP; 07 Jun 2019 14:33:41 -0700
IronPort-SDR: JImqDUV4gruLoVhn7HwAjSi6DM8y9q1XWgoQOGRizpaaIu786ItgVRKa+WhiIJ/V5D0C4iwRx5
 QJ16vPen2ZgyVPlq64hfzoSp3jJG0WDKLFwHsjQUhgk1HW/9DLXYNzFlctLExcT92oWQqJaKY4
 9uQJHHwYr06qg6NHj4gbMscQ8mVi0z1kGhMgFWram+1nqsKp2T8fiFPh0uSIF31qEAR5+osnUp
 VVwMJIkOmlrrnwrS7YPHqt7HKbVXkQLtB5kI+94tTekTuWjJ/crIOIjnHFfZ4x9lsCFNlEAcuC
 Iyg=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip01.wdc.com with ESMTP; 07 Jun 2019 14:58:48 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri,  7 Jun 2019 14:56:39 -0700
Message-Id: <881efba62177d8c2de53f264613eb075b2a904de.1559944445.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559944445.git.alistair.francis@wdc.com>
References: <cover.1559944445.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [PATCH v1 25/27] target/riscv: Implement second stage
 MMU
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
---
 target/riscv/cpu_helper.c | 87 +++++++++++++++++++++++++++++++++++----
 1 file changed, 78 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 6ff4272da2..ece3eadf66 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -293,13 +293,40 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
      * (riscv_cpu_do_interrupt) is correct */
 
     int mode = mmu_idx;
-
+    bool use_background = false;
+
+    /*
+     * Check if we should use the background registers for the two
+     * stage translation. We don't need to check if we actually need
+     * two stage translation as that happened before this function
+     * was called. Background registers will be used if the guest has
+     * forced a two stage translation to be on (in HS or M mode).
+     */
     if (mode == PRV_M && access_type != MMU_INST_FETCH) {
         if (get_field(env->mstatus, MSTATUS_MPRV)) {
             mode = get_field(env->mstatus, MSTATUS_MPP);
+
+            if (riscv_has_ext(env, RVH) &&
+                get_field(env->mstatus, MSTATUS_MPV)) {
+                use_background = true;
+            }
+        }
+    }
+
+    if (mode == PRV_S && access_type != MMU_INST_FETCH &&
+        riscv_has_ext(env, RVH) && !riscv_cpu_virt_enabled(env)) {
+        if (get_field(env->hstatus, HSTATUS_SPRV)) {
+            mode = get_field(env->mstatus, SSTATUS_SPP);
+            use_background = true;
         }
     }
 
+    if (first_stage == false) {
+        /* We are in stage 2 translation, this is similar to stage 1. */
+        /* Stage 2 is always taken as U-mode */
+        mode = PRV_U;
+    }
+
     if (mode == PRV_M || !riscv_feature(env, RISCV_FEATURE_MMU)) {
         *physical = addr;
         *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
@@ -309,13 +336,30 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     *prot = 0;
 
     target_ulong base;
-    int levels, ptidxbits, ptesize, vm, sum;
-    int mxr = get_field(env->mstatus, MSTATUS_MXR);
+    int levels, ptidxbits, ptesize, vm, sum, mxr, widened;
+
+    if (first_stage == true) {
+        mxr = get_field(env->mstatus, MSTATUS_MXR);
+    } else {
+        mxr = get_field(env->bsstatus, MSTATUS_MXR);
+    }
 
     if (env->priv_ver >= PRIV_VERSION_1_10_0) {
-        base = get_field(env->satp, SATP_PPN) << PGSHIFT;
+        if (first_stage == true) {
+            if (use_background) {
+                base = get_field(env->bsatp, SATP_PPN) << PGSHIFT;
+                vm = get_field(env->bsatp, SATP_MODE);
+            } else {
+                base = get_field(env->satp, SATP_PPN) << PGSHIFT;
+                vm = get_field(env->satp, SATP_MODE);
+            }
+            widened = 0;
+        } else {
+            base = get_field(env->hgatp, HGATP_PPN) << PGSHIFT;
+            vm = get_field(env->hgatp, HGATP_MODE);
+            widened = 2;
+        }
         sum = get_field(env->mstatus, MSTATUS_SUM);
-        vm = get_field(env->satp, SATP_MODE);
         switch (vm) {
         case VM_1_10_SV32:
           levels = 2; ptidxbits = 10; ptesize = 4; break;
@@ -333,6 +377,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
           g_assert_not_reached();
         }
     } else {
+        widened = 0;
         base = env->sptbr << PGSHIFT;
         sum = !get_field(env->mstatus, MSTATUS_PUM);
         vm = get_field(env->mstatus, MSTATUS_VM);
@@ -353,7 +398,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     }
 
     CPUState *cs = CPU(riscv_env_get_cpu(env));
-    int va_bits = PGSHIFT + levels * ptidxbits;
+    int va_bits = PGSHIFT + levels * ptidxbits + widened;
     target_ulong mask = (1L << (TARGET_LONG_BITS - (va_bits - 1))) - 1;
     target_ulong masked_msbs = (addr >> (va_bits - 1)) & mask;
     if (masked_msbs != 0 && masked_msbs != mask) {
@@ -367,11 +412,30 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
 restart:
 #endif
     for (i = 0; i < levels; i++, ptshift -= ptidxbits) {
-        target_ulong idx = (addr >> (PGSHIFT + ptshift)) &
+        target_ulong idx;
+        if (i == 0) {
+            idx = (addr >> (PGSHIFT + ptshift)) &
+                           ((1 << (ptidxbits + widened)) - 1);
+        } else {
+            idx = (addr >> (PGSHIFT + ptshift)) &
                            ((1 << ptidxbits) - 1);
+        }
 
         /* check that physical address of PTE is legal */
-        target_ulong pte_addr = base + idx * ptesize;
+        target_ulong pte_addr;
+
+        if (two_stage && first_stage) {
+            hwaddr vbase;
+
+            /* Do the second stage translation on the base PTE address. */
+            get_physical_address(env, &vbase, prot, base, access_type,
+                                 mmu_idx, false, true);
+
+            pte_addr = vbase + idx * ptesize;
+        } else {
+            pte_addr = base + idx * ptesize;
+        }
+
 #if defined(TARGET_RISCV32)
         target_ulong pte = ldl_phys(cs->as, pte_addr);
 #elif defined(TARGET_RISCV64)
@@ -457,7 +521,12 @@ restart:
             /* for superpage mappings, make a fake leaf PTE for the TLB's
                benefit. */
             target_ulong vpn = addr >> PGSHIFT;
-            *physical = (ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT;
+            if (i == 0) {
+                *physical = (ppn | (vpn & ((1L << (ptshift + widened)) - 1))) <<
+                             PGSHIFT;
+            } else {
+                *physical = (ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT;
+            }
 
             /* set permissions on the TLB entry */
             if ((pte & PTE_R) || ((pte & PTE_X) && mxr)) {
-- 
2.21.0


