Received: from eggs.gnu.org ([2001:4830:134:3::10]:36881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTIAR-0004x2-6c
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 20:02:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTIAP-0001jp-Ot
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 20:02:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTIAP-0001iN-IW
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 20:02:29 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A4EFF811D8
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 01:02:29 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 16 Jan 2017 23:02:02 -0200
Message-Id: <20170117010204.4909-8-ehabkost@redhat.com>
In-Reply-To: <20170117010204.4909-1-ehabkost@redhat.com>
References: <20170117010204.4909-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 7/9] qtest.py: Make 'binary' parameter optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

If the 'binary' parameter is omitted, use the $QTEST_QEMU_BINARY
environment variable.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Patch originally submitted as part of series:
* [RFC v2 00/20] qmp: Report bus information on 'query-machines'
---
 scripts/qtest.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/qtest.py b/scripts/qtest.py
index 0496490906..5a37b48143 100644
--- a/scripts/qtest.py
+++ b/scripts/qtest.py
@@ -79,8 +79,10 @@ class QEMUQtestProtocol(object):
 class QEMUQtestMachine(qemu.QEMUMachine):
     '''A QEMU VM'''
 
-    def __init__(self, binary, args=[], name=None, test_dir="/var/tmp",
+    def __init__(self, binary=None, args=[], name=None, test_dir="/var/tmp",
                  socket_scm_helper=None, logging=True):
+        if binary is None:
+            binary = os.getenv('QTEST_QEMU_BINARY')
         if name is None:
             name = "qemu-%d" % os.getpid()
         super(QEMUQtestMachine, self).__init__(binary, args, name=name, test_dir=test_dir,
-- 
2.11.0.259.g40922b1
