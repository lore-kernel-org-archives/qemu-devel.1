Received: from eggs.gnu.org ([209.51.188.92]:52110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gn224-0003VN-5h
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gn221-0000gM-Rk
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:31 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gn21x-0000bZ-Pe
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:26 -0500
Received: by mail-wr1-x444.google.com with SMTP id r10so10385072wrs.10
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 06:00:24 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 25 Jan 2019 14:00:08 +0000
Message-Id: <20190125140017.6092-6-alex.bennee@linaro.org>
In-Reply-To: <20190125140017.6092-1-alex.bennee@linaro.org>
References: <20190125140017.6092-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH  v1 05/14] docker: disable Xen on CentOS 7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

The Xen repository is failing to install, disable it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/centos7.docker | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dockerfiles/centos7.docker
index e0f18f5a41..e6fcbf4bcd 100644
--- a/tests/docker/dockerfiles/centos7.docker
+++ b/tests/docker/dockerfiles/centos7.docker
@@ -1,5 +1,5 @@
 FROM centos:7
-RUN yum install -y epel-release centos-release-xen
+RUN yum install -y epel-release
 RUN yum -y update
 ENV PACKAGES \
     bison \
@@ -8,7 +8,7 @@ ENV PACKAGES \
     ccache \
     csnappy-devel \
     flex \
-    g++ \
+    gcc-c++ \
     gcc \
     gettext \
     git \
@@ -29,7 +29,6 @@ ENV PACKAGES \
     spice-server-devel \
     tar \
     vte-devel \
-    xen-devel \
     zlib-devel
 RUN yum install -y $PACKAGES
 RUN rpm -q $PACKAGES | sort > /packages.txt
-- 
2.17.1
