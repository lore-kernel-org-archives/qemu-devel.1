Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC60C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:16:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 474C3206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FW6u/FcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474C3206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshph-0000DX-GC
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshoE-0006aF-VC
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:14:31 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:39654)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshoC-0004qf-Vo
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:14:30 -0400
Received: by mail-wm1-x32a.google.com with SMTP id w3so32866572wmi.4
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eqzXTFvwpMkciPOZ24DlL9wg1TWlgnxheOGFm1m1Zko=;
 b=FW6u/FcTipVkdqSZzFZKAq9AnznjWuqqoIrSafqtjxsj1J0rHKVIa0E55mwky604zW
 Ehj0sDxmJkhJs3y5APTC6QRdPKd8EyolXmHZv/7eGLK0bikJRZOdd9qg8nvFgM+BjmuY
 5NuS1SDF78imxtF3Ma+DpEydTsfJYLzOmY64iFhWyjjL2GLsAVs/w+t/KBpUTCq8lZmW
 cIeRFRUWzw3JgVHf95n/kyCIRfGpr0kZpO+B1FX6HJovMs+OyAI7aWEYCk7GlmmBnbEf
 YR8XdK3bR0YXY9CPZg/rx07Iy+ysAIu4imJbmKnPmnoDOCuZG5mAGaKPNR7pwE9hV2JK
 3m/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eqzXTFvwpMkciPOZ24DlL9wg1TWlgnxheOGFm1m1Zko=;
 b=DYTVDrGXETJatmFyAMTDl7M+gLMLU2iu5Kzee3wsWWpwhQcJFPOVi7IJigoKDotuP+
 0+oogvbDzBtxPwsglRp0z8fWbycnmbCzOb4yRbE36KAsKJj42Oc89CBz+8HCBo1DRlmv
 7XkQbjGGCvgcJt+33s+oCH9yKq+M3KUnTe/F7RD/xWVVP+jhcAfVqfQkVs+le0LZ1tuR
 ZsaXSrlisHfc7pZsBIMKNurf4YVxzTBov94toZNxM6k5c85Q8zFyXAqyiLWA4gcl64sU
 OSwiram/3MLgCm0Ht5nQshvOIJweC/x02X0nAMPFpM7iqp8xDbi5bv3rcxYGUYC3QxGe
 w/Dg==
X-Gm-Message-State: AOAM532vpF0urCwXpGwPcQg2doLf/dAoFfp1nZKBeK9QdM1FLJEXP8ds
 L72hlSqGut0Eqjlt9bBcP8/Mpg==
X-Google-Smtp-Source: ABdhPJwXL33GyUdaPXH54JPFfQkNmIC4XFPxqjG2oyc1yE+6MlX9QJUFaOrgei87uxprNEkTJckEwQ==
X-Received: by 2002:a1c:5986:: with SMTP id n128mr2529967wmb.112.1594106067389; 
 Tue, 07 Jul 2020 00:14:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j16sm27183653wrt.7.2020.07.07.00.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:14:22 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6342A1FFA6;
 Tue,  7 Jul 2020 08:09:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 18/41] gitlab: introduce explicit "container" and "build" stages
Date: Tue,  7 Jul 2020 08:08:35 +0100
Message-Id: <20200707070858.6622-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707070858.6622-1-alex.bennee@linaro.org>
References: <20200707070858.6622-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrangé <berrange@redhat.com>

If no stage is listed, jobs get put in an implicit "test" stage.
Some jobs which create container images to be used by later stages
are currently listed as in a "build" stages.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200622153318.751107-2-berrange@redhat.com>
Message-Id: <20200701135652.1366-21-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/edk2.yml b/.gitlab-ci.d/edk2.yml
index a9990b71475f..e1e045241661 100644
--- a/.gitlab-ci.d/edk2.yml
+++ b/.gitlab-ci.d/edk2.yml
@@ -1,5 +1,5 @@
 docker-edk2:
- stage: build
+ stage: containers
  rules: # Only run this job when the Dockerfile is modified
  - changes:
    - .gitlab-ci.d/edk2.yml
@@ -24,6 +24,7 @@ docker-edk2:
  - docker push $IMAGE_TAG
 
 build-edk2:
+ stage: build
  rules: # Only run this job when ...
  - changes: # ... roms/edk2/ is modified (submodule updated)
    - roms/edk2/*
diff --git a/.gitlab-ci.d/opensbi.yml b/.gitlab-ci.d/opensbi.yml
index 6a1750784ac1..62088ec5ec1b 100644
--- a/.gitlab-ci.d/opensbi.yml
+++ b/.gitlab-ci.d/opensbi.yml
@@ -1,5 +1,5 @@
 docker-opensbi:
- stage: build
+ stage: containers
  rules: # Only run this job when the Dockerfile is modified
  - changes:
    - .gitlab-ci.d/opensbi.yml
@@ -24,6 +24,7 @@ docker-opensbi:
  - docker push $IMAGE_TAG
 
 build-opensbi:
+ stage: build
  rules: # Only run this job when ...
  - changes: # ... roms/opensbi/ is modified (submodule updated)
    - roms/opensbi/*
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 349c77aa580e..9fdc752ea636 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,3 +1,7 @@
+stages:
+  - containers
+  - build
+
 include:
   - local: '/.gitlab-ci.d/edk2.yml'
   - local: '/.gitlab-ci.d/opensbi.yml'
@@ -17,6 +21,7 @@ include:
   - JOBS=$(expr $(nproc) + 1)
 
 build-system1:
+ stage: build
  image: ubuntu:19.10
  <<: *before_script_apt
  script:
@@ -31,6 +36,7 @@ build-system1:
  - make -j"$JOBS" check
 
 build-system2:
+ stage: build
  image: fedora:latest
  <<: *before_script_dnf
  script:
@@ -46,6 +52,7 @@ build-system2:
  - make -j"$JOBS" check
 
 build-disabled:
+ stage: build
  image: fedora:latest
  <<: *before_script_dnf
  script:
@@ -62,6 +69,7 @@ build-disabled:
  - make -j"$JOBS" check-qtest SPEED=slow
 
 build-tcg-disabled:
+ stage: build
  image: centos:8
  <<: *before_script_dnf
  script:
@@ -82,6 +90,7 @@ build-tcg-disabled:
             260 261 262 263 264 270 272 273 277 279
 
 build-user:
+ stage: build
  <<: *before_script_apt
  script:
  - mkdir build
@@ -92,6 +101,7 @@ build-user:
  - make run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
 
 build-clang:
+ stage: build
  image: fedora:latest
  <<: *before_script_dnf
  script:
@@ -106,6 +116,7 @@ build-clang:
  - make -j"$JOBS" check
 
 build-tci:
+ stage: build
  image: centos:8
  <<: *before_script_dnf
  script:
-- 
2.20.1


