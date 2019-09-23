Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BE2C4CEC4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 18:22:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCF43206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 18:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF43206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCSyh-0001qV-1Y
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 14:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iCSoU-0000w5-4a
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:11:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iCSoS-0000qv-8c
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:11:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44216)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1iCSoR-0000oU-Qg
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:11:52 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EB90C18CB8EB;
 Mon, 23 Sep 2019 18:11:50 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-231.bos.redhat.com [10.18.17.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 53B5C1001B00;
 Mon, 23 Sep 2019 18:11:50 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 6/6] docker: move tests from python2 to python3
Date: Mon, 23 Sep 2019 14:11:40 -0400
Message-Id: <20190923181140.7235-7-jsnow@redhat.com>
In-Reply-To: <20190923181140.7235-1-jsnow@redhat.com>
References: <20190923181140.7235-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Mon, 23 Sep 2019 18:11:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 tests/docker/dockerfiles/centos7.docker             | 2 +-
 tests/docker/dockerfiles/debian-xtensa-cross.docker | 2 +-
 tests/docker/dockerfiles/debian10.docker            | 2 +-
 tests/docker/dockerfiles/debian9.docker             | 2 +-
 tests/docker/dockerfiles/travis.docker              | 2 +-
 tests/docker/dockerfiles/ubuntu.docker              | 2 +-
 tests/docker/dockerfiles/ubuntu1804.docker          | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/docke=
rfiles/centos7.docker
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
diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/=
docker/dockerfiles/debian-xtensa-cross.docker
index b9c2e2e531..e6f93f65ee 100644
--- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
+++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
@@ -18,7 +18,7 @@ RUN apt-get update && \
         flex \
         gettext \
         git \
-        python-minimal
+        python3-minimal
=20
 ENV CPU_LIST csp dc232b dc233c
 ENV TOOLCHAIN_RELEASE 2018.02
diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/dock=
erfiles/debian10.docker
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
         $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut =
-d\  -f2)
diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/docke=
rfiles/debian9.docker
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
         $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut =
-d\  -f2)
diff --git a/tests/docker/dockerfiles/travis.docker b/tests/docker/docker=
files/travis.docker
index e72dc85ca7..ea14da29d9 100644
--- a/tests/docker/dockerfiles/travis.docker
+++ b/tests/docker/dockerfiles/travis.docker
@@ -5,7 +5,7 @@ ENV LC_ALL en_US.UTF-8
 RUN sed -i "s/# deb-src/deb-src/" /etc/apt/sources.list
 RUN apt-get update
 RUN apt-get -y build-dep qemu
-RUN apt-get -y install device-tree-compiler python2.7 python-yaml dh-aut=
oreconf gdb strace lsof net-tools gcovr
+RUN apt-get -y install device-tree-compiler python3 python3-yaml dh-auto=
reconf gdb strace lsof net-tools gcovr
 # Travis tools require PhantomJS / Neo4j / Maven accessible
 # in their PATH (QEMU build won't access them).
 ENV PATH /usr/local/phantomjs/bin:/usr/local/phantomjs:/usr/local/neo4j-=
3.2.7/bin:/usr/local/maven-3.5.2/bin:/usr/local/cmake-3.9.2/bin:/usr/loca=
l/clang-5.0.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin=
:/bin
diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/docker=
files/ubuntu.docker
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
diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/do=
ckerfiles/ubuntu1804.docker
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
--=20
2.21.0


