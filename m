Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FA2C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:27:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5260D2078E
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jpLlMGhv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5260D2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDnOT-00037l-DC
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kDnIv-0002bg-7O
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:21:21 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:54204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kDnIt-0007Zo-3s
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:21:20 -0400
Received: by mail-wm1-x334.google.com with SMTP id u18so2476043wmc.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 04:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PKpstIcY7X4muCx/xVveAt+vF3elxwMvmZRPrfN9dSs=;
 b=jpLlMGhvqRrbHJhLHm6S3PZrHwfXAZqWlfOx8zQCpZtQgAMUYmZ8ODF+wm9ATlYwAz
 xog77rfIIr1MbjXXW5PcGRbx7pOkckQXwUsw/JsSixbhqOA1zKeO/LWmktvBQsLfS5Op
 nt4f9JSOelcf+4DpGOxFJiYo/wlWvg5L7fmOli4UbZeLIIxcUyQdBQW0ib29Bxtd0p2y
 RaLkHsn3YJthEbyT/bBpDWqlnKSqdz2us/mCotrWFAlEJaJ9InGwtTau3pF37Qctap9T
 hrZfTWYbTX8cg9x5uxJqiMMMuiKKJnarWRU5F9YDDqkh0iFq6gW95ybu1OAv86yeoatl
 TAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PKpstIcY7X4muCx/xVveAt+vF3elxwMvmZRPrfN9dSs=;
 b=eD6VMBV4+MxHBfjXdkoK5HmcMzGTnA+Eacz5s5DxGZT/ongPRhSmmHcydjsFpIcr0O
 UfcJNW59IIC4FYXx7FEk1fXI6/Xr5Vk+DIRVVRKcmdMLfOisPUgeV58KoFUJChUOMkpO
 96fjFuGQ2tIU7P6edRSU4LwCET5BwmkgZ2fpFHFJdAa0gClnYCwvE1Bc6u9WdUQQ7ME9
 TCyqv/LpPSHnIe7bNElG4wzzZadi+azM2f8pnemrJHvKwq0TsFNxMugZHeJAjubA94H8
 4/Fh5rE3HcN/ou1Ak3Z9kNB9SUG67en08cZ1mc/F3fpjrrD8pH08NVkB6pqfNVFoxwms
 oK1g==
X-Gm-Message-State: AOAM531yUCnzlrFDXMsANTDODWd+Fjkk2pCUfnrWsX9FxX1LEoamdu7t
 YbgjPCfwN+v2uq35iHAn31KZvQ==
X-Google-Smtp-Source: ABdhPJya3yDM05NnlE0OYlUEQ+JB32eobkV0YyVJiaSEqSScCg1zmm0fdH+hs/iqSdaL62MEviPOXg==
X-Received: by 2002:a1c:7418:: with SMTP id p24mr1970872wmc.123.1599132077590; 
 Thu, 03 Sep 2020 04:21:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o2sm3907598wmo.37.2020.09.03.04.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 04:21:12 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3E7EE1FF91;
 Thu,  3 Sep 2020 12:21:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 5/8] qemu-iotests: move check-block back to Makefiles
Date: Thu,  3 Sep 2020 12:21:04 +0100
Message-Id: <20200903112107.27367-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200903112107.27367-1-alex.bennee@linaro.org>
References: <20200903112107.27367-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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
Cc: fam@euphon.net, Kevin Wolf <kwolf@redhat.com>, berrange@redhat.com,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, Max Reitz <mreitz@redhat.com>,
 cota@braap.org, stefanha@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

check-block has its own test harness, unlike every other test.  If
we capture its output, as is in general nicer to do without V=1,
there will be no sign of progress.  So for lack of a better option
just move the invocation of the test back to Makefile rules.

As a side effect, this will also fix "make check" in --disable-tools
builds, as they were trying to run qemu-iotests without having
made qemu-img before.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200902080046.10412-1-pbonzini@redhat.com>
---
 meson.build                    |  2 --
 tests/Makefile.include         | 15 ++++++++++++---
 tests/qemu-iotests/meson.build |  4 ----
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/meson.build b/meson.build
index 9b5076452b2..599306f59ad 100644
--- a/meson.build
+++ b/meson.build
@@ -1100,11 +1100,9 @@ if have_tools
              dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
   qemu_io = executable('qemu-io', files('qemu-io.c'),
              dependencies: [block, qemuutil], install: true)
-  qemu_block_tools += [qemu_img, qemu_io]
   if targetos != 'windows'
     qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
                dependencies: [block, qemuutil], install: true)
-    qemu_block_tools += [qemu_nbd]
   endif
 
   subdir('storage-daemon')
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 9ac8f5b86a6..08301f5bc9b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -468,7 +468,6 @@ check-tcg: $(RUN_TCG_TARGET_RULES)
 .PHONY: clean-tcg
 clean-tcg: $(CLEAN_TCG_TARGET_RULES)
 
-
 # Python venv for running tests
 
 .PHONY: check-venv check-acceptance
@@ -523,8 +522,18 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
 # Consolidated targets
 
 .PHONY: check-block check-unit check check-clean get-vm-images
-check-block:
-check-build: build-unit
+check:
+
+ifeq ($(CONFIG_TOOLS)$(CONFIG_POSIX),yy)
+QEMU_IOTESTS_HELPERS-$(CONFIG_LINUX) = tests/qemu-iotests/socket_scm_helper$(EXESUF)
+check: check-block
+check-block: $(SRC_PATH)/tests/check-block.sh qemu-img$(EXESUF) \
+		qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y) \
+		$(patsubst %-softmmu,qemu-system-%,$(filter %-softmmu,$(TARGET_DIRS)))
+	@$<
+endif
+
+check-build: build-unit $(QEMU_IOTESTS_HELPERS-y)
 
 check-clean:
 	rm -rf $(check-unit-y) tests/*.o tests/*/*.o $(QEMU_IOTESTS_HELPERS-y)
diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
index 3de09fb8fab..60470936b45 100644
--- a/tests/qemu-iotests/meson.build
+++ b/tests/qemu-iotests/meson.build
@@ -4,7 +4,3 @@ if 'CONFIG_LINUX' in config_host
 else
     socket_scm_helper = []
 endif
-test('qemu-iotests', sh, args: [files('../check-block.sh')],
-     depends: [qemu_block_tools, emulators, socket_scm_helper],
-     suite: 'block', timeout: 10000)
-
-- 
2.20.1


