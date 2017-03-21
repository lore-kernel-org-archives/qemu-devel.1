Received: from eggs.gnu.org ([2001:4830:134:3::10]:34526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cqODH-0007mI-6h
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 14:08:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cqODG-0000ou-94
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 14:08:55 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cqODG-0000mw-2t
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 14:08:54 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Mar 2017 18:08:49 +0000
Message-Id: <1490119729-26206-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] configure: Fix cut-n-paste errors in OS
 deprecation warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Thomas Huth <thuth@redhat.com>

Fix some cut-and-paste errors in the OS deprecation warning
pointed out by Thomas Huth.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 configure | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 3291603..d1ce33b 100755
--- a/configure
+++ b/configure
@@ -5144,8 +5144,8 @@ if test "$supported_os" = "no"; then
     echo
     echo "WARNING: SUPPORT FOR THIS HOST OS WILL GO AWAY IN FUTURE RELEASES!"
     echo
-    echo "CPU host OS $targetos support is not currently maintained."
-    echo "The QEMU project intends to remove support for this host CPU in"
+    echo "Host OS $targetos support is not currently maintained."
+    echo "The QEMU project intends to remove support for this host OS in"
     echo "a future release if nobody volunteers to maintain it and to"
     echo "provide a build host for our continuous integration setup."
     echo "configure has succeeded and you can continue to build, but"
-- 
2.7.4
