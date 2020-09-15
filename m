Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AADC2BBD1
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 03:16:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F13EF208DB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 03:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r/eqxy6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13EF208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI1Rz-0006Ih-3K
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 23:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kI1O9-0000J4-Ol
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 23:12:13 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:37705)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kI1O7-0001iC-NY
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 23:12:13 -0400
Received: by mail-pj1-x1044.google.com with SMTP id kk9so1006958pjb.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 20:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oRDNCGgDBV3Hs+I8rUYyH4/axR+nkyINEYfVA07Svm8=;
 b=r/eqxy6qNaDEoTjVfM6kNl/hY0aJpJrlyf1Oz3HZ4edMewD3MeeOniccB1j/AFr2Jh
 tEXsXevlGxa9TezG/q61uthkpCtsy48vvx4kUEoJRlFh6uCyT13O7llV1NobBI1frDPR
 VeCXMqNJx1y5xmkogrn3PIRXOIV10RYOPcAKwZOUu6eAK+HPPVNrpy8nlae9uLA+Im6L
 1Zd/TDp8Yb22vn821HqZpR4doJj+JhH/0TBkb6UxW2A3vvpBlOvMOsVi3uSpeE8ng2DO
 6+V32BJcGcMuMBq0v+YlKJGcSK9WGHqoClLpE+0E1T5sLStehreaoyNI8O6q0MptfkvK
 Pl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oRDNCGgDBV3Hs+I8rUYyH4/axR+nkyINEYfVA07Svm8=;
 b=rNOlvq2ONmFFj9+8gYPU7isZo5nOrWLG2NhplcApbCoi9lioYAmRAhwdGoxGre7Olh
 z/uLzO+84ibH/SZDItz1FBh/mwasq8CStGeMFTgbOlNdKRPHBhYG2sXMYnSr8/qVIVZg
 pfuAPaBcRFB9PtDI7pLJpRQYUM8Tc4kuT+FyhVvX1qtzQBPM48qPPZE7xrvQEyJGAryG
 Y+CCawBF4VbYaWkMGjZiyQlNJOEwlN11qk4n7Nqqb/Me/H5OPA2Spojtj7v6VZ1zAi5c
 j8UBdiRRJqGcGHcyFBnJLZNPXBcd7gih0XaMiUBBp/pajEVwjBDWHwMpfnxx++5ShzhG
 djsw==
X-Gm-Message-State: AOAM530Wls5SXunRkApecDeyHmOWBIIDbqUlA0S8Hl22CxKL+MFz0gr7
 fvn7IbjXPnhnJCdS0ADQ/yc2
X-Google-Smtp-Source: ABdhPJxuEOCDRg0UG8MIYLPcNqws56UZZMTltBtxlLvuX9ljERXxRgDe6aqDErDytSVZ8Q/gX99ktw==
X-Received: by 2002:a17:90a:4005:: with SMTP id u5mr2126190pjc.7.1600139530286; 
 Mon, 14 Sep 2020 20:12:10 -0700 (PDT)
Received: from localhost.localdomain ([147.75.106.138])
 by smtp.gmail.com with ESMTPSA id g23sm11551776pfh.133.2020.09.14.20.12.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 20:12:09 -0700 (PDT)
From: Haibo Xu <haibo.xu@linaro.org>
To: drjones@redhat.com,
	richard.henderson@linaro.org
Subject: [PATCH v3 05/12] target/arm/kvm: spe: Unify device attr operation
 helper
Date: Tue, 15 Sep 2020 03:11:41 +0000
Message-Id: <ed8d8d525139ac67569293d089e5508e37811b1c.1600135462.git.haibo.xu@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1600135462.git.haibo.xu@linaro.org>
References: <cover.1600135462.git.haibo.xu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=haibo.xu@linaro.org; helo=mail-pj1-x1044.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, philmd@redhat.com,
 qemu-devel@nongnu.org, Haibo Xu <haibo.xu@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew Jones <drjones@redhat.com>

Rename kvm_arm_pmu_set_attr() to kvm_arm_set_device_attr(),
So both the vPMU and vSPE device can share the same API.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
---
 target/arm/kvm64.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index ef1e960285..8ffd31ffdf 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -397,19 +397,20 @@ static CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, target_ulong addr)
     return NULL;
 }
 
-static bool kvm_arm_pmu_set_attr(CPUState *cs, struct kvm_device_attr *attr)
+static bool kvm_arm_set_device_attr(CPUState *cs, struct kvm_device_attr *attr,
+                                    const char *name)
 {
     int err;
 
     err = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, attr);
     if (err != 0) {
-        error_report("PMU: KVM_HAS_DEVICE_ATTR: %s", strerror(-err));
+        error_report("%s: KVM_HAS_DEVICE_ATTR: %s", name, strerror(-err));
         return false;
     }
 
     err = kvm_vcpu_ioctl(cs, KVM_SET_DEVICE_ATTR, attr);
     if (err != 0) {
-        error_report("PMU: KVM_SET_DEVICE_ATTR: %s", strerror(-err));
+        error_report("%s: KVM_SET_DEVICE_ATTR: %s", name, strerror(-err));
         return false;
     }
 
@@ -426,7 +427,7 @@ void kvm_arm_pmu_init(CPUState *cs)
     if (!ARM_CPU(cs)->has_pmu) {
         return;
     }
-    if (!kvm_arm_pmu_set_attr(cs, &attr)) {
+    if (!kvm_arm_set_device_attr(cs, &attr, "PMU")) {
         error_report("failed to init PMU");
         abort();
     }
@@ -443,7 +444,7 @@ void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
     if (!ARM_CPU(cs)->has_pmu) {
         return;
     }
-    if (!kvm_arm_pmu_set_attr(cs, &attr)) {
+    if (!kvm_arm_set_device_attr(cs, &attr, "PMU")) {
         error_report("failed to set irq for PMU");
         abort();
     }
-- 
2.17.1


