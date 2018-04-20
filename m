Received: from eggs.gnu.org ([2001:4830:134:3::10]:38660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9afn-0006C9-Jq
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9afm-0002M7-Mc
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:22:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f9afm-0002KZ-GO
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:22:14 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 20 Apr 2018 15:19:39 -0300
Message-Id: <20180420181951.7252-13-ehabkost@redhat.com>
In-Reply-To: <20180420181951.7252-1-ehabkost@redhat.com>
References: <20180420181951.7252-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 12/24] avocado_qemu: Improve migration error
 message
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

Expose the QMP result on migration error.

Signed-off-by: Amador Pahim <apahim@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/avocado/avocado_qemu/test.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/avocado/avocado_qemu/test.py b/tests/avocado/avocado_qemu/test.py
index f3c7091343..5e42cac8d0 100644
--- a/tests/avocado/avocado_qemu/test.py
+++ b/tests/avocado/avocado_qemu/test.py
@@ -328,7 +328,8 @@ class _VM(qemu.QEMUMachine):
                 logging.info("Migration successful")
                 return True
             elif 'failed' in res['return']:
-                raise QEMUMigrationError("Migration of %s failed" % self)
+                logging.error(res)
+                raise QEMUMigrationError("Migration of %s failed" % self.name)
             return False
 
         port = self.ports.find_free_port()
-- 
2.14.3
