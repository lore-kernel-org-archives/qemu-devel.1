Received: from eggs.gnu.org ([2001:4830:134:3::10]:58432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fM14c-0005pA-V6
	for qemu-devel@nongnu.org; Thu, 24 May 2018 20:59:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fM14Y-0005D2-Bj
	for qemu-devel@nongnu.org; Thu, 24 May 2018 20:59:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51356 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1fM14Y-0005Cl-7A
	for qemu-devel@nongnu.org; Thu, 24 May 2018 20:59:10 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 24 May 2018 20:58:36 -0400
Message-Id: <20180525005839.11556-3-crosa@redhat.com>
In-Reply-To: <20180525005839.11556-1-crosa@redhat.com>
References: <20180525005839.11556-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] scripts/qemu.py: allow adding to the list
 of extra arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Amador Pahim <amador@pahim.org>, Cleber Rosa <crosa@redhat.com>

Tests will often need to add extra arguments to QEMU command
line arguments.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 scripts/qemu.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 08a3e9af5a..7813dd45ad 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -359,3 +359,9 @@ class QEMUMachine(object):
         of the qemu process.
         '''
         return self._iolog
+
+    def add_args(self, *args):
+        '''
+        Adds to the list of extra arguments to be given to the QEMU binary
+        '''
+        return self._args.extend(args)
-- 
2.17.0
