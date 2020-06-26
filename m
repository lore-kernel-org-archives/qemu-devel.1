Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEFFC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:37:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A8FE20773
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NjWB6ru+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8FE20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqPU-0007dw-7g
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4d-0003D6-NU
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:27 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:33166)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4a-0006i5-Sx
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:27 -0400
Received: by mail-wm1-x32a.google.com with SMTP id a6so9089213wmm.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=VcBtpjeZz3a61u/7X0eqoIvF4Di9aqxcRFdw58SYd9s=;
 b=NjWB6ru+H6ptdq2Wke53tODPf8aWr0Cc3CcEk9hxtsbB5iiT3XIHoYjZbazMHw7W5H
 Kc7ZrbBOhvLD3Ok44HWqpE7SjXebsGOyHzjJ3rs1ev5nMFY//IwAiwnRMO4Olwvazl+7
 bv+5Zn4HAEinw1BXCGzWgieOHOCIh24HEJ5NMj/ygOhk831bOUuI4VAMgNG+Z8DN1WvT
 0jT3OF+XP4NGOIgVqn2l+VNpuJDsCL+Djgsdj2iNiYDgkzv79LvPDp06zdCK5ziATCMF
 C1lxHZpi5y/fIHuZB4/iiOO+dxp5O56WrD03Oj5wu7jax0lOKxnydF3msqXWOgVjVtJL
 8JSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VcBtpjeZz3a61u/7X0eqoIvF4Di9aqxcRFdw58SYd9s=;
 b=be8obh8+klYwuZe4YObCIa58QQ0gK3xdRr4p2O6J8L7iLezfuKXusJSZkOJKB7NrQZ
 5cLzTZLUWF5/P9yvgAFXbEk8VWwkU+C7Hu3MYqYfDDtPUWtyYmqRQYbtL2j1feYOivlU
 aiHWnj+s8ezHV/KQLjqT+GmRODYJLcsn2wQo3kT+xOduiV+szlTvAQNOH/S0L+ivlzZr
 YSNv7rE3DIKSevhqUj93idGxECFrjtT5tnfH3pgVQD2Wk+wj8flBZmfH8gDbaPmz/xoU
 ZHYHbWqWtOvhTQg2MuRiTfO0IOz/apU2X+dcgwv7EkyUNTt+oNSgu9bfyROq4wZxJpKT
 wuGw==
X-Gm-Message-State: AOAM530QbqjW+sktNKtiTgvh6DwkEYM9CgVa5nmJ9Rklinu7tntb3un8
 RgJppjlDp0lnoa701MIlXUe/jKTW5F/11Q==
X-Google-Smtp-Source: ABdhPJx+/hp7KKJ6Tbuiapx+25dc4pHJzIk1nHjhshsmxVy/M0cPiFvBQ553kxCh5HuYk+ujO/aIJw==
X-Received: by 2002:a1c:ba08:: with SMTP id k8mr3898364wmf.28.1593184522885;
 Fri, 26 Jun 2020 08:15:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.15.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:15:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/57] target/arm: Add mte helpers for sve scalar + int ff/nf
 loads
Date: Fri, 26 Jun 2020 16:14:14 +0100
Message-Id: <20200626151424.30117-48-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Because the elements are sequential, we can eliminate many tests all
at once when the tag hits TCMA, or if the page(s) are not Tagged.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200626033144.790098-36-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-sve.h    |  98 ++++++++++++++++
 target/arm/sve_helper.c    |  99 ++++++++++++++--
 target/arm/translate-sve.c | 232 +++++++++++++++++++++++++------------
 3 files changed, 343 insertions(+), 86 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 1425f33c927..f48752eb421 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -1285,6 +1285,55 @@ DEF_HELPER_FLAGS_4(sve_ldff1sds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ldff1dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ldff1dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
+DEF_HELPER_FLAGS_4(sve_ldff1bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1bhu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1bsu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1bdu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1bhs_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1bss_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1bds_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldff1hh_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hsu_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hdu_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hss_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hds_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldff1hh_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hsu_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hdu_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hss_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hds_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldff1ss_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1sdu_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1sds_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldff1ss_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1sdu_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1sds_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldff1dd_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1dd_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+
 DEF_HELPER_FLAGS_4(sve_ldnf1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ldnf1bhu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ldnf1bsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
@@ -1316,6 +1365,55 @@ DEF_HELPER_FLAGS_4(sve_ldnf1sds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ldnf1dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ldnf1dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
+DEF_HELPER_FLAGS_4(sve_ldnf1bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1bhu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1bsu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1bdu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1bhs_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1bss_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1bds_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldnf1hh_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hsu_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hdu_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hss_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hds_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldnf1hh_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hsu_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hdu_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hss_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hds_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldnf1ss_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1sdu_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1sds_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldnf1ss_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1sdu_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1sds_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldnf1dd_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1dd_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+
 DEF_HELPER_FLAGS_4(sve_st1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st2bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st3bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index ded9cedd18d..7aca4ad3840 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4794,7 +4794,7 @@ static void record_fault(CPUARMState *env, uintptr_t i, uintptr_t oprsz)
  */
 static inline QEMU_ALWAYS_INLINE
 void sve_ldnfff1_r(CPUARMState *env, void *vg, const target_ulong addr,
-                   uint32_t desc, const uintptr_t retaddr,
+                   uint32_t desc, const uintptr_t retaddr, uint32_t mtedesc,
                    const int esz, const int msz, const SVEContFault fault,
                    sve_ldst1_host_fn *host_fn,
                    sve_ldst1_tlb_fn *tlb_fn)
@@ -4826,13 +4826,25 @@ void sve_ldnfff1_r(CPUARMState *env, void *vg, const target_ulong addr,
     mem_off = info.mem_off_first[0];
     flags = info.page[0].flags;
 
+    /*
+     * Disable MTE checking if the Tagged bit is not set.  Since TBI must
+     * be set within MTEDESC for MTE, !mtedesc => !mte_active.
+     */
+    if (arm_tlb_mte_tagged(&info.page[0].attrs)) {
+        mtedesc = 0;
+    }
+
     if (fault == FAULT_FIRST) {
+        /* Trapping mte check for the first-fault element.  */
+        if (mtedesc) {
+            mte_check1(env, mtedesc, addr + mem_off, retaddr);
+        }
+
         /*
          * Special handling of the first active element,
          * if it crosses a page boundary or is MMIO.
          */
         bool is_split = mem_off == info.mem_off_split;
-        /* TODO: MTE check. */
         if (unlikely(flags != 0) || unlikely(is_split)) {
             /*
              * Use the slow path for cross-page handling.
@@ -4868,7 +4880,9 @@ void sve_ldnfff1_r(CPUARMState *env, void *vg, const target_ulong addr,
                 /* Watchpoint hit, see below. */
                 goto do_fault;
             }
-            /* TODO: MTE check. */
+            if (mtedesc && !mte_probe1(env, mtedesc, addr + mem_off)) {
+                goto do_fault;
+            }
             /*
              * Use the slow path for cross-page handling.
              * This is RAM, without a watchpoint, and will not trap.
@@ -4916,7 +4930,9 @@ void sve_ldnfff1_r(CPUARMState *env, void *vg, const target_ulong addr,
                      & BP_MEM_READ)) {
                     goto do_fault;
                 }
-                /* TODO: MTE check. */
+                if (mtedesc && !mte_probe1(env, mtedesc, addr + mem_off)) {
+                    goto do_fault;
+                }
                 host_fn(vd, reg_off, host + mem_off);
             }
             reg_off += 1 << esz;
@@ -4954,44 +4970,103 @@ void sve_ldnfff1_r(CPUARMState *env, void *vg, const target_ulong addr,
     record_fault(env, reg_off, reg_max);
 }
 
-#define DO_LDFF1_LDNF1_1(PART, ESZ) \
+static inline QEMU_ALWAYS_INLINE
+void sve_ldnfff1_r_mte(CPUARMState *env, void *vg, target_ulong addr,
+                       uint32_t desc, const uintptr_t retaddr,
+                       const int esz, const int msz, const SVEContFault fault,
+                       sve_ldst1_host_fn *host_fn,
+                       sve_ldst1_tlb_fn *tlb_fn)
+{
+    uint32_t mtedesc = desc >> (SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
+    int bit55 = extract64(addr, 55, 1);
+
+    /* Remove mtedesc from the normal sve descriptor. */
+    desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
+
+    /* Perform gross MTE suppression early. */
+    if (!tbi_check(desc, bit55) ||
+        tcma_check(desc, bit55, allocation_tag_from_addr(addr))) {
+        mtedesc = 0;
+    }
+
+    sve_ldnfff1_r(env, vg, addr, desc, retaddr, mtedesc,
+                  esz, msz, fault, host_fn, tlb_fn);
+}
+
+#define DO_LDFF1_LDNF1_1(PART, ESZ)                                     \
 void HELPER(sve_ldff1##PART##_r)(CPUARMState *env, void *vg,            \
                                  target_ulong addr, uint32_t desc)      \
 {                                                                       \
-    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), ESZ, MO_8, FAULT_FIRST, \
+    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), 0, ESZ, MO_8, FAULT_FIRST, \
                   sve_ld1##PART##_host, sve_ld1##PART##_tlb);           \
 }                                                                       \
 void HELPER(sve_ldnf1##PART##_r)(CPUARMState *env, void *vg,            \
                                  target_ulong addr, uint32_t desc)      \
 {                                                                       \
-    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), ESZ, MO_8, FAULT_NO,    \
+    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), 0, ESZ, MO_8, FAULT_NO, \
+                  sve_ld1##PART##_host, sve_ld1##PART##_tlb);           \
+}                                                                       \
+void HELPER(sve_ldff1##PART##_r_mte)(CPUARMState *env, void *vg,        \
+                                     target_ulong addr, uint32_t desc)  \
+{                                                                       \
+    sve_ldnfff1_r_mte(env, vg, addr, desc, GETPC(), ESZ, MO_8, FAULT_FIRST, \
+                      sve_ld1##PART##_host, sve_ld1##PART##_tlb);       \
+}                                                                       \
+void HELPER(sve_ldnf1##PART##_r_mte)(CPUARMState *env, void *vg,        \
+                                     target_ulong addr, uint32_t desc)  \
+{                                                                       \
+    sve_ldnfff1_r_mte(env, vg, addr, desc, GETPC(), ESZ, MO_8, FAULT_NO, \
                   sve_ld1##PART##_host, sve_ld1##PART##_tlb);           \
 }
 
-#define DO_LDFF1_LDNF1_2(PART, ESZ, MSZ) \
+#define DO_LDFF1_LDNF1_2(PART, ESZ, MSZ)                                \
 void HELPER(sve_ldff1##PART##_le_r)(CPUARMState *env, void *vg,         \
                                     target_ulong addr, uint32_t desc)   \
 {                                                                       \
-    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_FIRST,  \
+    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), 0, ESZ, MSZ, FAULT_FIRST, \
                   sve_ld1##PART##_le_host, sve_ld1##PART##_le_tlb);     \
 }                                                                       \
 void HELPER(sve_ldnf1##PART##_le_r)(CPUARMState *env, void *vg,         \
                                     target_ulong addr, uint32_t desc)   \
 {                                                                       \
-    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_NO,     \
+    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), 0, ESZ, MSZ, FAULT_NO,  \
                   sve_ld1##PART##_le_host, sve_ld1##PART##_le_tlb);     \
 }                                                                       \
 void HELPER(sve_ldff1##PART##_be_r)(CPUARMState *env, void *vg,         \
                                     target_ulong addr, uint32_t desc)   \
 {                                                                       \
-    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_FIRST,  \
+    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), 0, ESZ, MSZ, FAULT_FIRST, \
                   sve_ld1##PART##_be_host, sve_ld1##PART##_be_tlb);     \
 }                                                                       \
 void HELPER(sve_ldnf1##PART##_be_r)(CPUARMState *env, void *vg,         \
                                     target_ulong addr, uint32_t desc)   \
 {                                                                       \
-    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_NO,     \
+    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), 0, ESZ, MSZ, FAULT_NO,  \
                   sve_ld1##PART##_be_host, sve_ld1##PART##_be_tlb);     \
+}                                                                       \
+void HELPER(sve_ldff1##PART##_le_r_mte)(CPUARMState *env, void *vg,     \
+                                        target_ulong addr, uint32_t desc) \
+{                                                                       \
+    sve_ldnfff1_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_FIRST, \
+                      sve_ld1##PART##_le_host, sve_ld1##PART##_le_tlb); \
+}                                                                       \
+void HELPER(sve_ldnf1##PART##_le_r_mte)(CPUARMState *env, void *vg,     \
+                                        target_ulong addr, uint32_t desc) \
+{                                                                       \
+    sve_ldnfff1_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_NO, \
+                      sve_ld1##PART##_le_host, sve_ld1##PART##_le_tlb); \
+}                                                                       \
+void HELPER(sve_ldff1##PART##_be_r_mte)(CPUARMState *env, void *vg,     \
+                                        target_ulong addr, uint32_t desc) \
+{                                                                       \
+    sve_ldnfff1_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_FIRST, \
+                      sve_ld1##PART##_be_host, sve_ld1##PART##_be_tlb); \
+}                                                                       \
+void HELPER(sve_ldnf1##PART##_be_r_mte)(CPUARMState *env, void *vg,     \
+                                        target_ulong addr, uint32_t desc) \
+{                                                                       \
+    sve_ldnfff1_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_NO, \
+                      sve_ld1##PART##_be_host, sve_ld1##PART##_be_tlb); \
 }
 
 DO_LDFF1_LDNF1_1(bb,  MO_8)
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index daac8589f33..e4fbe484930 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4773,104 +4773,188 @@ static bool trans_LD_zpri(DisasContext *s, arg_rpri_load *a)
 
 static bool trans_LDFF1_zprr(DisasContext *s, arg_rprr_load *a)
 {
-    static gen_helper_gvec_mem * const fns[2][16] = {
-        /* Little-endian */
-        { gen_helper_sve_ldff1bb_r,
-          gen_helper_sve_ldff1bhu_r,
-          gen_helper_sve_ldff1bsu_r,
-          gen_helper_sve_ldff1bdu_r,
+    static gen_helper_gvec_mem * const fns[2][2][16] = {
+        { /* mte inactive, little-endian */
+          { gen_helper_sve_ldff1bb_r,
+            gen_helper_sve_ldff1bhu_r,
+            gen_helper_sve_ldff1bsu_r,
+            gen_helper_sve_ldff1bdu_r,
 
-          gen_helper_sve_ldff1sds_le_r,
-          gen_helper_sve_ldff1hh_le_r,
-          gen_helper_sve_ldff1hsu_le_r,
-          gen_helper_sve_ldff1hdu_le_r,
+            gen_helper_sve_ldff1sds_le_r,
+            gen_helper_sve_ldff1hh_le_r,
+            gen_helper_sve_ldff1hsu_le_r,
+            gen_helper_sve_ldff1hdu_le_r,
 
-          gen_helper_sve_ldff1hds_le_r,
-          gen_helper_sve_ldff1hss_le_r,
-          gen_helper_sve_ldff1ss_le_r,
-          gen_helper_sve_ldff1sdu_le_r,
+            gen_helper_sve_ldff1hds_le_r,
+            gen_helper_sve_ldff1hss_le_r,
+            gen_helper_sve_ldff1ss_le_r,
+            gen_helper_sve_ldff1sdu_le_r,
 
-          gen_helper_sve_ldff1bds_r,
-          gen_helper_sve_ldff1bss_r,
-          gen_helper_sve_ldff1bhs_r,
-          gen_helper_sve_ldff1dd_le_r },
+            gen_helper_sve_ldff1bds_r,
+            gen_helper_sve_ldff1bss_r,
+            gen_helper_sve_ldff1bhs_r,
+            gen_helper_sve_ldff1dd_le_r },
 
-        /* Big-endian */
-        { gen_helper_sve_ldff1bb_r,
-          gen_helper_sve_ldff1bhu_r,
-          gen_helper_sve_ldff1bsu_r,
-          gen_helper_sve_ldff1bdu_r,
+          /* mte inactive, big-endian */
+          { gen_helper_sve_ldff1bb_r,
+            gen_helper_sve_ldff1bhu_r,
+            gen_helper_sve_ldff1bsu_r,
+            gen_helper_sve_ldff1bdu_r,
 
-          gen_helper_sve_ldff1sds_be_r,
-          gen_helper_sve_ldff1hh_be_r,
-          gen_helper_sve_ldff1hsu_be_r,
-          gen_helper_sve_ldff1hdu_be_r,
+            gen_helper_sve_ldff1sds_be_r,
+            gen_helper_sve_ldff1hh_be_r,
+            gen_helper_sve_ldff1hsu_be_r,
+            gen_helper_sve_ldff1hdu_be_r,
 
-          gen_helper_sve_ldff1hds_be_r,
-          gen_helper_sve_ldff1hss_be_r,
-          gen_helper_sve_ldff1ss_be_r,
-          gen_helper_sve_ldff1sdu_be_r,
+            gen_helper_sve_ldff1hds_be_r,
+            gen_helper_sve_ldff1hss_be_r,
+            gen_helper_sve_ldff1ss_be_r,
+            gen_helper_sve_ldff1sdu_be_r,
 
-          gen_helper_sve_ldff1bds_r,
-          gen_helper_sve_ldff1bss_r,
-          gen_helper_sve_ldff1bhs_r,
-          gen_helper_sve_ldff1dd_be_r },
+            gen_helper_sve_ldff1bds_r,
+            gen_helper_sve_ldff1bss_r,
+            gen_helper_sve_ldff1bhs_r,
+            gen_helper_sve_ldff1dd_be_r } },
+
+        { /* mte active, little-endian */
+          { gen_helper_sve_ldff1bb_r_mte,
+            gen_helper_sve_ldff1bhu_r_mte,
+            gen_helper_sve_ldff1bsu_r_mte,
+            gen_helper_sve_ldff1bdu_r_mte,
+
+            gen_helper_sve_ldff1sds_le_r_mte,
+            gen_helper_sve_ldff1hh_le_r_mte,
+            gen_helper_sve_ldff1hsu_le_r_mte,
+            gen_helper_sve_ldff1hdu_le_r_mte,
+
+            gen_helper_sve_ldff1hds_le_r_mte,
+            gen_helper_sve_ldff1hss_le_r_mte,
+            gen_helper_sve_ldff1ss_le_r_mte,
+            gen_helper_sve_ldff1sdu_le_r_mte,
+
+            gen_helper_sve_ldff1bds_r_mte,
+            gen_helper_sve_ldff1bss_r_mte,
+            gen_helper_sve_ldff1bhs_r_mte,
+            gen_helper_sve_ldff1dd_le_r_mte },
+
+          /* mte active, big-endian */
+          { gen_helper_sve_ldff1bb_r_mte,
+            gen_helper_sve_ldff1bhu_r_mte,
+            gen_helper_sve_ldff1bsu_r_mte,
+            gen_helper_sve_ldff1bdu_r_mte,
+
+            gen_helper_sve_ldff1sds_be_r_mte,
+            gen_helper_sve_ldff1hh_be_r_mte,
+            gen_helper_sve_ldff1hsu_be_r_mte,
+            gen_helper_sve_ldff1hdu_be_r_mte,
+
+            gen_helper_sve_ldff1hds_be_r_mte,
+            gen_helper_sve_ldff1hss_be_r_mte,
+            gen_helper_sve_ldff1ss_be_r_mte,
+            gen_helper_sve_ldff1sdu_be_r_mte,
+
+            gen_helper_sve_ldff1bds_r_mte,
+            gen_helper_sve_ldff1bss_r_mte,
+            gen_helper_sve_ldff1bhs_r_mte,
+            gen_helper_sve_ldff1dd_be_r_mte } },
     };
 
     if (sve_access_check(s)) {
         TCGv_i64 addr = new_tmp_a64(s);
         tcg_gen_shli_i64(addr, cpu_reg(s, a->rm), dtype_msz(a->dtype));
         tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, a->rn));
-        do_mem_zpa(s, a->rd, a->pg, addr, a->dtype, 0, false,
-                   fns[s->be_data == MO_BE][a->dtype]);
+        do_mem_zpa(s, a->rd, a->pg, addr, a->dtype, 1, false,
+                   fns[s->mte_active[0]][s->be_data == MO_BE][a->dtype]);
     }
     return true;
 }
 
 static bool trans_LDNF1_zpri(DisasContext *s, arg_rpri_load *a)
 {
-    static gen_helper_gvec_mem * const fns[2][16] = {
-        /* Little-endian */
-        { gen_helper_sve_ldnf1bb_r,
-          gen_helper_sve_ldnf1bhu_r,
-          gen_helper_sve_ldnf1bsu_r,
-          gen_helper_sve_ldnf1bdu_r,
+    static gen_helper_gvec_mem * const fns[2][2][16] = {
+        { /* mte inactive, little-endian */
+          { gen_helper_sve_ldnf1bb_r,
+            gen_helper_sve_ldnf1bhu_r,
+            gen_helper_sve_ldnf1bsu_r,
+            gen_helper_sve_ldnf1bdu_r,
 
-          gen_helper_sve_ldnf1sds_le_r,
-          gen_helper_sve_ldnf1hh_le_r,
-          gen_helper_sve_ldnf1hsu_le_r,
-          gen_helper_sve_ldnf1hdu_le_r,
+            gen_helper_sve_ldnf1sds_le_r,
+            gen_helper_sve_ldnf1hh_le_r,
+            gen_helper_sve_ldnf1hsu_le_r,
+            gen_helper_sve_ldnf1hdu_le_r,
 
-          gen_helper_sve_ldnf1hds_le_r,
-          gen_helper_sve_ldnf1hss_le_r,
-          gen_helper_sve_ldnf1ss_le_r,
-          gen_helper_sve_ldnf1sdu_le_r,
+            gen_helper_sve_ldnf1hds_le_r,
+            gen_helper_sve_ldnf1hss_le_r,
+            gen_helper_sve_ldnf1ss_le_r,
+            gen_helper_sve_ldnf1sdu_le_r,
 
-          gen_helper_sve_ldnf1bds_r,
-          gen_helper_sve_ldnf1bss_r,
-          gen_helper_sve_ldnf1bhs_r,
-          gen_helper_sve_ldnf1dd_le_r },
+            gen_helper_sve_ldnf1bds_r,
+            gen_helper_sve_ldnf1bss_r,
+            gen_helper_sve_ldnf1bhs_r,
+            gen_helper_sve_ldnf1dd_le_r },
 
-        /* Big-endian */
-        { gen_helper_sve_ldnf1bb_r,
-          gen_helper_sve_ldnf1bhu_r,
-          gen_helper_sve_ldnf1bsu_r,
-          gen_helper_sve_ldnf1bdu_r,
+          /* mte inactive, big-endian */
+          { gen_helper_sve_ldnf1bb_r,
+            gen_helper_sve_ldnf1bhu_r,
+            gen_helper_sve_ldnf1bsu_r,
+            gen_helper_sve_ldnf1bdu_r,
 
-          gen_helper_sve_ldnf1sds_be_r,
-          gen_helper_sve_ldnf1hh_be_r,
-          gen_helper_sve_ldnf1hsu_be_r,
-          gen_helper_sve_ldnf1hdu_be_r,
+            gen_helper_sve_ldnf1sds_be_r,
+            gen_helper_sve_ldnf1hh_be_r,
+            gen_helper_sve_ldnf1hsu_be_r,
+            gen_helper_sve_ldnf1hdu_be_r,
 
-          gen_helper_sve_ldnf1hds_be_r,
-          gen_helper_sve_ldnf1hss_be_r,
-          gen_helper_sve_ldnf1ss_be_r,
-          gen_helper_sve_ldnf1sdu_be_r,
+            gen_helper_sve_ldnf1hds_be_r,
+            gen_helper_sve_ldnf1hss_be_r,
+            gen_helper_sve_ldnf1ss_be_r,
+            gen_helper_sve_ldnf1sdu_be_r,
 
-          gen_helper_sve_ldnf1bds_r,
-          gen_helper_sve_ldnf1bss_r,
-          gen_helper_sve_ldnf1bhs_r,
-          gen_helper_sve_ldnf1dd_be_r },
+            gen_helper_sve_ldnf1bds_r,
+            gen_helper_sve_ldnf1bss_r,
+            gen_helper_sve_ldnf1bhs_r,
+            gen_helper_sve_ldnf1dd_be_r } },
+
+        { /* mte inactive, little-endian */
+          { gen_helper_sve_ldnf1bb_r_mte,
+            gen_helper_sve_ldnf1bhu_r_mte,
+            gen_helper_sve_ldnf1bsu_r_mte,
+            gen_helper_sve_ldnf1bdu_r_mte,
+
+            gen_helper_sve_ldnf1sds_le_r_mte,
+            gen_helper_sve_ldnf1hh_le_r_mte,
+            gen_helper_sve_ldnf1hsu_le_r_mte,
+            gen_helper_sve_ldnf1hdu_le_r_mte,
+
+            gen_helper_sve_ldnf1hds_le_r_mte,
+            gen_helper_sve_ldnf1hss_le_r_mte,
+            gen_helper_sve_ldnf1ss_le_r_mte,
+            gen_helper_sve_ldnf1sdu_le_r_mte,
+
+            gen_helper_sve_ldnf1bds_r_mte,
+            gen_helper_sve_ldnf1bss_r_mte,
+            gen_helper_sve_ldnf1bhs_r_mte,
+            gen_helper_sve_ldnf1dd_le_r_mte },
+
+          /* mte inactive, big-endian */
+          { gen_helper_sve_ldnf1bb_r_mte,
+            gen_helper_sve_ldnf1bhu_r_mte,
+            gen_helper_sve_ldnf1bsu_r_mte,
+            gen_helper_sve_ldnf1bdu_r_mte,
+
+            gen_helper_sve_ldnf1sds_be_r_mte,
+            gen_helper_sve_ldnf1hh_be_r_mte,
+            gen_helper_sve_ldnf1hsu_be_r_mte,
+            gen_helper_sve_ldnf1hdu_be_r_mte,
+
+            gen_helper_sve_ldnf1hds_be_r_mte,
+            gen_helper_sve_ldnf1hss_be_r_mte,
+            gen_helper_sve_ldnf1ss_be_r_mte,
+            gen_helper_sve_ldnf1sdu_be_r_mte,
+
+            gen_helper_sve_ldnf1bds_r_mte,
+            gen_helper_sve_ldnf1bss_r_mte,
+            gen_helper_sve_ldnf1bhs_r_mte,
+            gen_helper_sve_ldnf1dd_be_r_mte } },
     };
 
     if (sve_access_check(s)) {
@@ -4880,8 +4964,8 @@ static bool trans_LDNF1_zpri(DisasContext *s, arg_rpri_load *a)
         TCGv_i64 addr = new_tmp_a64(s);
 
         tcg_gen_addi_i64(addr, cpu_reg_sp(s, a->rn), off);
-        do_mem_zpa(s, a->rd, a->pg, addr, a->dtype, 0, false,
-                   fns[s->be_data == MO_BE][a->dtype]);
+        do_mem_zpa(s, a->rd, a->pg, addr, a->dtype, 1, false,
+                   fns[s->mte_active[0]][s->be_data == MO_BE][a->dtype]);
     }
     return true;
 }
-- 
2.20.1


