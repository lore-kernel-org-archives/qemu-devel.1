Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750D5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:31:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41369206B6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XmVYKRqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41369206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsi4b-0004BR-Gp
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshxw-0001gq-So
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:24:32 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:37243)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshxv-0006hX-1K
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:24:32 -0400
Received: by mail-wm1-x32e.google.com with SMTP id o2so45353069wmh.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9byPofvUmGL/7sYy1T9aOuk75YT7bXG4EnLPH7NVVfk=;
 b=XmVYKRqfcRhuzuspcfM/XBV0n8dIDh9HipAQyYLUW1AXX4ATrKaskTzLkU0nQISf6L
 xHvqxtodYQDnnA7rU4EUXN4smvRkrBgOi6++goUgglCGg/KVovPX9WltL8pEeQxQhRFy
 CffZWt4rd8mC5jofSAb+EnYHI0jA3wCDQIjVcyiPC9BN6NZ+5dH0Z+sNFJohXbhgP65u
 DmoVGRQ7vILfLM/gKjgFRlBnblzAdvtHu9lvN1Qt3/o6uPi5FIksPB3nOkSud5jSbqhT
 09pR07LPh8lGKrkHPIiKvS93uXaXWhrwkdizNrgczJh4aTEolbQY+rV0mQE5mHrhfhlu
 V11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9byPofvUmGL/7sYy1T9aOuk75YT7bXG4EnLPH7NVVfk=;
 b=Ikzp3JnehjkfWNY52frI9vQlvahlawwWFbaBSTHu/7QWCsMV3mQcoHbuL+7ifLsxUv
 PZ2xygSUaZUrbOCbZCU4KpSsmLxiTB6U1TPOxpHyJp3wZZmYs7MlRDMYmGl4nAYFODpp
 lUFGbkFNxnaKNETr0ZIgJdAIOI82XoRfkQ6nH5FNhMEtJgzZ9mtCneka92LzeB1LC9HG
 hc0eT041bbblTm0Toofu+EE0dPkSy9yrvammzrL2X2arUDs/ivMAKZ9afLvAkgnGUgjq
 rBzFH2aLSCetYVb/mmzOAJsnmaqCpAcD0XYkyVo4DuR4olLr/x/hMNwAeKJitTQgWcgB
 eKsA==
X-Gm-Message-State: AOAM533N0Y1G1OSFXvMo80v7NUcTANs6nr6qDUF0XhbA1AN4Vjxz1bWB
 j9TAf0/CmG4q+yHQJcaRVczefQ==
X-Google-Smtp-Source: ABdhPJzoAOMhDvTlY6iKCJdeGotulybCr2cANQYvYm5kgOhbHJpXArRyfF6qV6FTcHcY6kE+Pfte3w==
X-Received: by 2002:a1c:96ce:: with SMTP id y197mr2649506wmd.86.1594106669604; 
 Tue, 07 Jul 2020 00:24:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q3sm2154570wmq.22.2020.07.07.00.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:24:27 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2B77B1FFBE;
 Tue,  7 Jul 2020 08:09:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 37/41] testing: add check-build target
Date: Tue,  7 Jul 2020 08:08:54 +0100
Message-Id: <20200707070858.6622-38-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707070858.6622-1-alex.bennee@linaro.org>
References: <20200707070858.6622-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we want to continue to split build and check phase it seems like a
good idea to allow building of the tests during our multi-threaded
build phase.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200701135652.1366-40-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 83e38ea19f3d..b0e5417146bf 100644
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
index c316e0d66475..94b1cc8302ed 100644
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


