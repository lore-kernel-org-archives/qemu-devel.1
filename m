Received: from eggs.gnu.org ([2001:4830:134:3::10]:39747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9ah4-0007Ke-Ux
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:23:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9ah1-0006Uo-TV
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:23:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f9ah1-0006Rt-N3
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:23:31 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 20 Apr 2018 15:19:46 -0300
Message-Id: <20180420181951.7252-20-ehabkost@redhat.com>
In-Reply-To: <20180420181951.7252-1-ehabkost@redhat.com>
References: <20180420181951.7252-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 19/24] avocado_qemu: Clean unneeded 'pass'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Alistair Francis <alistair23@gmail.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>

From: Amador Pahim <apahim@redhat.com>

The docstrings are enough. Let's remove the 'pass' instructions.

Signed-off-by: Amador Pahim <apahim@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/avocado/avocado_qemu/test.py | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tests/avocado/avocado_qemu/test.py b/tests/avocado/avocado_qemu/test.py
index dfffa2a03b..b921151bae 100644
--- a/tests/avocado/avocado_qemu/test.py
+++ b/tests/avocado/avocado_qemu/test.py
@@ -49,42 +49,36 @@ class QEMULoginTimeoutError(Exception):
     """
     If timeout expires
     """
-    pass
 
 
 class QEMULoginAuthenticationError(Exception):
     """
     If authentication fails
     """
-    pass
 
 
 class QEMULoginProcessTerminatedError(Exception):
     """
     If the client terminates during login
     """
-    pass
 
 
 class QEMULoginError(Exception):
     """
     If some other error occurs
     """
-    pass
 
 
 class QEMUConsoleError(Exception):
     """
     If some error with the console access happens
     """
-    pass
 
 
 class QEMUMigrationError(Exception):
     """
     If some error with the migration happens
     """
-    pass
 
 
 def _get_qemu_bin(arch):
-- 
2.14.3
