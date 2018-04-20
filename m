Received: from eggs.gnu.org ([2001:4830:134:3::10]:38615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9afi-00066z-Ii
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9afh-00025K-MW
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:22:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f9afh-00023v-GL
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:22:09 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 20 Apr 2018 15:19:38 -0300
Message-Id: <20180420181951.7252-12-ehabkost@redhat.com>
In-Reply-To: <20180420181951.7252-1-ehabkost@redhat.com>
References: <20180420181951.7252-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 11/24] avocado_qemu: Fix exception name in caller
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

There's a exception name mismatch when callin `QEMUMigrationError`.
Fixing.

Signed-off-by: Amador Pahim <apahim@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/avocado/avocado_qemu/test.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/avocado/avocado_qemu/test.py b/tests/avocado/avocado_qemu/test.py
index 57c63b2853..f3c7091343 100644
--- a/tests/avocado/avocado_qemu/test.py
+++ b/tests/avocado/avocado_qemu/test.py
@@ -328,7 +328,7 @@ class _VM(qemu.QEMUMachine):
                 logging.info("Migration successful")
                 return True
             elif 'failed' in res['return']:
-                raise QEMUMigrateError("Migration of %s failed" % self)
+                raise QEMUMigrationError("Migration of %s failed" % self)
             return False
 
         port = self.ports.find_free_port()
@@ -343,8 +343,8 @@ class _VM(qemu.QEMUMachine):
                                    text='Waiting for migration to complete')
 
         if mig_result is None:
-            raise QEMUMigrateError("Migration of %s did not complete after "
-                                   "%s s" % (self.name, timeout))
+            raise QEMUMigrationError("Migration of %s did not complete after "
+                                     "%s s" % (self.name, timeout))
 
         return newvm
 
-- 
2.14.3
