Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317A3C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:43:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB7D12146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xM454+Ti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7D12146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCtWU-0007IJ-4t
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 18:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCs5G-0003QI-Gu
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCs56-0007a6-Dk
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:10:54 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:55156)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCs56-0007ZV-7N
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:10:44 -0400
Received: by mail-wm1-x329.google.com with SMTP id p7so1899671wmp.4
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 14:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LQ7TtxdapHJhHWaN1sxRJBzcLqET+HVNb/Sa2fGG/OA=;
 b=xM454+TiZaJ2N6S6EChoA7grql6I6QTY6DcfY6Ae24pM0E4FVAXYLdQCHjXIvHjzRH
 1cuyPn+fnzgG0wxu0H7IjrFceHwJvh1Ch2xU1Vmt0bHRd3hvJAL3ofDcW5P39VVy2PNo
 vegdG9+GlaULxm3Wz9zp3jJO1Vo2MZadqSVuy1TtIpORMhVZA5KKwfvnumPWEpCJfoIp
 RuQuI5Fc2vGKtrmiIRBBEw8aBFLZDuVQr/zyDLySxeqtVn+uDYEurO0oKNLJXBBT45tA
 QOMlos19MB+bmQl9UjThSwuEUReHvtxMEvgWBzBvI4XxubDKs5EvFq28/SZiesZLnJ+W
 CamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LQ7TtxdapHJhHWaN1sxRJBzcLqET+HVNb/Sa2fGG/OA=;
 b=G7zbOPP+dOS1XDCEe7h4sTDbOENH6q78XSBfJk+uvsaM1klwZof+nmTZtN8G9a8U6H
 BAxDJ4cKKv+5HCdRSTgvB527/NhwvYx5iKt3U3rZNbR2IimLDpBWLvwWtbMPGFUwj7nP
 rpwgLk2qH0V/BReMGgyajlLB6eI1BobU7EFo7sDh1K/xaUHsTlrRc2eMJ2HIUsTtPgDV
 XcaFpbyyjenkS09qoY7X5atEKV5s+MW+5GZc2yr8IC1j1EEEVnzNyRAqgtluz29UG7Rg
 tQ8YFlL48/QzdbmNjQ75PtEqyD1GNwip7iVXtKeNhy+eTJd9gpXZFeMbbQR84tWMlFkK
 uRfA==
X-Gm-Message-State: APjAAAVSWB82hjQDXitR/kFeLeRcE8RRYT/6MmF/U/Z0aggNV2pVtG46
 xd5q4ghe1sNeygApChpTMzhgzQ==
X-Google-Smtp-Source: APXvYqygDsVm+eRqBa8IuGwIHekVuI5yc2o/QZtoMX5MVcT0GI70uwUHOV5vh9VDOYbzLmF+waIeHw==
X-Received: by 2002:a1c:a94b:: with SMTP id s72mr2606313wme.9.1569359440899;
 Tue, 24 Sep 2019 14:10:40 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j1sm5122072wrg.24.2019.09.24.14.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 14:10:35 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D29B51FFB7;
 Tue, 24 Sep 2019 22:01:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 32/33] docker: move tests from python2 to python3
Date: Tue, 24 Sep 2019 22:01:05 +0100
Message-Id: <20190924210106.27117-33-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924210106.27117-1-alex.bennee@linaro.org>
References: <20190924210106.27117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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

As part of the push to drop python2 support, replace any explicit python2
dependencies with python3 versions.

For centos, python2 still exists as an implicit dependency, but by adding
python3 we will be able to build even if the configure script begins to
require python 3.5+.

Tested with centos7, fedora, ubuntu, ubuntu1804, and debian 9 (amd64).
Tested under a custom configure script that requires Python 3.5+.

the travis dockerfile is also moved to using python3, which was tested
by running `make docker-test-build@travis`, which I hope is sufficient.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20190923181140.7235-7-jsnow@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/centos7.docker             | 2 +-
 tests/docker/dockerfiles/debian-xtensa-cross.docker | 2 +-
 tests/docker/dockerfiles/debian10.docker            | 2 +-
 tests/docker/dockerfiles/debian9.docker             | 2 +-
 tests/docker/dockerfiles/travis.docker              | 2 +-
 tests/docker/dockerfiles/ubuntu.docker              | 2 +-
 tests/docker/dockerfiles/ubuntu1804.docker          | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dockerfiles/centos7.docker
index e0b9d7dbe9f..953637065c4 100644
--- a/tests/docker/dockerfiles/centos7.docker
+++ b/tests/docker/dockerfiles/centos7.docker
@@ -25,6 +25,7 @@ ENV PACKAGES \
     nettle-devel \
     perl-Test-Harness \
     pixman-devel \
+    python3 \
     SDL-devel \
     spice-glib-devel \
     spice-server-devel \
@@ -34,4 +35,3 @@ ENV PACKAGES \
     zlib-devel
 RUN yum install -y $PACKAGES
 RUN rpm -q $PACKAGES | sort > /packages.txt
-
diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/docker/dockerfiles/debian-xtensa-cross.docker
index b9c2e2e5317..e6f93f65ee2 100644
--- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
+++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
@@ -18,7 +18,7 @@ RUN apt-get update && \
         flex \
         gettext \
         git \
-        python-minimal
+        python3-minimal
 
 ENV CPU_LIST csp dc232b dc233c
 ENV TOOLCHAIN_RELEASE 2018.02
diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/dockerfiles/debian10.docker
index 30a78813f27..dad498b52e3 100644
--- a/tests/docker/dockerfiles/debian10.docker
+++ b/tests/docker/dockerfiles/debian10.docker
@@ -26,7 +26,7 @@ RUN apt update && \
         git \
         pkg-config \
         psmisc \
-        python \
+        python3 \
         python3-sphinx \
         texinfo \
         $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/dockerfiles/debian9.docker
index b36f1d4ed83..8cbd742bb5f 100644
--- a/tests/docker/dockerfiles/debian9.docker
+++ b/tests/docker/dockerfiles/debian9.docker
@@ -26,7 +26,7 @@ RUN apt update && \
         git \
         pkg-config \
         psmisc \
-        python \
+        python3 \
         python3-sphinx \
         texinfo \
         $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
diff --git a/tests/docker/dockerfiles/travis.docker b/tests/docker/dockerfiles/travis.docker
index e72dc85ca7a..ea14da29d97 100644
--- a/tests/docker/dockerfiles/travis.docker
+++ b/tests/docker/dockerfiles/travis.docker
@@ -5,7 +5,7 @@ ENV LC_ALL en_US.UTF-8
 RUN sed -i "s/# deb-src/deb-src/" /etc/apt/sources.list
 RUN apt-get update
 RUN apt-get -y build-dep qemu
-RUN apt-get -y install device-tree-compiler python2.7 python-yaml dh-autoreconf gdb strace lsof net-tools gcovr
+RUN apt-get -y install device-tree-compiler python3 python3-yaml dh-autoreconf gdb strace lsof net-tools gcovr
 # Travis tools require PhantomJS / Neo4j / Maven accessible
 # in their PATH (QEMU build won't access them).
 ENV PATH /usr/local/phantomjs/bin:/usr/local/phantomjs:/usr/local/neo4j-3.2.7/bin:/usr/local/maven-3.5.2/bin:/usr/local/cmake-3.9.2/bin:/usr/local/clang-5.0.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfiles/ubuntu.docker
index a4f601395c8..f4864922240 100644
--- a/tests/docker/dockerfiles/ubuntu.docker
+++ b/tests/docker/dockerfiles/ubuntu.docker
@@ -60,7 +60,7 @@ ENV PACKAGES flex bison \
     libvte-2.91-dev \
     libxen-dev \
     make \
-    python-yaml \
+    python3-yaml \
     python3-sphinx \
     sparse \
     texinfo \
diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/dockerfiles/ubuntu1804.docker
index 883f9bcf31c..3cc4f492c4a 100644
--- a/tests/docker/dockerfiles/ubuntu1804.docker
+++ b/tests/docker/dockerfiles/ubuntu1804.docker
@@ -47,7 +47,7 @@ ENV PACKAGES flex bison \
     libvte-2.91-dev \
     libxen-dev \
     make \
-    python-yaml \
+    python3-yaml \
     python3-sphinx \
     sparse \
     texinfo \
-- 
2.20.1


