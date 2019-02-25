Received: from eggs.gnu.org ([209.51.188.92]:37948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI5G-0000i9-KU
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:22:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI5B-0001Ki-FG
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:22:20 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Feb 2019 16:20:15 +0100
Message-Id: <20190225152053.15976-34-kwolf@redhat.com>
In-Reply-To: <20190225152053.15976-1-kwolf@redhat.com>
References: <20190225152053.15976-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 33/71] iotests.py: Add node_info()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

This function queries a node; since we cannot do that right now, it
executes query-named-block-nodes and returns the matching node's object.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20190201192935.18394-8-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index d80fd7fc2a..82dd096c6e 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -543,6 +543,13 @@ class VM(qtest.QEMUQtestMachine):
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
2.20.1
