Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2065CCA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9742173B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pch7YEBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9742173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNIWv-0003oT-Bu
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 11:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8u-00089O-BZ
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8r-0001GF-L7
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:44 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:44402)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNI8r-00014z-Ei
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:41 -0400
Received: by mail-qt1-x843.google.com with SMTP id z22so12216025qtq.11
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 08:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=v4LDoKiCDj8UEOXKdxGeWLogI6gqriKirwE9ruJcfe0=;
 b=pch7YEBHcbkJ3G36TFQnhM/UL9PaTpFqbBNyr18NhZ9em5c89l9FC5BbzzErrpaL/x
 twr46E3i15KySqyHLzMRFVaf6iSlYbZLJ9nQGULn7jQLP9uhiHoXmTaMdJpVToNd3H0t
 7g9+sFi1vDVcLv2tt5hXDcvxhseEyrhak1iX4WM2dCgplwaXNbbyX9mRCtUrXSpNYhu2
 Zh88iWomFGJ1/tmNGyrPVtR0Zvev3oZ8Fixu30Ix2NT9+YpVEUbywr8pvHw6FMw1eIqj
 MthYRGE7obg14+ryc61LsweJsqQftGUGpTXL+eLzKXmsI5QVFM3ze5lrtEKfOxqos5Ue
 nKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v4LDoKiCDj8UEOXKdxGeWLogI6gqriKirwE9ruJcfe0=;
 b=bE6Uc/r2NfAAHLprWiTwUUv59eCB03p0JJ68UpvYcrDjVQYAK3EJBGflHQvjJtU3co
 D/pUoCcZLnIHk/PGQwOgkpYQzK+rhQGKU5Ep1JW4Fnfz561oLKZymACla0dMlVetJqJ4
 +SkB+OW1ACfub1PpphkML2sO9ccV3DudIt7OCurKREOgq8eY9zEm0jDDTuAnvFMz4Ygt
 TCymwF3twJKQWY8toKidjU5TzLiTl3X8xvoZyP9Q4tgSsrtf0Gwm+O0HiXLPvCpXqOph
 JluiuWhGeTiQwpnCvGZBh18XHIAjd3linAXiK79az0Cglt1uly+Tyt7DkiFYoXzznvdH
 z7xg==
X-Gm-Message-State: APjAAAUjIPJ9sIyuRfBJBWWf5/va5QQ5AwhGhkvzdwzz3oL5yGj53bXZ
 lQME0nh65oAhSF5hDEZw9bj9nrevE84=
X-Google-Smtp-Source: APXvYqyv43VECs+qbnv5dWIVHpSWTEq8mz9IMJ5YfNvFzDAW2mdU/4weO2ygnUZX5sn0ktVM6Jhm0w==
X-Received: by 2002:ac8:542:: with SMTP id c2mr9880986qth.338.1571842875633;
 Wed, 23 Oct 2019 08:01:15 -0700 (PDT)
Received: from localhost.localdomain (198-4-20-64.static.cosmoweb.net.
 [64.20.4.198])
 by smtp.gmail.com with ESMTPSA id l189sm11030168qke.69.2019.10.23.08.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 08:01:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 10/24] target/arm: Simplify set of PSTATE_SS in
 cpu_get_tb_cpu_state
Date: Wed, 23 Oct 2019 11:00:43 -0400
Message-Id: <20191023150057.25731-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023150057.25731-1-richard.henderson@linaro.org>
References: <20191023150057.25731-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hoist the variable load for PSTATE into the existing test vs is_a64.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e2a62cf19a..398e5f5d6d 100644
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
2.17.1


