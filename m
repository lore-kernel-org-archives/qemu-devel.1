Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBCCC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 06:54:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DC242076B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 06:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LT5I2t6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC242076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5kem-00064g-Aq
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 02:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5kdt-0005Dw-V1
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 02:53:45 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43301)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5kds-00041C-BQ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 02:53:45 -0400
Received: by mail-pg1-x542.google.com with SMTP id d19so535065pgl.10
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 23:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=j39crPjYqJGwIgrM7ErljlkD2SFiNa9r8wEicsqELGI=;
 b=LT5I2t6QfsNhm/Zmcw9Uw/LJBuiQz3Yv/l2hdyAlCVLO+tu3HLrsJjMffUkFfat3n8
 AznUmX8Mxnvexxtoc6aOsRpZqEQmvmaf1LZQyv5AIR8O1wCjEuHgGUti1+B1A0aNRo/w
 TIBwoYI9eFX3k3aC/2hfClf8o5YuHEjilka0pOPk7VBs8iTSJtlxm6oWfLWOgcXtuzat
 2O+me+06Vo5jxwo60jkmjdg5UQ+t1AYXiMscCOOKpYg3jb8u6HhaDxSzJKAAxlGJjYwa
 3aAPEaZWi2VuAeyZCoUp2cEtEzxMvQnia7V7MAHh00/oKFPW6scLapQS4s05iB50BIF1
 jgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j39crPjYqJGwIgrM7ErljlkD2SFiNa9r8wEicsqELGI=;
 b=pgFiXnT0vi7wQoCSIlV+AkX0bDWHrJbvIjNNe/tmaSsOmirzoa+dRoYV8GGfk0Gxoo
 /I9igjYBFNNGuwPog8LYk6yiKfPqqIUSFA8pa/S5nVswQzdF+ho8nF6ds7GpORfNZwFJ
 ZtP0iuXdICNR9yMPyPbhqvMRz/Yuwzypu7rqqRMDspkuIITRf4he39jvQwPpBsehZaWS
 50RbcuF//kaRJVMuyZZ6WZBTV94QmGCgfzYFm+KH7wtpqTCMuluTiVPYGsPZJpsVNNSI
 BwB6Xo/uNO1JoqNlLB9RW9NtLidWFYNn45fNS0ihx5ur0ujxkTmlAMqobI4qsRhDcnbj
 0Zfg==
X-Gm-Message-State: AOAM532AHTrPoTwZ9/6SIVtm6YvOc151yk3SB+GzMmIgIWAfvTz68r88
 8aevSlDBWpKHTTSouYRW/6nkbMPr/Iw=
X-Google-Smtp-Source: ABdhPJx/iBFx/J0HZt6t0WKKyzlbSQN24NoADEsr35yfXn85XTDgQAVAUxMApXMEwTMAjVbkkcq6Bw==
X-Received: by 2002:a65:4183:: with SMTP id a3mr3762192pgq.448.1597215222467; 
 Tue, 11 Aug 2020 23:53:42 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b26sm1242781pff.54.2020.08.11.23.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 23:53:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] target/arm: Add cpu property to control pauth
Date: Tue, 11 Aug 2020 23:53:38 -0700
Message-Id: <20200812065339.2030527-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200812065339.2030527-1-richard.henderson@linaro.org>
References: <20200812065339.2030527-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
Cc: mark.rutland@arm.com, peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The crypto overhead of emulating pauth can be significant for
some workloads.  Add an enumeration property that allows the
feature to be turned off, on with the architected algorithm,
or on with an implementation defined algorithm.

The architected algorithm is quite expensive to emulate;
using another algorithm may allow hardware acceleration.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu64.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index dd696183df..3181d0e2f8 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -572,6 +572,69 @@ void aarch64_add_sve_properties(Object *obj)
     }
 }
 
+static const char * const pauth_names[] = {
+    "off", "impdef", "arch"
+};
+
+static const QEnumLookup pauth_lookup = {
+    .array = pauth_names,
+    .size = ARRAY_SIZE(pauth_names)
+};
+
+static int cpu_arm_get_pauth(Object *obj, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    int value;
+
+    /* We will always set GPA+APA and GPI+API to the same value. */
+    if (FIELD_EX64(cpu->isar.id_aa64isar1, ID_AA64ISAR1, APA)) {
+        value = 2;
+    } else if (FIELD_EX64(cpu->isar.id_aa64isar1, ID_AA64ISAR1, API)) {
+        value = 1;
+    } else {
+        value = 0;
+    }
+    return value;
+}
+
+static void cpu_arm_set_pauth(Object *obj, int value, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    uint64_t t;
+
+    /* TODO: Handle HaveEnhancedPAC, HaveEnhancedPAC2, HaveFPAC. */
+    t = cpu->isar.id_aa64isar1;
+    switch (value) {
+    case 0:
+        t = FIELD_DP64(t, ID_AA64ISAR1, APA, 0);
+        t = FIELD_DP64(t, ID_AA64ISAR1, API, 0);
+        t = FIELD_DP64(t, ID_AA64ISAR1, GPA, 0);
+        t = FIELD_DP64(t, ID_AA64ISAR1, GPI, 0);
+        break;
+    case 1:
+        t = FIELD_DP64(t, ID_AA64ISAR1, APA, 0);
+        t = FIELD_DP64(t, ID_AA64ISAR1, API, 1);
+        t = FIELD_DP64(t, ID_AA64ISAR1, GPA, 0);
+        t = FIELD_DP64(t, ID_AA64ISAR1, GPI, 1);
+        break;
+    case 2:
+        t = FIELD_DP64(t, ID_AA64ISAR1, APA, 1);
+        t = FIELD_DP64(t, ID_AA64ISAR1, API, 0);
+        t = FIELD_DP64(t, ID_AA64ISAR1, GPA, 1);
+        t = FIELD_DP64(t, ID_AA64ISAR1, GPI, 0);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    cpu->isar.id_aa64isar1 = t;
+}
+
+static void aarch64_add_pauth_properties(Object *obj)
+{
+    object_property_add_enum(obj, "pauth", "ARMPauthKind", &pauth_lookup,
+                             cpu_arm_get_pauth, cpu_arm_set_pauth);
+}
+
 /* -cpu max: if KVM is enabled, like -cpu host (best possible with this host);
  * otherwise, a CPU with as many features enabled as our emulation supports.
  * The version of '-cpu max' for qemu-system-arm is defined in cpu.c;
@@ -720,6 +783,7 @@ static void aarch64_max_initfn(Object *obj)
 #endif
     }
 
+    aarch64_add_pauth_properties(obj);
     aarch64_add_sve_properties(obj);
     object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_max_vq,
                         cpu_max_set_sve_max_vq, NULL, NULL);
-- 
2.25.1


