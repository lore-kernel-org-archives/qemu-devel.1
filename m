Received: from eggs.gnu.org ([2001:4830:134:3::10]:42572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWx1k-0000v8-PH
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWx1j-0004ih-Ug
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dWx1j-0004hJ-OV
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:55 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 17 Jul 2017 11:48:23 +0800
Message-Id: <20170717034825.1524-14-famz@redhat.com>
In-Reply-To: <20170717034825.1524-1-famz@redhat.com>
References: <20170717034825.1524-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/15] docker.py: Drop infile parameter
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

The **kwargs can do this just well.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170712075528.22770-2-famz@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/docker.py | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index e707e5b..f5ac86b 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -112,11 +112,9 @@ class Docker(object):
         signal.signal(signal.SIGTERM, self._kill_instances)
         signal.signal(signal.SIGHUP, self._kill_instances)
=20
-    def _do(self, cmd, quiet=3DTrue, infile=3DNone, **kwargs):
+    def _do(self, cmd, quiet=3DTrue, **kwargs):
         if quiet:
             kwargs["stdout"] =3D DEVNULL
-        if infile:
-            kwargs["stdin"] =3D infile
         return subprocess.call(self._command + cmd, **kwargs)
=20
     def _do_kill_instances(self, only_known, only_active=3DTrue):
@@ -184,7 +182,7 @@ class Docker(object):
     def update_image(self, tag, tarball, quiet=3DTrue):
         "Update a tagged image using "
=20
-        self._do(["build", "-t", tag, "-"], quiet=3Dquiet, infile=3Dtarb=
all)
+        self._do(["build", "-t", tag, "-"], quiet=3Dquiet, stdin=3Dtarba=
ll)
=20
     def image_matches_dockerfile(self, tag, dockerfile):
         try:
--=20
2.9.4
