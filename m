Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BB8C282E1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:01:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8883720717
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ljKrv88x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8883720717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33440 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUK87-0000y9-Mb
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 20:01:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUK3s-0005Im-88
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:57:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJvK-0004mE-44
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:48:31 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:5536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJvJ-0004l4-Oi; Fri, 24 May 2019 19:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1558741709; x=1590277709;
	h=from:to:cc:subject:date:message-id:in-reply-to:
	references:mime-version:content-transfer-encoding;
	bh=eIB9eI6L2M66ALqcQ/sKS+2/cPf5O19r/6iL+QzBTLc=;
	b=ljKrv88xmzZtb6UX5k1ucDRkKZa7zTH2NxEdu3iOGw9Cos20DTenYf7T
	E/itHkF/O5RUAo8HVKRRg8HYWO0bN1CtU9C2yihHUJgmmKVvM6snUdydX
	GpCuoyvRhgtGgQ0NOoIaWpSPxIFz8tlTHKHcTVKmDDpvDBCTDd61qaPzW
	u0IWV67oID6X6vWxY8L6CoyhuJ0UEfTKjyjrYmmlKOUUvB+cI7vrkJ2p0
	Y6SahkgfZsLa73ob7XaJMmgwfnKPV1icSjYZgU9YxODHUTYrRZx2AXbL7
	AXKBmNej6Ei7cTBjBEUhkSqYUjLRQ7ryQ11ms9pHzMJEHiqAs3wDBFHa8 g==;
X-IronPort-AV: E=Sophos;i="5.60,508,1549900800"; d="scan'208";a="215265039"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
	([199.255.45.15])
	by ob1.hgst.iphmx.com with ESMTP; 25 May 2019 07:48:28 +0800
IronPort-SDR: BsjHU8BQp9HI/AHPyuiDmf6tFOR8AhiwiXckBMYC2T63fsLHsl1a4NYC4EjZrLnlkmXxjlocH4
	iLEqJy9EQVEMCDkHV3leedpC/QiRKAGodsa5vDuPq9BoG9V0YFgtZzypcdBAaoChgVAaQ7gWm6
	eigd9HWWQeXIirTSZF3Bhg/R2je7HeiO4f8yDRysDzoYDmoz9JQBSJB7A4mLQol7zXSdOi4NOC
	X89uz1g0YTp3DsOXk/14eW/HcVy00L12O9QHz4HXEokPTcfOBwPcgr/XT2Een+3fmDfrDPPB/g
	ICj7IkGAVRpXWKlCM715l/sm
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
	by uls-op-cesaep02.wdc.com with ESMTP; 24 May 2019 16:26:07 -0700
IronPort-SDR: FYoz2VOgvpqVXF+7F4PXPyVEnxCTAxjwYySVkwoardOiGv44jwzCyAyNJtEDwEuUiem7InMDRv
	QKi5hU0P9a76tXOsYmghFWTGmTrcHS+KXvtwX49+CnmtFswRsIDo7p5Z+VvMOiU+J7MyqwKLSv
	dpPufo9kR29SpAQqHbIOdzjth9dHORTLtbjYxaBT66f2SriAcugx5A8EHD+xWrkXojvzD57xNi
	11KqCFrtmy+EGZUteAVbppKzVRuLtP8pn1ig4UV0Q5ToUG+ECfKv92nnppQufVszO6BYJTJ72l
	yNQ=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
	risc6-mainframe.int.fusionio.com) ([10.196.157.140])
	by uls-op-cesaip01.wdc.com with ESMTP; 24 May 2019 16:48:29 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 24 May 2019 16:46:33 -0700
Message-Id: <a52e30a4be4bc83aa0d29685b6f2c80fb466ab39.1558741334.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558741334.git.alistair.francis@wdc.com>
References: <cover.1558741334.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 68.232.141.245
Subject: [Qemu-devel] [RFC v1 22/23] target/riscv: Call the second stage MMU
 in virtualisation mode
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The qemu_log_mask(CPU_LOG_MMU,... calls trigger false positive
checkpatch errors which are being ignored.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 118 ++++++++++++++++++++++++++++++++------
 1 file changed, 99 insertions(+), 19 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 387c12547b..99091ed0fd 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -569,15 +569,23 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
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
 
@@ -628,34 +636,106 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 #ifndef CONFIG_USER_ONLY
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
+    vaddr im_address;
     hwaddr pa = 0;
     int prot;
+    bool m_mode_two_stage = false;
+    bool hs_mode_two_stage = false;
     int ret = TRANSLATE_FAIL;
 
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
+                           get_field(env->mstatus, MSTATUS_MPRV) &&
+                           get_field(env->mstatus, MSTATUS_MPV);
+
+        hs_mode_two_stage = env->priv == PRV_S &&
+                            !riscv_cpu_virt_enabled(env) &&
+                            access_type != MMU_INST_FETCH &&
+                            get_field(env->hstatus, HSTATUS_SPRV) &&
+                            get_field(env->hstatus, HSTATUS_SPV);
+    }
+
+    if (riscv_cpu_virt_enabled(env) || m_mode_two_stage || hs_mode_two_stage) {
+        /* Two stage lookup */
+        ret = get_physical_address(env, &pa, &prot, address, access_type,
+                                   mmu_idx, true, true);
 
-    qemu_log_mask(CPU_LOG_MMU,
-                  "%s address=%" VADDR_PRIx " ret %d physical " TARGET_FMT_plx
-                  " prot %d\n", __func__, address, ret, pa, prot);
+        qemu_log_mask(CPU_LOG_MMU,
+                      "%s 1st-stage address=%" VADDR_PRIx " ret %d physical "
+                      TARGET_FMT_plx " prot %d\n",
+                      __func__, address, ret, pa, prot);
 
-    if (riscv_feature(env, RISCV_FEATURE_PMP) &&
-        !pmp_hart_has_privs(env, pa, TARGET_PAGE_SIZE, 1 << access_type)) {
-        ret = TRANSLATE_FAIL;
-    }
-    if (ret == TRANSLATE_SUCCESS) {
-        tlb_set_page(cs, address & TARGET_PAGE_MASK, pa & TARGET_PAGE_MASK,
-                     prot, mmu_idx, TARGET_PAGE_SIZE);
-        return true;
-    } else if (probe) {
-        return false;
+        if (ret == TRANSLATE_FAIL) {
+            if (!probe) {
+                raise_mmu_exception(env, address, access_type, true);
+                riscv_raise_exception(env, cs->exception_index, retaddr);
+            }
+            return ret;
+        }
+
+        /* Second stage lookup */
+        im_address = pa;
+
+        ret = get_physical_address(env, &pa, &prot, im_address, access_type, mmu_idx,
+                                   false, true);
+
+        qemu_log_mask(CPU_LOG_MMU,
+                "%s 2nd-stage address=%" VADDR_PRIx " ret %d physical "
+                TARGET_FMT_plx " prot %d\n",
+                __func__, im_address, ret, pa, prot);
+
+        if (riscv_feature(env, RISCV_FEATURE_PMP) &&
+            !pmp_hart_has_privs(env, pa, TARGET_PAGE_SIZE, 1 << access_type)) {
+            ret = TRANSLATE_FAIL;
+        }
+
+        if (ret == TRANSLATE_FAIL) {
+            /*
+             * Guest physical address translation failed, this is a HS
+             * level exception
+             */
+            if (!probe) {
+                raise_mmu_exception(env, im_address | (address & (TARGET_PAGE_SIZE - 1)), access_type, false);
+                riscv_raise_exception(env, cs->exception_index, retaddr);
+            }
+            return ret;
+        }
     } else {
-        raise_mmu_exception(env, address, access_type, true);
-        riscv_raise_exception(env, cs->exception_index, retaddr);
+        /* Single stage lookup */
+        ret = get_physical_address(env, &pa, &prot, address, access_type,
+                                   mmu_idx, true, false);
+
+        qemu_log_mask(CPU_LOG_MMU,
+                      "%s address=%" VADDR_PRIx " ret %d physical "
+                      TARGET_FMT_plx " prot %d\n",
+                      __func__, address, ret, pa, prot);
+
+        if (riscv_feature(env, RISCV_FEATURE_PMP) &&
+            !pmp_hart_has_privs(env, pa, TARGET_PAGE_SIZE, 1 << access_type)) {
+            ret = TRANSLATE_FAIL;
+        }
+
+        if (ret == TRANSLATE_FAIL) {
+            if (!probe) {
+                raise_mmu_exception(env, address, access_type, true);
+                riscv_raise_exception(env, cs->exception_index, retaddr);
+            }
+            return ret;
+        }
     }
+
+    tlb_set_page(cs, address & TARGET_PAGE_MASK, pa & TARGET_PAGE_MASK,
+                 prot, mmu_idx, TARGET_PAGE_SIZE);
+    return true;
+
 #else
     switch (access_type) {
     case MMU_INST_FETCH:
-- 
2.21.0


