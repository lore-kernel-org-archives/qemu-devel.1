Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DB3C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 23:59:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3B2A206BA
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 23:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="drlvJJAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B2A206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1JSs-00022f-Lj
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 19:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCV-0001K4-I8
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCU-0000M8-58
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:35 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38476)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCT-0000Il-My; Fri, 23 Aug 2019 19:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566603755; x=1598139755;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5/l8AjmMesb9o3KVwvrFCmJuIi2N9DKlGj66CZQ9yt8=;
 b=drlvJJAVi9Lcqb+j06JI0pQAkp14rOjWBQqX1sECYBPmZaXBD+0ArLYN
 sZNYJZdNEZcpKrZK1n0VSFCTZhcRUWz/uO8DmZrW4nxaZMY3wvtrugtrC
 90QFc+SMDHhjQ0baaVpQVyQyaewYogRz3FHxBxrvDCX96wwmfK1wiHXcE
 juNXyAWWmhJv4mGXV3IA36xtSaU+ZZC5aSui8IemQalhzLaxcVwMi+pRa
 Cjy3H7pZeHqOeQnx8lBD0QpayfXHt+SNmf02zUgkRTy6mLq91a9nwcjgR
 kZnnsaXwqleMJjOcLF5VL+RP7UwWkvM8C3Bd912gzi3bWiqOKP57tIuz8 w==;
IronPort-SDR: kKv+HSofe6pOjipJvmPJSm0MxKNZl6FMxK1JcXyQHZfp6KgeVKrnvBePtYDcNftyJQR/NNLwKi
 JOKv1BKKzil/BE116Tv5dgoE/NXUCPrrg+gwZZhz7+Q63FYQE8q1E6L6o/3/aU/vTl9aa3xmrs
 iixQ0PQYD2kxRlBGX7/TWNYRj0vZN+e9NO1htt6KWM014EdvZLxNjAyJ9yDPBNPjfqsG2yk7cU
 eFuv10yrMEsqNtB7FgHE8iuFBCImFYTosYZCOf5BuDDCkcaw4lAfzTK4/IpRZXlFwpZcnDyEPl
 grA=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="117486915"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 07:42:34 +0800
IronPort-SDR: iO0tTVjcAmbhT62H3shHbqfEuxfuNTaeA3TXStRTZw3GaKYVFns2h2UiCBUAofRkf0EwrWVA7X
 9QWAXxSzz721fXPvlTaTCdvHxfGzmfUaCSB2qsfMAqNiuJbFKA1PSeaEKrogYI/kQeJm3dAyaU
 N7VMI5KUE/bYAQhy081CmsnwkBL8a4F3bnPkfs9eqOphfGc3y0xYRIDOfomEo1D/RjH504MBYk
 iiysfyQsVVWKrIiJXBV/ataKWMKSAzyR6nafG2cPHBirsyRCPR2jkEvBQe3CLD6n9LEmVr4VDX
 tZl/562b58mW6h5HTDNtsa8T
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 16:39:50 -0700
IronPort-SDR: Qt6pB2EwpELfQxvXKzg4iOFFSjrP1IUbRi+q1IbRaqizhNkZQ7KmbUJLfw7AyyRkQxOtGUZqcv
 QQ0qW/vyYIENPjT3PXHpVpQbBDBTxTi0lCutkO4ZXr5H2OVmmM5o4O9aX3qgzfC2jrIekUVe4G
 /DEth/hJQZqmJghfF90Z+EwrL3ol9pWenafc/hZPTlbPMtEIIqfOCL+56/EfqnEiY23Pu5UVBk
 cl2tShliNzncESbo+VFRB0jF2ldJ1wCEvsRjUAgjktTlNu4dWR5dcJW7dQNUCnpdXM9HTS1R7b
 NNo=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 16:42:32 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 23 Aug 2019 16:38:52 -0700
Message-Id: <67e93a4f45693067abb03441e159b1f4a0a48276.1566603412.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566603412.git.alistair.francis@wdc.com>
References: <cover.1566603412.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v1 24/28] target/riscv: Implement second stage
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
Cc: alistair23@gmail.com, Anup.Patel@wdc.com, palmer@sifive.com,
 alistair.francis@wdc.com, Atish.Patra@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 96 +++++++++++++++++++++++++++++++++++----
 1 file changed, 86 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 8b9871f9ea..188d5cb39f 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -337,13 +337,40 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
      * (riscv_cpu_do_interrupt) is correct */
 
     int mode = mmu_idx;
+    bool use_background = false;
 
+    /*
+     * Check if we should use the background registers for the two
+     * stage translation. We don't need to check if we actually need
+     * two stage translation as that happened before this function
+     * was called. Background registers will be used if the guest has
+     * forced a two stage translation to be on (in HS or M mode).
+     */
     if (mode == PRV_M && access_type != MMU_INST_FETCH) {
         if (get_field(*env->mstatus, MSTATUS_MPRV)) {
             mode = get_field(*env->mstatus, MSTATUS_MPP);
+
+            if (riscv_has_ext(env, RVH) &&
+                get_field(*env->mstatus, MSTATUS_MPV)) {
+                use_background = true;
+            }
         }
     }
 
+    if (mode == PRV_S && access_type != MMU_INST_FETCH &&
+        riscv_has_ext(env, RVH) && !riscv_cpu_virt_enabled(env)) {
+        if (get_field(env->hstatus, HSTATUS_SPRV)) {
+            mode = get_field(*env->mstatus, SSTATUS_SPP);
+            use_background = true;
+        }
+    }
+
+    if (first_stage == false) {
+        /* We are in stage 2 translation, this is similar to stage 1. */
+        /* Stage 2 is always taken as U-mode */
+        mode = PRV_U;
+    }
+
     if (mode == PRV_M || !riscv_feature(env, RISCV_FEATURE_MMU)) {
         *physical = addr;
         *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
@@ -353,13 +380,30 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     *prot = 0;
 
     target_ulong base;
-    int levels, ptidxbits, ptesize, vm, sum;
-    int mxr = get_field(*env->mstatus, MSTATUS_MXR);
+    int levels, ptidxbits, ptesize, vm, sum, mxr, widened;
+
+    if (first_stage == true) {
+        mxr = get_field(*env->mstatus, MSTATUS_MXR);
+    } else {
+        mxr = get_field(env->vsstatus, MSTATUS_MXR);
+    }
 
     if (env->priv_ver >= PRIV_VERSION_1_10_0) {
-        base = get_field(env->satp, SATP_PPN) << PGSHIFT;
+        if (first_stage == true) {
+            if (use_background) {
+                base = get_field(env->vsatp, SATP_PPN) << PGSHIFT;
+                vm = get_field(env->vsatp, SATP_MODE);
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
         sum = get_field(*env->mstatus, MSTATUS_SUM);
-        vm = get_field(env->satp, SATP_MODE);
         switch (vm) {
         case VM_1_10_SV32:
           levels = 2; ptidxbits = 10; ptesize = 4; break;
@@ -377,6 +421,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
           g_assert_not_reached();
         }
     } else {
+        widened = 0;
         base = env->sptbr << PGSHIFT;
         sum = !get_field(*env->mstatus, MSTATUS_PUM);
         vm = get_field(*env->mstatus, MSTATUS_VM);
@@ -397,9 +442,16 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     }
 
     CPUState *cs = env_cpu(env);
-    int va_bits = PGSHIFT + levels * ptidxbits;
-    target_ulong mask = (1L << (TARGET_LONG_BITS - (va_bits - 1))) - 1;
-    target_ulong masked_msbs = (addr >> (va_bits - 1)) & mask;
+    int va_bits = PGSHIFT + levels * ptidxbits + widened;
+    target_ulong mask, masked_msbs;
+
+    if (TARGET_LONG_BITS > (va_bits - 1)) {
+        mask = (1L << (TARGET_LONG_BITS - (va_bits - 1))) - 1;
+    } else {
+        mask = 0;
+    }
+    masked_msbs = (addr >> (va_bits - 1)) & mask;
+
     if (masked_msbs != 0 && masked_msbs != mask) {
         return TRANSLATE_FAIL;
     }
@@ -411,17 +463,36 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
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
 
         if (riscv_feature(env, RISCV_FEATURE_PMP) &&
             !pmp_hart_has_privs(env, pte_addr, sizeof(target_ulong),
             1 << MMU_DATA_LOAD, PRV_S)) {
             return TRANSLATE_PMP_FAIL;
         }
+
 #if defined(TARGET_RISCV32)
         target_ulong pte = ldl_phys(cs->as, pte_addr);
 #elif defined(TARGET_RISCV64)
@@ -507,7 +578,12 @@ restart:
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
2.22.0


