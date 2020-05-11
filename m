Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6DCC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:42:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E276206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IagC0eV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E276206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY8hk-0001xL-FK
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 09:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8Zw-0002Vt-Uc
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:44 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:52132)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8Zv-0007Co-Q0
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:44 -0400
Received: by mail-wm1-x335.google.com with SMTP id f134so5900554wmf.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 06:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=EycYX61osoiUiTKFgHPBJxcF1OjdHnGeFDt+a8slNIw=;
 b=IagC0eV3GbvO+tI5GJbDS25Os/grZzVWaQyRGqejkYach3H8Pb3w4FDj04Jspye/Yk
 OVhzZHzh7k6bscJjZdN1hbCsBIT9+u/UrdWOzBX1obOd0x0q9nk/lT0M6pAQksTtQixh
 8RWJ1na0z7hjZ9lFQ3bcwVE+FXoVoNuhA0mHTtYFnE9njZjE0AfUUfg7dxmwaaDrZqQU
 +EcrUZ1z2DuGt/W1fiO6qYMBJpqn+dGVz9D8CjY+c87Tp+tpYDe7EGn5bvhrdF1QsbN0
 uZeSwXus3N/aZxtzfP4J8kxQg796Oz9/mBvtSCPC7/7rxn7GnsIbQmTPNuF1YUP8JOF/
 mupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EycYX61osoiUiTKFgHPBJxcF1OjdHnGeFDt+a8slNIw=;
 b=KW2J2H1lPwi8i3OZZhk3ZkVn5pnH/17zU6gu5Q6N/NwsJGzC9PiQPMOigohSi2tqkZ
 7wX8r69H6Jp76adBFhDdl8DpMvOHbq3V2OUsnJA9JfG9WD7WDaT/0jtrP/f0q0jePFuK
 KSFa/3xlQeMhcYNrnqK1rXPW4VshAWPasfgNi8/RhXtgbI2WMV26Chk4hzxBwEuajoUG
 5kNKUlHqndMzG5u3QwtIIKtdmMsQP2vhjZ+2fkFWodZWUJpm2XIyK6crzJuicKEZVXjU
 0sP1nqociEE5s9F3lo+5g2DdDVD/wlu83sgD39AqGdavSs9ZV288eDjrvlh+HeFIsvRE
 1eeg==
X-Gm-Message-State: AGi0PuafnvvGeURvCDlHxUxozdPuweLOJgCOM8VW2TClY6/814GG1V0v
 Xnz1A5uyeDTISVR06/1ZTPqchuEMFEG/tQ==
X-Google-Smtp-Source: APiQypJQ2fDECOnU6bV5jAI3Nvtmsv4YGdFrpXNHCKF6u9ZNfKGAxI4sOq2WgXkigh9o1lQcopcT4w==
X-Received: by 2002:a1c:e903:: with SMTP id q3mr30634884wmc.76.1589204082008; 
 Mon, 11 May 2020 06:34:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m3sm2154818wrn.96.2020.05.11.06.34.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 06:34:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/34] target/arm/kvm: Inline set_feature() calls
Date: Mon, 11 May 2020 14:33:58 +0100
Message-Id: <20200511133405.5275-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511133405.5275-1-peter.maydell@linaro.org>
References: <20200511133405.5275-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

We want to move the inlined declarations of set_feature()
from cpu*.c to cpu.h. To avoid clashing with the KVM
declarations, inline the few KVM calls.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200504172448.9402-2-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm32.c | 13 ++++---------
 target/arm/kvm64.c | 22 ++++++----------------
 2 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index f271181ab8e..7b3a19e9aef 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -22,11 +22,6 @@
 #include "internals.h"
 #include "qemu/log.h"
 
-static inline void set_feature(uint64_t *features, int feature)
-{
-    *features |= 1ULL << feature;
-}
-
 static int read_sys_reg32(int fd, uint32_t *pret, uint64_t id)
 {
     struct kvm_one_reg idreg = { .id = id, .addr = (uintptr_t)pret };
@@ -146,14 +141,14 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
      * timers; this in turn implies most of the other feature
      * bits, but a few must be tested.
      */
-    set_feature(&features, ARM_FEATURE_V7VE);
-    set_feature(&features, ARM_FEATURE_GENERIC_TIMER);
+    features |= 1ULL << ARM_FEATURE_V7VE;
+    features |= 1ULL << ARM_FEATURE_GENERIC_TIMER;
 
     if (extract32(id_pfr0, 12, 4) == 1) {
-        set_feature(&features, ARM_FEATURE_THUMB2EE);
+        features |= 1ULL << ARM_FEATURE_THUMB2EE;
     }
     if (extract32(ahcf->isar.mvfr1, 12, 4) == 1) {
-        set_feature(&features, ARM_FEATURE_NEON);
+        features |= 1ULL << ARM_FEATURE_NEON;
     }
 
     ahcf->features = features;
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index be5b31c2b0f..cd8ab6b8aed 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -447,16 +447,6 @@ void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
     }
 }
 
-static inline void set_feature(uint64_t *features, int feature)
-{
-    *features |= 1ULL << feature;
-}
-
-static inline void unset_feature(uint64_t *features, int feature)
-{
-    *features &= ~(1ULL << feature);
-}
-
 static int read_sys_reg32(int fd, uint32_t *pret, uint64_t id)
 {
     uint64_t ret;
@@ -648,11 +638,11 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
      * with VFPv4+Neon; this in turn implies most of the other
      * feature bits.
      */
-    set_feature(&features, ARM_FEATURE_V8);
-    set_feature(&features, ARM_FEATURE_NEON);
-    set_feature(&features, ARM_FEATURE_AARCH64);
-    set_feature(&features, ARM_FEATURE_PMU);
-    set_feature(&features, ARM_FEATURE_GENERIC_TIMER);
+    features |= 1ULL << ARM_FEATURE_V8;
+    features |= 1ULL << ARM_FEATURE_NEON;
+    features |= 1ULL << ARM_FEATURE_AARCH64;
+    features |= 1ULL << ARM_FEATURE_PMU;
+    features |= 1ULL << ARM_FEATURE_GENERIC_TIMER;
 
     ahcf->features = features;
 
@@ -802,7 +792,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     if (cpu->has_pmu) {
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
     } else {
-        unset_feature(&env->features, ARM_FEATURE_PMU);
+        env->features &= ~(1ULL << ARM_FEATURE_PMU);
     }
     if (cpu_isar_feature(aa64_sve, cpu)) {
         assert(kvm_arm_sve_supported(cs));
-- 
2.20.1


