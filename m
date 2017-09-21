Received: from eggs.gnu.org ([2001:4830:134:3::10]:58251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dv35g-0007nl-7m
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:08:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dv35c-0002z9-Qn
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:08:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64143)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dv35c-0002xa-KT
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:08:32 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 21 Sep 2017 23:07:44 +0800
Message-Id: <20170921150755.19914-3-famz@redhat.com>
In-Reply-To: <20170921150755.19914-1-famz@redhat.com>
References: <20170921150755.19914-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v11 02/13] qemu.py: Add "wait()" method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 scripts/qemu.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 5e02dd8e78..2b5c2accb5 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -215,6 +215,13 @@ class QEMUMachine(object):
                 LOG.debug('Output: %r', self._iolog)
             raise
=20
+    def wait(self):
+        '''Wait for the VM to power off'''
+        self._popen.wait()
+        self._qmp.close()
+        self._load_io_log()
+        self._post_shutdown()
+
     def shutdown(self):
         '''Terminate the VM and clean up'''
         if self.is_running():
--=20
2.13.5
