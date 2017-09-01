Received: from eggs.gnu.org ([2001:4830:134:3::10]:59753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dnkB6-0001KN-6T
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:32:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dnkB5-0006zA-Da
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:32:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1dnkB5-0006yv-8A
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:31:59 -0400
From: Amador Pahim <apahim@redhat.com>
Date: Fri,  1 Sep 2017 13:28:25 +0200
Message-Id: <20170901112829.2571-10-apahim@redhat.com>
In-Reply-To: <20170901112829.2571-1-apahim@redhat.com>
References: <20170901112829.2571-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v8 09/13] qemu.py: always cleanup on shutdown()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, famz@redhat.com, berrange@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, crosa@redhat.com, ldoktor@redhat.com, Amador Pahim <apahim@redhat.com>

Currently we only cleanup on shutdown() if the VM is running.

To make sure we will always cleanup, this patch makes the cleanup to
always happen in shutdown, regardless the VM running state.

Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 06f07bfaa2..ede734328b 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -205,8 +205,8 @@ class QEMUMachine(object):
                 self._popen.kill()
             self._popen.wait()
 
-            self._load_io_log()
-            self._post_shutdown()
+        self._load_io_log()
+        self._post_shutdown()
 
         exitcode = self.exitcode()
         if exitcode is not None and exitcode < 0:
-- 
2.13.5
