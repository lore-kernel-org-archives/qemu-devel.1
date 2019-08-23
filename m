Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F568C3A5A2
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 00:03:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F12AB2054F
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 00:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oGTWChG3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12AB2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1JWb-0004ui-P2
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 20:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCY-0001Nv-7K
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCW-0000Nq-Ov
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:38 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38476)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCW-0000Il-AE; Fri, 23 Aug 2019 19:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566603757; x=1598139757;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xbDp2VTa5nkr1Wtzu7iLEtCtDivv5fW+n8VqxwbfJaI=;
 b=oGTWChG3WPeNA12q2OkVdFBdTCgXG4B+CAz45A2Wd2EftUc70XekVKLC
 X8aTR/B3bo4assdJP1neWmZ8DfqvRS1GXIGGofPVrNDHb4umqT7pTilCG
 zrpoOnyglcHYERuUdGP/LLCT2fb2DLllSpBjTESckvSxY/n4BFPFEBuNb
 rJCfciTHvnY5jvSn3L67e9i0guhCqXq3OuOascqFNKBYzQ67u7AR5zwAC
 Tp0hAH4eN22zdU5KqENrtEyMMUTBEuQTZZn3r/sJtG3hxp2Jn5+upJ43f
 q4N18z3ifLXn0HAK5ayWm5q+WiYz6Qk1yjTMcseoxW7+lpLTwpJMCNo/d A==;
IronPort-SDR: cMAfVOtJjThnwSurkSw8t1w9PEy3c0/yT4w8N+e9BkoUYlKN8DlXXHAPo+yeJ5KUtygWGDCTTL
 GEDBmQaK7JyV/VbUUAyiWfd4Y7ck6y9bu0A24tignnHvN6VTgSO/Sjh8Ac6/dPqnWoaKT2uJUo
 PaBHNN2MK2N9Gvi4oj+6hdC5haaloanGqBO14sfi7fygRvhxDPTaaADfIodLvQUoyTiailGl7Y
 NMttLQXQY8W/Ay/u3ZfzLlhW5xglWlGTZNdcMNzcLY6Nk6jpRHIsLljxyJyBG0uxWSSCEO+UHA
 2MA=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="117486919"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 07:42:36 +0800
IronPort-SDR: q6sm5E7OMPszdoQk7XbbLXrMZT9O5g4FTQ9gs0qa/mU8e43p0jqahnmVZ/6Fza27f3n+KJLtoI
 hgKLnt5pmQawLji3RcP57noJzuSV/EINXuAY8tP7Vgnpp4M0qxZMtniaSjqIF3N19jWvj21yyU
 QxNC3BzU5IuNdw8J1wEbXe5WfKo1vrDx2b0FgrmEgGAqzH7peA8KLDQczd1NjMeGC6d5kZKBqT
 yW5S4T7Z7lXBhDVCsC1iHiTI4N1TskbrgE931aZ4YypG1OvGTFOl93OYsmuXcfYTPoB9aAJ+vy
 8Mq6HNMv2I/XAHJ6IAwdGn1U
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 16:39:53 -0700
IronPort-SDR: 0on1V1Ga0S8c7BQ0id/LN1bp8DD/60ScKbTTbm+97ksvp0YSYRSEDIRu50yrA1HTZR+rtdqDTD
 9fucfTG89padnL/tA2OmxpJZjsN1w9LH4KaZH3eHGdY4S7PlcT90vWUgPr/fxaAo75EIY4nRVm
 KHFHnOPr9gQqRN2VbWEGWOrtoRZe0HVMURmQNePUNImvwCapGDLrhIRK9wI3Y8921sYDTnEJd2
 qeDKSTdmCZrMLCwZYwBAgIB2Ng+fV01U2VmJXyJlP/pMYmC5qJCElkkX0f9KAcGXmwwL8sKMHR
 eeY=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 16:42:35 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 23 Aug 2019 16:38:55 -0700
Message-Id: <39abe56d7ba4d0ba392af6df09986af849f19403.1566603412.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566603412.git.alistair.francis@wdc.com>
References: <cover.1566603412.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v1 25/28] target/riscv: Call the second stage
 MMU in virtualisation mode
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

The qemu_log_mask(CPU_LOG_MMU,... calls trigger false positive
checkpatch errors which are being ignored.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 94 +++++++++++++++++++++++++++++++++++----
 1 file changed, 86 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 188d5cb39f..0761191f11 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -642,15 +642,23 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
 hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
     hwaddr phys_addr;
     int prot;
     int mmu_idx = cpu_mmu_index(&cpu->env, false);
 
-    if (get_physical_address(&cpu->env, &phys_addr, &prot, addr, 0, mmu_idx,
-                             true, false)) {
+    if (get_physical_address(env, &phys_addr, &prot, addr, 0, mmu_idx,
+                             true, riscv_cpu_virt_enabled(env))) {
         return -1;
     }
 
+    if (riscv_cpu_virt_enabled(env)) {
+        if (get_physical_address(env, &phys_addr, &prot, phys_addr,
+                                 0, mmu_idx, false, true)) {
+            return -1;
+        }
+    }
+
     return phys_addr;
 }
 
@@ -701,17 +709,35 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 #ifndef CONFIG_USER_ONLY
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
+    vaddr im_address;
     hwaddr pa = 0;
     int prot;
     bool pmp_violation = false;
+    bool m_mode_two_stage = false;
+    bool hs_mode_two_stage = false;
+    bool first_stage_error = true;
     int ret = TRANSLATE_FAIL;
     int mode = mmu_idx;
 
     qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
                   __func__, address, access_type, mmu_idx);
 
-    ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx,
-                               true, false);
+    /*
+     * Determine if we are in M mode and MPRV is set or in HS mode and SPRV is
+     * set and we want to access a virtulisation address.
+     */
+    if (riscv_has_ext(env, RVH)) {
+        m_mode_two_stage = env->priv == PRV_M &&
+                           access_type != MMU_INST_FETCH &&
+                           get_field(*env->mstatus, MSTATUS_MPRV) &&
+                           get_field(*env->mstatus, MSTATUS_MPV);
+
+        hs_mode_two_stage = env->priv == PRV_S &&
+                            !riscv_cpu_virt_enabled(env) &&
+                            access_type != MMU_INST_FETCH &&
+                            get_field(env->hstatus, HSTATUS_SPRV) &&
+                            get_field(env->hstatus, HSTATUS_SPV);
+    }
 
     if (mode == PRV_M && access_type != MMU_INST_FETCH) {
         if (get_field(*env->mstatus, MSTATUS_MPRV)) {
@@ -719,10 +745,58 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         }
     }
 
-    qemu_log_mask(CPU_LOG_MMU,
-                  "%s address=%" VADDR_PRIx " ret %d physical " TARGET_FMT_plx
-                  " prot %d\n", __func__, address, ret, pa, prot);
+    if (riscv_cpu_virt_enabled(env) || m_mode_two_stage || hs_mode_two_stage) {
+        /* Two stage lookup */
+        ret = get_physical_address(env, &pa, &prot, address, access_type,
+                                   mmu_idx, true, true);
+
+        qemu_log_mask(CPU_LOG_MMU,
+                      "%s 1st-stage address=%" VADDR_PRIx " ret %d physical "
+                      TARGET_FMT_plx " prot %d\n",
+                      __func__, address, ret, pa, prot);
+
+        if (ret == TRANSLATE_FAIL) {
+            goto tlb_lookup_done;
+        }
+
+        /* Second stage lookup */
+        im_address = pa;
 
+        ret = get_physical_address(env, &pa, &prot, im_address, access_type, mmu_idx,
+                                   false, true);
+
+        qemu_log_mask(CPU_LOG_MMU,
+                "%s 2nd-stage address=%" VADDR_PRIx " ret %d physical "
+                TARGET_FMT_plx " prot %d\n",
+                __func__, im_address, ret, pa, prot);
+
+        if (riscv_feature(env, RISCV_FEATURE_PMP) &&
+            (ret == TRANSLATE_SUCCESS) &&
+            !pmp_hart_has_privs(env, pa, size, 1 << access_type, mode)) {
+            ret = TRANSLATE_PMP_FAIL;
+        }
+
+        if (ret != TRANSLATE_SUCCESS) {
+            /*
+             * Guest physical address translation failed, this is a HS
+             * level exception
+             */
+            first_stage_error = false;
+            address = im_address | (address & (TARGET_PAGE_SIZE - 1));
+            goto tlb_lookup_done;
+        }
+    } else {
+        /* Single stage lookup */
+        ret = get_physical_address(env, &pa, &prot, address, access_type,
+                                   mmu_idx, true, false);
+
+        qemu_log_mask(CPU_LOG_MMU,
+                      "%s address=%" VADDR_PRIx " ret %d physical "
+                      TARGET_FMT_plx " prot %d\n",
+                      __func__, address, ret, pa, prot);
+    }
+
+tlb_lookup_done:
     if (riscv_feature(env, RISCV_FEATURE_PMP) &&
         (ret == TRANSLATE_SUCCESS) &&
         !pmp_hart_has_privs(env, pa, size, 1 << access_type, mode)) {
@@ -731,6 +805,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     if (ret == TRANSLATE_PMP_FAIL) {
         pmp_violation = true;
     }
+
     if (ret == TRANSLATE_SUCCESS) {
         tlb_set_page(cs, address & TARGET_PAGE_MASK, pa & TARGET_PAGE_MASK,
                      prot, mmu_idx, TARGET_PAGE_SIZE);
@@ -738,9 +813,12 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     } else if (probe) {
         return false;
     } else {
-        raise_mmu_exception(env, address, access_type, pmp_violation, true);
+        raise_mmu_exception(env, address, access_type, pmp_violation, first_stage_error);
         riscv_raise_exception(env, cs->exception_index, retaddr);
     }
+
+    return true;
+
 #else
     switch (access_type) {
     case MMU_INST_FETCH:
-- 
2.22.0


