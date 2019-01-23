Received: from eggs.gnu.org ([209.51.188.92]:48853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmJoF-0000EO-1t
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:47:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmJoA-0000bw-RU
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:47:17 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 23 Jan 2019 15:46:08 +0100
Message-Id: <20190123144610.8842-8-mreitz@redhat.com>
In-Reply-To: <20190123144610.8842-1-mreitz@redhat.com>
References: <20190123144610.8842-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 7/9] iotests.py: Filter filename in any string
 value
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

filter_qmp_testfiles() currently filters the filename only for specific
keys.  However, there are more keys that take filenames (such as
block-commit's @top and @base, or ssh's @path), and it does not make
sense to list them all here.  "$TEST_DIR/$PID-" should have enough
entropy not to appear anywhere randomly.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 29e4e3306f..b6cb73e108 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -274,7 +274,7 @@ def filter_testfiles(msg):
=20
 def filter_qmp_testfiles(qmsg):
     def _filter(key, value):
-        if key =3D=3D 'filename' or key =3D=3D 'backing-file':
+        if is_str(value):
             return filter_testfiles(value)
         return value
     return filter_qmp(qmsg, _filter)
--=20
2.20.1
