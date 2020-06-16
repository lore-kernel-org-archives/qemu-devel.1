Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A8BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:09:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA4D520707
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ds7BSCND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4D520707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl8Wi-0000PH-SC
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LV-0007hD-0R
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:33 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:41074)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LT-00043r-Aw
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:32 -0400
Received: by mail-wr1-x432.google.com with SMTP id j10so20068688wrw.8
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 02:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Xh9JIi5PO56r8qT3WMZmDFfqkHR1pjd5NKcmDZUKJ3Y=;
 b=Ds7BSCND5Hn7V+9HWGss3MVN1eu+d+8kbO85T7MJduJP1Lcmq5KUCr8gGZv07/xXZd
 KiQFwruiX4b824CpWX7pksKM14DRf0B3LrLoi7kg1LmmohyPwAdC5Q7VfI5/MFJ4PhcI
 9Y1zyAQvn1emydEZR92S2FfjshkKFOTh9LxpOdYpDzHdwYCkr+SE9FlvB7A4pdrWZ8n6
 kBQ4X8z73SBkLG/Kbym+jm6QM35X1W79C74D8YofErhKDUboV0Wn+XYTx7vTb04ArpJI
 1t+YsvgUQkSYivnQ0FT8zMsCGVTy3o6XkUX/r3rfgPtySJ5q4whn+drNU/c7O8GYXex6
 9LWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Xh9JIi5PO56r8qT3WMZmDFfqkHR1pjd5NKcmDZUKJ3Y=;
 b=CmROpsa0775ANH62OyjL5UNPUVEP5Am5iT7h6S+wy1+vR1HEl6bQjMvvhWE8wn9hLe
 3TbaXMj8FdzhB/rpMyU51OXgQ2QtrYoJWfthHC4S7AqMj9uzpCQ2x8/I5o/RI1DRXczN
 4iYWJpdTeAxuqh2zXmp0z8lTXRgh65EHaa+0C4EOT9Wn5ZGQ0UK0Ts5xn2eECYQqfkN2
 QlfB1zb9SycheNzEk1iVgFPE3LDhikAQjT35Nu3VEzi9zkhMaZAOFrlKAlGOKzbte7d4
 Bi4tq6IovMq/rNhQ5HvJr9mMAz3BKno/jixesd6vwivlqmWAL3aVD/XMOBxzCllHu661
 HJKw==
X-Gm-Message-State: AOAM531ygsJAGrbJVPDyBSGzR6guxYG2sVoQQqatR+CgPdhNGirF6Zo3
 lXv90eQj89Tt9dZeOirAEbe2NVVa6g8uZg==
X-Google-Smtp-Source: ABdhPJzYZDUm4MYFZHJSwFvOy6XZwKTt47t1TAC0fPlDubZeerXIdBwCJ1gXA9Hb3EESIXaIQlmJEA==
X-Received: by 2002:adf:e387:: with SMTP id e7mr2165543wrm.70.1592301448759;
 Tue, 16 Jun 2020 02:57:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z12sm31090851wrg.9.2020.06.16.02.57.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 02:57:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/23] target/arm/cpu: adjust virtual time for all KVM arm cpus
Date: Tue, 16 Jun 2020 10:56:59 +0100
Message-Id: <20200616095702.25848-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616095702.25848-1-peter.maydell@linaro.org>
References: <20200616095702.25848-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

From: fangying <fangying1@huawei.com>

Virtual time adjustment was implemented for virt-5.0 machine type,
but the cpu property was enabled only for host-passthrough and max
cpu model.  Let's add it for any KVM arm cpu which has the generic
timer feature enabled.

Signed-off-by: Ying Fang <fangying1@huawei.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Message-id: 20200608121243.2076-1-fangying1@huawei.com
[PMM: minor commit message tweak, removed inaccurate
 suggested-by tag]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c   |  6 ++++--
 target/arm/cpu64.c |  1 -
 target/arm/kvm.c   | 21 +++++++++++----------
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 32bec156f2d..5b7a36b5d7e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1245,6 +1245,10 @@ void arm_cpu_post_init(Object *obj)
     if (arm_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER)) {
         qdev_property_add_static(DEVICE(cpu), &arm_cpu_gt_cntfrq_property);
     }
+
+    if (kvm_enabled()) {
+        kvm_arm_add_vcpu_properties(obj);
+    }
 }
 
 static void arm_cpu_finalizefn(Object *obj)
@@ -2029,7 +2033,6 @@ static void arm_max_initfn(Object *obj)
 
     if (kvm_enabled()) {
         kvm_arm_set_cpu_features_from_host(cpu);
-        kvm_arm_add_vcpu_properties(obj);
     } else {
         cortex_a15_initfn(obj);
 
@@ -2183,7 +2186,6 @@ static void arm_host_initfn(Object *obj)
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         aarch64_add_sve_properties(obj);
     }
-    kvm_arm_add_vcpu_properties(obj);
     arm_cpu_post_init(obj);
 }
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index cbc5c3868fc..778cecc2e6c 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -592,7 +592,6 @@ static void aarch64_max_initfn(Object *obj)
 
     if (kvm_enabled()) {
         kvm_arm_set_cpu_features_from_host(cpu);
-        kvm_arm_add_vcpu_properties(obj);
     } else {
         uint64_t t;
         uint32_t u;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 4bdbe6dcac0..eef3bbd1cc2 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -194,17 +194,18 @@ static void kvm_no_adjvtime_set(Object *obj, bool value, Error **errp)
 /* KVM VCPU properties should be prefixed with "kvm-". */
 void kvm_arm_add_vcpu_properties(Object *obj)
 {
-    if (!kvm_enabled()) {
-        return;
-    }
+    ARMCPU *cpu = ARM_CPU(obj);
+    CPUARMState *env = &cpu->env;
 
-    ARM_CPU(obj)->kvm_adjvtime = true;
-    object_property_add_bool(obj, "kvm-no-adjvtime", kvm_no_adjvtime_get,
-                             kvm_no_adjvtime_set);
-    object_property_set_description(obj, "kvm-no-adjvtime",
-                                    "Set on to disable the adjustment of "
-                                    "the virtual counter. VM stopped time "
-                                    "will be counted.");
+    if (arm_feature(env, ARM_FEATURE_GENERIC_TIMER)) {
+        cpu->kvm_adjvtime = true;
+        object_property_add_bool(obj, "kvm-no-adjvtime", kvm_no_adjvtime_get,
+                                 kvm_no_adjvtime_set);
+        object_property_set_description(obj, "kvm-no-adjvtime",
+                                        "Set on to disable the adjustment of "
+                                        "the virtual counter. VM stopped time "
+                                        "will be counted.");
+    }
 }
 
 bool kvm_arm_pmu_supported(CPUState *cpu)
-- 
2.20.1


