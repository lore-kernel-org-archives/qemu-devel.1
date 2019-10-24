Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35350CA9EBC
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:43:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01DC12084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ve2Jy/MA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01DC12084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNaaR-0006kF-DS
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 06:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNaGe-0002Q7-7A
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNaGd-00049J-3f
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:56 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33439)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNaGc-00048k-ST
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:55 -0400
Received: by mail-wm1-x343.google.com with SMTP id 6so1673037wmf.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 03:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g2yjnFvogR+jOYTEWwruhPYFF18RK9D3ue14llssl0U=;
 b=Ve2Jy/MA1WY07XlKSkI/8bhuSPyA5vkxxp4Ld849yPxI/jhI17ccs0Gn9LgrfYmM24
 h09qIDXU+6AwYYAy6br1YYRhKUGWa/RbtLkysTH2imOcTmZpoYjx/HYRgUVLO4CGS+GE
 f5x9GGsA+OO5+9TNS7QKUWyOAiT3tmV0dCXa+1uhHWzxz2lKGflyXjmabpBxWsR9ir3b
 WYSg/lsQIeLfulNzjfZoBW8E9izdgSZevdyOWpNlZHSbSxcGsbM92asgaZ7GDk5saMyO
 ix9/R8sIo1jMySfhEjPw6Yb2/cbJFECcG83RXOudh8mlfovwYeHH+7M0HmS5uoxnwRTw
 6EIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g2yjnFvogR+jOYTEWwruhPYFF18RK9D3ue14llssl0U=;
 b=IhAsMTwz+fWD9Vh9Tc19KKh6PssAhUyI++gos676s97Z+xc5xVBMjY2edV/Ed7HUGa
 +424R+ItGlFb931HP+hPTwbCtgVFdmJC2hpUkNiM3iGq2uTGN3X4Y5S17/9j0hCCoRvb
 dakX7JXPwwyVDoSwcl7Uj6t0My2dzVzOmLJjA9dDrpy++ZwcdpXdqvvhynrvW/YxHfNw
 Gx6yQS6mJMle935kRSZyouM7XC0YUZOTerM+HxFvFs+PTY3DBE8eu2vAh6VMyjEzEhlb
 L80JlNwshUGpe81f2abdlrsEdln63Ftz0AKTkrc6lLSKhLDaj5t96/ViUvgg3JO/xOX/
 6o+w==
X-Gm-Message-State: APjAAAVvYEe5cB/9lBswt8EGJ5VwEbkD7WyqJd8IG/YCR9D8LhGQ7BT/
 5uC+bjOlibsNm+r1C7RtFw1LSw==
X-Google-Smtp-Source: APXvYqzHPTTnsEaZDfOGMnCuhEWz2oM6f+ynQmphyG/PzYC/9JPZ82unNy2BQ615sArohpPGVm0vWg==
X-Received: by 2002:a1c:1d48:: with SMTP id d69mr3932656wmd.160.1571912573352; 
 Thu, 24 Oct 2019 03:22:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c14sm19467162wru.24.2019.10.24.03.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 03:22:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C33A21FFA3;
 Thu, 24 Oct 2019 11:22:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 16/17] tests/docker: set HOST_ARCH if we don't have ARCH
Date: Thu, 24 Oct 2019 11:22:39 +0100
Message-Id: <20191024102240.2778-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024102240.2778-1-alex.bennee@linaro.org>
References: <20191024102240.2778-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As the docker rules want to be able to be run on a virgin unconfigured
checkout add a fallback and use it if we need to.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .shippable.yml                | 2 --
 tests/docker/Makefile.include | 6 ++++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/.shippable.yml b/.shippable.yml
index bbc6f88510f..f74a3de3ffd 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -27,8 +27,6 @@ env:
       TARGET_LIST=ppc64-softmmu,ppc64-linux-user,ppc64abi32-linux-user
 build:
   pre_ci:
-    # usually host ARCH is set by configure
-    - echo "ARCH=$(uname -m)" > config-host.mak
     - make docker-image-${IMAGE} V=1
   pre_ci_boot:
     image_name: qemu
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 89c56a3a88c..19dbe261699 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -2,6 +2,8 @@
 
 .PHONY: docker docker-test docker-clean docker-image docker-qemu-src
 
+HOST_ARCH = $(if $(ARCH),$(ARCH),$(shell uname -m))
+
 DOCKER_SUFFIX := .docker
 DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
 # we don't run tests on intermediate images (used as base by another image)
@@ -88,7 +90,7 @@ endif
 
 # Enforce dependencies for composite images
 docker-image-debian9-mxe: docker-image-debian9
-ifeq ($(ARCH),x86_64)
+ifeq ($(HOST_ARCH),x86_64)
 docker-image-debian-amd64: docker-image-debian9
 DOCKER_PARTIAL_IMAGES += debian-amd64-cross
 else
@@ -106,7 +108,7 @@ docker-image-debian-win32-cross: docker-image-debian9-mxe
 docker-image-debian-win64-cross: docker-image-debian9-mxe
 
 # For non-x86 hosts not all cross-compilers have been packaged
-ifneq ($(ARCH),x86_64)
+ifneq ($(HOST_ARCH),x86_64)
 DOCKER_PARTIAL_IMAGES += debian-mips-cross debian-mipsel-cross debian-mips64el-cross
 DOCKER_PARTIAL_IMAGES += debian-ppc64el-cross
 DOCKER_PARTIAL_IMAGES += debian-s390x-cross
-- 
2.20.1


