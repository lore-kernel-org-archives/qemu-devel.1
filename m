Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78848C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:36:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42AC7206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wVrfV6c3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42AC7206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCnf-0003TV-Bu
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:36:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCUD-0005qw-7p
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:16:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCUB-0003H2-2a
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:16:08 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:34862)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixCUA-0003Eh-R2
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:16:07 -0500
Received: by mail-wr1-x430.google.com with SMTP id g17so4828289wro.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 08:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=jCTq+59n1kUdQU8gu/KWOGZ9LyXQo5qog/dLshBHXPE=;
 b=wVrfV6c3SfEc2Hm69gJte442h7q7AFg/qTYiiiEXwB4j9Dh0Grngz2cQuG+r2j3Zds
 eW7vRAaR0eF+ES9st8Cv0I0m5dWCmilOc4GlE4eLx58qNhjlrZ6cn2FZOxdD7D7/pBW0
 aG9ySu3ovdAl/ytnkowezKUkjZUyzEonoU/qy0XAbYCDS8D5g50UsPei4Rg2fU2PjNlH
 7lH3jUJs6QT3hvp41DFO83qqNBVgb1F/Ri3PV7ihLAppegCjO2O5Fkkg9+gr6dXlXN9F
 Eq4OfKd/TDagfdSaJonXNPMk2uu2w7Xzp6BG7HYX8ToROuRgnZHQkyp+Dz88VRYOPmJm
 +GRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jCTq+59n1kUdQU8gu/KWOGZ9LyXQo5qog/dLshBHXPE=;
 b=TU8+NzX3vbLECPSGPn060FxGfvAxhxHn06yQNlmQotYPflv6PY2+yjNMjO+vq1YFpr
 hgc3M6pFwfoo7JKP0/z/Sw2ULGHy5AK6Kyik89xsZwHcb7u9DrFMhRJfHInbeG49wxxA
 5QBxLdlx2fBr1XY7nbw+yXYDKpUkhQVdmMjNz5z7/gt4BpIgEkQFNTOq4JLiFb9mx4Yk
 26s0/Y31yKEf8qC5zEqpVftWmCTeVvrDhybfBJ0wAcawUXJWopymohjpZOtp5HFOiEn3
 3DOupat/TrCJ5ppMojj8NUWzJCNMLZXwRF6Z8Q7SEG+wwSC1FYVPflIQooVE5BCD0/H1
 Ihqw==
X-Gm-Message-State: APjAAAXHHvLl92GzKrHPtKUJHo4TFD42qg5wTX7XN+SX1mX+49pHiDcW
 oqCsrHaZswjyr//UXyTospWMRK5x27d9rw==
X-Google-Smtp-Source: APXvYqy/gAg/xJE+bfHIX9bvTbaxNlQF4NjSB8SBi+lnBv3L4uNLVS3mLJo7NSx9gZPJrb0oaVEISg==
X-Received: by 2002:a5d:45c4:: with SMTP id b4mr6275654wrs.303.1580400965057; 
 Thu, 30 Jan 2020 08:16:05 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a22sm6994442wmd.20.2020.01.30.08.16.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 08:16:04 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/26] tests/arm-cpu-features: Check feature default values
Date: Thu, 30 Jan 2020 16:15:31 +0000
Message-Id: <20200130161533.8180-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130161533.8180-1-peter.maydell@linaro.org>
References: <20200130161533.8180-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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

If we know what the default value should be then we can test for
that as well as the feature existence.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200120101023.16030-5-drjones@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/arm-cpu-features.c | 37 +++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
index bef3ed24b60..a039e3c8d72 100644
--- a/tests/qtest/arm-cpu-features.c
+++ b/tests/qtest/arm-cpu-features.c
@@ -159,6 +159,25 @@ static bool resp_get_feature(QDict *resp, const char *feature)
     qobject_unref(_resp);                                              \
 })
 
+#define assert_feature(qts, cpu_type, feature, expected_value)         \
+({                                                                     \
+    QDict *_resp, *_props;                                             \
+                                                                       \
+    _resp = do_query_no_props(qts, cpu_type);                          \
+    g_assert(_resp);                                                   \
+    g_assert(resp_has_props(_resp));                                   \
+    _props = resp_get_props(_resp);                                    \
+    g_assert(qdict_get(_props, feature));                              \
+    g_assert(qdict_get_bool(_props, feature) == (expected_value));     \
+    qobject_unref(_resp);                                              \
+})
+
+#define assert_has_feature_enabled(qts, cpu_type, feature)             \
+    assert_feature(qts, cpu_type, feature, true)
+
+#define assert_has_feature_disabled(qts, cpu_type, feature)            \
+    assert_feature(qts, cpu_type, feature, false)
+
 static void assert_type_full(QTestState *qts)
 {
     const char *error;
@@ -405,16 +424,16 @@ static void test_query_cpu_model_expansion(const void *data)
     assert_error(qts, "host", "The CPU type 'host' requires KVM", NULL);
 
     /* Test expected feature presence/absence for some cpu types */
-    assert_has_feature(qts, "max", "pmu");
-    assert_has_feature(qts, "cortex-a15", "pmu");
+    assert_has_feature_enabled(qts, "max", "pmu");
+    assert_has_feature_enabled(qts, "cortex-a15", "pmu");
     assert_has_not_feature(qts, "cortex-a15", "aarch64");
 
     if (g_str_equal(qtest_get_arch(), "aarch64")) {
-        assert_has_feature(qts, "max", "aarch64");
-        assert_has_feature(qts, "max", "sve");
-        assert_has_feature(qts, "max", "sve128");
-        assert_has_feature(qts, "cortex-a57", "pmu");
-        assert_has_feature(qts, "cortex-a57", "aarch64");
+        assert_has_feature_enabled(qts, "max", "aarch64");
+        assert_has_feature_enabled(qts, "max", "sve");
+        assert_has_feature_enabled(qts, "max", "sve128");
+        assert_has_feature_enabled(qts, "cortex-a57", "pmu");
+        assert_has_feature_enabled(qts, "cortex-a57", "aarch64");
 
         sve_tests_default(qts, "max");
 
@@ -451,8 +470,8 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
         QDict *resp;
         char *error;
 
-        assert_has_feature(qts, "host", "aarch64");
-        assert_has_feature(qts, "host", "pmu");
+        assert_has_feature_enabled(qts, "host", "aarch64");
+        assert_has_feature_enabled(qts, "host", "pmu");
 
         assert_error(qts, "cortex-a15",
             "We cannot guarantee the CPU type 'cortex-a15' works "
-- 
2.20.1


