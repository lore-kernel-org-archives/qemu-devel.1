Received: from eggs.gnu.org ([2001:4830:134:3::10]:33956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVq8v-0003XD-IL
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:15:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVq8u-0001Fy-Ld
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:15:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dVq8u-0001Fc-9J
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:15:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 55B077F7A9
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 02:15:43 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Fri, 14 Jul 2017 10:15:02 +0800
Message-Id: <20170714021509.23681-14-famz@redhat.com>
In-Reply-To: <20170714021509.23681-1-famz@redhat.com>
References: <20170714021509.23681-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 13/20] armv7m: Convert armv7m.memory to
 DEFINE_PROP_LINK
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

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/arm/armv7m.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 8efc4e8..1c837da 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -132,12 +132,6 @@ static void armv7m_instance_init(Object *obj)
 
     /* Can't init the cpu here, we don't yet know which model to use */
 
-    object_property_add_link(obj, "memory",
-                             TYPE_MEMORY_REGION,
-                             (Object **)&s->board_memory,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
-                             &error_abort);
     memory_region_init(&s->container, obj, "armv7m-container", UINT64_MAX);
 
     object_initialize(&s->nvic, sizeof(s->nvic), "armv7m_nvic");
@@ -248,6 +242,8 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
 
 static Property armv7m_properties[] = {
     DEFINE_PROP_STRING("cpu-model", ARMv7MState, cpu_model),
+    DEFINE_PROP_LINK("memory", ARMv7MState, board_memory, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.9.4
