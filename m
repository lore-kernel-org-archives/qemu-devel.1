Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A43C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:11:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B17FB207F9
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H7wnbwfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17FB207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbPRr-0001MR-Re
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 10:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbPMP-0000r6-AS
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:06:17 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b]:46742)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbPM9-00021v-SE
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:06:17 -0400
Received: by mail-ej1-x62b.google.com with SMTP id e2so3891187eje.13
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 07:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YNz4cR2RJqYNSGkM/23ZopCXsChGl4cQuLehMB9w6UY=;
 b=H7wnbwfjnT17W6xqZy4tx6t9DcaNBGCIWgmexo/FTYMhPT+wzOE1RXtqfKBfS0vI5I
 xzohZPu7KU6v45Iue0kAlTzlhhp82SEHq0S8tn8Yxs8HM4ByfCE/0K1f7NcuLNurDlbn
 oWdQgtgC5/ZrWAY+ha8Oe+EHl/Tp6tks4icRXQvMCoTiSpCkoR0g12JBLcUc5JAw1zhx
 Oq7CmcAGXGts9WZSv9ud3L9nW7g+QLti7Oknlr9sdrYFWfoVcjjxuwzW5DqMe99U7qXD
 qxnI72rqrbu+KApPCp2yl/dwdGYeHF9VSj/tVXLRAHznO8TY4l9fWB8O5e/rJJ3NbnLc
 5Lww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YNz4cR2RJqYNSGkM/23ZopCXsChGl4cQuLehMB9w6UY=;
 b=E2DI4aWMxDhz8kagqn0WpdVTza/ZGAPEQTmIUC9mfziFPVi9pckW7XlDB5fSWXWaPR
 yqew9iq7bvkhBHp9Dv7c01vRMhhU8pXz3WYeWBXAIjup+ImN8Jb9B9y8KwY2tbJ8kdJg
 ofkQ0I8UKIvPbcz8jyy7bEyrfO0Lgvi5w9kqA0fpvr803UQWd9+IOGHg1hLm6I86Xep5
 z5kmeRxbG3KXJTL+nw+2OLTmIvN2TSLyOnGVIel+GrR9g6+ed0LaGEytLgE9A8KMl4rG
 1fjRl+T2AjuWxWgHdU07971QWXdXctsiBqbqWQvNwRp/2PMX6Q8mMgyRefvsgiu9WzRN
 qBwQ==
X-Gm-Message-State: AOAM533a9ao4nhbBfGRCAIup3sxIb9MBX14zxY47Kz285rZACsJ/ZYz4
 kndWj1cRRbgWz7gS8BIb7GZSxkui2rI=
X-Google-Smtp-Source: ABdhPJz0p+aJTIQHXOaCmDA0aHnJkk8QuyxyU8NciYfCv1Tc9ExJNjBUTOqYgH2A5Mj91g4Xqi6+OQ==
X-Received: by 2002:a17:906:2dc8:: with SMTP id
 h8mr4080737eji.108.1589983560483; 
 Wed, 20 May 2020 07:06:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g20sm2001782ejx.85.2020.05.20.07.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 07:05:49 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 001721FF98;
 Wed, 20 May 2020 15:05:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 09/15] tests/docker: add debian11 base image
Date: Wed, 20 May 2020 15:05:35 +0100
Message-Id: <20200520140541.30256-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200520140541.30256-1-alex.bennee@linaro.org>
References: <20200520140541.30256-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We won't use this for building QEMU but we do need newer GCC's and
binutils for building some of our test cases.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include            |  2 +-
 tests/docker/dockerfiles/debian11.docker | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)
 create mode 100644 tests/docker/dockerfiles/debian11.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 43a86786882..3596b589307 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -7,7 +7,7 @@ HOST_ARCH = $(if $(ARCH),$(ARCH),$(shell uname -m))
 DOCKER_SUFFIX := .docker
 DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
 # we don't run tests on intermediate images (used as base by another image)
-DOCKER_PARTIAL_IMAGES := debian9 debian10
+DOCKER_PARTIAL_IMAGES := debian9 debian10 debian11
 DOCKER_PARTIAL_IMAGES += debian9-mxe debian-bootstrap
 DOCKER_IMAGES := $(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker))))
 DOCKER_TARGETS := $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
diff --git a/tests/docker/dockerfiles/debian11.docker b/tests/docker/dockerfiles/debian11.docker
new file mode 100644
index 00000000000..5adfd62d553
--- /dev/null
+++ b/tests/docker/dockerfiles/debian11.docker
@@ -0,0 +1,18 @@
+#
+# Docker multiarch cross-compiler target
+#
+# This docker target uses the current development version of Debian as
+# a base for cross compilers for building test binaries. We won't
+# attempt to build QEMU on it yet given it is still in development.
+#
+# On its own you can't build much but the docker-foo-cross targets
+# build on top of the base debian image.
+#
+FROM debian:bullseye-slim
+
+# Duplicate deb line as deb-src
+RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
+
+# Install common build utilities
+RUN apt update && \
+    DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata
-- 
2.20.1


