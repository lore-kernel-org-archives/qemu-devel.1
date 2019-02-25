Received: from eggs.gnu.org ([209.51.188.92]:38783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI68-0001eu-1Q
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:23:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI67-000221-5r
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:23:15 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Feb 2019 16:20:45 +0100
Message-Id: <20190225152053.15976-64-kwolf@redhat.com>
In-Reply-To: <20190225152053.15976-1-kwolf@redhat.com>
References: <20190225152053.15976-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 63/71] iotests.py: Add is_str()
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

On Python 2.x, strings are not always unicode strings.  This function
checks whether a given value is a plain string, or a unicode string (if
there is a difference).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20190210145736.1486-7-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 82dd096c6e..52fc77563c 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -236,6 +236,12 @@ def image_size(img):
     r =3D qemu_img_pipe('info', '--output=3Djson', '-f', imgfmt, img)
     return json.loads(r)['virtual-size']
=20
+def is_str(val):
+    if sys.version_info.major >=3D 3:
+        return isinstance(val, str)
+    else:
+        return isinstance(val, str) or isinstance(val, unicode)
+
 test_dir_re =3D re.compile(r"%s" % test_dir)
 def filter_test_dir(msg):
     return test_dir_re.sub("TEST_DIR", msg)
--=20
2.20.1
