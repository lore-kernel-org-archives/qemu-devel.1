Received: from eggs.gnu.org ([2001:4830:134:3::10]:32897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dHxEM-00020h-IU
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 14:59:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dHxEL-00087c-7c
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 14:59:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dHxEL-00087B-2C
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 14:59:57 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  5 Jun 2017 15:59:26 -0300
Message-Id: <20170605185927.12111-10-ehabkost@redhat.com>
In-Reply-To: <20170605185927.12111-1-ehabkost@redhat.com>
References: <20170605185927.12111-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 09/10] qemu.py: Add QEMUMachine.exitcode() method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org

Allow the exit code of QEMU to be queried by scripts.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170526181200.17227-3-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 16934f1e02..880e3e8219 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -88,6 +88,11 @@ class QEMUMachine(object):
     def is_running(self):
         return self._popen and (self._popen.returncode is None)
 
+    def exitcode(self):
+        if self._popen is None:
+            return None
+        return self._popen.returncode
+
     def get_pid(self):
         if not self.is_running():
             return None
-- 
2.11.0.259.g40922b1
