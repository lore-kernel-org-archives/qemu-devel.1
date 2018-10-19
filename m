Received: from eggs.gnu.org ([2001:4830:134:3::10]:55293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gDSFl-0003oF-LP
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gDSFi-0006KP-Fx
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:43:37 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gDSFh-0006Ij-Qs
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:43:34 -0400
Received: by mail-wr1-x442.google.com with SMTP id w5-v6so36888524wrt.2
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 03:43:33 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 19 Oct 2018 11:43:26 +0100
Message-Id: <20181019104326.28052-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] configure: set cross_cc_FOO from cc,
 not host_cc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The purpose of the code is to use the designated compiler for building
the targets test cases. This is not actually host_cc which will still
be cc even when we are cross compiling. As the tests for $cpu all use
$cc we should do the same.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reported-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/configure b/configure
index 9138af37f8..d6605bd633 100755
--- a/configure
+++ b/configure
@@ -717,37 +717,37 @@ case "$cpu" in
   ppc|ppc64|s390|s390x|sparc64|x32)
     cpu="$cpu"
     supported_cpu="yes"
-    eval "cross_cc_${cpu}=\$host_cc"
+    eval "cross_cc_${cpu}=\$cc"
   ;;
   i386|i486|i586|i686|i86pc|BePC)
     cpu="i386"
     supported_cpu="yes"
-    cross_cc_i386=$host_cc
+    cross_cc_i386=$cc
   ;;
   x86_64|amd64)
     cpu="x86_64"
     supported_cpu="yes"
-    cross_cc_x86_64=$host_cc
+    cross_cc_x86_64=$cc
   ;;
   armv*b|armv*l|arm)
     cpu="arm"
     supported_cpu="yes"
-    cross_cc_arm=$host_cc
+    cross_cc_arm=$cc
   ;;
   aarch64)
     cpu="aarch64"
     supported_cpu="yes"
-    cross_cc_aarch64=$host_cc
+    cross_cc_aarch64=$cc
   ;;
   mips*)
     cpu="mips"
     supported_cpu="yes"
-    cross_cc_mips=$host_cc
+    cross_cc_mips=$cc
   ;;
   sparc|sun4[cdmuv])
     cpu="sparc"
     supported_cpu="yes"
-    cross_cc_sparc=$host_cc
+    cross_cc_sparc=$cc
   ;;
   *)
     # This will result in either an error or falling back to TCI later
-- 
2.17.1
