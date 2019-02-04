Received: from eggs.gnu.org ([209.51.188.92]:59692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj7A-0005LF-Gr
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj78-0003kN-UT
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:03 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:53877)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gqj78-0003jW-MC
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:02 -0500
Received: by mail-wm1-x32c.google.com with SMTP id d15so966188wmb.3
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 10:37:01 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	s132sm8836236wmf.28.2019.02.04.10.36.59 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 04 Feb 2019 10:36:59 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Feb 2019 19:35:42 +0100
Message-Id: <1549305379-51117-41-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
References: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 40/77] docker: adjust Xen repository for CentOS 7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The Xen repository is failing to install, pick the right name for the release package.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/dockerfiles/centos7.docker | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dockerfiles/centos7.docker
index e0f18f5..e0b9d7d 100644
--- a/tests/docker/dockerfiles/centos7.docker
+++ b/tests/docker/dockerfiles/centos7.docker
@@ -1,5 +1,6 @@
 FROM centos:7
-RUN yum install -y epel-release centos-release-xen
+RUN yum install -y epel-release centos-release-xen-48
+
 RUN yum -y update
 ENV PACKAGES \
     bison \
@@ -8,7 +9,7 @@ ENV PACKAGES \
     ccache \
     csnappy-devel \
     flex \
-    g++ \
+    gcc-c++ \
     gcc \
     gettext \
     git \
-- 
1.8.3.1
