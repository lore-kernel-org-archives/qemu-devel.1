Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3889BC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:43:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B10CD22266
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KYQlmSYz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10CD22266
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIWmP-0007PL-Q3
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIWWh-0002dJ-Od
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:27:07 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:37867)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIWWe-0005A8-1q
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:27:07 -0400
Received: by mail-wr1-x433.google.com with SMTP id z4so6733914wrr.4
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 05:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=F6UCai1slxaYSjxJW3Hv6F6J3+vyen6Qm4XWJ5JFqqg=;
 b=KYQlmSYzajeEI6/WqffnWQlhXmJ/IsK+cb3WxETHOEEakDSaj9RPqN190RmmSxo+0L
 wVMZApTCrC66LQji/4P7HGKWuBN0ajEFzD0dAzWaMYoTdvsnxUO5OOqHbvxwh9uNUpi6
 tGJuxq6ebHYBBjUxRWRgGgNUbMkPWOSMPnOHJ/68rxKFzBX7Zku3hPdRrDik88PnW7oD
 kQ0b5YTeBT5vKKvduxFSrDcWsDe5mBwoou37pTX/hrbsJFdxS/1PmzqJA1zTjF/n7DFm
 AgoVGxr+PQZ0/XKqmRdwMFJ+FSP7jCckpTKXwMaTDR/dYVWJFiJHB1dEgx6G9vQibgqs
 R/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=F6UCai1slxaYSjxJW3Hv6F6J3+vyen6Qm4XWJ5JFqqg=;
 b=WFY10yfCtfnYiQfxpswsHYWn77VOZCX2LPGYylr1VqK3pXPTn0DdeAmFzMn6AjFnF2
 d+JXA83hcwkwPCw5om59OdgvePPEr630ktrj9siSTf/co5U61gwoBAtxi3cscLK5+uqe
 xVp0Ibura4V2ZVj94is4ZnZcytSQ44IgB3g37SIYUMip6DGLYrC8Sv9HwL53kPsTGj9I
 cVd/UIFPrBFrd0f4pXF4EXszw/MUk1NQO1QOao2LLUesLN2fHggUq+nuPOewiq/Ak+6V
 mbSNHj7/t1KnnB3gOS5gyTsNro8vOi6H4Dp/A6Tf1F+aIJU6LYj29y4j3ctX/3Y03vZt
 M3Yw==
X-Gm-Message-State: AOAM533zcNcOgGdcbtfuVGdvBdCsRTmk5TizY01DXJs5qufB4XQsopOm
 giTEMeTQxyroPMSkRwUAhhPhTg==
X-Google-Smtp-Source: ABdhPJyWcGFZYFALTBBqMCYjnaK95HwOIx91D5tX1rB0jA0FQGrm4i8W7RxyFhAuxAy69/fEns1ILA==
X-Received: by 2002:a5d:4682:: with SMTP id u2mr28384470wrq.254.1600259222778; 
 Wed, 16 Sep 2020 05:27:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u12sm5055970wrt.81.2020.09.16.05.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 05:26:54 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3400A1FF96;
 Wed, 16 Sep 2020 13:26:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 8/8] configure: add [lm32|unicore32]-softmmu to deprecation
 logic
Date: Wed, 16 Sep 2020 13:26:48 +0100
Message-Id: <20200916122648.17468-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200916122648.17468-1-alex.bennee@linaro.org>
References: <20200916122648.17468-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While we are at it move the few places where they are into the
deprecation build bucket.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200915134317.11110-9-alex.bennee@linaro.org>

diff --git a/configure b/configure
index dfd7f18dcb24..756447900855 100755
--- a/configure
+++ b/configure
@@ -280,7 +280,7 @@ supported_whpx_target() {
     return 1
 }
 
-deprecated_targets_list=ppc64abi32-linux-user,tilegx-linux-user
+deprecated_targets_list=ppc64abi32-linux-user,tilegx-linux-user,lm32-softmmu,unicore32-softmmu
 deprecated_features=""
 
 supported_target() {
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index f027b55aef15..a18e18b57e54 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -134,7 +134,7 @@ build-system-fedora:
   variables:
     IMAGE: fedora
     CONFIGURE_ARGS: --disable-gcrypt --enable-nettle
-    TARGETS: tricore-softmmu unicore32-softmmu microblaze-softmmu mips-softmmu
+    TARGETS: tricore-softmmu microblaze-softmmu mips-softmmu
       xtensa-softmmu m68k-softmmu riscv32-softmmu ppc-softmmu sparc64-softmmu
     MAKE_CHECK_ARGS: check-build
   artifacts:
@@ -166,7 +166,7 @@ build-system-centos:
   variables:
     IMAGE: centos8
     CONFIGURE_ARGS: --disable-nettle --enable-gcrypt
-    TARGETS: ppc64-softmmu lm32-softmmu or1k-softmmu s390x-softmmu
+    TARGETS: ppc64-softmmu or1k-softmmu s390x-softmmu
       x86_64-softmmu rx-softmmu sh4-softmmu nios2-softmmu
     MAKE_CHECK_ARGS: check-build
   artifacts:
@@ -259,9 +259,10 @@ build-deprecated:
   <<: *native_build_job_definition
   variables:
     IMAGE: debian-all-test-cross
-    CONFIGURE_ARGS: --disable-docs --disable-tools --disable-system
+    CONFIGURE_ARGS: --disable-docs --disable-tools
     MAKE_CHECK_ARGS: check-tcg
-    TARGETS: ppc64abi32-linux-user tilegx-linux-user
+    TARGETS: ppc64abi32-linux-user tilegx-linux-user lm32-softmmu
+      unicore32-softmmu
   allow_failure: true
 
 build-oss-fuzz:
diff --git a/.shippable.yml b/.shippable.yml
index 89d8be4291b0..0b4fd6df1d81 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -8,7 +8,7 @@ env:
     - IMAGE=debian-amd64
       TARGET_LIST=x86_64-softmmu,x86_64-linux-user
     - IMAGE=debian-win32-cross
-      TARGET_LIST=arm-softmmu,i386-softmmu,lm32-softmmu
+      TARGET_LIST=arm-softmmu,i386-softmmu
     - IMAGE=debian-win64-cross
       TARGET_LIST=aarch64-softmmu,sparc64-softmmu,x86_64-softmmu
     - IMAGE=debian-armel-cross
-- 
2.20.1


