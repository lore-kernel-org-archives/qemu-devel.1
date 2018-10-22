Received: from eggs.gnu.org ([2001:4830:134:3::10]:39562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gEaeE-00034g-9r
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 09:53:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gEaeD-0006Am-66
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 09:53:34 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 22 Oct 2018 14:53:00 +0100
Message-Id: <20181022135307.14398-3-mreitz@redhat.com>
In-Reply-To: <20181022135307.14398-1-mreitz@redhat.com>
References: <20181022135307.14398-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/9] iotests: Flush in iotests.py's
 QemuIoInteractive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>

After issuing a command, flush the pipe.  This does not change anything
in Python 2, but it makes a difference in Python 3.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
---
 tests/qemu-iotests/iotests.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 4e67fbbe96..10f2d17419 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -178,6 +178,7 @@ class QemuIoInteractive:
         cmd = cmd.strip()
         assert cmd != 'q' and cmd != 'quit'
         self._p.stdin.write(cmd + '\n')
+        self._p.stdin.flush()
         return self._read_output()
 
 
-- 
2.17.1
