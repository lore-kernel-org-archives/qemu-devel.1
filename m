Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DB3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:04:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0021D207CB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dOf+EqVa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0021D207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdxbQ-00078S-7t
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 11:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdxSZ-0001tX-CZ
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:55:11 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:56274)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdxSY-0008CL-1s
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:55:10 -0400
Received: by mail-wm1-x32e.google.com with SMTP id c71so3314511wmd.5
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 07:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pdHJ03eUq17CH67wGlCY4jhES9SA8aqc6XGoB7RnGR8=;
 b=dOf+EqVaHBorjVSTNKWMMLwyFoC1UpitEfqqzHLZq1/JcrLdZc7unN9SCnovymMrEx
 wAdJxeXJ0oc2grPQGgHGsaUFGIUPp1OmWDryM+x1zsus8VLWWsFjr/+MfyAGqGVku7uE
 QQjGCCMPkH0DMwiiuH25IxM7IPKtkWuJIIDb2JA/HYjlk68gZ/XUXeH08NlsMcwMFA1+
 3jKNsFVHoJ/0sUh8xEmDpCKL7rrH7pYdso2QTlcCKwXnNjzQTLjB25QJgElLWLMr/Hnt
 D7q5iR0ieybK+dAMK72gDGx5TZETB0E9swzzSJ+FSHxmHgzj3j+He2Yjh+1Ys388sLU3
 eZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pdHJ03eUq17CH67wGlCY4jhES9SA8aqc6XGoB7RnGR8=;
 b=Xr8pJBZkBksItUVGwEUzAgEkKa1JmZysTB/tb3zEFWaeIiW/WVwQg5foibuFWzW56e
 5jD/nez7u9EZwDwhSG6WRDPp+CRMAuehCK8qoJacCDz4TxOp90sYZMbsri2wKl7SYAhh
 tUHlIMjLGdo8SYFsOzoVPi/aIbSe3HLqz0QqKuwaUpKlPPWgcElKlzGVqrH+tO2qC1Q+
 0ZuHR2IGJ5xmkkHVYSwuZedtXTt8lgnhMCyeo5VA72x/T4mYsVv1P4nDFin0vVeJxme7
 T8fK2ScacQB5ESTVzM1geKPxcBtsP6fpsQL+v7B+v/x7ornjoS4MauFhdio36XEiTNzy
 MnEA==
X-Gm-Message-State: AOAM531EKrE8wNEkAn3WCBdCv2BMis0xeQwuLLN/OrhfQS5OUTDo6U72
 c3gyFVqrvDzfUB2yDgfA5HwQHSnQVo0=
X-Google-Smtp-Source: ABdhPJxmlQWiebq2oxO0/dHoeVuZFCkg7OnWDbcs3ejftHmfaoAhiwpEU0smFA730HVlPXWKOH+pow==
X-Received: by 2002:a1c:2702:: with SMTP id n2mr4782561wmn.107.1590591307337; 
 Wed, 27 May 2020 07:55:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h196sm3116565wme.22.2020.05.27.07.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 07:55:04 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C169F1FF96;
 Wed, 27 May 2020 15:54:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 08/12] tests/docker: add debian11 base image
Date: Wed, 27 May 2020 15:54:51 +0100
Message-Id: <20200527145455.2550-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200527145455.2550-1-alex.bennee@linaro.org>
References: <20200527145455.2550-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

We won't use this for building QEMU but we do need newer GCC's and
binutils for building some of our test cases.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200520140541.30256-10-alex.bennee@linaro.org>

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


