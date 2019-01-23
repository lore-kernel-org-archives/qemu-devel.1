Received: from eggs.gnu.org ([209.51.188.92]:48666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmJo6-00005m-3s
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:47:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmJo0-0000PB-29
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:47:10 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 23 Jan 2019 15:46:07 +0100
Message-Id: <20190123144610.8842-7-mreitz@redhat.com>
In-Reply-To: <20190123144610.8842-1-mreitz@redhat.com>
References: <20190123144610.8842-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 6/9] iotests.py: Add is_str()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

Strings can have various representations, this helper function checks
whether a given value is in any of them.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index f51456fa63..29e4e3306f 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -221,6 +221,12 @@ def image_size(img):
     r =3D qemu_img_pipe('info', '--output=3Djson', '-f', imgfmt, img)
     return json.loads(r)['virtual-size']
=20
+def is_str(val):
+    if sys.version_info.major >=3D 3:
+        return isinstance(val, str) or isinstance(val, bytes)
+    else:
+        return isinstance(val, str) or isinstance(val, unicode)
+
 test_dir_re =3D re.compile(r"%s" % test_dir)
 def filter_test_dir(msg):
     return test_dir_re.sub("TEST_DIR", msg)
--=20
2.20.1
