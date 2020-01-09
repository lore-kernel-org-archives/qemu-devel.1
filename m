Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D48C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:22:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A12420661
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UEOEdLbW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A12420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipYhl-0005TF-Se
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 09:22:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ipYeY-0001AB-4e
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ipYeW-0006DK-LL
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:13 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:37118)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ipYeW-00068N-Dx
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:12 -0500
Received: by mail-wr1-x42f.google.com with SMTP id w15so7602274wru.4
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 06:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aLSGKJVJ8GzXMyvCS2+6bjDQkXD5H9Xhihyf+FOwMEw=;
 b=UEOEdLbWJX/2v8znXz/3MOkA7jWwwCQYBK4whGRG4/K6UGpFFMMw1T4l1YbOzxlGDw
 0cyHAtbnVHeyPa7wdRUkKrG48tzGaccX2E2toAouccgUgWS8kUFsQ+VDHt6gQfIDPieo
 BE/JS/knoaI/FoeevoWt3OCrRab2xPsv2ZShWwIDFaKnYTG2h47eFOubJTstaqF8VHsa
 xyvcrnBD3sCIt/lyH4clHD0uRuet2ogNIi2mHVYuXQT+8sxOrxT/FWqvH5yAByLk1ojN
 UbbFrZV6tUUgGgGjcell4vM8hOH7BwOxQQQhH2/gznUvdRewS/gvJ8ru42b2NTaefla0
 oZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aLSGKJVJ8GzXMyvCS2+6bjDQkXD5H9Xhihyf+FOwMEw=;
 b=EVbt+lXAnQqDi40mlP7f33kWRljAk1IZJ7LHr6MCYuZWerqpUXCQRSaFPSJbDuZrbj
 22nBDQIKPI9RxelmCVZA1iSchNoqnziTPsU4bnRG8VQ71Iynpt7kaqLzQd2ubQB12oLT
 cEot5LziuU8fkBBxlO65GHEwDvem93cQvJqwfWIcNOHvibd0fSr3IGhWaXPlYIIiIFeX
 yHPUrxF/34TqkVl4ehCn1mMqYtYYP5AsJHRFuf3OlmElyCmd6Wt8P2AFo5kSEDBLHuIs
 ZbJ4S5Mw92hhk3yKR3qm23LE3AZyvApvl6m7e7HXiuMeeBv7jr8ZaBSlmurijIQl9t0M
 bhuA==
X-Gm-Message-State: APjAAAX2uitayPtm3Eyq2XsTWeIlrikrnCiZpAwC2crkggyxR0ZhGkpZ
 YuQspj9d5nrR39B172luBdK1RVMCHNs=
X-Google-Smtp-Source: APXvYqzhHoQmVbY8yq1ACK4vAy69EN+RsVxT9PxeMYDz23+LD3UW5+a1Nvz/WEM/UhQtU/cAo1WZyw==
X-Received: by 2002:a5d:404b:: with SMTP id w11mr11802595wrp.171.1578579551330; 
 Thu, 09 Jan 2020 06:19:11 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p26sm2883902wmc.24.2020.01.09.06.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 06:19:06 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A3B221FF98;
 Thu,  9 Jan 2020 14:18:59 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 08/14] testing: don't nest build for fp-test
Date: Thu,  9 Jan 2020 14:18:52 +0000
Message-Id: <20200109141858.14376-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200109141858.14376-1-alex.bennee@linaro.org>
References: <20200109141858.14376-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
Cc: "Emilio G . Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Re-calling the main make is counter-productive and really messes up
with parallel builds. Just ensure we have built the pre-requisites
before we build the fp-test bits. If the user builds manually just
complain if the parent build hasn't got the bits we need.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 49e3b0d3194..7a767bf1148 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -969,7 +969,7 @@ FP_TEST_BIN=$(BUILD_DIR)/tests/fp/fp-test
 
 # the build dir is created by configure
 .PHONY: $(FP_TEST_BIN)
-$(FP_TEST_BIN):
+$(FP_TEST_BIN): config-host.h $(test-util-obj-y)
 	$(call quiet-command, \
 	 	$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" $(notdir $@), \
 	         "BUILD", "$(notdir $@)")
diff --git a/tests/fp/Makefile b/tests/fp/Makefile
index 5a35e7c2109..56768ecfd2f 100644
--- a/tests/fp/Makefile
+++ b/tests/fp/Makefile
@@ -554,15 +554,13 @@ TF_OBJS_LIB += $(TF_OBJS_TEST)
 
 BINARIES := fp-test$(EXESUF) fp-bench$(EXESUF)
 
-# everything depends on config-host.h because platform.h includes it
-all: $(BUILD_DIR)/config-host.h
-	$(MAKE) $(BINARIES)
+# We require artefacts from the main build including config-host.h
+# because platform.h includes it. Rather than re-invoking the main
+# build we just error out if things aren't there.
+$(LIBQEMUUTIL) $(BUILD_DIR)/config-host.h:
+	$(error $@ missing, re-run parent build)
 
-$(LIBQEMUUTIL):
-	$(MAKE) -C $(BUILD_DIR) libqemuutil.a
-
-$(BUILD_DIR)/config-host.h:
-	$(MAKE) -C $(BUILD_DIR) config-host.h
+all: $(BUILD_DIR)/config-host.h $(BINARIES)
 
 # libtestfloat.a depends on libsoftfloat.a, so specify it first
 FP_TEST_LIBS := libtestfloat.a libsoftfloat.a $(LIBQEMUUTIL)
-- 
2.20.1


