Received: from eggs.gnu.org ([209.51.188.92]:46621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gkE7a-0005JL-PZ
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:18:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gkE7Z-0004Zu-RF
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:18:38 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 17 Jan 2019 18:17:42 -0200
Message-Id: <20190117201743.20470-9-ehabkost@redhat.com>
In-Reply-To: <20190117201743.20470-1-ehabkost@redhat.com>
References: <20190117201743.20470-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 8/9] qemu.py: Fix error message when qemu dies
 from signal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-trivial@nongnu.org

From: Eric Blake <eblake@redhat.com>

When qemu dies from a signal, the python code gets a negative
value for exitcode; but signal numbers are positive.  Copy the
pattern used in qemu-iotests/iotests.py for reporting a positive
value.

CC: qemu-trivial@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190111201330.14473-1-eblake@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 6e3b0e6771..0a5e02eb56 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -351,7 +351,7 @@ class QEMUMachine(object):
                 command = ' '.join(self._qemu_full_args)
             else:
                 command = ''
-            LOG.warn(msg, exitcode, command)
+            LOG.warn(msg, -exitcode, command)
 
         self._launched = False
 
-- 
2.18.0.rc1.1.g3f1ff2140
