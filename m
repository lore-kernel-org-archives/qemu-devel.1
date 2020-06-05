Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DD2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:41:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA012074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ivveq8k5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA012074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGL8-0002bl-UD
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 13:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jhGI8-0004PG-11
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:38:04 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:45699)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jhGI6-00042q-W7
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:38:03 -0400
Received: by mail-pg1-x535.google.com with SMTP id n23so5483546pgb.12
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 10:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=803eDYLxeJBOM1lm3oQCQ/DECicGijz33nVW4BPgwBQ=;
 b=Ivveq8k5c6Bre34x7c3IBsxeBk/DMPW9wMxl+uG2Dvk0eW70QxO/XpguNZ4rrVQGnq
 g19ToVLqZy0pOju9y5wB6D7Po88nYsQ1oSiZfCl5Kz8IeKSI0XK5P1gU/b+NgiSIf8J/
 taQ7yiqVZsCKThcJtNBBjO1Nv15TOvUEA79Aiziyd4GZHKJr5of8NrAztqTswF7/XLPz
 o2XE7EK2C4ktOeuLnt+zuqSIXrfxK/9ml7WgPJU6AWAQA+pYxa0jV2AxGULtcgVdf6mc
 05w+CtKfIqvoopfzMqZC+k7nyVb66L/BJSUyGkXcUAHBzd3f71IFDqW7c7RWy/rigH8k
 YaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=803eDYLxeJBOM1lm3oQCQ/DECicGijz33nVW4BPgwBQ=;
 b=g6rTyGq6TN5ASISsDpp8CLFhWu9/wm2z/0t8IpQ30N/WY6aLmLimLPuWm7skZKXMOh
 avbH0s7exXVD6M7pe8rGcUXfweQPbL1kjb/nmpUDFnXp6SR1zfE+yECJsRaMTKLP5ciZ
 eXgGsCqa+49Ko4jQZi13k6YGrWN3Ga3DCqyxaE18mluoZonOVCq1dtK5AYQhdCLHXArx
 GAUJwYXiddM620mHxFe7g7LAeDiQNHiFUwfcmaUEB43O0OJ1g8A/+AscqUqIRcD1W66M
 GuT07DpsFoTRY9E3FjObzMS75sEcOqaOKF9XQncSCClyN7zSs76DQr1o2M96wFqYQ7zG
 +4dA==
X-Gm-Message-State: AOAM531cuwbiOtSzQFkoa+1zj8gGw9eYLXCmjQd8s1uQDYN7/HTK5sCE
 ViLiQxuLOQDdzPmk1+aewdkLaLZqFaoUKw==
X-Google-Smtp-Source: ABdhPJyUHdTF/SV3Qo5asvOXhkjbKXIm+KSfzrQG3nkZ9fVYdg7+QSDtdgZTV0p8NM2o/3repwq3+A==
X-Received: by 2002:a62:8487:: with SMTP id
 k129mr10934010pfd.296.1591378680322; 
 Fri, 05 Jun 2020 10:38:00 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 (c-73-47-162-176.hsd1.ma.comcast.net. [73.47.162.176])
 by smtp.gmail.com with ESMTPSA id a19sm188307pfd.165.2020.06.05.10.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 10:37:59 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/13] tests:  Disable select tests under TSan,
 which hit TSan issue.
Date: Fri,  5 Jun 2020 13:34:22 -0400
Message-Id: <20200605173422.1490-14-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200605173422.1490-1-robert.foley@linaro.org>
References: <20200605173422.1490-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=robert.foley@linaro.org; helo=mail-pg1-x535.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 robert.foley@linaro.org, cota@braap.org, Paolo Bonzini <pbonzini@redhat.com>,
 peter.puhov@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Disable a few tests under CONFIG_TSAN, which
run into a known TSan issue that results in a hang.
https://github.com/google/sanitizers/issues/1116

The disabled tests under TSan include all the qtests as well as
the test-char, test-qga, and test-qdev-global-props.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 tests/Makefile.include       | 9 +++++++--
 tests/qtest/Makefile.include | 7 +++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 6e3d6370df..874a2990b3 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -53,7 +53,6 @@ SYSEMU_TARGET_LIST := $(subst -softmmu.mak,,$(notdir \
 
 check-unit-y += tests/check-qdict$(EXESUF)
 check-unit-y += tests/check-block-qdict$(EXESUF)
-check-unit-$(CONFIG_SOFTMMU) += tests/test-char$(EXESUF)
 check-unit-y += tests/check-qnum$(EXESUF)
 check-unit-y += tests/check-qstring$(EXESUF)
 check-unit-y += tests/check-qlist$(EXESUF)
@@ -106,7 +105,6 @@ check-unit-y += tests/test-qht$(EXESUF)
 check-unit-y += tests/test-qht-par$(EXESUF)
 check-unit-y += tests/test-bitops$(EXESUF)
 check-unit-y += tests/test-bitcnt$(EXESUF)
-check-unit-y += tests/test-qdev-global-props$(EXESUF)
 check-unit-y += tests/check-qom-interface$(EXESUF)
 check-unit-y += tests/check-qom-proplist$(EXESUF)
 check-unit-y += tests/test-qemu-opts$(EXESUF)
@@ -121,9 +119,16 @@ check-speed-$(CONFIG_BLOCK) += tests/benchmark-crypto-cipher$(EXESUF)
 check-unit-$(CONFIG_BLOCK) += tests/test-crypto-secret$(EXESUF)
 check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) += tests/test-crypto-tlscredsx509$(EXESUF)
 check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) += tests/test-crypto-tlssession$(EXESUF)
+ifndef CONFIG_TSAN
+# Some tests: test-char, test-qdev-global-props, and test-qga,
+# are not runnable under TSan due to a known issue.
+# https://github.com/google/sanitizers/issues/1116
+check-unit-$(CONFIG_SOFTMMU) += tests/test-char$(EXESUF)
+check-unit-y += tests/test-qdev-global-props$(EXESUF)
 ifneq (,$(findstring qemu-ga,$(TOOLS)))
 check-unit-$(call land,$(CONFIG_LINUX),$(CONFIG_VIRTIO_SERIAL)) += tests/test-qga$(EXESUF)
 endif
+endif
 check-unit-y += tests/test-timed-average$(EXESUF)
 check-unit-$(CONFIG_INOTIFY1) += tests/test-util-filemonitor$(EXESUF)
 check-unit-y += tests/test-util-sockets$(EXESUF)
diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
index 9e5a51d033..71fd714a2a 100644
--- a/tests/qtest/Makefile.include
+++ b/tests/qtest/Makefile.include
@@ -313,12 +313,15 @@ tests/qtest/tpm-tis-device-test$(EXESUF): tests/qtest/tpm-tis-device-test.o test
 # QTest rules
 
 TARGETS=$(patsubst %-softmmu,%, $(filter %-softmmu,$(TARGET_DIRS)))
+QTEST_TARGETS =
+# The qtests are not runnable (yet) under TSan due to a known issue.
+# https://github.com/google/sanitizers/issues/1116
+ifndef CONFIG_TSAN
 ifeq ($(CONFIG_POSIX),y)
 QTEST_TARGETS = $(TARGETS)
 check-qtest-y=$(foreach TARGET,$(TARGETS), $(check-qtest-$(TARGET)-y:%=tests/qtest/%$(EXESUF)))
 check-qtest-y += $(check-qtest-generic-y:%=tests/qtest/%$(EXESUF))
-else
-QTEST_TARGETS =
+endif
 endif
 
 qtest-obj-y = tests/qtest/libqtest.o $(test-util-obj-y)
-- 
2.17.1


