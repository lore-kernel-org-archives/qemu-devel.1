Received: from eggs.gnu.org ([2001:4830:134:3::10]:60944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1f8oUE-0007NB-99
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:55:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1f8oUD-0003Nx-K0
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:55:06 -0400
From: Olaf Hering <olaf@aepfle.de>
Date: Wed, 18 Apr 2018 16:54:43 +0200
Message-Id: <20180418145443.6332-1-olaf@aepfle.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] configure: require glib-2.24 on Linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: Olaf Hering <olaf@aepfle.de>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>

Since usage of g_realloc_n was introduced, glib-2.22 can not be used
anymore on Linux. Leave non-Linux unchanged because one developer system
still uses it.
Fixes commit 418026ca43 ("util: Introduce vfio helpers")

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 configure | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 6e9b994f21..ca19a66726 100755
--- a/configure
+++ b/configure
@@ -3369,7 +3369,11 @@ fi
 if test "$mingw32" = yes; then
     glib_req_ver=2.30
 else
-    glib_req_ver=2.22
+    if test "$targetos" = Linux; then
+       glib_req_ver=2.24
+    else
+       glib_req_ver=2.22
+    fi
 fi
 glib_modules=gthread-2.0
 if test "$modules" = yes; then
