Received: from eggs.gnu.org ([2001:4830:134:3::10]:36880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTIAR-0004x1-6K
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 20:02:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTIAN-0001gk-NF
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 20:02:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTIAN-0001fD-H4
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 20:02:27 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9031421722
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 01:02:27 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 16 Jan 2017 23:02:01 -0200
Message-Id: <20170117010204.4909-7-ehabkost@redhat.com>
In-Reply-To: <20170117010204.4909-1-ehabkost@redhat.com>
References: <20170117010204.4909-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 6/9] qtest.py: make logging optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Support the 'logging' parameter on QEMUQtestMachine, for test
cases that don't require logging.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Patch originally submitted as part of series:
* [RFC v2 00/20] qmp: Report bus information on 'query-machines'
---
 scripts/qtest.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/qtest.py b/scripts/qtest.py
index 5ac2c69ba8..0496490906 100644
--- a/scripts/qtest.py
+++ b/scripts/qtest.py
@@ -80,11 +80,12 @@ class QEMUQtestMachine(qemu.QEMUMachine):
     '''A QEMU VM'''
 
     def __init__(self, binary, args=[], name=None, test_dir="/var/tmp",
-                 socket_scm_helper=None):
+                 socket_scm_helper=None, logging=True):
         if name is None:
             name = "qemu-%d" % os.getpid()
         super(QEMUQtestMachine, self).__init__(binary, args, name=name, test_dir=test_dir,
-                                               socket_scm_helper=socket_scm_helper)
+                                               socket_scm_helper=socket_scm_helper,
+                                               logging=logging)
         self._qtest_path = os.path.join(test_dir, name + "-qtest.sock")
 
     def _base_args(self):
-- 
2.11.0.259.g40922b1
