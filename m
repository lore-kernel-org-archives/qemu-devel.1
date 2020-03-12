Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6E1C2BB1D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:50:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC481206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PRuEC7/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC481206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCR2a-00037Y-Rn
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxI-00086d-6l
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxH-000505-0X
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:08 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45176)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCQxG-0004zl-Qx
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:06 -0400
Received: by mail-wr1-x441.google.com with SMTP id m9so8335355wro.12
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 09:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ZDzXTbj3Kw0VgoD1DocT1IFxe6z/Gv28taLlkqSSY/U=;
 b=PRuEC7/edkiJsdXwpeDJtSXKcWVYp5olEGh9yBc9wMLpkK/zgWBaYP1oXti/76n4qD
 riupAACdZeiC99shMS6UVryeeGque6iR67/EK3QvFmz9AaTd0Pg5gukTbETFZRmVPVvT
 qMkimTmw7mHMxLkmCl1dg/kHBTXw3oKu1Au4kz71+J8/8KG95POx2eTAidp/kJ26exLB
 M24+TombE/uWQeTlo63Y01PVCPBPnOh9Ifju5nA6Y84satB3Ab5WZo1eIKxC1YekTtoj
 47rdwmPTOwrbl4vO1BL3EubLhxiEJ319miHv/6Vd/3DxOfVYWNy7R9tgVqC86gd6SUZ4
 72LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZDzXTbj3Kw0VgoD1DocT1IFxe6z/Gv28taLlkqSSY/U=;
 b=KK8w1gcjexa+HHrdlVXX8MwlE5ajjiCQf5g1G/ioN9ZdCYo8aqlkyYQ7dD/PWtVlMq
 wm8DR7l8rptMJQVwU6xkEXHC9jZhsarLLj1PcLWjUy0HJ8Edqo/oGdkbgFqZqL9d4rr1
 v0lQ46YBFm0nni87d62Hz+WjmyIFDY/AThP518bA86lgCtT7wnnXL941EA+qe5Aoinzv
 XU7TBxJ4ylWDAP2TNwR1sj/QV3DK8UekD4UHID8VxrRok6j6oPr9DNBbduiWDQCo+5Yb
 L0VO9gc0KhEu5M4JhXQlyRo0L5/YRdC+KM339Kfd3h4aXiGRPCkPeTfRRuLjslCI8Dvs
 lA3A==
X-Gm-Message-State: ANhLgQ1l2h/hFP1W6GxPLCE+3WEllUve2vjZ20/CQAFXrDP4zZrUPyN5
 KdpEsvDVjNDy/nugiJiDVmW6yqy12rMhkQ==
X-Google-Smtp-Source: ADFU+vtFmm2hmtVGUSYTQ8HefUCbxEf/0dXT5olI4sbJ5C1hgR6bSgCH53Ytw2slC5j/HaOJR4jE7A==
X-Received: by 2002:adf:e911:: with SMTP id f17mr11381689wrm.87.1584031505649; 
 Thu, 12 Mar 2020 09:45:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm36838640wrp.85.2020.03.12.09.45.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 09:45:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/36] target/arm: Recalculate hflags correctly after writes to
 CONTROL
Date: Thu, 12 Mar 2020 16:44:26 +0000
Message-Id: <20200312164459.25924-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312164459.25924-1-peter.maydell@linaro.org>
References: <20200312164459.25924-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

A write to the CONTROL register can change our current EL (by
writing to the nPRIV bit). That means that we can't assume
that s->current_el is still valid in trans_MSR_v7m() when
we try to rebuild the hflags.

Add a new helper rebuild_hflags_m32_newel() which, like the
existing rebuild_hflags_a32_newel(), recalculates the current
EL from scratch, and use it in trans_MSR_v7m().

This fixes an assertion about an hflags mismatch when the
guest changes privilege by writing to CONTROL.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200303174950.3298-4-peter.maydell@linaro.org
---
 target/arm/helper.h    |  1 +
 target/arm/helper.c    | 12 ++++++++++++
 target/arm/translate.c |  7 +++----
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 72eb9e6a1a5..f37b8670a55 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -90,6 +90,7 @@ DEF_HELPER_4(msr_banked, void, env, i32, i32, i32)
 DEF_HELPER_2(get_user_reg, i32, env, i32)
 DEF_HELPER_3(set_user_reg, void, env, i32, i32)
 
+DEF_HELPER_FLAGS_1(rebuild_hflags_m32_newel, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_2(rebuild_hflags_m32, TCG_CALL_NO_RWG, void, env, int)
 DEF_HELPER_FLAGS_1(rebuild_hflags_a32_newel, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_2(rebuild_hflags_a32, TCG_CALL_NO_RWG, void, env, int)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f91e5d5345f..bc64077ec7c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12468,6 +12468,18 @@ void arm_rebuild_hflags(CPUARMState *env)
     env->hflags = rebuild_hflags_internal(env);
 }
 
+/*
+ * If we have triggered a EL state change we can't rely on the
+ * translator having passed it to us, we need to recompute.
+ */
+void HELPER(rebuild_hflags_m32_newel)(CPUARMState *env)
+{
+    int el = arm_current_el(env);
+    int fp_el = fp_exception_el(env, el);
+    ARMMMUIdx mmu_idx = arm_mmu_idx_el(env, el);
+    env->hflags = rebuild_hflags_m32(env, fp_el, mmu_idx);
+}
+
 void HELPER(rebuild_hflags_m32)(CPUARMState *env, int el)
 {
     int fp_el = fp_exception_el(env, el);
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7f0154194cf..4715ca0d2ad 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8551,7 +8551,7 @@ static bool trans_MRS_v7m(DisasContext *s, arg_MRS_v7m *a)
 
 static bool trans_MSR_v7m(DisasContext *s, arg_MSR_v7m *a)
 {
-    TCGv_i32 addr, reg, el;
+    TCGv_i32 addr, reg;
 
     if (!arm_dc_feature(s, ARM_FEATURE_M)) {
         return false;
@@ -8561,9 +8561,8 @@ static bool trans_MSR_v7m(DisasContext *s, arg_MSR_v7m *a)
     gen_helper_v7m_msr(cpu_env, addr, reg);
     tcg_temp_free_i32(addr);
     tcg_temp_free_i32(reg);
-    el = tcg_const_i32(s->current_el);
-    gen_helper_rebuild_hflags_m32(cpu_env, el);
-    tcg_temp_free_i32(el);
+    /* If we wrote to CONTROL, the EL might have changed */
+    gen_helper_rebuild_hflags_m32_newel(cpu_env);
     gen_lookup_tb(s);
     return true;
 }
-- 
2.20.1


