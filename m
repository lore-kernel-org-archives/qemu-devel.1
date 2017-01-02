Received: from eggs.gnu.org ([2001:4830:134:3::10]:41681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cO4nF-0001TD-0Y
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 10:45:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cO4nA-0001Em-9l
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 10:45:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cO4nA-0001EB-4D
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 10:44:56 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Jan 2017 16:44:48 +0100
Message-Id: <1483371890-289981-2-git-send-email-imammedo@redhat.com>
In-Reply-To: <1483371890-289981-1-git-send-email-imammedo@redhat.com>
References: <1483371890-289981-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] cleanup: remove not used header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, armbru@redhat.com, dgilbert@redhat.com, eblake@redhat.com, afaerber@suse.de

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
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
