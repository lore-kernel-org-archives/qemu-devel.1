Received: from eggs.gnu.org ([209.51.188.92]:52229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldz4-0005DC-Qb
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:07:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldz3-00053M-Am
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:07:42 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:42788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gldz3-0004ha-2h
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:07:41 -0500
Received: by mail-wr1-x432.google.com with SMTP id q18so24435462wrx.9
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:07:12 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	133sm56197732wme.9.2019.01.21.10.07.10 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 21 Jan 2019 10:07:10 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Jan 2019 19:06:20 +0100
Message-Id: <1548093980-43088-50-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
References: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 49/49] docker: disable Xen on CentOS 7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The Xen repository is failing to install, disable it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/dockerfiles/centos7.docker | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dockerfiles/centos7.docker
index e0f18f5..e6fcbf4 100644
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
1.8.3.1
