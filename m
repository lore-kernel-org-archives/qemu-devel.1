Received: from eggs.gnu.org ([2001:4830:134:3::10]:56683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0CD-0005lN-6l
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0CC-0003Cq-5Z
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dt0CC-00039e-0A
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:52 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 15 Sep 2017 20:37:37 -0300
Message-Id: <20170915233739.26860-14-ehabkost@redhat.com>
In-Reply-To: <20170915233739.26860-1-ehabkost@redhat.com>
References: <20170915233739.26860-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/15] qemu.py: use os.path.null instead of
 /dev/null
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Amador Pahim <apahim@redhat.com>

From: Amador Pahim <apahim@redhat.com>

For increased portability, let's use os.path.devnull.

Signed-off-by: Amador Pahim <apahim@redhat.com>
Message-Id: <20170901112829.2571-4-apahim@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 8d3d24dd2b..c9bcaafe41 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -124,7 +124,7 @@ class QEMUMachine(object):
         fd_param =3D ["%s" % self._socket_scm_helper,
                     "%d" % self._qmp.get_sock_fd(),
                     "%s" % fd_file_path]
-        devnull =3D open('/dev/null', 'rb')
+        devnull =3D open(os.path.devnull, 'rb')
         proc =3D subprocess.Popen(fd_param, stdin=3Ddevnull, stdout=3Dsu=
bprocess.PIPE,
                                 stderr=3Dsubprocess.STDOUT)
         output =3D proc.communicate()[0]
@@ -186,7 +186,7 @@ class QEMUMachine(object):
=20
     def launch(self):
         '''Launch the VM and establish a QMP connection'''
-        devnull =3D open('/dev/null', 'rb')
+        devnull =3D open(os.path.devnull, 'rb')
         qemulog =3D open(self._qemu_log_path, 'wb')
         try:
             self._pre_launch()
--=20
2.13.5
