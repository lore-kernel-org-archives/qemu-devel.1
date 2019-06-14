Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0069EC46477
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:48:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7470217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ucb28COx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7470217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53874 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbqJK-0003Om-RD
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 13:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58664)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpqj-0005bD-60
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpqe-000790-U9
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:18:47 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34591)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbpqe-0006jT-9j
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:18:44 -0400
Received: by mail-wm1-x343.google.com with SMTP id w9so9349805wmd.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AtuxXjdv5rXrTnKR+kY966HW3wPcp99t7mVhH09mMeM=;
 b=Ucb28COxP9N29+yMdbrQdA8kVqmAcU7/gxDxXTq8Wg5unXy7e46lTP2VZBMTDxPs25
 TCC5DRkxaTJpGdp0YAf1P6n53sLM4VNTdU0BAEsHi05rG8aoGULBL+S3VYYwepmRG5Aw
 Kh3PRKN0UkQ1phFe8VQrLrSaflgWhiD1Bu/R3JhKzAlnP58osihn6EVYYs58MDJIhsKF
 UBYYPima3IZ5JT2av60y6NUDZGkDfd+bbGRaswGF+d5Y5QGUguJ9DW15LyUuC5q3LRpZ
 xdIzsA3gyClRJL9K0we/cnDS0hyCgzxqnbV5mY+/aYVj9ZTC/TS58jiZWDIsWCqSp0Bv
 DAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AtuxXjdv5rXrTnKR+kY966HW3wPcp99t7mVhH09mMeM=;
 b=jKDb+CIRJ18NHkXcux4FM86iA0/aZWIPUPqjxUQIsHoHBM7D8nmdZ7yjFmLeQrNttf
 Y34rS7z0t9wW68DaKiQOh11Sq6FlSGtQjHwXA98mqBg92zTC1p3fjD6YqPnen4C1jR2Q
 CM5lnh3HkTeEwkrlAitDXCKDO0jofRtISPGlR4VMomRZSGHnjNpnZJe4b9z7GJ37jeuk
 R3n4LUH/1ELwDDEqe+FND0XJZWWcm401Gc9ME03CDvdUIdXbuD5oo6uxw6Swr3QSBu6e
 O6Wpotnsrgh0ExtpplJR1yTh9d5lPmfoqW7m1cB6E7v1kedWbzSHbANmX+Wy6Q3U+Tw5
 re5Q==
X-Gm-Message-State: APjAAAUuY9fWIrWgPfKxOb67g+g7RUp1+n01l0CPvMOQalGRdeqWzVAD
 RUPSqxFPE6UL6F0mWTTYdq/TFw==
X-Google-Smtp-Source: APXvYqw6zw6RiTxGhinm8wxWiITqeOci37oKCHRT75bc/xo6UZLh6n5d9dfL9DXvBYvTILTScO5J0Q==
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr8445078wml.97.1560532712975; 
 Fri, 14 Jun 2019 10:18:32 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id x129sm5473118wmg.44.2019.06.14.10.18.28
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:18:29 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3B87D1FFC1;
 Fri, 14 Jun 2019 18:12:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:52 +0100
Message-Id: <20190614171200.21078-43-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH  v3 42/50] tests/tcg: enable plugin testing
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If CONFIG_PLUGINS is enabled then lets enable testing for all our TCG
targets. This is a simple smoke test that ensure we don't crash or
otherwise barf out by running each plugin against each test.

There is a minor knock on effect for additional runners which need
specialised QEMU_OPTS which will also need to declare a plugin version
of the runner. If this gets onerous we might need to add another
helper.

Checking the results of the plugins is left for a later exercise.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/Makefile.include                | 10 +++++++-
 tests/tcg/Makefile                    | 34 +++++++++++++++++++++++++++
 tests/tcg/arm/Makefile.softmmu-target |  1 +
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index db750dd6d0..04b0460262 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1047,6 +1047,14 @@ check-softfloat:
 		"SKIPPED for non-TCG builds")
 endif
 
+# Plugins
+ifeq ($(CONFIG_PLUGIN),y)
+plugins:
+	$(call quiet-command,\
+		$(MAKE) $(SUBDIR_MAKEFLAGS) -C tests/plugin V="$(V)", \
+		"BUILD", "plugins")
+endif
+
 # Per guest TCG tests
 
 BUILD_TCG_TARGET_RULES=$(patsubst %,build-tcg-tests-%, $(TARGET_DIRS))
@@ -1061,7 +1069,7 @@ $(foreach PROBE_TARGET,$(TARGET_DIRS), 				\
 		$(eval build-tcg-tests-$(PROBE_TARGET): $(DOCKER_PREREQ))))
 endif
 
-build-tcg-tests-%:
+build-tcg-tests-%: $(if $(CONFIG_PLUGIN),plugins)
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" \
 		SKIP_DOCKER_BUILD=1 TARGET_DIR="$*/" guest-tests, \
 		"BUILD", "TCG tests for $*")
diff --git a/tests/tcg/Makefile b/tests/tcg/Makefile
index 6fa63cc8d5..9474ab2900 100644
--- a/tests/tcg/Makefile
+++ b/tests/tcg/Makefile
@@ -116,11 +116,37 @@ all: $(TESTS)
 #
 
 RUN_TESTS=$(patsubst %,run-%, $(TESTS))
+
+# If plugins exist also include those in the tests
+ifeq ($(CONFIG_PLUGIN),y)
+PLUGIN_DIR=../../tests/plugin
+VPATH+=$(PLUGIN_DIR)
+PLUGINS=$(notdir $(wildcard $(PLUGIN_DIR)/*.so))
+
+# We need to ensure expand the run-plugin-TEST-with-PLUGIN
+# pre-requistes manually here as we can't use stems to handle it. We
+# also add some special helpers the run-plugin- rules can use bellow.
+
+$(foreach p,$(PLUGINS), \
+	$(foreach t,$(TESTS),\
+		$(eval run-plugin-$(t)-with-$(p): $t $p) \
+		$(eval RUN_TESTS+=run-plugin-$(t)-with-$(p))))
+endif
+
+strip-plugin = $(wordlist 1, 1, $(subst -with-, ,$1))
+extract-plugin = $(wordlist 2, 2, $(subst -with-, ,$1))
+
 RUN_TESTS+=$(EXTRA_RUNS)
 
 ifdef CONFIG_USER_ONLY
 run-%: %
 	$(call run-test, $<, $(QEMU) $(QEMU_OPTS) $<, "$< on $(TARGET_NAME)")
+
+run-plugin-%:
+	$(call run-test, $@, $(QEMU) $(QEMU_OPTS) \
+		-plugin $(PLUGIN_DIR)/$(call extract-plugin,$@) \
+		 $(call strip-plugin,$<), \
+	"$< on $(TARGET_NAME)")
 else
 run-%: %
 	$(call run-test, $<, \
@@ -128,6 +154,14 @@ run-%: %
 		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
 	   	  $(QEMU_OPTS) $<, \
 	  "$< on $(TARGET_NAME)")
+
+run-plugin-%:
+	$(call run-test, $@, \
+	  $(QEMU) -monitor none -display none \
+		  -chardev file$(COMMA)path=$@.out$(COMMA)id=output \
+	   	  -plugin $(PLUGIN_DIR)/$(call extract-plugin,$@) \
+	   	  $(QEMU_OPTS) $(call strip-plugin,$<), \
+	  "$< on $(TARGET_NAME)")
 endif
 
 gdb-%: %
diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefile.softmmu-target
index 49d48d8a1c..cd628306b3 100644
--- a/tests/tcg/arm/Makefile.softmmu-target
+++ b/tests/tcg/arm/Makefile.softmmu-target
@@ -25,5 +25,6 @@ LDFLAGS+=-nostdlib -N -static
 test-armv6m-undef: EXTRA_CFLAGS+=-mcpu=cortex-m0
 
 run-test-armv6m-undef: QEMU_OPTS+=-semihosting -M microbit -kernel
+run-plugin-test-armv6m-undef-%: QEMU_OPTS+=-semihosting -M microbit -kernel
 
 endif
-- 
2.20.1


