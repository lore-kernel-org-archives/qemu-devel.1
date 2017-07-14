Received: from eggs.gnu.org ([2001:4830:134:3::10]:33816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVq8c-0003Ft-JM
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVq8b-00017L-OC
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:15:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dVq8b-00017B-Hj
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:15:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 77207804F0
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 02:15:24 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Fri, 14 Jul 2017 10:14:53 +0800
Message-Id: <20170714021509.23681-5-famz@redhat.com>
In-Reply-To: <20170714021509.23681-1-famz@redhat.com>
References: <20170714021509.23681-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 04/20] qmp: Use ObjectProperty.type if
 present
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

The dynamic value is more informative in the case of link property,
otherwise it is the same.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 qmp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qmp.c b/qmp.c
index 133fdfc..9f8a167 100644
--- a/qmp.c
+++ b/qmp.c
@@ -496,7 +496,8 @@ static DevicePropertyInfo *make_device_property_info(ObjectClass *klass,
 
             info = g_malloc0(sizeof(*info));
             info->name = g_strdup(prop->name);
-            info->type = g_strdup(prop->info->name);
+            info->type = default_type ? g_strdup(default_type)
+                                      : g_strdup(prop->info->name);
             info->has_description = !!prop->info->description;
             info->description = g_strdup(prop->info->description);
             return info;
-- 
2.9.4
