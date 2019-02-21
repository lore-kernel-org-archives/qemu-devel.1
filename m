Received: from eggs.gnu.org ([209.51.188.92]:32869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gwcgj-0005ex-Q3
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 19:58:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gwcgj-0000tS-41
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 19:58:09 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Wed, 20 Feb 2019 19:57:34 -0500
Message-Id: <20190221005753.27955-2-crosa@redhat.com>
In-Reply-To: <20190221005753.27955-1-crosa@redhat.com>
References: <20190221005753.27955-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 01/20] scripts/qemu.py: log QEMU launch
 command line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Caio Carrara <ccarrara@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>, Cornelia Huck <cohuck@redhat.com>

Even when the launch of QEMU succeeds, it's useful to have the command
line recorded.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Caio Carrara <ccarrara@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 scripts/qemu.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 32b00af5cc..ee85309923 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -320,6 +320,7 @@ class QEMUMachine(object):
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
