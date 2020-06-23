Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA62C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:19:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EA7C2072E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KxSkZ4Cx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA7C2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhtr-0007tH-G4
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 08:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhHV-0003dg-0k
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:40:01 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:42345)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhHP-0003U9-Dm
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:40:00 -0400
Received: by mail-wr1-x435.google.com with SMTP id o11so12450054wrv.9
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=n6zJE0yRFKX8qUS2j9Gbp90DG/pGEs6Utl5blOSwKkE=;
 b=KxSkZ4CxYJYh0vSGxFXyjuv1LH+k8DwHeLKMrr4FRJN2mX2MX/pqkD0cZZCifihqtI
 woXWscOYu7SOUUmXxILNgY5Vz+3pHpFnDy+7BcncLFg8MIEk0mdlLO7lmy5DwaicepjA
 EqcuHxNxaj+uFb0MieYayoAM8ZtgCALXu4SeL3H1oSjbNWOGZHfAiZjZNlpOW1pWPYTS
 GWg/NnJdwDs0oOMs8MhJ87Pzra+NDUIMjCAem9DY3zqRur3BJklNRXkSbvwcvMN2V5am
 j5DWjJkB5K8LM6k/n17eu5hf1pNVGt/j7f7rT2BalAcnG2beJOpE/kwQ9KL5pX2mLFU5
 jkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=n6zJE0yRFKX8qUS2j9Gbp90DG/pGEs6Utl5blOSwKkE=;
 b=qNTJMx84CmKJia6N6EP3ipT2PUIC6LptLEScCqh81lQEfk02N2yZZVqCJHBCI8L2pA
 12E6oscHX/DIwsVZPsqgDLqzFdh8namicRcrzef2I9pnWbifMQEeVn7w5MBwZBeAiHWV
 b3byTgaTz0GcY6volWRHrrsyYQqtrXOsSJysjlWlkE+l6GFIaDVCZeYaFrk3/ssRLeHx
 wl5EG9sqALYMPj1p+MkxSD7HOqrsDTqsvZidQTdN79o4b7ERCDlAlf71FfsE0YDZFmvm
 BbLXwyivDy/SwxD70JTKo75ScdjhuiNUA9f9PD/zC67XUd2AwsDkbTRHU0T+a90Nf1D1
 gO0g==
X-Gm-Message-State: AOAM5331210/DvCk088Ok5rR7rzlXpUJ+8Kz7BA6OV/dSIxnUcKORIrE
 Ia6cPCXU1tdK2pTwpFEZADyqpA6Pk+GeVw==
X-Google-Smtp-Source: ABdhPJxsS/kvwA25vSYO0t3MBLnO2e6iVLujEakx+4/Nt3nVSwHk5n1bAoJ3kaZjAg2WrFfMN0wUQA==
X-Received: by 2002:a5d:458a:: with SMTP id p10mr19518630wrq.184.1592912393453; 
 Tue, 23 Jun 2020 04:39:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/42] tests/qtest/arm-cpu-features: Add feature setting tests
Date: Tue, 23 Jun 2020 12:39:03 +0100
Message-Id: <20200623113904.28805-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

From: Andrew Jones <drjones@redhat.com>

Some cpu features may be enabled and disabled for all configurations
that support the feature. Let's test that.

A recent regression[*] inspired adding these tests.

[*] '-cpu host,pmu=on' caused a segfault

Signed-off-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200623090622.30365-2-philmd@redhat.com
Message-Id: <20200623082310.17577-1-drjones@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/arm-cpu-features.c | 38 ++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
index 46921736766..f7e062c1891 100644
--- a/tests/qtest/arm-cpu-features.c
+++ b/tests/qtest/arm-cpu-features.c
@@ -159,16 +159,35 @@ static bool resp_get_feature(QDict *resp, const char *feature)
     qobject_unref(_resp);                                              \
 })
 
-#define assert_feature(qts, cpu_type, feature, expected_value)         \
+#define resp_assert_feature(resp, feature, expected_value)             \
 ({                                                                     \
-    QDict *_resp, *_props;                                             \
+    QDict *_props;                                                     \
                                                                        \
-    _resp = do_query_no_props(qts, cpu_type);                          \
     g_assert(_resp);                                                   \
     g_assert(resp_has_props(_resp));                                   \
     _props = resp_get_props(_resp);                                    \
     g_assert(qdict_get(_props, feature));                              \
     g_assert(qdict_get_bool(_props, feature) == (expected_value));     \
+})
+
+#define assert_feature(qts, cpu_type, feature, expected_value)         \
+({                                                                     \
+    QDict *_resp;                                                      \
+                                                                       \
+    _resp = do_query_no_props(qts, cpu_type);                          \
+    g_assert(_resp);                                                   \
+    resp_assert_feature(_resp, feature, expected_value);               \
+    qobject_unref(_resp);                                              \
+})
+
+#define assert_set_feature(qts, cpu_type, feature, value)              \
+({                                                                     \
+    const char *_fmt = (value) ? "{ %s: true }" : "{ %s: false }";     \
+    QDict *_resp;                                                      \
+                                                                       \
+    _resp = do_query(qts, cpu_type, _fmt, feature);                    \
+    g_assert(_resp);                                                   \
+    resp_assert_feature(_resp, feature, value);                        \
     qobject_unref(_resp);                                              \
 })
 
@@ -424,10 +443,14 @@ static void test_query_cpu_model_expansion(const void *data)
     assert_error(qts, "host", "The CPU type 'host' requires KVM", NULL);
 
     /* Test expected feature presence/absence for some cpu types */
-    assert_has_feature_enabled(qts, "max", "pmu");
     assert_has_feature_enabled(qts, "cortex-a15", "pmu");
     assert_has_not_feature(qts, "cortex-a15", "aarch64");
 
+    /* Enabling and disabling pmu should always work. */
+    assert_has_feature_enabled(qts, "max", "pmu");
+    assert_set_feature(qts, "max", "pmu", false);
+    assert_set_feature(qts, "max", "pmu", true);
+
     assert_has_not_feature(qts, "max", "kvm-no-adjvtime");
 
     if (g_str_equal(qtest_get_arch(), "aarch64")) {
@@ -464,7 +487,10 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
         return;
     }
 
+    /* Enabling and disabling kvm-no-adjvtime should always work. */
     assert_has_feature_disabled(qts, "host", "kvm-no-adjvtime");
+    assert_set_feature(qts, "host", "kvm-no-adjvtime", true);
+    assert_set_feature(qts, "host", "kvm-no-adjvtime", false);
 
     if (g_str_equal(qtest_get_arch(), "aarch64")) {
         bool kvm_supports_sve;
@@ -475,7 +501,11 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
         char *error;
 
         assert_has_feature_enabled(qts, "host", "aarch64");
+
+        /* Enabling and disabling pmu should always work. */
         assert_has_feature_enabled(qts, "host", "pmu");
+        assert_set_feature(qts, "host", "pmu", false);
+        assert_set_feature(qts, "host", "pmu", true);
 
         assert_error(qts, "cortex-a15",
             "We cannot guarantee the CPU type 'cortex-a15' works "
-- 
2.20.1


