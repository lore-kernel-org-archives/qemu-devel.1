Received: from eggs.gnu.org ([2001:4830:134:3::10]:42556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dikqX-0000xZ-Tj
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:14:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dikqW-0006DR-W5
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:14:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1dikqW-0006D3-Pm
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:14:08 -0400
From: Amador Pahim <apahim@redhat.com>
Date: Fri, 18 Aug 2017 19:05:18 +0200
Message-Id: <20170818170526.13496-4-apahim@redhat.com>
In-Reply-To: <20170818170526.13496-1-apahim@redhat.com>
References: <20170818170526.13496-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v7 03/11] qemu.py: use os.path.null instead of
 /dev/null
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

For increased portability, let's use os.path.devnull.

Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index ef531bb23b..51545f7f97 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -78,7 +78,7 @@ class QEMUMachine(object):
         fd_param = ["%s" % self._socket_scm_helper,
                     "%d" % self._qmp.get_sock_fd(),
                     "%s" % fd_file_path]
-        devnull = open('/dev/null', 'rb')
+        devnull = open(os.path.devnull, 'rb')
         p = subprocess.Popen(fd_param, stdin=devnull, stdout=subprocess.PIPE,
                              stderr=subprocess.STDOUT)
         output = p.communicate()[0]
@@ -139,7 +139,7 @@ class QEMUMachine(object):
 
     def launch(self):
         '''Launch the VM and establish a QMP connection'''
-        devnull = open('/dev/null', 'rb')
+        devnull = open(os.path.devnull, 'rb')
         qemulog = open(self._qemu_log_path, 'wb')
         try:
             self._pre_launch()
-- 
2.13.5
