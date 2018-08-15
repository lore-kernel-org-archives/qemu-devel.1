Received: from eggs.gnu.org ([2001:4830:134:3::10]:56972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpmFQ-0007AK-Nj
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpmFP-0001Dw-AK
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36186 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fpmFO-0001C4-Te
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:23 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 15 Aug 2018 11:12:43 +0800
Message-Id: <20180815031248.14908-13-famz@redhat.com>
In-Reply-To: <20180815031248.14908-1-famz@redhat.com>
References: <20180815031248.14908-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 12/17] tests/vm: Pass the jobs parallelism
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
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

Our test suite works for parallel execution too, and this can
noticeably speed up a test run; pass the 'jobs' setting to
it as well as to the build proper.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20180803085230.30574-3-peter.maydell@linaro.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/vm/freebsd     | 2 +-
 tests/vm/netbsd      | 2 +-
 tests/vm/openbsd     | 2 +-
 tests/vm/ubuntu.i386 | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 039dad8f69..2187a17327 100755
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
index 3972d8b45c..2cc4798f0c 100755
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
index 6ae16d97fd..df6b79fe7d 100755
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
index fc27b6935e..2498fc7570 100755
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
