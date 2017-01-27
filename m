Received: from eggs.gnu.org ([2001:4830:134:3::10]:35051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cX0yR-0007pW-Sb
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 02:29:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cX0yG-0005Ju-TT
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 02:29:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cX0yG-0005JU-Ln
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 02:29:20 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 27 Jan 2017 08:29:17 +0100
Message-Id: <1485502157-25445-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1485502157-25445-1-git-send-email-armbru@redhat.com>
References: <1485502157-25445-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 3/3] qmp: Fix argument name in error message of
 device-list-properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Lin Ma <lma@suse.com>

From: Lin Ma <lma@suse.com>

The argument is called "typename", not "name".

[Thanks to Markus for correcting the commit message]

Signed-off-by: Lin Ma <lma@suse.com>
Message-Id: <20170125052703.23571-1-lma@suse.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qmp.c b/qmp.c
index 0028f0b..886059e 100644
--- a/qmp.c
+++ b/qmp.c
@@ -531,12 +531,12 @@ DevicePropertyInfoList *qmp_device_list_properties(const char *typename,
 
     klass = object_class_dynamic_cast(klass, TYPE_DEVICE);
     if (klass == NULL) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "name", TYPE_DEVICE);
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "typename", TYPE_DEVICE);
         return NULL;
     }
 
     if (object_class_is_abstract(klass)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "name",
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "typename",
                    "non-abstract device type");
         return NULL;
     }
-- 
2.7.4
