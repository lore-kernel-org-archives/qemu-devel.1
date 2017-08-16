Received: from eggs.gnu.org ([2001:4830:134:3::10]:43330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhslQ-0006Iq-Qi
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 03:29:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhslN-00051w-JO
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 03:29:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dhslN-000518-DQ
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 03:29:13 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 16 Aug 2017 15:20:58 +0800
Message-Id: <20170816072104.24420-4-famz@redhat.com>
In-Reply-To: <20170816072104.24420-1-famz@redhat.com>
References: <20170816072104.24420-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 3/9] qemu.py: Add "wait()" method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, stefanha@redhat.com, pbonzini@redhat.com, Peter Maydell <peter.maydell@linaro.org>, Kamil Rytarowski <kamil@netbsd.org>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 scripts/qemu.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index e5f314efdb..3e7eb44035 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -144,6 +144,11 @@ class QEMUMachine(object):
             self._post_shutdown()
             raise
 
+    def wait(self):
+        self._popen.wait()
+        self._qmp.close()
+        self._post_shutdown()
+
     def shutdown(self):
         '''Terminate the VM and clean up'''
         if self.is_running():
-- 
2.13.4
