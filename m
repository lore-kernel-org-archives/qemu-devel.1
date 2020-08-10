Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8306C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:59:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BA9022BF3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DoiMkcr4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA9022BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5DxT-0001pS-Ip
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 15:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Doy-0001Cs-KI
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:51:00 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40168)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Dow-0004yN-R6
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:51:00 -0400
Received: by mail-wr1-x442.google.com with SMTP id l2so9309034wrc.7
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LSVn2WKQmCMQEFWwav2YKrRxyoiYWkDAUAzH6RvFEtY=;
 b=DoiMkcr4OfPIGRdqayTkzUkRgiX0WKQq46v5fIjtCejtCoZs+uEYAUSKT0pJbXgTs3
 LQ5Jdz5EV+s6aRYaP5LFmWgH1+qVKrQEk10jl+jzaM+lKYP4yYOyI7DReFQrq8fOi2vb
 QTkdZSL1OytZM3KA8oPsMaBFpV3M4dkmbgyEOK4QOMIZ4YWenaw6Z9rdZgm741ze988d
 htiQ+iLcKtzkzaPtCQeTAK50xt9lrGlL3LJIbi3AUh9cC/+YuTaoazlKJlDffl8gab3r
 kcv1e2zr5H6dizZewRsmxCVl623f6Z3chTDGwurPdMfR8KUAiH73vvsrp6unM0+VJvEI
 USHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LSVn2WKQmCMQEFWwav2YKrRxyoiYWkDAUAzH6RvFEtY=;
 b=c7ANHg2w9ZjwgstNzbf6QE41xbiUz+DzZ6EMlz63DSeAxlaj9UJ1H3rgCX4JKIfVCB
 +myJzdIGEgHU7DE5ZekZhlyqD7AWHIyjA31p6YrlAhKeCbmVdJ5XWaGBD5to8KI4MgiS
 AdtRPhwxnZOgbdo/ylMV2LAZY25mNMxMRutMKgVlKVl0crypo0NCA3ImqZXJ98tZZyVk
 SvfmdNDyx2E1IxwoGi5ELHs2sRJRWZiKf6ohUhFOCwpp+eKkKCkvVGMwNN1pXqjYJgav
 CJwBDqozCBPowopx1cKPj6LQkp3m4Q4EGBtBBHUWJFfOwwy3MGPXQFHFFXRpDGM/RLlY
 4gWw==
X-Gm-Message-State: AOAM533WbMTQYaqZdu32lPsOi+iXkNLphsW82EMpgJv1AFkIQJ324Bn1
 vZEOJkAVPU4rmjokGbUl7ll7uk00r7oKdw==
X-Google-Smtp-Source: ABdhPJzfTgnWP9rLvsLny7LOwWyRFDNYDgtLJluK4P/OOJ2g/ovqWOIA0xKvFjYNb90xPrAXQB5ndQ==
X-Received: by 2002:adf:e7c9:: with SMTP id e9mr26767912wrn.10.1597089056932; 
 Mon, 10 Aug 2020 12:50:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b129sm976087wmb.29.2020.08.10.12.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 12:50:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 20/20] Remove texinfo dependency from docker and CI configs
Date: Mon, 10 Aug 2020 20:50:19 +0100
Message-Id: <20200810195019.25427-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200810195019.25427-1-peter.maydell@linaro.org>
References: <20200810195019.25427-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't need texinfo to build the docs any more, so we can
drop that dependency from our docker and other CI configs.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Changes v4->v5: remove texinfo from ubuntu2004.docker too
---
 .travis.yml                                | 1 -
 tests/docker/dockerfiles/debian10.docker   | 1 -
 tests/docker/dockerfiles/debian9.docker    | 1 +
 tests/docker/dockerfiles/fedora.docker     | 1 -
 tests/docker/dockerfiles/ubuntu.docker     | 1 -
 tests/docker/dockerfiles/ubuntu1804.docker | 1 -
 tests/docker/dockerfiles/ubuntu2004.docker | 1 -
 7 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 6695c0620fc..ff4361079f3 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -198,7 +198,6 @@ jobs:
         apt:
           packages:
             - python3-sphinx
-            - texinfo
             - perl
 
 
diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/dockerfiles/debian10.docker
index bcdff04ddfe..e5dbfa8fe95 100644
--- a/tests/docker/dockerfiles/debian10.docker
+++ b/tests/docker/dockerfiles/debian10.docker
@@ -30,7 +30,6 @@ RUN apt update && \
         psmisc \
         python3 \
         python3-sphinx \
-        texinfo \
         $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
 
 ENV FEATURES docs
diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/dockerfiles/debian9.docker
index 0f0ebe530af..7e4b8a672fc 100644
--- a/tests/docker/dockerfiles/debian9.docker
+++ b/tests/docker/dockerfiles/debian9.docker
@@ -28,4 +28,5 @@ RUN apt update && \
         pkg-config \
         psmisc \
         python3 \
+        python3-sphinx \
         $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 70b6186bd3e..71e4b569770 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -96,7 +96,6 @@ ENV PACKAGES \
     tar \
     tesseract \
     tesseract-langpack-eng \
-    texinfo \
     usbredir-devel \
     virglrenderer-devel \
     vte291-devel \
diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfiles/ubuntu.docker
index 161806e6b8c..b556ed17d29 100644
--- a/tests/docker/dockerfiles/ubuntu.docker
+++ b/tests/docker/dockerfiles/ubuntu.docker
@@ -63,7 +63,6 @@ ENV PACKAGES \
     python3-yaml \
     python3-sphinx \
     sparse \
-    texinfo \
     xfslibs-dev
 RUN apt-get update && \
     DEBIAN_FRONTEND=noninteractive apt-get -y install $PACKAGES
diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/dockerfiles/ubuntu1804.docker
index a10ea2850b6..a6a7617da67 100644
--- a/tests/docker/dockerfiles/ubuntu1804.docker
+++ b/tests/docker/dockerfiles/ubuntu1804.docker
@@ -49,7 +49,6 @@ ENV PACKAGES \
     python3-yaml \
     python3-sphinx \
     sparse \
-    texinfo \
     xfslibs-dev
 RUN apt-get update && \
     DEBIAN_FRONTEND=noninteractive apt-get -y install $PACKAGES
diff --git a/tests/docker/dockerfiles/ubuntu2004.docker b/tests/docker/dockerfiles/ubuntu2004.docker
index 8d10934a2a7..cafe8443fbf 100644
--- a/tests/docker/dockerfiles/ubuntu2004.docker
+++ b/tests/docker/dockerfiles/ubuntu2004.docker
@@ -57,7 +57,6 @@ ENV PACKAGES flex bison \
     sparse \
     tesseract-ocr \
     tesseract-ocr-eng \
-    texinfo \
     xfslibs-dev\
     vim
 RUN apt-get update && \
-- 
2.20.1


