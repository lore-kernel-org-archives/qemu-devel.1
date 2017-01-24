Received: from eggs.gnu.org ([2001:4830:134:3::10]:58646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1cVyjm-0004AC-UL
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:54:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1cVyji-0006Np-4E
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:54:07 -0500
Received: from prv3-mh.provo.novell.com ([137.65.250.26]:60913)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lma@suse.com>) id 1cVyjh-0006NW-TY
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:54:02 -0500
From: Lin Ma <lma@suse.com>
Date: Tue, 24 Jan 2017 18:53:32 +0800
Message-Id: <20170124105332.15992-1-lma@suse.com>
Subject: [Qemu-devel] [PATCH] qmp: set accurate parameter name for error msg
 of device-list-properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

Signed-off-by: Lin Ma <lma@suse.com>
---
 qmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qmp.c b/qmp.c
index 0028f0b..812db6c 100644
--- a/qmp.c
+++ b/qmp.c
@@ -531,7 +531,7 @@ DevicePropertyInfoList *qmp_device_list_properties(const char *typename,
 
     klass = object_class_dynamic_cast(klass, TYPE_DEVICE);
     if (klass == NULL) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "name", TYPE_DEVICE);
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "typename", TYPE_DEVICE);
         return NULL;
     }
 
-- 
2.9.2
