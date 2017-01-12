Received: from eggs.gnu.org ([2001:4830:134:3::10]:41992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRjec-0000PV-HA
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:59:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRjeZ-0000ft-Ng
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:59:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cRjeZ-0000fL-Hp
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:59:11 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 12 Jan 2017 15:53:51 -0200
Message-Id: <20170112175356.21701-2-ehabkost@redhat.com>
In-Reply-To: <20170112175356.21701-1-ehabkost@redhat.com>
References: <20170112175356.21701-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 1/6] qom: remove unused header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1484052795-158195-2-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qom/object_interfaces.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index ded4d84c85..4b880d077c 100644
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
2.11.0.259.g40922b1
