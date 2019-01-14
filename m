Received: from eggs.gnu.org ([209.51.188.92]:57499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj54R-0003jm-La
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:26:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj54O-0005K4-Pf
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:26:39 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 14 Jan 2019 10:25:51 -0600
Message-Id: <20190114162605.5330-7-eblake@redhat.com>
In-Reply-To: <20190114162605.5330-1-eblake@redhat.com>
References: <20190114162605.5330-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/20] iotests: add filter_generated_node_ids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: John Snow <jsnow@redhat.com>

To mimic the common filter of the same name, but for the python tests.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20181221093529.23855-7-jsnow@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/iotests.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index a34e66813a3..9595429fea2 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -239,6 +239,9 @@ def filter_testfiles(msg):
     prefix =3D os.path.join(test_dir, "%s-" % (os.getpid()))
     return msg.replace(prefix, 'TEST_DIR/PID-')

+def filter_generated_node_ids(msg):
+    return re.sub("#block[0-9]+", "NODE_NAME", msg)
+
 def filter_img_info(output, filename):
     lines =3D []
     for line in output.split('\n'):
--=20
2.20.1
