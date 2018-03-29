Received: from eggs.gnu.org ([2001:4830:134:3::10]:33094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fHW-0002p4-JN
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fHT-00026U-3U
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:40:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47383)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f1fHS-00025C-R5
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:40:22 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 29 Mar 2018 18:38:51 -0300
Message-Id: <20180329213857.15499-13-ehabkost@redhat.com>
In-Reply-To: <20180329213857.15499-1-ehabkost@redhat.com>
References: <20180329213857.15499-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 12/18] qemu.py: Only wait for process if it's
 still running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Marcel Apfelbaum <marcel@redhat.com>, Amador Pahim <apahim@redhat.com>

TODO: explain why

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index e19e4b34d0..aaba04b3c1 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -275,7 +275,8 @@ class QEMUMachine(object):
 
     def wait(self):
         '''Wait for the VM to power off'''
-        self._popen.wait()
+        if self.is_running():
+            self._popen.wait()
         self._post_shutdown()
 
     def shutdown(self):
-- 
2.14.3
