Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A18ECA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 08:54:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD40B217D9
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 08:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cl2BtAo/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD40B217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQShZ-0003ZQ-Lt
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 04:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iQSet-00014u-GZ
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:51:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iQSer-0008Tt-4A
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:51:51 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:32871)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iQSeq-0008KI-TJ
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:51:49 -0400
Received: by mail-wr1-x42b.google.com with SMTP id s1so8974650wro.0
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2019 01:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=cU0ztaO6mnX2lbCzssErMqt/BItGWLQpsUe0rwEBjZo=;
 b=Cl2BtAo/vQYAETpF4aag+MiOlQGxfoKfG6BzH3m6ZSl4INfag2u/j52l733IlRQDyN
 B4Ngyy5z4agna0XIJxVI8PRkKPEUsTCh8zNDicucybu9Bai+Hm21ujVGIYlLaPYk0r1R
 ySIram8iJFGiQrd7D3Ty7jMqZ3jz2foOST9OigLlg03ALz1EteGPI3MEhvKmWRcjELSN
 FySbWn1cE8gpoRYf8jz0B6uJ5PfcV58k+u+mdVbAypNaKHvMv1bzsxFTL71dzPIjw8mp
 p7hDXlC5g0CYHQtQtZnzv1HK2fM297FyRHv7zhJxaFFzLmH3QcN/b5Q09cD1N6M9WyPZ
 ot8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cU0ztaO6mnX2lbCzssErMqt/BItGWLQpsUe0rwEBjZo=;
 b=mIu3IAaIqXExCixMq5/2GRS0Y3idm2w2XfxPQX7qlOC1LgipeKn5bZzY27DokkpLji
 uN3T/18eKPd5OtkyTjItowAB+zOl4//IY2m6V3DMY57jP3RSg35a3vRNDG1nsTuFpGZ2
 2960pzbb63V8Ud1lZMSfnQdR7n0TofE8HeLZsmm8SEBX9npa+wP7GJsuFCvtvyVo6YXl
 qPoj7D+cSiwjRaKPxqpPUDHBeZ++LHxzn6DX+bQgbJ2Pt2aIDaKPPeQU3ynptWvD3UO9
 nbgz479ABOHQwDqpbaBsHIPlHO2mIHZYtzisaiXQLcsfYVbNPT5YdG6MEb6mV5l9qGgZ
 FoNQ==
X-Gm-Message-State: APjAAAUH9wA8Yl4AmKI8sSxGdbBK065Rx1qhbmSZSnm87RCK7WKTJv3G
 zLjuBDwnLWGECmL5lh+lf3y/JVV6zkvRO8pM
X-Google-Smtp-Source: APXvYqwtOBoYSRo2/7adod2StOo51HTBaW6kIBNJF7iwc2Gmv9sAXSgfKvLcxf4VTyopI3+3CjyOHw==
X-Received: by 2002:a05:6000:101:: with SMTP id
 o1mr9805058wrx.394.1572598306553; 
 Fri, 01 Nov 2019 01:51:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d20sm8818922wra.4.2019.11.01.01.51.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2019 01:51:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/11] target/arm: Allow SVE to be disabled via a CPU property
Date: Fri,  1 Nov 2019 08:51:32 +0000
Message-Id: <20191101085140.5205-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191101085140.5205-1-peter.maydell@linaro.org>
References: <20191101085140.5205-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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

From: Andrew Jones <drjones@redhat.com>

Since 97a28b0eeac14 ("target/arm: Allow VFP and Neon to be disabled via
a CPU property") we can disable the 'max' cpu model's VFP and neon
features, but there's no way to disable SVE. Add the 'sve=on|off'
property to give it that flexibility. We also rename
cpu_max_get/set_sve_vq to cpu_max_get/set_sve_max_vq in order for them
to follow the typical *_get/set_<property-name> pattern.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Reviewed-by: Beata Michalska <beata.michalska@linaro.org>
Message-id: 20191031142734.8590-4-drjones@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c         |  3 ++-
 target/arm/cpu64.c       | 52 ++++++++++++++++++++++++++++++++++------
 target/arm/monitor.c     |  2 +-
 tests/arm-cpu-features.c |  1 +
 4 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ab3e1a03616..72a27ec4b0e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -200,7 +200,8 @@ static void arm_cpu_reset(CPUState *s)
         env->cp15.cpacr_el1 = deposit64(env->cp15.cpacr_el1, 16, 2, 3);
         env->cp15.cptr_el[3] |= CPTR_EZ;
         /* with maximum vector length */
-        env->vfp.zcr_el[1] = cpu->sve_max_vq - 1;
+        env->vfp.zcr_el[1] = cpu_isar_feature(aa64_sve, cpu) ?
+                             cpu->sve_max_vq - 1 : 0;
         env->vfp.zcr_el[2] = env->vfp.zcr_el[1];
         env->vfp.zcr_el[3] = env->vfp.zcr_el[1];
         /*
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index d7f5bf610a7..89a8ae77fe8 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -256,15 +256,23 @@ static void aarch64_a72_initfn(Object *obj)
     define_arm_cp_regs(cpu, cortex_a72_a57_a53_cp_reginfo);
 }
 
-static void cpu_max_get_sve_vq(Object *obj, Visitor *v, const char *name,
-                               void *opaque, Error **errp)
+static void cpu_max_get_sve_max_vq(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
-    visit_type_uint32(v, name, &cpu->sve_max_vq, errp);
+    uint32_t value;
+
+    /* All vector lengths are disabled when SVE is off. */
+    if (!cpu_isar_feature(aa64_sve, cpu)) {
+        value = 0;
+    } else {
+        value = cpu->sve_max_vq;
+    }
+    visit_type_uint32(v, name, &value, errp);
 }
 
-static void cpu_max_set_sve_vq(Object *obj, Visitor *v, const char *name,
-                               void *opaque, Error **errp)
+static void cpu_max_set_sve_max_vq(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
     Error *err = NULL;
@@ -279,6 +287,34 @@ static void cpu_max_set_sve_vq(Object *obj, Visitor *v, const char *name,
     error_propagate(errp, err);
 }
 
+static void cpu_arm_get_sve(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    bool value = cpu_isar_feature(aa64_sve, cpu);
+
+    visit_type_bool(v, name, &value, errp);
+}
+
+static void cpu_arm_set_sve(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    Error *err = NULL;
+    bool value;
+    uint64_t t;
+
+    visit_type_bool(v, name, &value, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    t = cpu->isar.id_aa64pfr0;
+    t = FIELD_DP64(t, ID_AA64PFR0, SVE, value);
+    cpu->isar.id_aa64pfr0 = t;
+}
+
 /* -cpu max: if KVM is enabled, like -cpu host (best possible with this host);
  * otherwise, a CPU with as many features enabled as our emulation supports.
  * The version of '-cpu max' for qemu-system-arm is defined in cpu.c;
@@ -391,8 +427,10 @@ static void aarch64_max_initfn(Object *obj)
 #endif
 
         cpu->sve_max_vq = ARM_MAX_VQ;
-        object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_vq,
-                            cpu_max_set_sve_vq, NULL, NULL, &error_fatal);
+        object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_max_vq,
+                            cpu_max_set_sve_max_vq, NULL, NULL, &error_fatal);
+        object_property_add(obj, "sve", "bool", cpu_arm_get_sve,
+                            cpu_arm_set_sve, NULL, NULL, &error_fatal);
     }
 }
 
diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index 560970de7f5..2209b27b9a0 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -97,7 +97,7 @@ GICCapabilityList *qmp_query_gic_capabilities(Error **errp)
  * then the order that considers those dependencies must be used.
  */
 static const char *cpu_model_advertised_features[] = {
-    "aarch64", "pmu",
+    "aarch64", "pmu", "sve",
     NULL
 };
 
diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
index 6ebb03d7ad6..d5e18eb6662 100644
--- a/tests/arm-cpu-features.c
+++ b/tests/arm-cpu-features.c
@@ -197,6 +197,7 @@ static void test_query_cpu_model_expansion(const void *data)
 
     if (g_str_equal(qtest_get_arch(), "aarch64")) {
         assert_has_feature(qts, "max", "aarch64");
+        assert_has_feature(qts, "max", "sve");
         assert_has_feature(qts, "cortex-a57", "pmu");
         assert_has_feature(qts, "cortex-a57", "aarch64");
 
-- 
2.20.1


