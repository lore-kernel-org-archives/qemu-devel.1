Received: from eggs.gnu.org ([2001:4830:134:3::10]:60080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cQvvX-0007cx-2q
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:53:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cQvvU-0003tz-TB
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:53:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cQvvU-0003tl-NJ
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:53:20 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 10 Jan 2017 13:53:13 +0100
Message-Id: <1484052795-158195-2-git-send-email-imammedo@redhat.com>
In-Reply-To: <1484052795-158195-1-git-send-email-imammedo@redhat.com>
References: <1484052795-158195-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/3] qom: remove unused header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, armbru@redhat.com, dgilbert@redhat.com, eblake@redhat.com, afaerber@suse.de, pbonzini@redhat.com

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qom/object_interfaces.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index ded4d84..4b880d0 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -3,7 +3,6 @@
 #include "qom/object_interfaces.h"
 #include "qemu/module.h"
 #include "qapi-visit.h"
-#include "qapi/qobject-output-visitor.h"
 #include "qapi/opts-visitor.h"
 
 void user_creatable_complete(Object *obj, Error **errp)
-- 
2.7.4
