Received: from eggs.gnu.org ([209.51.188.92]:39055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gxGhz-0003rQ-HP
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 14:42:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gxGhy-00089m-SD
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 14:42:07 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Fri, 22 Feb 2019 14:41:42 -0500
Message-Id: <20190222194146.13102-4-crosa@redhat.com>
In-Reply-To: <20190222194146.13102-1-crosa@redhat.com>
References: <20190222194146.13102-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/7] scripts/qemu.py: log QEMU launch command
 line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Caio Carrara <ccarrara@redhat.com>

Even when the launch of QEMU succeeds, it's useful to have the command
line recorded.

Reviewed-by: Caio Carrara <ccarrara@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20190202005610.24048-2-crosa@redhat.com>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 python/qemu/__init__.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/python/qemu/__init__.py b/python/qemu/__init__.py
index 38de3e9177..585cd2a1a3 100644
--- a/python/qemu/__init__.py
+++ b/python/qemu/__init__.py
@@ -321,6 +321,7 @@ class QEMUMachine(object):
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
