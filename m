Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7723AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:04:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B0320663
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ECf6hMdn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B0320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdM7-0006Le-DV
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdEc-0002VK-2r
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:57:11 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:42727)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdEa-0005s0-5V
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:57:09 -0400
Received: by mail-wr1-x432.google.com with SMTP id o11so23963513wrv.9
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 06:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L8UfFOdn0PEpfIwJNpttfVutTAGLSZl2+EE67E2O1dE=;
 b=ECf6hMdnZSxiSvyASALYKL8QtN0yvYibTwrCRMVphCpoOSQkwGa9xHsW4qZblU4/7e
 F+jDv4EF+Iqkz3073JBo52kCk+/yxtN2OGc9MvuPA/piZxAsDzdKxbhVAQA45ouCY0FO
 L4V7mIQl+wl6WCh9peaa6vnG0JzUd8nXJ3czSTUlIJYnKm3nvjd/TkCL6VT5iZw/zJt/
 edGIjGIsFBBMlKLDtHPpfsptnhAVWMlT11zWvoRYTc6eih/gj3rbGoO/MkgJSIzE0ffP
 aeHxSrafSlYIV10eDNsf1ioY1XGOLTlXRL1HpWya1gk6rifZhu9QgBAVlXZK15jsHl1T
 Hahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L8UfFOdn0PEpfIwJNpttfVutTAGLSZl2+EE67E2O1dE=;
 b=kGjeXGQZAHTF4mvzEeU8WhZVcqgh3oQIHlkiHIGmxOuINK/lRAiLr/v2tcGBJbQqNs
 tCuHEV+MGq2oxDsnsnLDRIIjLWEeXnEaRGAdju3gILUz+Xc+QMHHhYE9O8ZwVGPM5FFS
 m4WsuioPePTviawfmmg/YNiZNA/2yK+L6drqUORI27Av3EflnoAP/Uad1KqIJomDEN+r
 qCF8OUIOqygaZ7AAU8gwmBR2hhjpXufxzg35nXO9yOcDX8wEgaZjre5Xkxc8ncBnc6Xc
 ZZbQO7Bj5FQMa0/HWMPsJdBVbKoEWTzd3fcb5qJHXQepnucZ3NELzZDzeRRgITlPejHY
 7XLQ==
X-Gm-Message-State: AOAM5331cwh41Hcl0ECa/YRolVy9CcG9ry8DEgCfTcp8fRft3ZQpAd1h
 TwhJ630sCApE1mojpe0tyKisTQ==
X-Google-Smtp-Source: ABdhPJwmLxu3rdFhcap5RrAIzAV7AHizoxqQmQLhhLq5Jr5MMZYntecCSkmAqsLDyIRTVYDtFbud9Q==
X-Received: by 2002:a5d:43d2:: with SMTP id v18mr26461379wrr.196.1593611826657; 
 Wed, 01 Jul 2020 06:57:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c65sm7158037wme.8.2020.07.01.06.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 06:57:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 73CAF1FFAF;
 Wed,  1 Jul 2020 14:56:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 25/40] tests/docker: add packages needed for
 check-acceptance
Date: Wed,  1 Jul 2020 14:56:37 +0100
Message-Id: <20200701135652.1366-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200701135652.1366-1-alex.bennee@linaro.org>
References: <20200701135652.1366-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need additional python packages to run check-acceptance. Add them
to the docker images we will be using later.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/docker/dockerfiles/fedora.docker     |  7 +++++++
 tests/docker/dockerfiles/ubuntu2004.docker | 10 +++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 798ddd2c3e0..70b6186bd3e 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -80,7 +80,12 @@ ENV PACKAGES \
     pixman-devel \
     python3 \
     python3-PyYAML \
+    python3-numpy \
+    python3-opencv \
+    python3-pillow \
+    python3-pip \
     python3-sphinx \
+    python3-virtualenv \
     rdma-core-devel \
     SDL2-devel \
     snappy-devel \
@@ -89,6 +94,8 @@ ENV PACKAGES \
     systemd-devel \
     systemtap-sdt-devel \
     tar \
+    tesseract \
+    tesseract-langpack-eng \
     texinfo \
     usbredir-devel \
     virglrenderer-devel \
diff --git a/tests/docker/dockerfiles/ubuntu2004.docker b/tests/docker/dockerfiles/ubuntu2004.docker
index 6050ce7e8a8..f7aac840bf8 100644
--- a/tests/docker/dockerfiles/ubuntu2004.docker
+++ b/tests/docker/dockerfiles/ubuntu2004.docker
@@ -46,9 +46,17 @@ ENV PACKAGES flex bison \
     libxen-dev \
     libzstd-dev \
     make \
-    python3-yaml \
+    python3-numpy \
+    python3-opencv \
+    python3-pil \
+    python3-pip \
     python3-sphinx \
+    python3-venv \
+    python3-yaml \
+    rpm2cpio \
     sparse \
+    tesseract-ocr \
+    tesseract-ocr-eng \
     texinfo \
     xfslibs-dev\
     vim
-- 
2.20.1


