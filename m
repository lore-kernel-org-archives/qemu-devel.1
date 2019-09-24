Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3643C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 00:18:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7561120872
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 00:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mZMeoeSn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7561120872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCv1E-0004Yr-Am
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 20:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCuzu-0003eZ-RR
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 20:17:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCuzt-0000pk-K5
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 20:17:34 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:53720)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCuzt-0000pa-CA
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 20:17:33 -0400
Received: by mail-wm1-x32b.google.com with SMTP id i16so2404559wmd.3
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 17:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UWXODm6BuFnMzwN8yk+MOa3eu06k3cObvd4skljNWys=;
 b=mZMeoeSnF0b6h7yFy9mhE2+V655PPtPKCvPWk1hnNmyOHwPd+BegsW8W8R0caF5whs
 +N5g5qDXvCTOcEWPhjw5JzM4kC40uxQDbpFSWWMxbV3EvJVRtU9UXa6V1w4G7ev1+2Ok
 4lNfSm1G26LE8ul3g4VqWtifSuwr/h8aBXeEki2nv6TmFA9mX1z7FwaAfOhwFHXozFRm
 YxMPmP966FhJX0pHD2gC+4F2orW6YVFQnVpg08YvwoRmvk+F/mw81pZ5ou/ZNbzyFxHL
 QZEyQwCdPmxML00V35P4ySXsiIvpdfjMcFaxREWZX+6U5NWPMkqGLlL2VJEDFI8nXIJz
 v+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UWXODm6BuFnMzwN8yk+MOa3eu06k3cObvd4skljNWys=;
 b=mppqDVV1cAHR6lvqod4cusx/wdRNS3HOfkpkaw6beiem84HDsd5Am1Om1KD/uHk155
 tqAwk1urVWlncWkO/2n62Py0OxuVoGrGNElYVVa8+Fat2gtB/wZu0f9RmT62UI5yRMcu
 hW/2EnGsYyqrU1ejVH3m7BFOt6C5LH3hqJ8uifcUCW64Sch5iF7AQrNEJFUAMUeQl5p0
 XI71ng2uSIP7WAGlbIKeModk7t1cZL9eNuUoImBbO1lpIa0tlf8OQ/laKgStjf1luM89
 ft9IsmNKkKqU3Tg/RI4k0Du5/whQOY4iP29DLClNasGc7I+516mtNULmkPTBqrN1QS4M
 56fg==
X-Gm-Message-State: APjAAAWK6yJVILCd2jd3ZHevnf2mQv2T8zf3zkW4rtfeUhV/BYs4xaKF
 yw7+wSUmTwEzJqD83LKIhnkJFp6ErfA1Xw==
X-Google-Smtp-Source: APXvYqyNngUDM9McheyRedMPowJ0P2WqyplBJGWSX4d0J3ZcCZs21Qftl11iEv5Z8FYKljUlFzY1uQ==
X-Received: by 2002:a7b:c92b:: with SMTP id h11mr2698665wml.10.1569360034125; 
 Tue, 24 Sep 2019 14:20:34 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k24sm4136223wmi.1.2019.09.24.14.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 14:20:33 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B41FE1FFB5;
 Tue, 24 Sep 2019 22:01:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 31/33] docker: remove unused debian-sid
Date: Tue, 24 Sep 2019 22:01:04 +0100
Message-Id: <20190924210106.27117-32-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924210106.27117-1-alex.bennee@linaro.org>
References: <20190924210106.27117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, jsnow@redhat.com,
 f4bug@amsat.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

debian-sid is listed as a partial image, so we cannot run tests against it.
Since it isn't used by any other testable image, remove it for now as it
is prone to bitrot.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20190923181140.7235-6-jsnow@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include              |  2 +-
 tests/docker/dockerfiles/debian-sid.docker | 35 ----------------------
 2 files changed, 1 insertion(+), 36 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-sid.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 053c418d8cd..180e5439ef9 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -5,7 +5,7 @@
 DOCKER_SUFFIX := .docker
 DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
 # we don't run tests on intermediate images (used as base by another image)
-DOCKER_PARTIAL_IMAGES := debian9 debian10 debian-sid
+DOCKER_PARTIAL_IMAGES := debian9 debian10
 DOCKER_PARTIAL_IMAGES += debian9-mxe debian-bootstrap
 DOCKER_IMAGES := $(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker))))
 DOCKER_TARGETS := $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
diff --git a/tests/docker/dockerfiles/debian-sid.docker b/tests/docker/dockerfiles/debian-sid.docker
deleted file mode 100644
index 2a1bcc33b24..00000000000
--- a/tests/docker/dockerfiles/debian-sid.docker
+++ /dev/null
@@ -1,35 +0,0 @@
-#
-# Debian Sid Base
-#
-# Currently we can build all our guests with cross-compilers in the
-# latest Debian release (Buster). However new compilers will first
-# arrive in Sid. However Sid is a rolling distro which may be broken
-# at any particular time. To try and mitigate this we use Debian's
-# snapshot archive which provides a "stable" view of what state Sid
-# was in.
-#
-
-# This must be earlier than the snapshot date we are aiming for
-FROM debian:sid-20190812-slim
-
- # Use a snapshot known to work (see http://snapshot.debian.org/#Usage)
-ENV DEBIAN_SNAPSHOT_DATE "20190820"
-RUN sed -i "s%^deb \(https\?://\)deb.debian.org/debian/\? \(.*\)%deb [check-valid-until=no] \1snapshot.debian.org/archive/debian/${DEBIAN_SNAPSHOT_DATE} \2%" /etc/apt/sources.list
-
-# Duplicate deb line as deb-src
-RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
-
-# Install common build utilities
-RUN apt update && \
-    DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
-    DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt install -y --no-install-recommends \
-        bison \
-        build-essential \
-        ca-certificates \
-        flex \
-        git \
-        pkg-config \
-        psmisc \
-        python \
-        texinfo || { echo "Failed to build - see debian-sid.docker notes"; exit 1; }
-- 
2.20.1


