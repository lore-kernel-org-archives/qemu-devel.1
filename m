Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2345C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:57:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92977207CB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="frz0aBzy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92977207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdxV1-0006Se-Mn
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 10:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdxSa-0001vt-Dd
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:55:12 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:56277)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdxSZ-0008Dw-1Z
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:55:11 -0400
Received: by mail-wm1-x331.google.com with SMTP id c71so3314627wmd.5
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 07:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Dm74SlTEnZyxd4hI8XjcLMpSfE87lkjOy5GE4QJMVNA=;
 b=frz0aBzywnSTSWGwvUWtphMoIDMAotS0DsPg7ncp+DhFTrjTtKSAzlUoLWbLLRs8Yk
 2W1GH9QYRcxW8p2lzPbqoMtdtAmaeNlBMOiEgLDj7lSXtMbl54MyZ0of6Jy/fPwdh4Ft
 uuBD5RqVQcTu222W8BIoi0sl/vhy9NGFl2iC/hn79k7rYQ8cSEEvh9SNVBHz3vA4IgkB
 tmDitPqnHS15O9ORlmnoMGdjPLX2dK+NeQ8NRDKZgoy6bFeoAHg6iTH8DHui8rmY++bB
 K4cgjvGDHCDv3BcrvvlPZ8RrXZcbWxF1JQGRv4Wf6YKAaicsJBDLo6rGQHx13wGUxrYs
 d/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Dm74SlTEnZyxd4hI8XjcLMpSfE87lkjOy5GE4QJMVNA=;
 b=WwItR8Ds60/6tGi7QTM1CYWpv4J+6Fm1FnkN7jBrX9lbhU4+RBh37GHeDiN66fgV3s
 QtoNk6zf/wSzTwtL3umhHv3inRWmFysYnDNjS3DVUwtyH/SkrNQXia/b3WJMkwDhOITE
 SjwvsKHaHZXDFfgk/ckj8sjdtTRQMcN1e2ut+J5QfQeRhlC4Out1GVxhPquESiNd3NXX
 8040vQCyu1S5ONYeUyhQvYoxewhwbB6etNPGdE1LYz0bHZJArKAqAJajqQFOVMLKqMe2
 DIOicRAhXqBHM7eNBe+452y+Otognyk3Y43FueQsKKKmUQxD2+4HTA8k0yj+ly/j3C7Y
 Tyjg==
X-Gm-Message-State: AOAM532w8Yp4HHIMRTxb+7r99mI1AGTLD/XBI7JMPYz7EKdq42CLPcdE
 KjO+xV8gi05nfWyOrSgQYxMzDA==
X-Google-Smtp-Source: ABdhPJxLWfwmrt9WFFKidhqVAIKb+7svcSx89nbP+VEjDN/eLF7pIkXK0rLZL45hrIvFBbl4UGddYg==
X-Received: by 2002:a1c:a905:: with SMTP id s5mr4540623wme.120.1590591309385; 
 Wed, 27 May 2020 07:55:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s19sm2869069wmj.21.2020.05.27.07.55.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 07:55:04 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DC4D61FF98;
 Wed, 27 May 2020 15:54:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 09/12] tests/docker: use a gcc-10 based image for arm64 tests
Date: Wed, 27 May 2020 15:54:52 +0100
Message-Id: <20200527145455.2550-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200527145455.2550-1-alex.bennee@linaro.org>
References: <20200527145455.2550-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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
Cc: Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we enable newer features that we want to test on arm64 targets we
need newer compilers. Split off a new debian-arm64-test-cross image
which we can use to build these new tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200520140541.30256-11-alex.bennee@linaro.org>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 3596b589307..ed46bd98eb5 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -131,9 +131,11 @@ docker-image-travis: NOUSER=1
 
 # Specialist build images, sometimes very limited tools
 docker-image-tricore-cross: docker-image-debian9
+docker-image-debian-arm64-test-cross: docker-image-debian11
 
 # These images may be good enough for building tests but not for test builds
 DOCKER_PARTIAL_IMAGES += debian-alpha-cross
+DOCKER_PARTIAL_IMAGES += debian-arm64-test-cross
 DOCKER_PARTIAL_IMAGES += debian-hppa-cross
 DOCKER_PARTIAL_IMAGES += debian-m68k-cross debian-mips64-cross
 DOCKER_PARTIAL_IMAGES += debian-powerpc-cross debian-ppc64-cross
diff --git a/tests/docker/dockerfiles/debian-arm64-test-cross.docker b/tests/docker/dockerfiles/debian-arm64-test-cross.docker
new file mode 100644
index 00000000000..a44e76d9421
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-arm64-test-cross.docker
@@ -0,0 +1,13 @@
+#
+# Docker arm64 cross-compiler target (tests only)
+#
+# This docker target builds on the debian Bullseye base image.
+#
+FROM qemu:debian11
+
+# Add the foreign architecture we want and install dependencies
+RUN dpkg --add-architecture arm64
+RUN apt update && \
+    DEBIAN_FRONTEND=noninteractive eatmydata \
+        apt install -y --no-install-recommends \
+        crossbuild-essential-arm64 gcc-10-aarch64-linux-gnu
diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
index eaaaff6233a..2326f978562 100755
--- a/tests/tcg/configure.sh
+++ b/tests/tcg/configure.sh
@@ -97,8 +97,8 @@ for target in $target_list; do
   case $target in
     aarch64-*)
       # We don't have any bigendian build tools so we only use this for AArch64
-      container_image=debian-arm64-cross
-      container_cross_cc=aarch64-linux-gnu-gcc
+      container_image=debian-arm64-test-cross
+      container_cross_cc=aarch64-linux-gnu-gcc-10
       ;;
     alpha-*)
       container_image=debian-alpha-cross
-- 
2.20.1


