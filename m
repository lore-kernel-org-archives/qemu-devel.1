Received: from eggs.gnu.org ([2001:4830:134:3::10]:59591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dnkAh-0000zI-AY
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dnkAe-0006mb-62
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:31:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1dnkAd-0006mM-W7
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:31:32 -0400
From: Amador Pahim <apahim@redhat.com>
Date: Fri,  1 Sep 2017 13:28:19 +0200
Message-Id: <20170901112829.2571-4-apahim@redhat.com>
In-Reply-To: <20170901112829.2571-1-apahim@redhat.com>
References: <20170901112829.2571-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v8 03/13] qemu.py: use os.path.null instead of
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
index aca6fa4d82..a6e06291ea 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -79,7 +79,7 @@ class QEMUMachine(object):
         fd_param = ["%s" % self._socket_scm_helper,
                     "%d" % self._qmp.get_sock_fd(),
                     "%s" % fd_file_path]
-        devnull = open('/dev/null', 'rb')
+        devnull = open(os.path.devnull, 'rb')
         p = subprocess.Popen(fd_param, stdin=devnull, stdout=subprocess.PIPE,
                              stderr=subprocess.STDOUT)
         output = p.communicate()[0]
@@ -140,7 +140,7 @@ class QEMUMachine(object):
 
     def launch(self):
         '''Launch the VM and establish a QMP connection'''
-        devnull = open('/dev/null', 'rb')
+        devnull = open(os.path.devnull, 'rb')
         qemulog = open(self._qemu_log_path, 'wb')
         try:
             self._pre_launch()
-- 
2.13.5
