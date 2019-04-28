Received: from eggs.gnu.org ([209.51.188.92]:52514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hKm9O-0007zA-2i
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 11:55:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hKm9M-00052j-S2
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 11:55:33 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Sun, 28 Apr 2019 17:54:48 +0200
Message-Id: <20190428155451.15653-6-thuth@redhat.com>
In-Reply-To: <20190428155451.15653-1-thuth@redhat.com>
References: <20190428155451.15653-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 5/8] cirrus / travis: Add gnu-sed and bash
 for macOS and FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Ed Maste <emaste@freebsd.org>, Christophe Fergeau <cfergeau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

We are going to enable the qemu-iotests during "make check" again,
and for running the iotests, we need bash and gnu-sed.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .cirrus.yml | 4 ++--
 .travis.yml | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index 47ef5bc604..8326a3a4b1 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -7,7 +7,7 @@ freebsd_12_task:
     cpu: 8
     memory: 8G
   install_script: pkg install -y
-    bison curl cyrus-sasl git glib gmake gnutls
+    bash bison curl cyrus-sasl git glib gmake gnutls gsed
     nettle perl5 pixman pkgconf png usbredir
   script:
     - mkdir build
@@ -20,7 +20,7 @@ macos_task:
   osx_instance:
     image: mojave-base
   install_script:
-    - brew install pkg-config python glib pixman make sdl2
+    - brew install pkg-config python gnu-sed glib pixman make sdl2
   script:
     - ./configure --python=3D/usr/local/bin/python3 || { cat config.log;=
 exit 1; }
     - gmake -j$(sysctl -n hw.ncpu)
diff --git a/.travis.yml b/.travis.yml
index 2e06aee9d0..ba94644192 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -42,6 +42,7 @@ addons:
     packages:
       - glib
       - pixman
+      - gnu-sed
=20
=20
 # The channel name "irc.oftc.net#qemu" is encrypted against qemu/qemu
--=20
2.21.0
