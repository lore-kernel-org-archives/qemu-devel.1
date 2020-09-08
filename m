Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1981DC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC91421D46
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QfFfk0Hu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC91421D46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFYpW-00069D-TR
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 04:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFYlO-0006Dy-L6
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:14:02 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:51783)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFYlL-0000VL-Uz
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:14:02 -0400
Received: by mail-pj1-x1042.google.com with SMTP id a9so4692026pjg.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 01:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zq8jUh6rr55C3iWlgIX0sFstenVLmlXQeyrdeGeUxsU=;
 b=QfFfk0HucHpO/x5Jc0DCHPv1/TNxgbR0bKs0thQNWDve3EYX38Od2x6m0shvaVR3lm
 9IPFIl3SxZp1ttV76d2ZXNjFdLiO58rjGbORvuCAE5b8JZncIo2sVSmId5z8POfV1aH9
 mup4t48Yh6gCUidgmvJr7xt+opOUkEC8neR7IcPYhlSxfw1GOLIR7Gp6yRjKDAcniPay
 xPVMotf6YWG9sZvVyZXOEoAn8d2z5K75Fz7Y3iWfEOpVtYORH/cpPhYzETIDxnh7WFgj
 1BJ4jDdOBjd04i05OZ6LPLc+Y4Bq4tgN+lMr5GatQcVaVRxbQooWukUPSyU8MGGUsmWB
 AS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zq8jUh6rr55C3iWlgIX0sFstenVLmlXQeyrdeGeUxsU=;
 b=t8JU80heHZpxL5GpQomgSTOrZIWMm7m6vJTyTdTJkNNzsOiHyD2eets+tpL3+7gSeX
 HEgpfm4+z1wPYRsWQO/LODcCod//CE+LThuiNFeg3WmeIla7+ubOyf444T7UKuxeBDHE
 zcRwDkTC5kUkmloVYxtLfe0/yuZkH6xx0LCc9KYvMmxdp/zAUTYTCph3VakNdKMO3jMZ
 50w1+saOYZJecZao8zQzUB4b7QywQUEfhIGKwxOKCdgI/gX/YER1u8h9Z/ttCuzvMQZE
 UnYB2Kg2nO2/Kp19l/Hz8oTY/uKFkkCPLDOwSwlg3He6+UK5Gfk03TRBpxmlrjzshPdy
 6Www==
X-Gm-Message-State: AOAM533ngwOhImqr7b/0EbnchuJHJY+tONvO+0QxTSMv3NkhNXju3fbO
 RCD7JC1ewWn1ua89lxnkKKrO
X-Google-Smtp-Source: ABdhPJzlRN1M8h16oz81XvukGczif4UIfS0V9BlFyYExNj30RXZy9QyNWrwE2SI2w53DuR4Z3v8czg==
X-Received: by 2002:a17:90b:1212:: with SMTP id
 gl18mr2103309pjb.138.1599552837216; 
 Tue, 08 Sep 2020 01:13:57 -0700 (PDT)
Received: from localhost.localdomain ([147.75.106.138])
 by smtp.gmail.com with ESMTPSA id m190sm16934788pfm.184.2020.09.08.01.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 01:13:56 -0700 (PDT)
From: Haibo Xu <haibo.xu@linaro.org>
To: drjones@redhat.com,
	richard.henderson@linaro.org
Subject: [PATCH v2 12/12] target/arm: spe: Add corresponding doc and test.
Date: Tue,  8 Sep 2020 08:13:30 +0000
Message-Id: <f85b67a841ad86f461c7dc0c8f5f8b1e5d490da5.1599549462.git.haibo.xu@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599549462.git.haibo.xu@linaro.org>
References: <cover.1599549462.git.haibo.xu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=haibo.xu@linaro.org; helo=mail-pj1-x1042.google.com
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

Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
---
 docs/system/arm/cpu-features.rst | 20 ++++++++++++++++++++
 target/arm/monitor.c             |  2 +-
 tests/qtest/arm-cpu-features.c   |  9 +++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
index 2d5c06cd01..5b81b9a560 100644
--- a/docs/system/arm/cpu-features.rst
+++ b/docs/system/arm/cpu-features.rst
@@ -344,3 +344,23 @@ verbose command lines.  However, the recommended way to select vector
 lengths is to explicitly enable each desired length.  Therefore only
 example's (1), (4), and (6) exhibit recommended uses of the properties.
 
+SPE CPU Property
+==================
+
+The SPE CPU property `spe` is used to enable or disable the SPE feature,
+just as the `pmu` CPU property completely enables or disables the PMU.
+
+Currently, this property is only available with KVM mode, and is enabled
+by default if KVM support it. When KVM is enabled, if the host does not
+support SPE, then an error is generated when attempting to enable it.
+
+Following are 2 examples to use this property:
+
+  1) Disable SPE::
+
+     $ qemu-system-aarch64 -M virt,accel=kvm -cpu max,spe=off
+
+  2) Implicitly enable it with the `host` CPU type if host cpu
+     support it::
+
+     $ qemu-system-aarch64 -M virt,accel=kvm -cpu host
diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index ba6e01abd0..1b8f08988a 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -99,7 +99,7 @@ QEMU_BUILD_BUG_ON(ARM_MAX_VQ > 16);
  * then the order that considers those dependencies must be used.
  */
 static const char *cpu_model_advertised_features[] = {
-    "aarch64", "pmu", "sve",
+    "aarch64", "pmu", "spe", "sve",
     "sve128", "sve256", "sve384", "sve512",
     "sve640", "sve768", "sve896", "sve1024", "sve1152", "sve1280",
     "sve1408", "sve1536", "sve1664", "sve1792", "sve1920", "sve2048",
diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
index 77b5e30a9c..4d393fb2e2 100644
--- a/tests/qtest/arm-cpu-features.c
+++ b/tests/qtest/arm-cpu-features.c
@@ -494,6 +494,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
 
     if (g_str_equal(qtest_get_arch(), "aarch64")) {
         bool kvm_supports_sve;
+        bool kvm_supports_spe;
         char max_name[8], name[8];
         uint32_t max_vq, vq;
         uint64_t vls;
@@ -512,8 +513,10 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
             "with KVM on this host", NULL);
 
         assert_has_feature(qts, "host", "sve");
+        assert_has_feature(qts, "host", "spe");
         resp = do_query_no_props(qts, "host");
         kvm_supports_sve = resp_get_feature(resp, "sve");
+        kvm_supports_spe = resp_get_feature(resp, "spe");
         vls = resp_get_sve_vls(resp);
         qobject_unref(resp);
 
@@ -573,10 +576,16 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
         } else {
             g_assert(vls == 0);
         }
+
+        if (kvm_supports_spe) {
+                assert_set_feature(qts, "host", "spe", false);
+                assert_set_feature(qts, "host", "spe", true);
+        }
     } else {
         assert_has_not_feature(qts, "host", "aarch64");
         assert_has_not_feature(qts, "host", "pmu");
         assert_has_not_feature(qts, "host", "sve");
+        assert_has_not_feature(qts, "host", "spe");
     }
 
     qtest_quit(qts);
-- 
2.17.1


