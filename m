Received: from eggs.gnu.org ([2001:4830:134:3::10]:33210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fHk-00035x-Gg
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fHj-0002e5-H1
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:40:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f1fHj-0002c5-At
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:40:39 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 29 Mar 2018 18:38:55 -0300
Message-Id: <20180329213857.15499-17-ehabkost@redhat.com>
In-Reply-To: <20180329213857.15499-1-ehabkost@redhat.com>
References: <20180329213857.15499-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 16/18] qemu.py: is_launched() method
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

Useful if some code gets a QEMUMachine object in unknown state,
and wants to launch it only if necessary.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index d25fe030bb..d32b923a15 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -236,6 +236,9 @@ class QEMUMachine(object):
 
         self._launched = False
 
+    def is_launched(self):
+        return self._launched
+
     def launch(self):
         """
         Launch the VM and make sure we cleanup and expose the
-- 
2.14.3
