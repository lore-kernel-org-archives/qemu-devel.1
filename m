Received: from eggs.gnu.org ([2001:4830:134:3::10]:46956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1flVpB-0007wr-9x
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 04:52:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1flVpA-0003cN-FH
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 04:52:41 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1flVpA-0003Tb-5Y
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 04:52:40 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  3 Aug 2018 09:52:27 +0100
Message-Id: <20180803085230.30574-3-peter.maydell@linaro.org>
In-Reply-To: <20180803085230.30574-1-peter.maydell@linaro.org>
References: <20180803085230.30574-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/5] tests/vm: Pass the jobs parallelism
 setting to 'make check'
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

Our test suite works for parallel execution too, and this can
noticeably speed up a test run; pass the 'jobs' setting to
it as well as to the build proper.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/vm/freebsd     | 2 +-
 tests/vm/netbsd      | 2 +-
 tests/vm/openbsd     | 2 +-
 tests/vm/ubuntu.i386 | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 039dad8f693..2187a173274 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -24,7 +24,7 @@ class FreeBSDVM(basevm.BaseVM):
         tar -xf /dev/vtbd1;
         ./configure {configure_opts};
         gmake -j{jobs};
-        gmake check;
+        gmake -j{jobs} check;
     """
 
     def build_image(self, img):
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 3972d8b45cd..2cc4798f0c4 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -24,7 +24,7 @@ class NetBSDVM(basevm.BaseVM):
         tar -xf /dev/rld1a;
         ./configure --python=python2.7 {configure_opts};
         gmake -j{jobs};
-        gmake check;
+        gmake -j{jobs} check;
     """
 
     def build_image(self, img):
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 6ae16d97fdf..df6b79fe7dc 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -25,7 +25,7 @@ class OpenBSDVM(basevm.BaseVM):
         ./configure --cc=x86_64-unknown-openbsd6.1-gcc-4.9.4 --python=python2.7 {configure_opts};
         gmake -j{jobs};
         # XXX: "gmake check" seems to always hang or fail
-        #gmake check;
+        #gmake -j{jobs} check;
     """
 
     def build_image(self, img):
diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index fc319e0e6eb..059d295865c 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -26,7 +26,7 @@ class UbuntuX86VM(basevm.BaseVM):
         tar -xf /dev/vdb;
         ./configure {configure_opts};
         make -j{jobs};
-        make check;
+        make -j{jobs} check;
     """
 
     def _gen_cloud_init_iso(self):
-- 
2.17.1
