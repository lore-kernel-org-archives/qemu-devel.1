Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA8AC4727E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:30:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 868E220708
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dn5uKd9N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 868E220708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCKJ-00017I-7K
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQBsC-0005F6-BH
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:01:00 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:40223)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQBs4-0000zB-4L
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:00:56 -0400
Received: by mail-wm1-x32b.google.com with SMTP id k18so2964257wmj.5
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 09:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IRAdzJ9Fz7lwIEn0uOrEMb6UUG23jZ5P/nghwH5F3rs=;
 b=dn5uKd9N4M+yJzBqA+TpW/E/u7+IphQ0ybtWhiLVd4BJuKj9/aCEJPqkI3Jnfrr/AI
 kzJs7hzBDuCTWu1LCy1WoXNd7627OYjozlUpJWsMZ4+nV5eF9lt5ltn9ZzT4lgrgmVZc
 re+puXb1F/hxr6nB8NnEEa3PITpebBcnlVvPNxeokmvSHtvDbbga0coxpOEYVCDN3TkR
 5+i9E6PhhUylsyR/mJIh1hJSH18umUWiDgL3XyK8Ls8oRoOJAa9PZBAsCb9Rf24syTAy
 O4ykd5ZVTlI0n7ciydy5gJMfSVhpNkXnZIQi5xa2paPInIgDQJvlA9CngAC96qcs4J01
 gn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IRAdzJ9Fz7lwIEn0uOrEMb6UUG23jZ5P/nghwH5F3rs=;
 b=D58zogtnmNS2OBnKmQSOJ4DYCMT2od/h39l28udq+cxoSZIEM0ZjLn4PoDEtfS1iTx
 1fgitrda/9tS2TDt5m+H2PH3y327MCbIhzbpNTCK/EVmNjIuQtzPlS0tMvMzu4W2DjQr
 Ms0q3BJOj7B6hz5rmmGOIZ5D/14BBec5QpVJ8zzJO9s8ZBLqSe+ARZY13VJJLFANPKt4
 nvKnfXktyzReA/1TgSkc3jPaZmhskB8vcV3VN9uwFAca0yolgWPcmQmdp4+jA8CGnYMI
 2G9S0E+8YQKLzYHVL8H46jvb6AuYuPVC2Zd+B+Rf2MKHS0hAIjvdU29sjU03BI1I3bZA
 Tbpg==
X-Gm-Message-State: AOAM530kWvJMW5YQqqTQ5Eu9TgHH6C4ZQoLlix0J7ruiD6b345BEAdvY
 ye7y1XhC3h2bOOsCNXIYOAWubg==
X-Google-Smtp-Source: ABdhPJxp2ssTVJ+yC+Hide5r8LP9CMniGq6QZxUxWjfrqmaC2CPmjevj2g2qQHafd+lx/um+IkaKEw==
X-Received: by 2002:a7b:c847:: with SMTP id c7mr4191616wml.41.1602086449068;
 Wed, 07 Oct 2020 09:00:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f14sm3318700wme.22.2020.10.07.09.00.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:00:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AE4F31FF92;
 Wed,  7 Oct 2020 17:00:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 06/22] tests/docker: Add genisoimage to the docker file
Date: Wed,  7 Oct 2020 17:00:22 +0100
Message-Id: <20201007160038.26953-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201007160038.26953-1-alex.bennee@linaro.org>
References: <20201007160038.26953-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

genisoimage is needed for running the tests/qtest/cdrom-test qtest.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20201006174347.152040-1-thuth@redhat.com>
---
 tests/docker/dockerfiles/centos8.docker      | 1 +
 tests/docker/dockerfiles/debian-amd64.docker | 1 +
 tests/docker/dockerfiles/fedora.docker       | 1 +
 tests/docker/dockerfiles/ubuntu2004.docker   | 1 +
 4 files changed, 4 insertions(+)

diff --git a/tests/docker/dockerfiles/centos8.docker b/tests/docker/dockerfiles/centos8.docker
index f435616d6a..0fc2697491 100644
--- a/tests/docker/dockerfiles/centos8.docker
+++ b/tests/docker/dockerfiles/centos8.docker
@@ -8,6 +8,7 @@ ENV PACKAGES \
     dbus-daemon \
     gcc \
     gcc-c++ \
+    genisoimage \
     gettext \
     git \
     glib2-devel \
diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
index d2500dcff1..314c6bae83 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -14,6 +14,7 @@ RUN apt update && \
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
     apt install -y --no-install-recommends \
+        genisoimage \
         libbz2-dev \
         liblzo2-dev \
         libgcrypt20-dev \
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index ec783418c8..85c975543d 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -15,6 +15,7 @@ ENV PACKAGES \
     findutils \
     gcc \
     gcc-c++ \
+    genisoimage \
     gettext \
     git \
     glib2-devel \
diff --git a/tests/docker/dockerfiles/ubuntu2004.docker b/tests/docker/dockerfiles/ubuntu2004.docker
index cafe8443fb..f4b9556b9e 100644
--- a/tests/docker/dockerfiles/ubuntu2004.docker
+++ b/tests/docker/dockerfiles/ubuntu2004.docker
@@ -3,6 +3,7 @@ ENV PACKAGES flex bison \
     ccache \
     clang-10\
     gcc \
+    genisoimage \
     gettext \
     git \
     glusterfs-common \
-- 
2.20.1


