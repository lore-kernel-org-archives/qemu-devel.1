Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E4DFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:38:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 956992089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T0asdU8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956992089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5yy-0008TN-7I
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5mS-0002DM-Od
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5mR-0001GP-9K
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:28 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:37759)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5mR-0001Fo-2c
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:27 -0400
Received: by mail-wr1-x431.google.com with SMTP id p14so2359312wro.4
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Shj2sUFHREFoNKEY0G4KRrT2p/DDO+h1POzPYyb7/oY=;
 b=T0asdU8/UtNNPnhq+7KesM5zKbF1Mp9KNB00J3msfMlctmw75FDJ9OfF2hHs4090M7
 mowtYq/TnPhB89E8I4t6/1paq+00pMnLVA8WCUzBDh05ILD1Zcx6H4nh5ak1hCzCDKRU
 nD7lVp+a22NnZT6UGZukmJjA6UN17bggu2CYPbQ12R1/qbcZVcRF60YMv7I66ngU+Eua
 WTOcDqNjJ/IrRF2hkXQnGiKRUdfLeG33p78YmlFAMwVaXap21FUrZeLBZrkU3WkurQRv
 Qc3gINfsvf4zs651MD98gkHU2pg14pefvMvbvOG+7/zd3O1EZk0h5W0cc6G6yeM4k4PT
 YO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Shj2sUFHREFoNKEY0G4KRrT2p/DDO+h1POzPYyb7/oY=;
 b=f/qzgZvLb+Adsr6jyKmrdw2HonI+Yn1JfvWiH49xPn/hkHJnKHAXGAgUIQFNIRua29
 NEgHXJvGhbnRWjaoUbsSJbnT/RLcRw46649WVYzdw+6RrIM4k/hNdGqpq4SPIjSzLaJR
 GhWKkkGvZZLWGF+fa3fu2hZYvhyZDOP7RRb6qt12naOi7Ta9uCtbEeRfrT12A6oWTZil
 +p0N6yABAEup4OP55wDUYdgvkI/warwveD509ETJJcuAG40cC55ywBrKtin4Pwe65U2V
 If43ga1Epsv2JQMeKc5yhtjVobjIJOuQyjI/3RvBNkmyGcdNsxDi3/i3NRkb6JSM5Tva
 9K6Q==
X-Gm-Message-State: APjAAAVZCGhpIAsecBKlzVbVOSihOKvRNFr+Sl5rnU/a7+7E6LJJyxGr
 p/vA+QSHc8SEqBAAOZIYuzVjXw==
X-Google-Smtp-Source: APXvYqx3+Y/XpQEAU35PWKo+SVpo0RhAzvrisyAebpLdcInhtng81lOMlWA/ZMJvBGP4IcTrUjy4lg==
X-Received: by 2002:a5d:46d2:: with SMTP id g18mr2924439wrs.245.1571318725828; 
 Thu, 17 Oct 2019 06:25:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g11sm2202766wmh.45.2019.10.17.06.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:25:22 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 566E31FFC5;
 Thu, 17 Oct 2019 14:16:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 47/54] tests/tcg: enable plugin testing
Date: Thu, 17 Oct 2019 14:16:08 +0100
Message-Id: <20191017131615.19660-48-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 robert.foley@futurewei.com, Richard Henderson <richard.henderson@linaro.org>,
 peter.puhov@futurewei.com, aaron@os.amperecomputing.com, cota@braap.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v5
  - fix for the latest changes to check-tcg
  - extend timeout for plugin tests
  - add special runner for semihosting with plugin
  - fix naming of test in call output
  - add special plugin aware runners for semihosting
v6
  - outs -d plugin output support

squash! tests/tcg: enable plugin testing
---
 tests/Makefile.include                | 11 +++++++-
 tests/tcg/Makefile.target             | 37 +++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target     |  6 +++++
 tests/tcg/arm/Makefile.softmmu-target |  1 +
 tests/tcg/arm/Makefile.target         |  6 +++++
 5 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3543451ed3..646a704e65 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1052,6 +1052,15 @@ check-softfloat:
 		"SKIPPED for non-TCG builds")
 endif
 
+# Plugins
+ifeq ($(CONFIG_PLUGIN),y)
+.PHONY: plugins
+plugins:
+	$(call quiet-command,\
+		$(MAKE) $(SUBDIR_MAKEFLAGS) -C tests/plugin V="$(V)", \
+		"BUILD", "plugins")
+endif
+
 # Per guest TCG tests
 
 BUILD_TCG_TARGET_RULES=$(patsubst %,build-tcg-tests-%, $(TARGET_DIRS))
@@ -1062,7 +1071,7 @@ RUN_TCG_TARGET_RULES=$(patsubst %,run-tcg-tests-%, $(TARGET_DIRS))
 $(foreach PROBE_TARGET,$(TARGET_DIRS), 				\
 	$(eval -include $(SRC_PATH)/tests/tcg/Makefile.prereqs))
 
-build-tcg-tests-%:
+build-tcg-tests-%: $(if $(CONFIG_PLUGIN),plugins)
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
 		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
 		SRC_PATH=$(SRC_PATH) \
diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 9664613002..3c7421a356 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -123,11 +123,39 @@ all: $(TESTS) $(EXTRA_TESTS)
 #
 
 RUN_TESTS=$(patsubst %,run-%, $(TESTS))
+
+# If plugins exist also include those in the tests
+ifeq ($(CONFIG_PLUGIN),y)
+PLUGIN_DIR=../../plugin
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
+		$(eval run-plugin-$(t)-with-$(p): TIMEOUT=30) \
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
+		-d plugin -D $*.pout \
+		 $(call strip-plugin,$<), \
+	"$* on $(TARGET_NAME)")
 else
 run-%: %
 	$(call run-test, $<, \
@@ -135,6 +163,15 @@ run-%: %
 		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
 	   	  $(QEMU_OPTS) $<, \
 	  "$< on $(TARGET_NAME)")
+
+run-plugin-%:
+	$(call run-test, $@, \
+	  $(QEMU) -monitor none -display none \
+		  -chardev file$(COMMA)path=$@.out$(COMMA)id=output \
+	   	  -plugin $(PLUGIN_DIR)/$(call extract-plugin,$@) \
+	    	  -d plugin -D $*.pout \
+	   	  $(QEMU_OPTS) $(call strip-plugin,$<), \
+	  "$* on $(TARGET_NAME)")
 endif
 
 gdb-%: %
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 509f1afa93..96d2321045 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -26,4 +26,10 @@ AARCH64_TESTS += semihosting
 run-semihosting: semihosting
 	$(call run-test,$<,$(QEMU) $< 2> $<.err, "$< on $(TARGET_NAME)")
 
+run-plugin-semihosting-with-%:
+	$(call run-test, $@, $(QEMU) $(QEMU_OPTS) \
+		-plugin $(PLUGIN_DIR)/$(call extract-plugin,$@) \
+		 $(call strip-plugin,$<) 2> $<.err, \
+		"$< on $(TARGET_NAME) with $*")
+
 TESTS += $(AARCH64_TESTS)
diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefile.softmmu-target
index 231e9a57b4..3fe237ba39 100644
--- a/tests/tcg/arm/Makefile.softmmu-target
+++ b/tests/tcg/arm/Makefile.softmmu-target
@@ -23,3 +23,4 @@ LDFLAGS+=-nostdlib -N -static
 test-armv6m-undef: EXTRA_CFLAGS+=-mcpu=cortex-m0
 
 run-test-armv6m-undef: QEMU_OPTS+=-semihosting -M microbit -kernel
+run-plugin-test-armv6m-undef-%: QEMU_OPTS+=-semihosting -M microbit -kernel
diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 3ddff85240..0765f37ff0 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -34,6 +34,12 @@ ARM_TESTS += semihosting
 run-semihosting: semihosting
 	$(call run-test,$<,$(QEMU) $< 2> $<.err, "$< on $(TARGET_NAME)")
 
+run-plugin-semihosting-with-%:
+	$(call run-test, $@, $(QEMU) $(QEMU_OPTS) \
+		-plugin $(PLUGIN_DIR)/$(call extract-plugin,$@) \
+		 $(call strip-plugin,$<) 2> $<.err, \
+		"$< on $(TARGET_NAME) with $*")
+
 TESTS += $(ARM_TESTS)
 
 # On ARM Linux only supports 4k pages
-- 
2.20.1


