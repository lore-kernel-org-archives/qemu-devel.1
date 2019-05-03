Received: from eggs.gnu.org ([209.51.188.92]:37829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMHC-0003tX-1T
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMHA-0006vI-7f
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hMMHA-0006v6-2b
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:08 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu,  2 May 2019 21:41:21 -0300
Message-Id: <20190503004130.8285-11-ehabkost@redhat.com>
In-Reply-To: <20190503004130.8285-1-ehabkost@redhat.com>
References: <20190503004130.8285-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/19] tests/boot_linux_console: increase timeout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Cleber Rosa <crosa@redhat.com>

When running on very low powered environments, some tests may time out
causing false negatives.  As a conservative change, and for
considering that human time (investigating false negatives) is worth
more than some extra machine cycles (and time), let's increase the
overall timeout.

CC: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20190312171824.5134-11-crosa@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
index a94f5cd2c8..bfcae3771b 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -19,7 +19,7 @@ class BootLinuxConsole(Test):
     kernel command line is properly passed from QEMU to the kernel
     """
=20
-    timeout =3D 60
+    timeout =3D 90
=20
     KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
=20
--=20
2.18.0.rc1.1.g3f1ff2140
