Received: from eggs.gnu.org ([2001:4830:134:3::10]:45703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fRGXw-00085e-4F
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fRGXt-00056y-09
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:31:12 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  8 Jun 2018 09:29:47 -0300
Message-Id: <20180608122952.2009-6-ehabkost@redhat.com>
In-Reply-To: <20180608122952.2009-1-ehabkost@redhat.com>
References: <20180608122952.2009-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 05/10] python: futurize -f
 lib2to3.fixes.fix_standarderror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-block@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Juan Quintela <quintela@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Rename StandardError to Exception.

This is necessary for Python 3 compatibility.

Done using:

  $ py=$( (g grep -l -E '^#!.*python';find -name '*.py' -printf '%P\n';) | \
    sort -u | grep -v README.sh4)
  $ futurize -w -f lib2to3.fixes.fix_standarderror $py

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
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
