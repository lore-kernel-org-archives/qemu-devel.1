Received: from eggs.gnu.org ([209.51.188.92]:45867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gkCsA-0006WJ-3m
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:58:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gkCrV-0007dy-0D
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:58:24 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 17 Jan 2019 13:56:11 -0500
Message-Id: <20190117185628.21862-2-crosa@redhat.com>
In-Reply-To: <20190117185628.21862-1-crosa@redhat.com>
References: <20190117185628.21862-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 01/18] scripts/qemu.py: log QEMU launch command
 line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

Even when the launch of QEMU succeeds, it's useful to have the command
line recorded.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 scripts/qemu.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 6e3b0e6771..ec3567d4e2 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -312,6 +312,7 @@ class QEMUMachine(object):
         self._pre_launch()
         self._qemu_full_args =3D (self._wrapper + [self._binary] +
                                 self._base_args() + self._args)
+        LOG.debug('VM launch command: %r', ' '.join(self._qemu_full_args=
))
         self._popen =3D subprocess.Popen(self._qemu_full_args,
                                        stdin=3Ddevnull,
                                        stdout=3Dself._qemu_log_file,
--=20
2.20.1
