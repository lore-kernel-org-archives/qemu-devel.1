Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FA5CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:55:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CA202184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZkQXPcgh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA202184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMudb-000552-RX
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGz-0002u5-Fu
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGy-0001Mx-6x
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:29 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38588)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMuGy-0001Mp-1J
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:28 -0400
Received: by mail-wm1-x344.google.com with SMTP id 3so16198538wmi.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=c3SRR/5ATUh31uzJHoI/RZYESh8V+bDrSMsvPoCPz8M=;
 b=ZkQXPcghisdGtbOCRm8ZF4qlfwU+4gC+R+NKDq23QQcF7w0ujogPXGYyKTylCN+WrJ
 j6MoGxEmzS3QoeJD4Oid8t+2WwuKHupMv3VZP91qK8MuYPsh2xp7FvLRneYTkDkxDL5z
 keC54L1MHPXWf2aC4wgjc1MtpT5UO4BG27E3MbqSe33ISigZQVFPLppq9vtcQvnsystF
 NyN+UqchjsbOl9yBlbW4XWbB+fzZ6fXI9eDjeauq0bQ59R9WLc3DT2Ak04GqXkhm2C1e
 mI+1fxxelG3x2nGlMBlI3aFr22nrWbwZtsIjTOn5Qx+0UpzWU9+aRzHsQRSeBHMMYkrj
 ugGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c3SRR/5ATUh31uzJHoI/RZYESh8V+bDrSMsvPoCPz8M=;
 b=SXvdMcgWzrRTJ+4MhQSsJP+9JIjaTGBkPi4vUqNh5Pf/bmkoe6XBxsMVMaxIA4oN7D
 tDZMR5pifkANTzWh041OGHKlaJsakwxXLHuhEK9ddoT0ahJfzdIW900GdtqdRO/xrOR+
 rtGzSXGEKFzftKu5jwwAzvycO5q6xoLh/fCLgtBHmmOp2OOB/O4DDNPIg+5UEiXjQg1W
 fEqtvZnQ3gmMewairFCnTGX2n51zyqw+u9tywLyAqxls6VigiRsSqqjZdeYyn+vcQRgy
 Fti+hcOVorOPAks71tiTY9E2V7sa0BhHl0mUkUclIUmrMybcOidzqeMNbnd2LPx/viXX
 r63w==
X-Gm-Message-State: APjAAAX5Ubt4ISss2cy2VN1RFFBVUJofGHENvpxD23ad07ZcuwmAzsnq
 Y6pte5BvGNcP8akxDdwNvqQmlQ5AWos=
X-Google-Smtp-Source: APXvYqwP/t1Zi+KOQ0BhzBMwkRj/zdO79eF54pv57KIbbI+Z+zGsPvxQLx/2iD0PDNvJZ079HfYM3Q==
X-Received: by 2002:a7b:c186:: with SMTP id y6mr3249584wmi.67.1571751146334;
 Tue, 22 Oct 2019 06:32:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r2sm20263856wma.1.2019.10.22.06.32.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:32:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/41] target/arm: Simplify set of PSTATE_SS in
 cpu_get_tb_cpu_state
Date: Tue, 22 Oct 2019 14:31:13 +0100
Message-Id: <20191022133134.14487-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022133134.14487-1-peter.maydell@linaro.org>
References: <20191022133134.14487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

Hoist the variable load for PSTATE into the existing test vs is_a64.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191018174431.1784-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e2a62cf19a0..398e5f5d6df 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11197,7 +11197,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
     int current_el = arm_current_el(env);
     int fp_el = fp_exception_el(env, current_el);
-    uint32_t flags;
+    uint32_t flags, pstate_for_ss;
 
     if (is_a64(env)) {
         *pc = env->pc;
@@ -11205,6 +11205,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
             flags = FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
         }
+        pstate_for_ss = env->pstate;
     } else {
         *pc = env->regs[15];
 
@@ -11257,9 +11258,11 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             || arm_el_is_aa64(env, 1) || arm_feature(env, ARM_FEATURE_M)) {
             flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
         }
+        pstate_for_ss = env->uncached_cpsr;
     }
 
-    /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
+    /*
+     * The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
      * states defined in the ARM ARM for software singlestep:
      *  SS_ACTIVE   PSTATE.SS   State
      *     0            x       Inactive (the TB flag for SS is always 0)
@@ -11267,16 +11270,9 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
      *     1            1       Active-not-pending
      * SS_ACTIVE is set in hflags; PSTATE_SS is computed every TB.
      */
-    if (FIELD_EX32(flags, TBFLAG_ANY, SS_ACTIVE)) {
-        if (is_a64(env)) {
-            if (env->pstate & PSTATE_SS) {
-                flags = FIELD_DP32(flags, TBFLAG_ANY, PSTATE_SS, 1);
-            }
-        } else {
-            if (env->uncached_cpsr & PSTATE_SS) {
-                flags = FIELD_DP32(flags, TBFLAG_ANY, PSTATE_SS, 1);
-            }
-        }
+    if (FIELD_EX32(flags, TBFLAG_ANY, SS_ACTIVE) &&
+        (pstate_for_ss & PSTATE_SS)) {
+        flags = FIELD_DP32(flags, TBFLAG_ANY, PSTATE_SS, 1);
     }
 
     *pflags = flags;
-- 
2.20.1


