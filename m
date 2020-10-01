Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9A3C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 21:52:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAE1E206C9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 21:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RNJtL65k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE1E206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO6VB-0001DM-I7
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 17:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kO6U3-0000dr-IF
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 17:51:27 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37190)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kO6U0-00034a-QJ
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 17:51:27 -0400
Received: by mail-wr1-x444.google.com with SMTP id z4so362398wrr.4
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 14:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7Pi2MLqv9eXoByMXGqOMrEtbyvdvwGhIllgml8Al4t0=;
 b=RNJtL65ksVu4fuKTPMzDNBBB8MUL0ykcWhBIkOW/YGSEcAP+PBOsNehssXrYESJWEI
 SsJF4t55AHGjVKd4iQLhtD8Y+SJAxr+Xp+eWkXBU1CI05Kwg9vGYedjIy4CqkfkUf1P0
 5uOn3sgDESSxXx4XAp5Ublc9LaN3H5zUxYNBedIBUnuSoP1wQ9vp55KY/7x0MeLXrmMu
 6k/F2dvx+aqFQRhjZI1ua2Z6q+h0KDgdwqR6IaXgj+igYWrd/0xRjPrT3xavBGsugtNK
 0Gcxoa9TCHcudLi06SeCcEfDUacXsNi9ArDfFKLYW+Ta+C+E6fxCM8Y+xWxznjILKa2Y
 nXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7Pi2MLqv9eXoByMXGqOMrEtbyvdvwGhIllgml8Al4t0=;
 b=Jn4SApRlWipzRR9WlWWPcuQwflZYKqxUz+yoywcYsO1wWbE82DmLk6R1fpL3ztcd1u
 scd9FyLZIRlM9Xu9B1s8Qv3WuR/diPBHURurWTdNgm9LKgVHUMhHyHBka70bhgJoHmZb
 c4yLFrdozTTF4SUvsrms3T0S4kZ2hXVp4lf6wDVL/UpBNVtWhNhR0DvDfMND4pb97hhQ
 Rv+4Ot5keG2e8n9e/2V0zfb8/4/V0y2z3VMBlr4xCMfrxCq1Q+MaWk16QE3if+sfxY12
 A8FpEj2uq7qR/06JBCTuU+NT9EwejYIh6eFeLeG8EZUwPEy5E67s9p7Kr9MxLv01Ny5K
 ptCg==
X-Gm-Message-State: AOAM530EcP3cwTSIGnh16DlVpKxmdQacdKnWmIxcqowFLnda1t0H525T
 QW52AdEMNlL/rlXaFQzM5aViHw==
X-Google-Smtp-Source: ABdhPJwc2F+4faW9HRTZZAsZAS9s8yBLHkHwSY4hm1IordkiXNOLwWBhvo+3rgaIfspaBSomKWvVEg==
X-Received: by 2002:adf:82ce:: with SMTP id 72mr11103641wrc.404.1601589082944; 
 Thu, 01 Oct 2020 14:51:22 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t5sm11280966wrb.21.2020.10.01.14.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 14:51:21 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 398DD1FF7E;
 Thu,  1 Oct 2020 22:51:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] gitlab: move linux-user plugins test across to gitlab
Date: Thu,  1 Oct 2020 22:51:14 +0100
Message-Id: <20201001215114.28154-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Even with the recent split moving beefier plugins into contrib and
dropping them from the check-tcg tests we are still hitting time
limits. This possibly points to a slow down of --debug-tcg but seeing
as we are migrating stuff to gitlab we might as well take advantage of
the ability to properly split our builds.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.yml | 23 +++++++++++++++++++++++
 .travis.yml    | 11 -----------
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index c265e7f8ab..cc16385d65 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -244,6 +244,29 @@ build-user:
     CONFIGURE_ARGS: --disable-tools --disable-system
     MAKE_CHECK_ARGS: check-tcg
 
+# Run check-tcg against linux-user (with plugins)
+# we skip sparc64-linux-user until it has been fixed somewhat
+# we skip cris-linux-user as it doesn't use the common run loop
+build-user-plugins:
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: debian-all-test-cross
+    CONFIGURE_ARGS: --disable-tools --disable-system --enable-plugins --enable-debug-tcg --target-list-exclude=sparc64-linux-user,cris-linux-user
+    MAKE_CHECK_ARGS: build-tcg
+  artifacts:
+    expire_in: 2 days
+    paths:
+      - build
+
+check-user-plugins:
+  <<: *native_test_job_definition
+  needs:
+    - job: build-user-plugins
+      artifacts: true
+  variables:
+    IMAGE: debian-all-test-cross
+    MAKE_CHECK_ARGS: check-tcg
+
 build-clang:
   <<: *native_build_job_definition
   variables:
diff --git a/.travis.yml b/.travis.yml
index c255c331a7..519e62432d 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -311,17 +311,6 @@ jobs:
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
 
-    # Run check-tcg against linux-user (with plugins)
-    # we skip sparc64-linux-user until it has been fixed somewhat
-    # we skip cris-linux-user as it doesn't use the common run loop
-    - name: "GCC plugins check-tcg (user)"
-      env:
-        - CONFIG="--disable-system --enable-plugins --enable-debug-tcg --target-list-exclude=sparc64-linux-user,cris-linux-user"
-        - TEST_BUILD_CMD="make build-tcg"
-        - TEST_CMD="make check-tcg"
-        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
-
-
     # Run check-tcg against softmmu targets
     - name: "GCC check-tcg (some-softmmu)"
       env:
-- 
2.20.1


