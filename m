Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654E8C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 14:13:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 334BC206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 14:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dYZPggY7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 334BC206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0QLm-0006EC-Gk
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 10:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k0QJ3-0003IP-LQ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 10:10:13 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53488)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k0QJ1-0006d3-85
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 10:10:13 -0400
Received: by mail-wm1-x344.google.com with SMTP id g8so6292744wmk.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 07:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4coBDICnjHJO+AJICY4wzMsyHlEruM/1bvobKPsXPTA=;
 b=dYZPggY7lsW49vbrtQdmKjaQ8xpn0PQZa72334VqZQ3VVeLHNoijNQT5oqCPuU3Bz8
 98bxGIWga9rHDLLIePKzv4IIqUw4qhOYCTa70qArtodXh3qpFqiaP68fFx0+JSID2uO7
 4DVarl2xpInoRl7p/7DvGGGL+A3YH1LcveEXqXLfQThbknSHBvcDAgjahvVIVpAiSBfa
 APz5a9F1IcTwzOhuRisazTbE2p41QL57Drn1MhO72XlpIcqOHOJD7QdnVoks7DSrHsEa
 mdruOB9HcagxNaN87Z9vV7jcSztFP2es1H6wyiV+xWfJD0bKV/a+orZfqlWx710k5a3S
 gmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4coBDICnjHJO+AJICY4wzMsyHlEruM/1bvobKPsXPTA=;
 b=BCAA30mfC5caRauSl/bVecSalmjOH27DOOdNMJNGXmppmqS+S7Lascxt8GDQv5Cwxq
 uAq88mkPofwqCOUY2bWQSuOpAa4GD9JqZNWC2BIYlKzlNITAqc4S/y8Ju9LRsZlM6iNo
 6VyA759I3XhWNV5tWZVY8/5EHxxPHM+fYGCw/pv1PP2pw00NDbNhO/+fK15k3yHwRgPU
 duEIxGk43eOucQhlrKuEqqj+uU4fAr/K6MR6IFXvNukTkmdZaY+fwsIYwTMKR4pXkp9s
 lkt7yMJHTXv/MTLKjSw1Y92VQtJhC4GXP/1OD5RFrqG+XcRIiSjkP2yozlkujATsfS5b
 XL5Q==
X-Gm-Message-State: AOAM532LE6E58jlZd5SRJOipnOw4sSsfEFDJAqeln+omD3MgrNzo3zKm
 QlkpplGBZKhu/4fB/wyg8O20bA==
X-Google-Smtp-Source: ABdhPJxIoddAjPv0qIQGrqGaPbl7UzlIaHqGojPy6Z++nTI1FP/X0OoURL0YozA7V/9/msp2H5Wyaw==
X-Received: by 2002:a1c:2e07:: with SMTP id u7mr4501732wmu.52.1595945409623;
 Tue, 28 Jul 2020 07:10:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h199sm4584938wme.42.2020.07.28.07.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2020 07:10:08 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A4BF71FF8C;
 Tue, 28 Jul 2020 15:10:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 2/2] target/arm: only set the nexttick timer if !ISTATUS
Date: Tue, 28 Jul 2020 15:10:05 +0100
Message-Id: <20200728141005.28664-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200728141005.28664-1-alex.bennee@linaro.org>
References: <20200728141005.28664-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, boost.lists@gmail.com,
 victor.clement@openwide.fr, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 pavel.dovgaluk@ispras.ru, pbonzini@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Otherwise we have an unfortunate interaction with -count sleep=off
which means we fast forward time when we don't need to. The easiest
way to trigger it was to attach to the gdbstub and place a break point
at the timers IRQ routine. Once the timer fired setting the next event
at INT_MAX then qemu_start_warp_timer would skip to the end.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/helper.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c69a2baf1d3..ec1b84cf0fd 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2683,7 +2683,7 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
         uint64_t count = gt_get_countervalue(&cpu->env);
         /* Note that this must be unsigned 64 bit arithmetic: */
         int istatus = count - offset >= gt->cval;
-        uint64_t nexttick;
+        uint64_t nexttick = 0;
         int irqstate;
 
         gt->ctl = deposit32(gt->ctl, 2, 1, istatus);
@@ -2692,21 +2692,30 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
         qemu_set_irq(cpu->gt_timer_outputs[timeridx], irqstate);
 
         if (istatus) {
-            /* Next transition is when count rolls back over to zero */
-            nexttick = UINT64_MAX;
+            /*
+             * The IRQ status of the timer will persist until:
+             *   - CVAL is changed or
+             *   - ENABLE is changed
+             *
+             * There is no point re-arming the timer for some far
+             * flung future - currently it just is.
+             */
+            timer_del(cpu->gt_timer[timeridx]);
         } else {
             /* Next transition is when we hit cval */
             nexttick = gt->cval + offset;
-        }
-        /* Note that the desired next expiry time might be beyond the
-         * signed-64-bit range of a QEMUTimer -- in this case we just
-         * set the timer for as far in the future as possible. When the
-         * timer expires we will reset the timer for any remaining period.
-         */
-        if (nexttick > INT64_MAX / gt_cntfrq_period_ns(cpu)) {
-            timer_mod_ns(cpu->gt_timer[timeridx], INT64_MAX);
-        } else {
-            timer_mod(cpu->gt_timer[timeridx], nexttick);
+
+            /*
+             * It is possible the next tick is beyond the
+             * signed-64-bit range of a QEMUTimer but currently the
+             * timer system doesn't support a run time of more the 292
+             * odd years so we set it to INT_MAX in this case.
+             */
+            if (nexttick > INT64_MAX / gt_cntfrq_period_ns(cpu)) {
+                timer_mod_ns(cpu->gt_timer[timeridx], INT64_MAX);
+            } else {
+                timer_mod(cpu->gt_timer[timeridx], nexttick);
+            }
         }
         trace_arm_gt_recalc(timeridx, irqstate, nexttick);
     } else {
-- 
2.20.1


