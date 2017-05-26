Received: from eggs.gnu.org ([2001:4830:134:3::10]:57729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dEJig-0003qy-K9
	for qemu-devel@nongnu.org; Fri, 26 May 2017 14:12:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dEJif-0003fa-P9
	for qemu-devel@nongnu.org; Fri, 26 May 2017 14:12:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dEJif-0003fO-J6
	for qemu-devel@nongnu.org; Fri, 26 May 2017 14:12:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0C764E02D
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 18:12:12 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 26 May 2017 15:11:59 -0300
Message-Id: <20170526181200.17227-3-ehabkost@redhat.com>
In-Reply-To: <20170526181200.17227-1-ehabkost@redhat.com>
References: <20170526181200.17227-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/3] qemu.py: Add QEMUMachine.exitcode()
 method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>

Allow the exit code of QEMU to be queried by scripts.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 16934f1e02..ebe1c4b919 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -88,6 +88,10 @@ class QEMUMachine(object):
     def is_running(self):
         return self._popen and (self._popen.returncode is None)
 
+    def exitcode(self):
+        if self._popen:
+            return self._popen.returncode
+
     def get_pid(self):
         if not self.is_running():
             return None
-- 
2.11.0.259.g40922b1
