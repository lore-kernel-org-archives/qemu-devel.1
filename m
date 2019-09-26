Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA77C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:59:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EE7E222C3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eh0KQihD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE7E222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43005 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDYzY-0000ly-SA
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 14:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYm8-0002Ic-OB
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:46:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYm6-00050f-Nb
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:46:00 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:37045)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDYm4-0004xX-BP
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:45:56 -0400
Received: by mail-wr1-x430.google.com with SMTP id i1so3928063wro.4
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 11:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=frj9YaghIiluWKTjZzqpfYiPrz4BwfSWHXhAc0MSyw0=;
 b=eh0KQihDu/SN238kRpVdDI2lIM0ozqdqR5TTpZXh/cpFDlsgRg+Sib7El7MkH5yRXG
 tVVKR/A0l54iimTonMwSEB+MpxoseVVDMogY1JEaaXyu/FN+DB7AcWLZQRMc9CXHQnf2
 oT92uz1PaF036gN6BQe1wWGVF4wHv7dpb8NsKmHRhjujX1OCwoYWLQKfwb7oBJJ+wj5s
 xz2Z/T7bgB2PwY7x6svmEaPCmIwmswyFPNFz9ysai8rVyCuGVPU9l48bP2T9GdsJ5WvJ
 OMJv6xzBi3cNGT9zuB0XZpuGxmP7PiiLBdM1f1ZVCF3eJ9LOII2a0wWHHYSjcArazbIo
 hDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=frj9YaghIiluWKTjZzqpfYiPrz4BwfSWHXhAc0MSyw0=;
 b=ff1LeJcxEtTcyIZbyIcUGYt5J8bnaqxQsqZnoif8HPnf4dLnDl9LIordHTUQlkV6po
 RCJ6dhcVh4VsxOWoRkEFQF5OQU9dZU+XLFanAYEtzaMWvFM6LCrHtJK/pYdjFULcAIo5
 abSwvuruUC6GZ71/9NhQt7CYL0TMx931ovvn2PRdG5m9wL9pF/SA/73u/WRdC/scqVel
 8Zh2bFYCPG5561Wk9xl8xRkiBA0B9QczAwuzDUDA1HNgIFogaYJMSUqXi6tR//ee8DTp
 Js0uVeUAgVEIiRPhZ1/bMStBquKTqvIsGYECjSqmBlI7CKdgRlgY9kxLQp8EENXUXaA9
 2dOA==
X-Gm-Message-State: APjAAAVUIwLT63TUsxaI+/nSw6A5xhtFQOUXujtFY0/xu1se4uukTti5
 QSM8O245I6ZoRFuXzsWFhQK3nw==
X-Google-Smtp-Source: APXvYqyT95i+sMBh+NkN5W4mRiVG/9PQzPodmlnVHWhmZOuOQeGvELRnVNU8z69A3q+V/GYXns+xNw==
X-Received: by 2002:a5d:6b49:: with SMTP id x9mr4473243wrw.80.1569523554932;
 Thu, 26 Sep 2019 11:45:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h125sm5938706wmf.31.2019.09.26.11.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 11:45:52 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B730E1FFB1;
 Thu, 26 Sep 2019 19:35:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 27/28] docker: move tests from python2 to python3
Date: Thu, 26 Sep 2019 19:35:52 +0100
Message-Id: <20190926183553.13895-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926183553.13895-1-alex.bennee@linaro.org>
References: <20190926183553.13895-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
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
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dockerfiles/centos7.docker
index e0b9d7dbe9..953637065c 100644
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
index b9c2e2e531..e6f93f65ee 100644
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
index 30a78813f2..dad498b52e 100644
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
index b36f1d4ed8..8cbd742bb5 100644
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
index e72dc85ca7..ea14da29d9 100644
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
index a4f601395c..f486492224 100644
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
index 883f9bcf31..3cc4f492c4 100644
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


