Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D87C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:16:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3F672076E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xRVAKtGz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F672076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo6C5-00023t-Oy
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 10:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jo68v-0004AC-Cr
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:12:49 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:35448)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jo68t-0005vz-If
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:12:49 -0400
Received: by mail-wr1-x42b.google.com with SMTP id g18so2461547wrm.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 07:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c7AoJ4KTaY68imxRMzTzv8EVx07Om13RK/P3Xy39tRA=;
 b=xRVAKtGzctVjzoQCyfyZRkdeeUi2NkP5Issuk3qYnS3FbpxRyGuXNBvBmHHYenzAvH
 fC+Dn+5oQ+oCb+ipGsAcPTRNOTKLwcwAXpIeipS3+hvyoRvVMaEftrdv1nb8d/t6Pnp8
 v1gHA41TJeN344UqvquKepl+L/ONSiXMAz8GPLoiC2IbEbqrf8XfmmfqGNkX/FrtXwKx
 q7o392Wk+RGfKyTDxRxu61GXZU+PWy4AwOQl6dUcYKd8QzpVtPFTeXKwukT7YjivDyG6
 V6lFpasCGfJIoxBljMVMi6hzjdN/OVLORWSKBwEk75DCAFBvp949mPtFYL3k6VERthg0
 xZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c7AoJ4KTaY68imxRMzTzv8EVx07Om13RK/P3Xy39tRA=;
 b=OvlLxZQxDdOX66q83dyrIclxCdn3PAcb/ECT8aJ83Qv5IYjjlNP7TZRe1kzvOO0lFZ
 IrY0z5ZQx/Gx+oW3IP9CFEEzgKORk982aVi38K5Vh5f5J8XvTpD8l4Gh8Hu+226y5h+i
 4E83DR/vqNMhX/2n+tonybz1704t+vexVKVNmmvAii7f9ITc2elziBzoN0CLzE1ltkhi
 P8Yw5FTujGa6RBpchqj7kHtf63JEXmiiuvmP7FQTNw8Npo12j+V6ngM3vhEB8GzCyZi5
 ZBiqbHrcuRGkf+mk6TSFjzGJ06VGp8EaNq7mqXmA3BPLrk4zSdBKNDDTaYZhXQ0PoZiA
 GCwg==
X-Gm-Message-State: AOAM532H1nI3LL/rp/JPQ4qNkV3fAuvJX+bfWjAqWCAU+W55XvyNxZti
 7xw1BeRoyp1YdKCtNOUTUfLbWA==
X-Google-Smtp-Source: ABdhPJym/4S2zuCcNVyqfHLx69Rc+4tOB3VDX5FiMxt1Qtzq293tzR59rHFvn0DL8fUJcF0jUqHoNw==
X-Received: by 2002:adf:f70e:: with SMTP id r14mr33237282wrp.150.1593007966044; 
 Wed, 24 Jun 2020 07:12:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c25sm8081800wml.46.2020.06.24.07.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 07:12:40 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1500B1FFA5;
 Wed, 24 Jun 2020 15:04:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 17/25] gitlab: introduce explicit "container" and "build"
 stages
Date: Wed, 24 Jun 2020 15:04:38 +0100
Message-Id: <20200624140446.15380-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200624140446.15380-1-alex.bennee@linaro.org>
References: <20200624140446.15380-1-alex.bennee@linaro.org>
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
 Laszlo Ersek <lersek@redhat.com>, richard.henderson@linaro.org,
 f4bug@amsat.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, cota@braap.org,
 aurelien@aurel32.net
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
Message-Id: <20200622153318.751107-2-berrange@redhat.com>
---
 .gitlab-ci.d/edk2.yml    |  3 ++-
 .gitlab-ci.d/opensbi.yml |  3 ++-
 .gitlab-ci.yml           | 11 +++++++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/edk2.yml b/.gitlab-ci.d/edk2.yml
index 088ba4b43a3..d4e7dfcba65 100644
--- a/.gitlab-ci.d/edk2.yml
+++ b/.gitlab-ci.d/edk2.yml
@@ -1,5 +1,5 @@
 docker-edk2:
- stage: build
+ stage: containers
  rules: # Only run this job when the Dockerfile is modified
  - changes:
    - .gitlab-ci-edk2.yml
@@ -24,6 +24,7 @@ docker-edk2:
  - docker push $IMAGE_TAG
 
 build-edk2:
+ stage: build
  rules: # Only run this job when ...
  - changes: # ... roms/edk2/ is modified (submodule updated)
    - roms/edk2/*
diff --git a/.gitlab-ci.d/opensbi.yml b/.gitlab-ci.d/opensbi.yml
index dd051c01245..ec1c1f4cab7 100644
--- a/.gitlab-ci.d/opensbi.yml
+++ b/.gitlab-ci.d/opensbi.yml
@@ -1,5 +1,5 @@
 docker-opensbi:
- stage: build
+ stage: containers
  rules: # Only run this job when the Dockerfile is modified
  - changes:
    - .gitlab-ci-opensbi.yml
@@ -24,6 +24,7 @@ docker-opensbi:
  - docker push $IMAGE_TAG
 
 build-opensbi:
+ stage: build
  rules: # Only run this job when ...
  - changes: # ... roms/opensbi/ is modified (submodule updated)
    - roms/opensbi/*
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 349c77aa580..9fdc752ea63 100644
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


