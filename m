Received: from eggs.gnu.org ([2001:4830:134:3::10]:43573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnQOt-00086r-6m
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnQOs-0007gQ-G0
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:24:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dnQOs-0007gA-9m
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:24:54 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 31 Aug 2017 15:24:30 +0100
Message-Id: <20170831142430.16665-6-berrange@redhat.com>
In-Reply-To: <20170831142430.16665-1-berrange@redhat.com>
References: <20170831142430.16665-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 5/5] qapi: Adapt to moved location of
 'maketrans' function in py3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, "Daniel P. Berrange" <berrange@redhat.com>

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 scripts/qapi.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 3c06711e2c..853622badd 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1743,7 +1743,10 @@ def c_enum_const(type_name, const_name, prefix=None):
         type_name = prefix
     return camel_to_upper(type_name) + '_' + c_name(const_name, False).upper()
 
-c_name_trans = string.maketrans('.-', '__')
+if hasattr(str, 'maketrans'):
+    c_name_trans = str.maketrans('.-', '__')
+else:
+    c_name_trans = string.maketrans('.-', '__')
 
 
 # Map @name to a valid C identifier.
-- 
2.13.5
