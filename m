Received: from eggs.gnu.org ([2001:4830:134:3::10]:42417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVxYZ-0000Ft-2Y
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVxYY-00050v-3a
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:42 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVxYX-00050H-LD
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:41 -0400
Received: by mail-wr0-x244.google.com with SMTP id g46so1016362wrd.0
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 03:10:41 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 14 Jul 2017 12:10:18 +0200
Message-Id: <1500027028-4127-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1500027028-4127-1-git-send-email-pbonzini@redhat.com>
References: <1500027028-4127-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 45/55] qmp: Use ObjectProperty.type if present
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>

From: Fam Zheng <famz@redhat.com>

The dynamic value is more informative in the case of link property,
otherwise it is the same.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170714021509.23681-5-famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qmp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qmp.c b/qmp.c
index e6b68fe..2cd40c3 100644
--- a/qmp.c
+++ b/qmp.c
@@ -486,7 +486,8 @@ static DevicePropertyInfo *make_device_property_info(ObjectClass *klass,
 
             info = g_malloc0(sizeof(*info));
             info->name = g_strdup(prop->name);
-            info->type = g_strdup(prop->info->name);
+            info->type = default_type ? g_strdup(default_type)
+                                      : g_strdup(prop->info->name);
             info->has_description = !!prop->info->description;
             info->description = g_strdup(prop->info->description);
             return info;
-- 
1.8.3.1
