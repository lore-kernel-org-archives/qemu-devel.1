Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A673FC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 19:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A392087E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 19:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eBG1BmBQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A392087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52715 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRiHq-00039p-5J
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 15:12:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hRiGt-0002hZ-ER
	for qemu-devel@nongnu.org; Fri, 17 May 2019 15:12:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hRiGr-0003TY-Rw
	for qemu-devel@nongnu.org; Fri, 17 May 2019 15:11:59 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:56170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hRiGr-00037X-Kx
	for qemu-devel@nongnu.org; Fri, 17 May 2019 15:11:57 -0400
Received: by mail-wm1-x343.google.com with SMTP id x64so7885546wmb.5
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 12:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=UR0Nl8W0wGoR68IUXHoYPpMH947NuEaUQ987FFuQHgQ=;
	b=eBG1BmBQ1eQJFu8uk2BZBQTbtpsioduBsI91troFOlN3LsspM11K2ZMnheI8wK3BQi
	3PsUgPMKWtsr6F73c3TddXNTmLtd4sbviGwteI1FrcgQPujoFHAMQILddPPm00jxLMeR
	zM+UwgJmPCFDUl7QCo3OnE4yVDo+qvkI3BZC6ywbrgV+0SCXdy0uUzHxONMvhuVba12W
	fE2nnHY+ccrmXc3urEqU/bEPeWwSAZ6szJn+JBktaTGoAdxZSAhZrxkvR87RTXBM8LFs
	hH+m3tftM02+EvLvn93AETv4OvGNceJHgmXrVG9Lk3002wBYRbcGwPMBhDhadxYnm85c
	BozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=UR0Nl8W0wGoR68IUXHoYPpMH947NuEaUQ987FFuQHgQ=;
	b=QQUw2jGJotjSuLPYX/yP+HYIb11pcu93lig/ki7oCKfDnPXLERqmfDYIqHqZ9GcLVr
	lKQFV6+RUGHa4CA0W+YwsgSjSHPv5hwX3vLrbzx4QKzsvlFuYpxw3u80oecrow0nu+Bt
	T3mXM7o+WdN3JNGLvz3wnYv8jOE45WL+RgutQr3b745QyZnFnP2WtZHADW3H4GZX6sRH
	Hvqb0iG7/lkq24pTaesmMEDL7ViYSgf9cAsKkzFXseXsb0k0us9bMJ/9ctlaXGXLj+Vk
	eUMTPc4yHtqpj8hb6GvJVc/r2DeKqV0LWdN2R+T7/4NMg4g5Q7tvYYHGRcx43uPnUOvX
	p7ng==
X-Gm-Message-State: APjAAAWw7D1GVwNzPe86c3w17Mbj/NdUPwvj+QzOeD44oRQvpH86b7vO
	VzkihwEcyNhf8ZB0xZ3jSrWzwQ==
X-Google-Smtp-Source: APXvYqzhl2gT1R4mkVFoK8VU5qobMZ2TSL3UsV8WqMTby7Im0IOYqwym7zBaREmwhzRhgMTnrVX55g==
X-Received: by 2002:a1c:f606:: with SMTP id w6mr3491982wmc.130.1558120296938; 
	Fri, 17 May 2019 12:11:36 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	b12sm11358023wmg.27.2019.05.17.12.11.36
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 17 May 2019 12:11:36 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id DF8EB1FF87;
	Fri, 17 May 2019 20:11:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: cota@braap.org
Date: Fri, 17 May 2019 20:11:20 +0100
Message-Id: <20190517191120.765-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181209193749.12277-1-cota@braap.org>
References: <20181209193749.12277-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [RFC PATCH] tests/tcg: enable plugin testing
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
	"open list:ARM" <qemu-arm@nongnu.org>, bobby.prani@gmail.com,
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
---
 tests/Makefile.include                | 10 +++++++-
 tests/tcg/Makefile                    | 34 +++++++++++++++++++++++++++
 tests/tcg/arm/Makefile.softmmu-target |  1 +
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 792f685ac11..91d254cdca5 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1037,6 +1037,14 @@ check-softfloat:
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
@@ -1051,7 +1059,7 @@ $(foreach PROBE_TARGET,$(TARGET_DIRS), 				\
 		$(eval build-tcg-tests-$(PROBE_TARGET): $(DOCKER_PREREQ))))
 endif
 
-build-tcg-tests-%:
+build-tcg-tests-%: $(if $(CONFIG_PLUGIN),plugins)
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" \
 		SKIP_DOCKER_BUILD=1 TARGET_DIR="$*/" guest-tests, \
 		"BUILD", "TCG tests for $*")
diff --git a/tests/tcg/Makefile b/tests/tcg/Makefile
index 6fa63cc8d53..9474ab29003 100644
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
index 49d48d8a1c3..cd628306b3e 100644
--- a/tests/tcg/arm/Makefile.softmmu-target
+++ b/tests/tcg/arm/Makefile.softmmu-target
@@ -25,5 +25,6 @@ LDFLAGS+=-nostdlib -N -static
 test-armv6m-undef: EXTRA_CFLAGS+=-mcpu=cortex-m0
 
 run-test-armv6m-undef: QEMU_OPTS+=-semihosting -M microbit -kernel
+run-plugin-test-armv6m-undef-%: QEMU_OPTS+=-semihosting -M microbit -kernel
 
 endif
-- 
2.20.1


