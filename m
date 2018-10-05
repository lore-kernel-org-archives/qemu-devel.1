Received: from eggs.gnu.org ([2001:4830:134:3::10]:56890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g8ZiC-0002vp-Aw
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 19:40:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g8ZiB-0007zp-Bv
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 19:40:48 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Sat,  6 Oct 2018 01:39:58 +0200
Message-Id: <20181005234023.8104-7-mreitz@redhat.com>
In-Reply-To: <20181005234023.8104-1-mreitz@redhat.com>
References: <20181005234023.8104-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v11 06/31] iotests.py: Add filter_imgfmt()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 tests/qemu-iotests/iotests.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 4e67fbbe96..5c45788dac 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -246,6 +246,9 @@ def filter_img_info(output, filename):
         lines.append(line)
     return '\n'.join(lines)
 
+def filter_imgfmt(msg):
+    return msg.replace(imgfmt, 'IMGFMT')
+
 def log(msg, filters=[]):
     for flt in filters:
         msg = flt(msg)
-- 
2.17.1
