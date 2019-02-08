Received: from eggs.gnu.org ([209.51.188.92]:44522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gsCuG-0007IF-5t
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:37:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gsCuF-0002h8-Bl
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:37:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gsCuD-0002fY-BL
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:37:51 -0500
From: marcandre.lureau@redhat.com
Date: Fri,  8 Feb 2019 19:11:22 +0100
Message-Id: <20190208181122.23393-6-marcandre.lureau@redhat.com>
In-Reply-To: <20190208181122.23393-1-marcandre.lureau@redhat.com>
References: <20190208181122.23393-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH slirp 5/5] Add .gitlab-ci.yml
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 .gitlab-ci.yml | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 .gitlab-ci.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
new file mode 100644
index 0000000..71fda28
--- /dev/null
+++ b/.gitlab-ci.yml
@@ -0,0 +1,20 @@
+image: fedora:latest
+
+variables:
+  DEPS: meson ninja-build
+        gcc pkg-config glib2-devel
+        mingw64-gcc mingw64-pkg-config mingw64-glib2
+
+before_script:
+  - dnf install -y $DEPS
+
+build:
+  script:
+    - meson build || (cat build/meson-logs/meson-log.txt && exit 1)
+    - ninja -C build
+    - (cd build && meson test) || (cat build/meson-logs/testlog.txt && e=
xit 1)
+
+build-mingw64:
+  script:
+    - (mkdir buildw && cd buildw && mingw64-meson) || (cat buildw/meson-=
logs/meson-log.txt && exit 1)
+    - ninja -C buildw
--=20
2.21.0.rc0.1.g036caf7885
