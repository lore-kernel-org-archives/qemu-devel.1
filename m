Received: from eggs.gnu.org ([2001:4830:134:3::10]:57032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpmFY-0007Ic-9H
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpmFW-0001dD-Hx
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35486 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fpmFW-0001ai-4P
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:30 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 15 Aug 2018 11:12:46 +0800
Message-Id: <20180815031248.14908-16-famz@redhat.com>
In-Reply-To: <20180815031248.14908-1-famz@redhat.com>
References: <20180815031248.14908-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 15/17] tests/vm: Use make's --output-sync option
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

Use make's --output-sync option when running tests inside VMs,
so that if we're building with parallelization the output doesn't
get scrambled.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20180803085230.30574-6-peter.maydell@linaro.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/vm/freebsd     | 4 ++--
 tests/vm/netbsd      | 4 ++--
 tests/vm/openbsd     | 4 ++--
 tests/vm/ubuntu.i386 | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 795f739c7b..0a6ec4614a 100755
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
index c211672bcb..45c9260dc0 100755
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
index 1e0c2500ad..98edfbca4b 100755
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
index 160b9be034..3f6ed48b74 100755
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
