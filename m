Received: from eggs.gnu.org ([2001:4830:134:3::10]:50742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKp4D-0004BQ-JU
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKp4C-0000NZ-AR
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dKp4C-0000NF-4n
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:20 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 13 Jun 2017 13:53:00 -0300
Message-Id: <20170613165313.20954-3-ehabkost@redhat.com>
In-Reply-To: <20170613165313.20954-1-ehabkost@redhat.com>
References: <20170613165313.20954-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 02/15] error: New IGNORE_ERRORS macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Define new IGNORE_ERRORS macro that should be used when errors will be
ignored.

NULL will still work by now, but will break once we implement
IGNORE_ERRORS in a different way later.  Other patches will convert
existing code to use IGNORE_ERRORS.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qapi/error.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index 7e532d00e9..38f7afba2e 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -66,7 +66,7 @@
  *     }
  *
  * Call a function ignoring errors:
- *     foo(arg, NULL);
+ *     foo(arg, IGNORE_ERRORS);
  *
  * Call a function aborting on errors:
  *     foo(arg, &error_abort);
@@ -117,6 +117,8 @@
 
 #include "qapi-types.h"
 
+#define IGNORE_ERRORS (NULL)
+
 /*
  * Overall category of an error.
  * Based on the qapi type QapiErrorClass, but reproduced here for nicer
-- 
2.11.0.259.g40922b1
