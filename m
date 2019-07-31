Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB88FC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:43:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BC7520659
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pd4FHlXV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC7520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsvRE-0005tW-QN
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 16:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60842)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMk-0004PZ-4l
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMj-0003R5-5d
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:30 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:42596)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsvMj-0003Qc-0J
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:29 -0400
Received: by mail-pg1-x542.google.com with SMTP id t132so32632425pgb.9
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 13:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ebweW1bxG4mlr4zUkxD0Pv+fcpZzn603jNjjqkso5Rc=;
 b=Pd4FHlXVvd1NDlai2uvi/QThJmS6tM9qc8YQZhRRXPHzO/xGKv4PyTfytTx+FuzJGw
 8vMOLE4mLSYhTlI9N+sVoOdsrBLamtj+EXgP+UI0WYyZ/+5LgzMwUgnziTwp2kGegI8V
 ZenC+sp7oFcVh713Ov6tWgN6zxk8h3UB24DfggXhtQTUP57LWiMsbBVhrnCknyVK1qh5
 7ZeAIvsKW+e4BqdQQheZohhIRLftBqR0a8i4JKYeaU83Px/TdNaK/yOI4g1rGGjiDm6V
 hEeuvwi1VxTfJ5lcBVI+4bu/Wj0bry6xnF2Um0HQxOJdON+QyWgeMiZolQaUWwZax2Hp
 TUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ebweW1bxG4mlr4zUkxD0Pv+fcpZzn603jNjjqkso5Rc=;
 b=ESdtlkJ+2zMJpFp6ELuQQ5ArCHZK2uoElb+rgaFb/WJs7U6wTkK97vU7uvp+F3EJO+
 dn/gUB9yxE3w7WowltgVNsn7Pd/15G61vIoC5wtVcqTSNkVsHqYqgQ1thORkYsaphmNp
 gPlqVSwFA0wnlAl9MRQA3yoAQo1/NW8FIlnQNi7YQinyg57jU/NSV2G5dLrgGSzlZ+ok
 tdSo32YU5didPBmuoyzjiCz09liC6eUCybHG1Hfl/PVr2li10/Hys95ly6eI5+ONCJEo
 p6dhGAp/xcaovG/k3lpK34W2gS/DgBfaP6TrGBizm0MsNGVvoQMNYw0eFdpEQw+JCilk
 o+WQ==
X-Gm-Message-State: APjAAAUJHf9oaL9Nmd4SwHudebTgSrhkbT0lRNROGLH+MqZM+Im8MX4X
 6hSItZ6xLuqtOBGNueXU9ND0dhzbu/I=
X-Google-Smtp-Source: APXvYqzIpj1PYk8SZZchf81xB6FYstaT2805Ekm/aKloX7Cr22N30pDGchCcQmW19UGq4I0YnJ+QXQ==
X-Received: by 2002:a63:f452:: with SMTP id p18mr89844584pgk.373.1564605507738; 
 Wed, 31 Jul 2019 13:38:27 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g4sm84054164pfo.93.2019.07.31.13.38.26
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 13:38:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:37:51 -0700
Message-Id: <20190731203813.30765-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731203813.30765-1-richard.henderson@linaro.org>
References: <20190731203813.30765-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v2 10/32] target/arm: Update CNTVCT_EL0 for VHE
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The virtual offset may be 0 depending on EL, E2H and TGE.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8d8b3cc40e..e2fcb03da5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2484,9 +2484,31 @@ static uint64_t gt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return gt_get_countervalue(env);
 }
 
+static uint64_t gt_virt_cnt_offset(CPUARMState *env)
+{
+    uint64_t hcr;
+
+    switch (arm_current_el(env)) {
+    case 2:
+        hcr = arm_hcr_el2_eff(env);
+        if (hcr & HCR_E2H) {
+            return 0;
+        }
+        break;
+    case 0:
+        hcr = arm_hcr_el2_eff(env);
+        if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
+            return 0;
+        }
+        break;
+    }
+
+    return env->cp15.cntvoff_el2;
+}
+
 static uint64_t gt_virt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    return gt_get_countervalue(env) - env->cp15.cntvoff_el2;
+    return gt_get_countervalue(env) - gt_virt_cnt_offset(env);
 }
 
 static void gt_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -2501,7 +2523,13 @@ static void gt_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static uint64_t gt_tval_read(CPUARMState *env, const ARMCPRegInfo *ri,
                              int timeridx)
 {
-    uint64_t offset = timeridx == GTIMER_VIRT ? env->cp15.cntvoff_el2 : 0;
+    uint64_t offset = 0;
+
+    switch (timeridx) {
+    case GTIMER_VIRT:
+        offset = gt_virt_cnt_offset(env);
+        break;
+    }
 
     return (uint32_t)(env->cp15.c14_timer[timeridx].cval -
                       (gt_get_countervalue(env) - offset));
@@ -2511,7 +2539,13 @@ static void gt_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
                           int timeridx,
                           uint64_t value)
 {
-    uint64_t offset = timeridx == GTIMER_VIRT ? env->cp15.cntvoff_el2 : 0;
+    uint64_t offset = 0;
+
+    switch (timeridx) {
+    case GTIMER_VIRT:
+        offset = gt_virt_cnt_offset(env);
+        break;
+    }
 
     trace_arm_gt_tval_write(timeridx, value);
     env->cp15.c14_timer[timeridx].cval = gt_get_countervalue(env) - offset +
-- 
2.17.1


