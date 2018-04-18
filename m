Received: from eggs.gnu.org ([2001:4830:134:3::10]:51471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1f8hs6-0005ao-98
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 03:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1f8hs5-0002Ah-K6
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 03:51:18 -0400
From: Olaf Hering <olaf@aepfle.de>
Date: Wed, 18 Apr 2018 09:50:44 +0200
Message-Id: <20180418075045.27393-1-olaf@aepfle.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1] configure: recognize more rpmbuild macros
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

Extend the list of recognized, but ignored options from rpms %configure
macro. This fixes build on hosts running SUSE Linux.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 configure | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configure b/configure
index 0a19b033bc..6e9b994f21 100755
--- a/configure
+++ b/configure
@@ -959,6 +959,9 @@ for opt do
   ;;
   --firmwarepath=*) firmwarepath="$optarg"
   ;;
+  --host=*|--build=*|\
+  --program-prefix=*|--exec-prefix=*|\
+  --disable-dependency-tracking|\
   --sbindir=*|--sharedstatedir=*|\
   --oldincludedir=*|--datarootdir=*|--infodir=*|--localedir=*|\
   --htmldir=*|--dvidir=*|--pdfdir=*|--psdir=*)
