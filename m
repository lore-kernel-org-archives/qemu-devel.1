Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DB9C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:03:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F7B420774
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c2ncmBy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F7B420774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6JRu-0008GV-DK
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 16:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6JR6-00070l-Eg
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 16:02:52 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:36808)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6JR4-0002up-IQ
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 16:02:52 -0400
Received: by mail-pg1-x543.google.com with SMTP id p37so3367215pgl.3
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 13:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w9gZScYwazZmhXvULHHn4Zso902of0s82F8B1sVs7zk=;
 b=c2ncmBy+R3RN5hNVYSkExTuW6UCW4Re+QA8Ow1rwV6l7zHyUqQweQq7l2mOfQ158ih
 uKPa5XGLrkAsnpXbVrJNHZwwTHTvp2NJZ8gwO2KaWlhi+9h0RABj/J+fhrL+PAKrs1wH
 rKWm0G5vMOULMnKCbXkuTeTGs7q/i+36dei080GpScKptp6btZX/BkJrjKKq+f9GHxuU
 UTwL4IZcOdH76NxmEAerF3e6jIcheZjZGnqV8sl+FfIQRJ7gw69dvHOauvPu0CR6bwuu
 bolcimtCIgEG5gvvU/eA5iy2zNhxGdoxS0OQEMPaCUmOxGZi5MQ6UPrp+eNwC8ed+aVP
 x9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w9gZScYwazZmhXvULHHn4Zso902of0s82F8B1sVs7zk=;
 b=G4Jxd1L3UM2nQbyxfJmxIUKwC88dy0v1EyR+D/4lcZrf2IbtQLYCc5UgxBaPeU0Tf+
 AD1ORNPBWy3wH768C5IREryOglnH9ar83aIE8VJGrggUF3hJDBBWFhuwa1gEGJ76pTHc
 4Gb2Bvr2OvMOsS6EJZgMTa+ltHs+BR3KzO6KhKUPzYX0pF3Lbesc/4Vjf8nv3IPYIYL4
 gvhTarJ52kcKX4I8aXRQ/bR4ahKvWhd3X782vVtpkJm/0SbuAdlbwdUaEoTpWQTu5Eno
 QjGhOMnmiyaLjXz7sOt+4tgVU62zVLuzzjfZZIGZa84AhICIDbYp6ji/TF7m6X6/BhoL
 7GIg==
X-Gm-Message-State: AOAM531oC9j4BipFs/z5u4UA+5ZAfGJSe7Xtg5wwtsrJ8hHelYLQC0gw
 WvBZVX8Ls/HM/defjStCO3nzupk4aIg=
X-Google-Smtp-Source: ABdhPJwNAWNN+ITQPMoAsn0FVkiCpqUBuszqLGtXii4dSbVVLLkem2iZJWUidreSEcc5t6AXVjuDTw==
X-Received: by 2002:a63:3309:: with SMTP id z9mr4984431pgz.7.1597348967245;
 Thu, 13 Aug 2020 13:02:47 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id h12sm6871103pfr.143.2020.08.13.13.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 13:02:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] target/arm: Add cpu properties to control pauth
Date: Thu, 13 Aug 2020 13:02:41 -0700
Message-Id: <20200813200243.3036772-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813200243.3036772-1-richard.henderson@linaro.org>
References: <20200813200243.3036772-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: mark.rutland@arm.com, peter.maydell@linaro.org, drjones@redhat.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The crypto overhead of emulating pauth can be significant for
some workloads.  Add two boolean properties that allows the
feature to be turned off, on with the architected algorithm,
or on with an implementation defined algorithm.

We need two intermediate booleans to control the state while
parsing properties lest we clobber ID_AA64ISAR1 into an invalid
intermediate state.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Use boolean properties instead of an enum (drjones).
---
 target/arm/cpu.h     | 10 ++++++++++
 target/arm/cpu.c     | 13 +++++++++++++
 target/arm/cpu64.c   | 40 ++++++++++++++++++++++++++++++++++++----
 target/arm/monitor.c |  1 +
 4 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9e8ed423ea..44901923c8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -196,9 +196,11 @@ typedef struct {
 #ifdef TARGET_AARCH64
 # define ARM_MAX_VQ    16
 void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp);
+void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp);
 #else
 # define ARM_MAX_VQ    1
 static inline void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp) { }
+static inline void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp) { }
 #endif
 
 typedef struct ARMVectorReg {
@@ -938,6 +940,14 @@ struct ARMCPU {
     uint64_t reset_cbar;
     uint32_t reset_auxcr;
     bool reset_hivecs;
+
+    /*
+     * Intermediate values used during property parsing.
+     * Once finalized, the values should be read from ID_AA64ISAR1.
+     */
+    bool prop_pauth;
+    bool prop_pauth_impdef;
+
     /* DCZ blocksize, in log_2(words), ie low 4 bits of DCZID_EL0 */
     uint32_t dcz_blocksize;
     uint64_t rvbar;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 111579554f..c719562d3d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1307,6 +1307,19 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
             error_propagate(errp, local_err);
             return;
         }
+
+        /*
+         * KVM does not support modifications to this feature.
+         * We have not registered the cpu properties when KVM
+         * is in use, so the user will not be able to set them.
+         */
+        if (!kvm_enabled()) {
+            arm_cpu_pauth_finalize(cpu, &local_err);
+            if (local_err != NULL) {
+                error_propagate(errp, local_err);
+                return;
+            }
+        }
     }
 }
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index dd696183df..0227862d39 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -28,6 +28,8 @@
 #include "sysemu/kvm.h"
 #include "kvm_arm.h"
 #include "qapi/visitor.h"
+#include "hw/qdev-properties.h"
+
 
 #ifndef CONFIG_USER_ONLY
 static uint64_t a57_a53_l2ctlr_read(CPUARMState *env, const ARMCPRegInfo *ri)
@@ -572,6 +574,36 @@ void aarch64_add_sve_properties(Object *obj)
     }
 }
 
+void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
+{
+    int arch_val = 0, impdef_val = 0;
+    uint64_t t;
+
+    /* TODO: Handle HaveEnhancedPAC, HaveEnhancedPAC2, HaveFPAC. */
+    if (cpu->prop_pauth) {
+        if (cpu->prop_pauth_impdef) {
+            impdef_val = 1;
+        } else {
+            arch_val = 1;
+        }
+    } else if (cpu->prop_pauth_impdef) {
+        error_setg(errp, "cannot enable pauth-impdef without pauth");
+        error_append_hint(errp, "Add pauth=on to the CPU property list.\n");
+    }
+
+    t = cpu->isar.id_aa64isar1;
+    t = FIELD_DP64(t, ID_AA64ISAR1, APA, arch_val);
+    t = FIELD_DP64(t, ID_AA64ISAR1, GPA, arch_val);
+    t = FIELD_DP64(t, ID_AA64ISAR1, API, impdef_val);
+    t = FIELD_DP64(t, ID_AA64ISAR1, GPI, impdef_val);
+    cpu->isar.id_aa64isar1 = t;
+}
+
+static Property arm_cpu_pauth_property =
+    DEFINE_PROP_BOOL("pauth", ARMCPU, prop_pauth, true);
+static Property arm_cpu_pauth_impdef_property =
+    DEFINE_PROP_BOOL("pauth-impdef", ARMCPU, prop_pauth_impdef, false);
+
 /* -cpu max: if KVM is enabled, like -cpu host (best possible with this host);
  * otherwise, a CPU with as many features enabled as our emulation supports.
  * The version of '-cpu max' for qemu-system-arm is defined in cpu.c;
@@ -627,10 +659,6 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64ISAR1, DPB, 2);
         t = FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 1);
         t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 1);
-        t = FIELD_DP64(t, ID_AA64ISAR1, APA, 1); /* PAuth, architected only */
-        t = FIELD_DP64(t, ID_AA64ISAR1, API, 0);
-        t = FIELD_DP64(t, ID_AA64ISAR1, GPA, 1);
-        t = FIELD_DP64(t, ID_AA64ISAR1, GPI, 0);
         t = FIELD_DP64(t, ID_AA64ISAR1, SB, 1);
         t = FIELD_DP64(t, ID_AA64ISAR1, SPECRES, 1);
         t = FIELD_DP64(t, ID_AA64ISAR1, FRINTTS, 1);
@@ -718,6 +746,10 @@ static void aarch64_max_initfn(Object *obj)
         cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
         cpu->dcz_blocksize = 7; /*  512 bytes */
 #endif
+
+        /* Default to PAUTH on, with the architected algorithm. */
+        qdev_property_add_static(DEVICE(obj), &arm_cpu_pauth_property);
+        qdev_property_add_static(DEVICE(obj), &arm_cpu_pauth_impdef_property);
     }
 
     aarch64_add_sve_properties(obj);
diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index ba6e01abd0..2c7be32b33 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -104,6 +104,7 @@ static const char *cpu_model_advertised_features[] = {
     "sve640", "sve768", "sve896", "sve1024", "sve1152", "sve1280",
     "sve1408", "sve1536", "sve1664", "sve1792", "sve1920", "sve2048",
     "kvm-no-adjvtime",
+    "pauth", "pauth-impdef",
     NULL
 };
 
-- 
2.25.1


