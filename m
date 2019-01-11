Received: from eggs.gnu.org ([209.51.188.92]:49911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gi3BS-000183-0O
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 15:13:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gi3BR-0003oG-Aj
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 15:13:37 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri, 11 Jan 2019 14:13:30 -0600
Message-Id: <20190111201330.14473-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] qemu.py: Fix error message when qemu dies from
 signal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

When qemu dies from a signal, the python code gets a negative
value for exitcode; but signal numbers are positive.  Copy the
pattern used in qemu-iotests/iotests.py for reporting a positive
value.

CC: qemu-trivial@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 scripts/qemu.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 6e3b0e67719..0a5e02eb56e 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -351,7 +351,7 @@ class QEMUMachine(object):
                 command =3D ' '.join(self._qemu_full_args)
             else:
                 command =3D ''
-            LOG.warn(msg, exitcode, command)
+            LOG.warn(msg, -exitcode, command)

         self._launched =3D False

--=20
2.20.1
