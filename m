Received: from eggs.gnu.org ([209.51.188.92]:55131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqZZl-000506-FF
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 03:25:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqZZk-0006NJ-LO
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 03:25:57 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon,  4 Feb 2019 09:25:43 +0100
Message-Id: <1549268743-18502-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] tests/docker/test-mingw and docs: Remove
 --with-sdlabi=2.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-trivial@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

Patchew currently reports failures with the mingw docker test - this
is due to --with-sdlabi=2.0 configure flag which does not exist anymore.
Remove this remainder from the docker test and the docs now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/multiseat.txt      | 2 +-
 tests/docker/test-mingw | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/docs/multiseat.txt b/docs/multiseat.txt
index 8dde36c..11850c9 100644
--- a/docs/multiseat.txt
+++ b/docs/multiseat.txt
@@ -9,7 +9,7 @@ First you must compile qemu with a user interface supporting
 multihead/multiseat and input event routing.  Right now this
 list includes sdl2, gtk (both 2+3) and vnc:
 
-  ./configure --enable-sdl --with-sdlabi=2.0
+  ./configure --enable-sdl
 
 or
 
diff --git a/tests/docker/test-mingw b/tests/docker/test-mingw
index b078f22..4b84cfe 100755
--- a/tests/docker/test-mingw
+++ b/tests/docker/test-mingw
@@ -27,8 +27,7 @@ for prefix in x86_64-w64-mingw32- i686-w64-mingw32-; do
         --enable-curl \
         --enable-vnc \
         --enable-bzip2 \
-        --enable-guest-agent \
-        --with-sdlabi=2.0
+        --enable-guest-agent
     install_qemu
     make clean
 
-- 
1.8.3.1
