Received: from eggs.gnu.org ([2001:4830:134:3::10]:39592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1diAr1-0000Qf-Mp
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 22:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1diAqy-0001dZ-KV
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 22:48:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1diAqy-0001dO-Eq
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 22:48:12 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 17 Aug 2017 10:47:38 +0800
Message-Id: <20170817024746.5961-3-famz@redhat.com>
In-Reply-To: <20170817024746.5961-1-famz@redhat.com>
References: <20170817024746.5961-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v2 02/10] qemu.py: Add variable vga type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

Some guests behave differently when no VGA is detected. Add a variable
to allow override the "none" default.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 scripts/qemu.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 880e3e8219..e5f314efdb 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -39,6 +39,7 @@ class QEMUMachine(object):
         self._iolog = None
         self._socket_scm_helper = socket_scm_helper
         self._debug = debug
+        self._vga = "none"
 
     # This can be used to add an unused monitor instance.
     def add_monitor_telnet(self, ip, port):
@@ -111,7 +112,7 @@ class QEMUMachine(object):
             moncdev = 'socket,id=mon,path=%s' % self._monitor_address
         return ['-chardev', moncdev,
                 '-mon', 'chardev=mon,mode=control',
-                '-display', 'none', '-vga', 'none']
+                '-display', 'none', '-vga', self._vga]
 
     def _pre_launch(self):
         self._qmp = qmp.qmp.QEMUMonitorProtocol(self._monitor_address, server=True,
-- 
2.13.4
