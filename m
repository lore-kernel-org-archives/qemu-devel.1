Received: from eggs.gnu.org ([2001:4830:134:3::10]:33347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gZ1cU-0006yJ-16
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:44:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gZ1cT-00066D-8g
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:44:13 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 17 Dec 2018 23:43:24 +0100
Message-Id: <20181217224348.14922-8-mreitz@redhat.com>
In-Reply-To: <20181217224348.14922-1-mreitz@redhat.com>
References: <20181217224348.14922-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v12 07/31] iotests.py: Add node_info()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>

This function queries a node; since we cannot do that right now, it
executes query-named-block-nodes and returns the matching node's object.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/iotests.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 0c1b8ad272..ad9e9abad1 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -474,6 +474,13 @@ class VM(qtest.QEMUQtestMachine):
                 else:
                     iotests.log(ev)
=20
+    def node_info(self, node_name):
+        nodes =3D self.qmp('query-named-block-nodes')
+        for x in nodes['return']:
+            if x['node-name'] =3D=3D node_name:
+                return x
+        return None
+
=20
 index_re =3D re.compile(r'([^\[]+)\[([^\]]+)\]')
=20
--=20
2.19.2
