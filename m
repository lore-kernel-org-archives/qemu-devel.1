Received: from eggs.gnu.org ([2001:4830:134:3::10]:34137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dtm2p-0006Ij-DE
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 22:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dtm2o-00059Y-JT
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 22:44:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dtm2o-00059M-DG
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 22:44:22 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 18 Sep 2017 10:43:51 +0800
Message-Id: <20170918024402.3265-3-famz@redhat.com>
In-Reply-To: <20170918024402.3265-1-famz@redhat.com>
References: <20170918024402.3265-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 02/13] qemu.py: Add "wait()" method
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

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 scripts/qemu.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 8c67595ec8..774e201e8b 100644
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
