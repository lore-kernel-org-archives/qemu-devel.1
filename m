Received: from eggs.gnu.org ([2001:4830:134:3::10]:40423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1em0uN-0003Ta-Hu
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 12:31:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1em0uJ-0002Gv-KR
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 12:31:51 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 14 Feb 2018 18:31:45 +0100
Message-Id: <1518629505-22480-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] configure: Add missing space when using
 --with-pkgversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

When running configure with --with-pkgversion=foo there is no
space anymore between the version number and the parentheses:

$ m68k-softmmu/qemu-system-m68k -version
QEMU emulator version 2.11.50(foo)

Fix it by moving the space from the configure script to the Makefile.

Fixes: 67a1de0d195a6185c39b436159c9ffc7720bf979
Buglink: https://bugs.launchpad.net/qemu/+bug/1673373
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Makefile  | 2 +-
 configure | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 4ec7a3c..41adbc9 100644
--- a/Makefile
+++ b/Makefile
@@ -369,7 +369,7 @@ qemu-version.h: FORCE
 		(cd $(SRC_PATH); \
 		printf '#define QEMU_PKGVERSION '; \
 		if test -n "$(PKGVERSION)"; then \
-			printf '"$(PKGVERSION)"\n'; \
+			printf '" ($(PKGVERSION))"\n'; \
 		else \
 			if test -d .git; then \
 				printf '" ('; \
diff --git a/configure b/configure
index fe9eea9..1fc687c 100755
--- a/configure
+++ b/configure
@@ -1162,7 +1162,7 @@ for opt do
   ;;
   --disable-blobs) blobs="no"
   ;;
-  --with-pkgversion=*) pkgversion=" ($optarg)"
+  --with-pkgversion=*) pkgversion="$optarg"
   ;;
   --with-coroutine=*) coroutine="$optarg"
   ;;
-- 
1.8.3.1
