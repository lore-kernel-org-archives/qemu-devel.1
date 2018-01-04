Received: from eggs.gnu.org ([2001:4830:134:3::10]:52645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX6hj-0000gz-Ou
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:41:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX6hd-0002vd-RR
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:41:11 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu,  4 Jan 2018 11:40:42 -0300
Message-Id: <20180104144046.30793-3-f4bug@amsat.org>
In-Reply-To: <20180104144046.30793-1-f4bug@amsat.org>
References: <20180104144046.30793-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 2/6] hw/net/e1000: real device name is
 'e1000-82540em', 'e1000' is an alias
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Sascha Silbe <silbe@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Jason Wang <jasowang@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/net/e1000.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 05a00cba31..2280f7fdf9 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -1648,6 +1648,7 @@ typedef struct E1000Info {
     uint16_t   device_id;
     uint8_t    revision;
     uint16_t   phy_id2;
+    const char **aliases;
 } E1000Info;
 
 static void e1000_class_init(ObjectClass *klass, void *data)
@@ -1695,10 +1696,11 @@ static const TypeInfo e1000_base_info = {
 
 static const E1000Info e1000_devices[] = {
     {
-        .name      = "e1000",
+        .name      = "e1000-82540em",
         .device_id = E1000_DEV_ID_82540EM,
         .revision  = 0x03,
         .phy_id2   = E1000_PHY_ID2_8254xx_DEFAULT,
+        .aliases   = (const char * []) {"e1000", NULL},
     },
     {
         .name      = "e1000-82544gc",
@@ -1725,6 +1727,7 @@ static void e1000_register_types(void)
 
         type_info.name = info->name;
         type_info.parent = TYPE_E1000_BASE;
+        type_info.aliases = info->aliases;
         type_info.class_data = (void *)info;
         type_info.class_init = e1000_class_init;
         type_info.instance_init = e1000_instance_init;
-- 
2.15.1
