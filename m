Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215CDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:03:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5DFA20774
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NW9Ru9Kg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5DFA20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6JRv-0008It-6r
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 16:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6JR7-00072D-Ni
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 16:02:53 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:35322)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6JR6-0002uz-3L
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 16:02:53 -0400
Received: by mail-pj1-x1041.google.com with SMTP id t6so3267211pjr.0
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 13:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fb5Y49cmdeZbmdDx5YZDyQ2EhM1utpNhLqY0w1DdTAE=;
 b=NW9Ru9KgJ+JXWJtLt3TmJXIgcddizv5ba3KDl1ZJd48AUohxL7qxm6tttwmQCIQkEw
 fv7LexCG5UgMz/KZR9h2RJaMbYTOU6yCW9BR+tFaZKvqACkKZj5BGr28haxZn8VA6knu
 IX2ZEgIUPjkp2VobDFanJ3Bq+oEJqwseCK9uo7HS6THNAEgMcBEx3VvQHs/0tSLIho7N
 Gt6F6geh6+rA0XsKqV1R3QvNwG3K2bl6VJYqki+Fq4/42UeUgKugfjX6Vi+zDFFwnbxV
 j0v2JmMOs3H7cD3kJCFMKFS2kfBJ84umB704V72vFBgxnC3vdXV4buJaPmapQ7YMCpGS
 Ch4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fb5Y49cmdeZbmdDx5YZDyQ2EhM1utpNhLqY0w1DdTAE=;
 b=lomAPhQiaZ2vAzljxX5vUm4m07fW4WRavtqRxFME+2ikrSzKxiJhyOEN8IZTc/1P79
 C90QyGGxPvQu25LwVLlxMTcTWz8o0hT7XF3YCf4o9eGpmhhe5cPUXMZx96r6CRv26g75
 NG5+UE99i/o0fZLbQY59toluisswsIgvsT7D3jjs5tUjFrYd9ofiSJtyHMwtDBYPAOXB
 J5LmHJGyRq0NknIbqX7NykjHdT359xUn8OJEHgjGxHLMXLMtPovI+tB5k6ih0yUepkIi
 HPl7WbzKNEFXHsnO+t918tYmRfMsHW0iRTfacP9eEnFnw1N8HJhIwXD4FLUtFdqGqCqr
 t1dw==
X-Gm-Message-State: AOAM532xOYY5bALWaN729/IUH/CmHPOz/4T0ifPodubG4zkQN9E21KSl
 An3ovBU/y3b97BJuYimg+o5cB2Ac/Cw=
X-Google-Smtp-Source: ABdhPJzg5YUxeE2QFCPhJlTNtHjqCx5elZi5oNeBpd21vQYWSR2qK0P9bM5PHB9aRBahHY7ft6SVWg==
X-Received: by 2002:a17:902:b701:: with SMTP id
 d1mr5201070pls.92.1597348970163; 
 Thu, 13 Aug 2020 13:02:50 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id h12sm6871103pfr.143.2020.08.13.13.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 13:02:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] target/arm: Use object_property_add_bool for "sve"
 property
Date: Thu, 13 Aug 2020 13:02:43 -0700
Message-Id: <20200813200243.3036772-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813200243.3036772-1-richard.henderson@linaro.org>
References: <20200813200243.3036772-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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

The interface for object_property_add_bool is simpler,
making the code easier to understand.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu64.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 0227862d39..cce0da0b90 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -488,6 +488,12 @@ static void cpu_max_set_sve_max_vq(Object *obj, Visitor *v, const char *name,
     cpu->sve_max_vq = max_vq;
 }
 
+/*
+ * Note that cpu_arm_get/set_sve_vq cannot use the simpler
+ * object_property_add_bool interface because they make use
+ * of the contents of "name" to determine which bit on which
+ * to operate.
+ */
 static void cpu_arm_get_sve_vq(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
@@ -529,26 +535,17 @@ static void cpu_arm_set_sve_vq(Object *obj, Visitor *v, const char *name,
     set_bit(vq - 1, cpu->sve_vq_init);
 }
 
-static void cpu_arm_get_sve(Object *obj, Visitor *v, const char *name,
-                            void *opaque, Error **errp)
+static bool cpu_arm_get_sve(Object *obj, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
-    bool value = cpu_isar_feature(aa64_sve, cpu);
-
-    visit_type_bool(v, name, &value, errp);
+    return cpu_isar_feature(aa64_sve, cpu);
 }
 
-static void cpu_arm_set_sve(Object *obj, Visitor *v, const char *name,
-                            void *opaque, Error **errp)
+static void cpu_arm_set_sve(Object *obj, bool value, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
-    bool value;
     uint64_t t;
 
-    if (!visit_type_bool(v, name, &value, errp)) {
-        return;
-    }
-
     if (value && kvm_enabled() && !kvm_arm_sve_supported()) {
         error_setg(errp, "'sve' feature not supported by KVM on this host");
         return;
@@ -563,8 +560,7 @@ void aarch64_add_sve_properties(Object *obj)
 {
     uint32_t vq;
 
-    object_property_add(obj, "sve", "bool", cpu_arm_get_sve,
-                        cpu_arm_set_sve, NULL, NULL);
+    object_property_add_bool(obj, "sve", cpu_arm_get_sve, cpu_arm_set_sve);
 
     for (vq = 1; vq <= ARM_MAX_VQ; ++vq) {
         char name[8];
-- 
2.25.1


