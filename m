Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AE5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:35:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E115420663
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="M/Q5BgY4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E115420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh1GX-0001mh-TK
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 21:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4185f83b6=alistair.francis@wdc.com>)
 id 1jh1BP-00028u-AF; Thu, 04 Jun 2020 21:30:07 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:2768)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4185f83b6=alistair.francis@wdc.com>)
 id 1jh1BN-00009O-W8; Thu, 04 Jun 2020 21:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591320606; x=1622856606;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=veOH8KddxewBAO1ktp2wI9Ku5cmFe6g9CSOLpuML7tQ=;
 b=M/Q5BgY4x1a9B5IbkTr9okiBInKuZ7uBp78/lEi+QP0mJsuGb06teAjJ
 ijANkLplnrEL0rFOY+VY6fhIUhcT2gZiMhekeA24hbG1foEqfpvOrzFgN
 vYAKWJrX9y6T6d0zht5Lm6Cj4ILPiN0VHYeLDmB06ZwnFedddC6VWqJTu
 NerybhYQXMk85sdcQWRApALUajRcVqpux7ihzgum9xlSMAVWNr/MZkCUw
 Iz5oXz9z0iiYtwKe0U3QxShijA4BLFm7gHuHEOfspVWIXI9bfK68nTuWC
 /wEaSwlTRZJmv07Q22UZPhXuis/8kaXsPWFqg6+0nPwyuNXKWsoIJF6ge Q==;
IronPort-SDR: 1YyF/+xMDRij6uu8gfKBCDehyMpsRXc3+GDTa1shLsfy/EsT2Uz1Sxdy+tmJyHR6fRJR8Beihw
 yeEcCVEw5FlnB8tW6OPn7/ppHtUBrWgjhbcDdbNUuUZzs/JAYyr/HGQLg0Zul6mfbrvFUt6ExI
 qfwHnYz5VqgxBS5NGqpVqnwb6x8SOrh58gnagEBQRP6AWfVyRpA01v+QhSjPlkyDb59icCrB1q
 zvvGz8kr4M5WIDBsLGT1+fRqfNP3qmLBli59ihrPfsymhtTFxhSpdOBmENb/SOpihi5DQzDtv8
 pBQ=
X-IronPort-AV: E=Sophos;i="5.73,474,1583164800"; d="scan'208";a="143573564"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2020 09:29:50 +0800
IronPort-SDR: /tjDAdRgErrpNwtknTD/6RUkLdIB/4yiUNoJS+FtHLgErj3oslEjg6nCrc/YrikqKa+bo+hmGV
 W3RSDEcdMBWrDhuFqf7niQPVRg5ZBX7O8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2020 18:18:52 -0700
IronPort-SDR: Ke3c3Tz71RjJOKu+buhGh2Mx2CJk4uOoMjsYP+kfoFIcjbd6YmRPSqBHwSMQbc0NFykgsPCMxG
 XE0PEMzqUfvg==
WDCIronportException: Internal
Received: from cnf006056.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.233])
 by uls-op-cesaip02.wdc.com with ESMTP; 04 Jun 2020 18:29:49 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 07/17] target/riscv: Do two-stage lookups on hlv/hlvx/hsv
 instructions
Date: Thu,  4 Jun 2020 18:21:01 -0700
Message-Id: <edff0b5882e168aa9411fb54b7409386dd20a561.1591319882.git.alistair@alistair23.me>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1591319882.git.alistair@alistair23.me>
References: <cover.1591319882.git.alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=4185f83b6=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 21:29:41
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alistair.francis@wdc.com, anup.pate@wdc.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 54 +++++++++++++++------------------------
 1 file changed, 21 insertions(+), 33 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 68abccc993..1521c14b72 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -340,22 +340,13 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
      * was called. Background registers will be used if the guest has
      * forced a two stage translation to be on (in HS or M mode).
      */
+    if (riscv_cpu_two_stage_lookup(env) && access_type != MMU_INST_FETCH) {
+        use_background = true;
+    }
+
     if (mode == PRV_M && access_type != MMU_INST_FETCH) {
         if (get_field(env->mstatus, MSTATUS_MPRV)) {
             mode = get_field(env->mstatus, MSTATUS_MPP);
-
-            if (riscv_has_ext(env, RVH) &&
-                MSTATUS_MPV_ISSET(env)) {
-                use_background = true;
-            }
-        }
-    }
-
-    if (mode == PRV_S && access_type != MMU_INST_FETCH &&
-        riscv_has_ext(env, RVH) && !riscv_cpu_virt_enabled(env)) {
-        if (get_field(env->hstatus, HSTATUS_SPRV)) {
-            mode = get_field(env->mstatus, SSTATUS_SPP);
-            use_background = true;
         }
     }
 
@@ -705,8 +696,6 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     hwaddr pa = 0;
     int prot, prot2;
     bool pmp_violation = false;
-    bool m_mode_two_stage = false;
-    bool hs_mode_two_stage = false;
     bool first_stage_error = true;
     int ret = TRANSLATE_FAIL;
     int mode = mmu_idx;
@@ -716,30 +705,21 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
                   __func__, address, access_type, mmu_idx);
 
-    /*
-     * Determine if we are in M mode and MPRV is set or in HS mode and SPRV is
-     * set and we want to access a virtulisation address.
-     */
-    if (riscv_has_ext(env, RVH)) {
-        m_mode_two_stage = env->priv == PRV_M &&
-                           access_type != MMU_INST_FETCH &&
-                           get_field(env->mstatus, MSTATUS_MPRV) &&
-                           MSTATUS_MPV_ISSET(env);
-
-        hs_mode_two_stage = env->priv == PRV_S &&
-                            !riscv_cpu_virt_enabled(env) &&
-                            access_type != MMU_INST_FETCH &&
-                            get_field(env->hstatus, HSTATUS_SPRV) &&
-                            get_field(env->hstatus, HSTATUS_SPV);
-    }
-
     if (mode == PRV_M && access_type != MMU_INST_FETCH) {
         if (get_field(env->mstatus, MSTATUS_MPRV)) {
             mode = get_field(env->mstatus, MSTATUS_MPP);
         }
     }
 
-    if (riscv_cpu_virt_enabled(env) || m_mode_two_stage || hs_mode_two_stage) {
+    if (riscv_has_ext(env, RVH) && env->priv == PRV_M &&
+        access_type != MMU_INST_FETCH &&
+        get_field(env->mstatus, MSTATUS_MPRV) &&
+        MSTATUS_MPV_ISSET(env)) {
+        riscv_cpu_set_two_stage_lookup(env, true);
+    }
+
+    if (riscv_cpu_virt_enabled(env) ||
+        (riscv_cpu_two_stage_lookup(env) && access_type != MMU_INST_FETCH)) {
         /* Two stage lookup */
         ret = get_physical_address(env, &pa, &prot, address, access_type,
                                    mmu_idx, true, true);
@@ -791,6 +771,14 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                       __func__, address, ret, pa, prot);
     }
 
+    /* We did the two stage lookup based on MPRV, unset the lookup */
+    if (riscv_has_ext(env, RVH) && env->priv == PRV_M &&
+        access_type != MMU_INST_FETCH &&
+        get_field(env->mstatus, MSTATUS_MPRV) &&
+        MSTATUS_MPV_ISSET(env)) {
+        riscv_cpu_set_two_stage_lookup(env, false);
+    }
+
     if (riscv_feature(env, RISCV_FEATURE_PMP) &&
         (ret == TRANSLATE_SUCCESS) &&
         !pmp_hart_has_privs(env, pa, size, 1 << access_type, mode)) {
-- 
2.26.2


