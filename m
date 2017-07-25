Received: from eggs.gnu.org ([2001:4830:134:3::10]:49152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1da3WI-0004vt-1A
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1da3WE-00025x-1R
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:21:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1da3WD-00025e-RL
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:21:13 -0400
From: Amador Pahim <apahim@redhat.com>
Date: Tue, 25 Jul 2017 19:10:11 +0200
Message-Id: <20170725171014.25193-4-apahim@redhat.com>
In-Reply-To: <20170725171014.25193-1-apahim@redhat.com>
References: <20170725171014.25193-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v5 3/6] qemu.py: cleanup message on negative
 exit code
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

The message contains the self._args, which has only part of the
options used in the qemu command line and is not representative
enough to figure out what happened to the process.

This patch drops the self._args part of the message.

Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index f37e2fe58e..56142ed59b 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -154,7 +154,8 @@ class QEMUMachine(object):
 
             exitcode = self._popen.wait()
             if exitcode < 0:
-                sys.stderr.write('qemu received signal %i: %s\n' % (-exitcode, ' '.join(self.args)))
+                sys.stderr.write('qemu received signal %i\n' % -exitcode)
+
             self._load_io_log()
             self._post_shutdown()
 
-- 
2.13.3
