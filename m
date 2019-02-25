Received: from eggs.gnu.org ([209.51.188.92]:37826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI5D-0000dw-En
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:22:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI5B-0001KQ-D6
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:22:19 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Feb 2019 16:20:14 +0100
Message-Id: <20190225152053.15976-33-kwolf@redhat.com>
In-Reply-To: <20190225152053.15976-1-kwolf@redhat.com>
References: <20190225152053.15976-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 32/71] iotests.py: Add filter_imgfmt()
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

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190201192935.18394-7-mreitz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index b461f53abf..d80fd7fc2a 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -304,6 +304,16 @@ def filter_img_info(output, filename):
         lines.append(line)
     return '\n'.join(lines)
=20
+def filter_imgfmt(msg):
+    return msg.replace(imgfmt, 'IMGFMT')
+
+def filter_qmp_imgfmt(qmsg):
+    def _filter(key, value):
+        if is_str(value):
+            return filter_imgfmt(value)
+        return value
+    return filter_qmp(qmsg, _filter)
+
 def log(msg, filters=3D[], indent=3DNone):
     '''Logs either a string message or a JSON serializable message (like=
 QMP).
     If indent is provided, JSON serializable messages are pretty-printed=
.'''
--=20
2.20.1
