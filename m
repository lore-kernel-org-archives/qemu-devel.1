Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F51C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:28:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C00902065D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tmvi6Rh6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C00902065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsi2C-0007mh-2Y
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshoQ-00073K-Py
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:14:42 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:40374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshoN-0004sZ-Nv
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:14:42 -0400
Received: by mail-wr1-x42f.google.com with SMTP id f2so16004074wrp.7
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BhAPRbyJ6wjGUojYdyED7mQgTxQ6WKTzi+98H1OGLvA=;
 b=tmvi6Rh60yUjJoJdLRzyAuDs3Uetu+eqE6la3Po2XNfZOV2GmBOtY5yjLNzLOYFKJZ
 3F3nmlxXU8WmbfjHSLXi4q6o8fk5zz1FnSdhZXyaa+hBiRH9gv0NwldCupYmsUYPMboS
 z4jVdoOrgR7breirfvpvYZf9BhFMkpw1lVB0qEDTCMZrGShE9Qf9h4aLGCgLQGyuM8i2
 d8vOMEfAHR8aVJOlz1GaIay64MpiJdSwaDymepqnZrjGEkBWoYoMCDAve8CDHxzDbtFT
 WYgwfl31Hg8/iJfTBQW7p3Ct8DdR/H21YcV4QHXjkcgh7eb9Y8ByeWXr59qCyDpjB4C4
 VuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BhAPRbyJ6wjGUojYdyED7mQgTxQ6WKTzi+98H1OGLvA=;
 b=pcq8Xhu6dtuCZkfWJNLP+ymLmMNSOjpZVPUHhO3NGK5orrM3y23vdT+RBMhIKWLnGO
 86ZhjSJ7JR9OkojSwCjPYZgXWXgrjxSALx8G4RDaBHrRodZURUwJ3yLpqGULnqI7Wi9F
 OOW8Grldn1a2nNAPibFbeNg672AmZpHsSe0CS/6xJf2tjb+rnXf3BlyeGKBTNjfmoFTC
 4eW/6lHd7Sh9tHslPSiekE4GB5XbGY/kSloy3B2VjC9G4dR4pk3YI8b7PVvyHnj67wBJ
 g9tOsZqFCgg49xVNAr1b4/rzdycrC0iL09vob266tYWjiPapjgNyH50wm/hepzGFgivm
 lGiQ==
X-Gm-Message-State: AOAM5331/Pn407Ivv91He96uk/qcQohi7vWMlZQbNAKQ4zqc/tt1vG8F
 rfWgx+nZxBdaLhjoSOXSuOrz/A==
X-Google-Smtp-Source: ABdhPJzYVfoILTqBuFcDySh8hEF6doRJmzMuqjMzMgr/GC/Ol0zW59P4uUjgFdkbPt4tF1usAHLNXQ==
X-Received: by 2002:a5d:630c:: with SMTP id i12mr57737967wru.158.1594106078157; 
 Tue, 07 Jul 2020 00:14:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m16sm23078090wro.0.2020.07.07.00.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:14:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DABEA1FFAC;
 Tue,  7 Jul 2020 08:09:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 23/41] tests/docker: add packages needed for check-acceptance
Date: Tue,  7 Jul 2020 08:08:40 +0100
Message-Id: <20200707070858.6622-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707070858.6622-1-alex.bennee@linaro.org>
References: <20200707070858.6622-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need additional python packages to run check-acceptance. Add them
to the docker images we will be using later.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200701135652.1366-26-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 798ddd2c3e0b..70b6186bd3ea 100644
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
index 6050ce7e8a80..f7aac840bf86 100644
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


