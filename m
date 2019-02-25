Received: from eggs.gnu.org ([209.51.188.92]:38826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI6C-0001jC-CM
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:23:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI69-00023q-VY
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:23:20 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Feb 2019 16:20:46 +0100
Message-Id: <20190225152053.15976-65-kwolf@redhat.com>
In-Reply-To: <20190225152053.15976-1-kwolf@redhat.com>
References: <20190225152053.15976-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 64/71] iotests.py: Filter filename in any string
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

filter_qmp_testfiles() currently filters the filename only for specific
keys.  However, there are more keys that take filenames (such as
block-commit's @top and @base, or ssh's @path), and it does not make
sense to list them all here.  "$TEST_DIR/$PID-" should have enough
entropy not to appear anywhere randomly.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20190210145736.1486-8-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 52fc77563c..cba91a9927 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -289,7 +289,7 @@ def filter_testfiles(msg):
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
