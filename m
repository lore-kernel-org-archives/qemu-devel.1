Received: from eggs.gnu.org ([209.51.188.92]:46464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpeVl-0005gl-1V
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:30:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpeVi-0002IL-Tp
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:30:00 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri,  1 Feb 2019 20:29:10 +0100
Message-Id: <20190201192935.18394-7-mreitz@redhat.com>
In-Reply-To: <20190201192935.18394-1-mreitz@redhat.com>
References: <20190201192935.18394-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v13 06/31] iotests.py: Add filter_imgfmt()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index c323c62d20..8c5dd40f83 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -312,6 +312,16 @@ def filter_img_info(output, filename):
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
