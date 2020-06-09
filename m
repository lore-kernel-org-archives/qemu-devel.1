Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE96AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:14:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 550872065C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="meFFanmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 550872065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jikdw-00064s-LB
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 16:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jikZP-000815-Mz
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:10:03 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:39678)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jikZO-0005cr-ED
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:10:03 -0400
Received: by mail-pg1-x52c.google.com with SMTP id w20so10766230pga.6
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 13:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=cHjY5HzznfKw8VbLxbBOVqurhqy9xCUukR85p1gtXTQ=;
 b=meFFanmvYve6P4U84sZWJmvNJtxvl5Odzkfx3EOOaEY5IqWwcu1Km1m14phH79lK+E
 siDDwMZyUYpSACzfFDVm51PWeqkaCCEzWEPOtCFWKm3bivPuBYP+zmprenJG6WtDXzaC
 eVNGbpf1vr2zkfRk8OItepu9IEUQcFqVV7O+cLN4ZeXomi5N3P8asrGpUJpZ1jGOFyQb
 8GjgAlYecgyA5wyUlQ3r4OUDaaXZuxyvmPHIvHv2x/98AivNrO6aHm1h1vw36xKxJ7bT
 MchefeoniBvHVRetRX7wQxSKGs8BnpJ/x45nHcJdXojORQOXuN7bM4s4Gone8VxuV0LH
 6Obw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=cHjY5HzznfKw8VbLxbBOVqurhqy9xCUukR85p1gtXTQ=;
 b=Fe5aprxNo2W2erFC9UsLro6G/IGjM388VQV0pfqiLxMr0pMKI6OccXR7mPNzVJ92ft
 i/osxIK22ZAC5W6AbyyfBcc18ezJo+t7pdIzwxjFiijCeknCrU2im64X+lExyyQTwP8u
 8g3X9WW4KG9U3VDseBBie6ceIKiTSAFas/Xs+QrInhLWipoC7Nu79f8I8uWm21UFl0Ku
 5FSdMeq2yc1kEBCdK//MfEnxgaHdSfG2uRNEsW/nuZVsrbuO27ZIPtunmKlHLOAV+tSw
 Hav7JxRJoPvV348SjRvq2zbFG8WH1EL5sdsIz89XULgD0Vu9C8vICaVs9jQ3ORct2uXl
 ZCWA==
X-Gm-Message-State: AOAM530xr2PqBahfSbj9xyHFacb45J9WpF0OmGYYNevp5EOyPHYlMFdN
 m0ofy99W46QEs1mm7fLjxaAebDA0SEhjUQ==
X-Google-Smtp-Source: ABdhPJyTysgoZ3Lbeg8LtOxKKhDI98mw0xurs+9pgRIytjwTseN0pyz7We8x3Kd2vlZamEf6L7oeRQ==
X-Received: by 2002:aa7:8b56:: with SMTP id i22mr26717403pfd.63.1591733400654; 
 Tue, 09 Jun 2020 13:10:00 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1d09:cef2:3b1f:abce])
 by smtp.gmail.com with ESMTPSA id n19sm10523374pfu.194.2020.06.09.13.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 13:09:59 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/13] tests:  Disable select tests under TSan,
 which hit TSan issue.
Date: Tue,  9 Jun 2020 16:07:38 -0400
Message-Id: <20200609200738.445-14-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609200738.445-1-robert.foley@linaro.org>
References: <20200609200738.445-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=robert.foley@linaro.org; helo=mail-pg1-x52c.google.com
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
Reviewed-by: Emilio G. Cota <cota@braap.org>
---
 tests/Makefile.include       | 9 +++++++--
 tests/qtest/Makefile.include | 7 +++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index c2397de8ed..8d82c24d83 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -55,7 +55,6 @@ SYSEMU_TARGET_LIST := $(subst -softmmu.mak,,$(notdir \
 
 check-unit-y += tests/check-qdict$(EXESUF)
 check-unit-y += tests/check-block-qdict$(EXESUF)
-check-unit-$(CONFIG_SOFTMMU) += tests/test-char$(EXESUF)
 check-unit-y += tests/check-qnum$(EXESUF)
 check-unit-y += tests/check-qstring$(EXESUF)
 check-unit-y += tests/check-qlist$(EXESUF)
@@ -108,7 +107,6 @@ check-unit-y += tests/test-qht$(EXESUF)
 check-unit-y += tests/test-qht-par$(EXESUF)
 check-unit-y += tests/test-bitops$(EXESUF)
 check-unit-y += tests/test-bitcnt$(EXESUF)
-check-unit-$(CONFIG_SOFTMMU) += tests/test-qdev-global-props$(EXESUF)
 check-unit-y += tests/check-qom-interface$(EXESUF)
 check-unit-y += tests/check-qom-proplist$(EXESUF)
 check-unit-y += tests/test-qemu-opts$(EXESUF)
@@ -123,9 +121,16 @@ check-speed-$(CONFIG_BLOCK) += tests/benchmark-crypto-cipher$(EXESUF)
 check-unit-$(CONFIG_BLOCK) += tests/test-crypto-secret$(EXESUF)
 check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) += tests/test-crypto-tlscredsx509$(EXESUF)
 check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) += tests/test-crypto-tlssession$(EXESUF)
+ifndef CONFIG_TSAN
+# Some tests: test-char, test-qdev-global-props, and test-qga,
+# are not runnable under TSan due to a known issue.
+# https://github.com/google/sanitizers/issues/1116
+check-unit-$(CONFIG_SOFTMMU) += tests/test-char$(EXESUF)
+check-unit-$(CONFIG_SOFTMMU) += tests/test-qdev-global-props$(EXESUF)
 ifneq (,$(findstring qemu-ga,$(TOOLS)))
 check-unit-$(call land,$(CONFIG_LINUX),$(CONFIG_VIRTIO_SERIAL)) += tests/test-qga$(EXESUF)
 endif
+endif
 check-unit-$(CONFIG_SOFTMMU) += tests/test-timed-average$(EXESUF)
 check-unit-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_INOTIFY1)) += tests/test-util-filemonitor$(EXESUF)
 check-unit-$(CONFIG_SOFTMMU) += tests/test-util-sockets$(EXESUF)
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


