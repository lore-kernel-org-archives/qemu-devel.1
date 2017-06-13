Received: from eggs.gnu.org ([2001:4830:134:3::10]:50836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKp4S-0004M0-8R
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKp4R-0000RL-GY
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dKp4R-0000RC-AS
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:35 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 13 Jun 2017 13:53:06 -0300
Message-Id: <20170613165313.20954-9-ehabkost@redhat.com>
In-Reply-To: <20170613165313.20954-1-ehabkost@redhat.com>
References: <20170613165313.20954-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 08/15] error: New ERR_IS_* macros for checking
 Error** values
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

Define new macros that should be used when checking errp values.
Existing methods will still work by now, but will break once we
implement IGNORE_ERRORS in a different way later.  Other patches will
convert existing code to use the new macros.

TODO: write more detailed API documentation

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qapi/error.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index 38f7afba2e..1000853051 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -119,6 +119,9 @@
 
 #define IGNORE_ERRORS (NULL)
 
+#define ERR_IS_SET(e) (!!*(e))
+#define ERR_IS_IGNORED(e) (!(e))
+
 /*
  * Overall category of an error.
  * Based on the qapi type QapiErrorClass, but reproduced here for nicer
-- 
2.11.0.259.g40922b1
