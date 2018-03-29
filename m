Received: from eggs.gnu.org ([2001:4830:134:3::10]:33176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fHf-000318-6U
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:40:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fHc-0002NB-3v
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:40:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f1fHb-0002Ly-VJ
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:40:32 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 29 Mar 2018 18:38:54 -0300
Message-Id: <20180329213857.15499-16-ehabkost@redhat.com>
In-Reply-To: <20180329213857.15499-1-ehabkost@redhat.com>
References: <20180329213857.15499-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 15/18] qemu.py: qmp_obj() method
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

A wrapper for the QEMUMonitorProtocol.cmd_obj() method.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 00b44ea0f4..d25fe030bb 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -311,6 +311,9 @@ class QEMUMachine(object):
 
         return self._qmp.cmd(cmd, args=qmp_args)
 
+    def qmp_obj(self, *args, **kwargs):
+        return self._qmp.cmd_obj(*args, **kwargs)
+
     def command(self, cmd, conv_keys=True, **args):
         '''
         Invoke a QMP command.
-- 
2.14.3
