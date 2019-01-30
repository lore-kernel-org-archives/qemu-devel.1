Received: from eggs.gnu.org ([209.51.188.92]:39846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gorjo-0006b5-Vh
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:25:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gorjm-0005MJ-UR
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:25:16 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 30 Jan 2019 16:24:30 +0100
Message-Id: <20190130152434.17283-7-mreitz@redhat.com>
In-Reply-To: <20190130152434.17283-1-mreitz@redhat.com>
References: <20190130152434.17283-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 06/10] iotests.py: Add is_str()
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

On Python 2.x, strings are not always unicode strings.  This function
checks whether a given value is a plain string, or a unicode string (if
there is a difference).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index f51456fa63..3e91444b79 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -221,6 +221,12 @@ def image_size(img):
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
