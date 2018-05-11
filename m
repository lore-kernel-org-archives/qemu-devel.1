Received: from eggs.gnu.org ([2001:4830:134:3::10]:41218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fHGQA-000276-9t
	for qemu-devel@nongnu.org; Fri, 11 May 2018 18:21:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fHGQ9-0004RW-ES
	for qemu-devel@nongnu.org; Fri, 11 May 2018 18:21:50 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 11 May 2018 19:20:47 -0300
Message-Id: <20180511222052.8734-6-ehabkost@redhat.com>
In-Reply-To: <20180511222052.8734-1-ehabkost@redhat.com>
References: <20180511222052.8734-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 05/10] python: futurize -f
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org

Rename StandardError to Exception.

This is necessary for Python 3 compatibility.

Done using:

  $ py=$( (g grep -l -E '^#!.*python';find -name '*.py' -printf '%P\n';) | \
    sort -u | grep -v README.sh4)
  $ futurize -w -f lib2to3.fixes.fix_standarderror $py

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
2.14.3
