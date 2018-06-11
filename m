Received: from eggs.gnu.org ([2001:4830:134:3::10]:60601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQqK-0001pc-Lj
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:43:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQqG-0000Fo-KB
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:43:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSQqG-0000FJ-DC
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:42:56 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 11 Jun 2018 14:42:35 -0300
Message-Id: <20180611174243.31070-6-ehabkost@redhat.com>
In-Reply-To: <20180611174243.31070-1-ehabkost@redhat.com>
References: <20180611174243.31070-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 05/13] python: futurize -f
 lib2to3.fixes.fix_standarderror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Rename StandardError to Exception.

This is necessary for Python 3 compatibility.

Done using:

  $ py=$( (g grep -l -E '^#!.*python';find -name '*.py' -printf '%P\n';) | \
    sort -u | grep -v README.sh4)
  $ futurize -w -f lib2to3.fixes.fix_standarderror $py

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20180608122952.2009-6-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qmp/qemu-ga-client | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/qmp/qemu-ga-client b/scripts/qmp/qemu-ga-client
index 6045fcd3f2..976e69e05f 100755
--- a/scripts/qmp/qemu-ga-client
+++ b/scripts/qmp/qemu-ga-client
@@ -137,7 +137,7 @@ class QemuGuestAgentClient:
 
     def fsfreeze(self, cmd):
         if cmd not in ['status', 'freeze', 'thaw']:
-            raise StandardError('Invalid command: ' + cmd)
+            raise Exception('Invalid command: ' + cmd)
 
         return getattr(self.qga, 'fsfreeze' + '_' + cmd)()
 
@@ -146,7 +146,7 @@ class QemuGuestAgentClient:
 
     def suspend(self, mode):
         if mode not in ['disk', 'ram', 'hybrid']:
-            raise StandardError('Invalid mode: ' + mode)
+            raise Exception('Invalid mode: ' + mode)
 
         try:
             getattr(self.qga, 'suspend' + '_' + mode)()
@@ -157,7 +157,7 @@ class QemuGuestAgentClient:
 
     def shutdown(self, mode='powerdown'):
         if mode not in ['powerdown', 'halt', 'reboot']:
-            raise StandardError('Invalid mode: ' + mode)
+            raise Exception('Invalid mode: ' + mode)
 
         try:
             self.qga.shutdown(mode=mode)
-- 
2.18.0.rc1.1.g3f1ff2140
