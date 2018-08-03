Received: from eggs.gnu.org ([2001:4830:134:3::10]:46933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1flVpA-0007wB-FE
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 04:52:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1flVp9-0003aU-IX
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 04:52:40 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1flVp9-0003Yz-AE
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 04:52:39 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  3 Aug 2018 09:52:30 +0100
Message-Id: <20180803085230.30574-6-peter.maydell@linaro.org>
In-Reply-To: <20180803085230.30574-1-peter.maydell@linaro.org>
References: <20180803085230.30574-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 5/5] tests/vm: Use make's --output-sync option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Use make's --output-sync option when running tests inside VMs,
so that if we're building with parallelization the output doesn't
get scrambled.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/vm/freebsd     | 4 ++--
 tests/vm/netbsd      | 4 ++--
 tests/vm/openbsd     | 4 ++--
 tests/vm/ubuntu.i386 | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 795f739c7b3..0a6ec4614a7 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -23,8 +23,8 @@ class FreeBSDVM(basevm.BaseVM):
         cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
         tar -xf /dev/vtbd1;
         ./configure {configure_opts};
-        gmake -j{jobs} {verbose};
-        gmake -j{jobs} check {verbose};
+        gmake --output-sync -j{jobs} {verbose};
+        gmake --output-sync -j{jobs} check {verbose};
     """
 
     def build_image(self, img):
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index c211672bcbd..45c9260dc0d 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -23,8 +23,8 @@ class NetBSDVM(basevm.BaseVM):
         cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
         tar -xf /dev/rld1a;
         ./configure --python=python2.7 {configure_opts};
-        gmake -j{jobs} {verbose};
-        gmake -j{jobs} check {verbose};
+        gmake --output-sync -j{jobs} {verbose};
+        gmake --output-sync -j{jobs} check {verbose};
     """
 
     def build_image(self, img):
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 1e0c2500ad9..98edfbca4ba 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -23,9 +23,9 @@ class OpenBSDVM(basevm.BaseVM):
         cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
         tar -xf /dev/rsd1c;
         ./configure --cc=x86_64-unknown-openbsd6.1-gcc-4.9.4 --python=python2.7 {configure_opts};
-        gmake -j{jobs} {verbose};
+        gmake --output-sync -j{jobs} {verbose};
         # XXX: "gmake check" seems to always hang or fail
-        #gmake -j{jobs} check {verbose};
+        #gmake --output-sync -j{jobs} check {verbose};
     """
 
     def build_image(self, img):
diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index 7ea25327071..54c25d5727a 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -25,8 +25,8 @@ class UbuntuX86VM(basevm.BaseVM):
         sudo chmod a+r /dev/vdb;
         tar -xf /dev/vdb;
         ./configure {configure_opts};
-        make -j{jobs};
-        make check -j{jobs} {verbose};
+        make --output-sync -j{jobs};
+        make --output-sync check -j{jobs} {verbose};
     """
 
     def _gen_cloud_init_iso(self):
-- 
2.17.1
