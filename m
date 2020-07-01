Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80943C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:21:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EF862077D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oQrjkOJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF862077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdbf-0000r3-It
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdL6-0005Nw-Qv
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:03:52 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:33272)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdL4-0006s6-LO
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:03:52 -0400
Received: by mail-wr1-x42b.google.com with SMTP id f18so15927678wrs.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 07:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6iI9/w6QPP17yFAS2LeQCOWZjjok/LI3j4IGGgPNwkk=;
 b=oQrjkOJZ5sjTJa4s+xN7BoTtY6doSPVbV6LoG3Sn0CaYY3ZhEGylBntFSml1Q6vWBR
 O173JsW/NqnAleGq+rG4qnqhp3G1UECM0/MtVbayvof2qaMJHel/MeRE0HQ3MoXE89vi
 bgXyMtzlI1aDJDmlQGYtZJgaGqI5EUq3zxueaY/EmoeklqCapD6xMMwWBzEsJyDkNLfH
 oz1Od1l16EHZoyHkX5wFqdpmc8bF7TTueEEdgOkJzR0YskrXsQUIgWJwGc6MF9oVh1kP
 9NKc6cYme4ysyeoWBHfT+06yZXv+OsPTeaxXiE+qVedFZ2emJiftQOrSlfUobuApILcV
 TNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6iI9/w6QPP17yFAS2LeQCOWZjjok/LI3j4IGGgPNwkk=;
 b=S7r/EmkfWMj1G8t3H1P3lL7pQ7uZjNAZGzVLd/9ATYVsgiDJJF4TqvaRMGQ12pa4Pu
 dZ97YLekuv/QLzAwSNqn+DBF3lRTRQQL4RPv3fRLSpl0U2yNXqiO1iVXBHzukC0qOZV5
 cflz3Ky0OnZ+sjlWHr2b9mC0Q0DZgQpaJtxqM+pjWTqT5xNuLnYQPiLzJW8Ap1UGYsyu
 zETaZh7C37scEdOjzB/UfZL9s4UlpzSKjMhLF0+0htMiWbRsrlh7E8F1/JvhAgRulFV5
 0oINFGRh6u+3AGUpkCxgxkNKny9igo47OGeEN6RTBS8e/a7XDEvTA9efoJxFf8g2zvH7
 zjxQ==
X-Gm-Message-State: AOAM532B1TcF4U/YXF9GTkvANkcIiq5FZKezrLQwijmOYVXMmBPyjh1i
 ggbsacgbj1MmyXqLc8rFOTeMDg==
X-Google-Smtp-Source: ABdhPJzo+2E66bebCacQpLqEVRwCdFlWKPj9Viso6JbXz+iCA2+cf2yD5+q03uYqI6rItVE0xMp4fQ==
X-Received: by 2002:adf:e6c8:: with SMTP id y8mr28673953wrm.40.1593612229115; 
 Wed, 01 Jul 2020 07:03:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q1sm7406724wro.82.2020.07.01.07.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 07:03:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C60E01FFC0;
 Wed,  1 Jul 2020 14:56:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v4 39/40] testing: add check-build target
Date: Wed,  1 Jul 2020 14:56:51 +0100
Message-Id: <20200701135652.1366-40-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200701135652.1366-1-alex.bennee@linaro.org>
References: <20200701135652.1366-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we want to continue to split build and check phase it seems like a
good idea to allow building of the tests during our multi-threaded
build phase.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.yml         |  5 ++++-
 tests/Makefile.include | 17 +++++++++++++----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 83e38ea19f3..b0e5417146b 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -36,7 +36,7 @@ include:
     - make -j"$JOBS"
     - if test -n "$MAKE_CHECK_ARGS";
       then
-        make $MAKE_CHECK_ARGS ;
+        make -j"$JOBS" $MAKE_CHECK_ARGS ;
       fi
 
 .native_test_job_template: &native_test_job_definition
@@ -60,6 +60,7 @@ build-system-ubuntu-main:
     TARGETS: aarch64-softmmu alpha-softmmu cris-softmmu hppa-softmmu lm32-softmmu
       moxie-softmmu microblazeel-softmmu mips64el-softmmu m68k-softmmu ppc-softmmu
       riscv64-softmmu sparc-softmmu
+    MAKE_CHECK_ARGS: check-build
   artifacts:
     paths:
       - build
@@ -90,6 +91,7 @@ build-system-fedora-alt:
     TARGETS: tricore-softmmu unicore32-softmmu microblaze-softmmu mips-softmmu
       riscv32-softmmu s390x-softmmu sh4-softmmu sparc64-softmmu x86_64-softmmu
       xtensa-softmmu nios2-softmmu or1k-softmmu
+    MAKE_CHECK_ARGS: check-build
   artifacts:
     paths:
       - build
@@ -124,6 +126,7 @@ build-system-fedora-disabled:
       --disable-qom-cast-debug --disable-spice --disable-vhost-vsock
       --disable-vhost-net --disable-vhost-crypto --disable-vhost-user
     TARGETS: i386-softmmu ppc64-softmmu mips64-softmmu i386-linux-user
+    MAKE_CHECK_ARGS: check-build
   artifacts:
     paths:
       - build
diff --git a/tests/Makefile.include b/tests/Makefile.include
index c316e0d6647..94b1cc8302e 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -22,6 +22,8 @@ endif
 	@echo " $(MAKE) check-venv           Creates a Python venv for tests"
 	@echo " $(MAKE) check-clean          Clean the tests and related data"
 	@echo
+	@echo "The following are useful for CI builds"
+	@echo " $(MAKE) check-build          Build most test binaris"
 	@echo " $(MAKE) get-vm-images        Downloads all images used by acceptance tests, according to configured targets (~350 MB each, 1.5 GB max)"
 	@echo
 	@echo
@@ -649,6 +651,10 @@ $(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: %-softmmu/all $(c
 	  QTEST_QEMU_BINARY=$*-softmmu/qemu-system-$* \
 	  QTEST_QEMU_IMG=qemu-img$(EXESUF))
 
+build-qtest: $(patsubst %, %-softmmu/all, $(QTEST_TARGETS)) $(check-qtest-y)
+
+build-unit: $(check-unit-y)
+
 check-unit: $(check-unit-y)
 	$(call do_test_human, $^)
 
@@ -680,7 +686,6 @@ check-report.tap: $(patsubst %,check-report-qtest-%.tap, $(QTEST_TARGETS)) check
 FP_TEST_BIN=$(BUILD_DIR)/tests/fp/fp-test
 
 # the build dir is created by configure
-.PHONY: $(FP_TEST_BIN)
 $(FP_TEST_BIN): config-host.h $(test-util-obj-y)
 	$(call quiet-command, \
 	 	$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" $(notdir $@), \
@@ -814,9 +819,10 @@ check-softfloat-ops: $(SF_MATH_RULES)
 
 .PHONY: check-softfloat
 ifeq ($(CONFIG_TCG),y)
-check-softfloat: check-softfloat-conv check-softfloat-compare check-softfloat-ops
+build-softfloat: $(FP_TEST_BIN)
+check-softfloat: build-softfloat check-softfloat-conv check-softfloat-compare check-softfloat-ops
 else
-check-softfloat:
+build-softfloat check-softfloat:
 	$(call quiet-command, /bin/true, "FLOAT TEST", \
 		"SKIPPED for non-TCG builds")
 endif
@@ -955,7 +961,8 @@ check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
 ifeq ($(CONFIG_TOOLS),y)
 check-block: $(patsubst %,check-%, $(check-block-y))
 endif
-check: check-block check-qapi-schema check-unit check-softfloat check-qtest check-decodetree
+check-build: build-unit build-softfloat build-qtest
+
 check-clean:
 	rm -rf $(check-unit-y) tests/*.o tests/*/*.o $(QEMU_IOTESTS_HELPERS-y)
 	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y:%=tests/qtest/%$(EXESUF))) $(check-qtest-generic-y:%=tests/qtest/%$(EXESUF)))
@@ -963,6 +970,8 @@ check-clean:
 	rm -f tests/qtest/dbus-vmstate1-gen-timestamp
 	rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)
 
+check: check-block check-qapi-schema check-unit check-softfloat check-qtest check-decodetree
+
 clean: check-clean
 
 # Build the help program automatically
-- 
2.20.1


