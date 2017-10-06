Received: from eggs.gnu.org ([2001:4830:134:3::10]:42274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cQl-0000gn-DF
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:53:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cQk-0006ax-Pc
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:53:23 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:44 -0300
Message-Id: <20171006235023.11952-50-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 49/88] hw/misc: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Gabriel Somlo <gsomlo@gmail.com>, "Denis V. Lunev" <den@openvz.org>, Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: added hw/misc/pvpanic.c]
---
 hw/misc/applesmc.c | 2 +-
 hw/misc/pvpanic.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index 7be8b5f13c..12e32b107e 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -252,7 +252,7 @@ static void applesmc_add_key(AppleSMCState *s, const char *key,
 {
     struct AppleSMCData *def;
 
-    def = g_malloc0(sizeof(struct AppleSMCData));
+    def = g_new0(struct AppleSMCData, 1);
     def->key = key;
     def->len = len;
     def->data = data;
diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index 2b1e9a6450..dc51e4386c 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -95,7 +95,7 @@ static void pvpanic_isa_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    pvpanic_port = g_malloc(sizeof(*pvpanic_port));
+    pvpanic_port = g_new(uint16_t, 1);
     *pvpanic_port = cpu_to_le16(s->ioport);
     fw_cfg_add_file(fw_cfg, "etc/pvpanic-port", pvpanic_port,
                     sizeof(*pvpanic_port));
-- 
2.14.2
