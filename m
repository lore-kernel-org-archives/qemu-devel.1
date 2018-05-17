Received: from eggs.gnu.org ([2001:4830:134:3::10]:52848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJN6V-0003Qm-5Y
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:54:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJN6U-0007Hs-5w
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:54:15 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:35563)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fJN6T-0007HK-VJ
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:54:14 -0400
Received: by mail-wm0-x22f.google.com with SMTP id o78-v6so10701848wmg.0
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 10:54:13 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 17 May 2018 18:47:10 +0100
Message-Id: <20180517174718.10107-42-alex.bennee@linaro.org>
In-Reply-To: <20180517174718.10107-1-alex.bennee@linaro.org>
References: <20180517174718.10107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 41/49] tests/tcg: enable building for m68k
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

As before, using Debian SID compilers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/Makefile.include                     |  1 +
 tests/docker/dockerfiles/debian-m68k-cross.docker | 12 ++++++++++++
 tests/tcg/m68k/Makefile.include                   |  2 ++
 3 files changed, 15 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-m68k-cross.docker
 create mode 100644 tests/tcg/m68k/Makefile.include

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 2471c4f30a..15c52127c7 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -64,6 +64,7 @@ docker-image-debian-win32-cross: docker-image-debian8-mxe
 docker-image-debian-win64-cross: docker-image-debian8-mxe
 docker-image-debian-alpha-cross: docker-image-debian-sid
 docker-image-debian-hppa-cross: docker-image-debian-sid
+docker-image-debian-m68k-cross: docker-image-debian-sid
 docker-image-travis: NOUSER=1
 
 # Expand all the pre-requistes for each docker image and test combination
diff --git a/tests/docker/dockerfiles/debian-m68k-cross.docker b/tests/docker/dockerfiles/debian-m68k-cross.docker
new file mode 100644
index 0000000000..21ba3b0132
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-m68k-cross.docker
@@ -0,0 +1,12 @@
+#
+# Docker cross-compiler target
+#
+# This docker target builds on the debian sid base image which
+# contains cross compilers for Debian "ports" targets.
+#
+FROM qemu:debian-sid
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        gcc-m68k-linux-gnu \
+        libc6-dev-m68k-cross
diff --git a/tests/tcg/m68k/Makefile.include b/tests/tcg/m68k/Makefile.include
new file mode 100644
index 0000000000..cd7c6bf50d
--- /dev/null
+++ b/tests/tcg/m68k/Makefile.include
@@ -0,0 +1,2 @@
+DOCKER_IMAGE=debian-m68k-cross
+DOCKER_CROSS_COMPILER=m68k-linux-gnu-gcc
-- 
2.17.0
