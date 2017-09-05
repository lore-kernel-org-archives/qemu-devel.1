Received: from eggs.gnu.org ([2001:4830:134:3::10]:42943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpDeQ-0006jD-AI
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:12:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpDeL-000862-MV
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:12:22 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue,  5 Sep 2017 21:11:45 +0800
Message-Id: <20170905131149.10669-3-famz@redhat.com>
In-Reply-To: <20170905131149.10669-1-famz@redhat.com>
References: <20170905131149.10669-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 2/6] armv7m: Convert armv7m.memory to
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/arm/armv7m.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 4c560dde56..b64a409b40 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -132,12 +132,6 @@ static void armv7m_instance_init(Object *obj)
=20
     /* Can't init the cpu here, we don't yet know which model to use */
=20
-    object_property_add_link(obj, "memory",
-                             TYPE_MEMORY_REGION,
-                             (Object **)&s->board_memory,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
-                             &error_abort);
     memory_region_init(&s->container, obj, "armv7m-container", UINT64_MA=
X);
=20
     object_initialize(&s->nvic, sizeof(s->nvic), TYPE_NVIC);
@@ -248,6 +242,8 @@ static void armv7m_realize(DeviceState *dev, Error **=
errp)
=20
 static Property armv7m_properties[] =3D {
     DEFINE_PROP_STRING("cpu-model", ARMv7MState, cpu_model),
+    DEFINE_PROP_LINK("memory", ARMv7MState, board_memory, TYPE_MEMORY_RE=
GION,
+                     MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
--=20
2.13.5
