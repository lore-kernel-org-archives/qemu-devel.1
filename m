Received: from eggs.gnu.org ([2001:4830:134:3::10]:42236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cQi-0000dN-3h
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:53:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cQh-0006Y6-7X
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:53:20 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:43 -0300
Message-Id: <20171006235023.11952-49-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 48/88] hw/input: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, "M : Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: squashed hw/input/pxa2xx_keypad.c]
---
Andrzej: can you add an entry for tsc2005.c in MAINTAINERS? (or tell me where)

 hw/input/pckbd.c         | 2 +-
 hw/input/ps2.c           | 4 ++--
 hw/input/pxa2xx_keypad.c | 2 +-
 hw/input/tsc2005.c       | 3 +--
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index c479f827b6..ef9e055b1d 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -465,7 +465,7 @@ void i8042_mm_init(qemu_irq kbd_irq, qemu_irq mouse_irq,
                    MemoryRegion *region, ram_addr_t size,
                    hwaddr mask)
 {
-    KBDState *s = g_malloc0(sizeof(KBDState));
+    KBDState *s = g_new0(KBDState, 1);
 
     s->irq_kbd = kbd_irq;
     s->irq_mouse = mouse_irq;
diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index dff3f1e024..3e8f5ee98d 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -1296,7 +1296,7 @@ static QemuInputHandler ps2_keyboard_handler = {
 
 void *ps2_kbd_init(void (*update_irq)(void *, int), void *update_arg)
 {
-    PS2KbdState *s = (PS2KbdState *)g_malloc0(sizeof(PS2KbdState));
+    PS2KbdState *s = g_new0(PS2KbdState, 1);
 
     trace_ps2_kbd_init(s);
     s->common.update_irq = update_irq;
@@ -1318,7 +1318,7 @@ static QemuInputHandler ps2_mouse_handler = {
 
 void *ps2_mouse_init(void (*update_irq)(void *, int), void *update_arg)
 {
-    PS2MouseState *s = (PS2MouseState *)g_malloc0(sizeof(PS2MouseState));
+    PS2MouseState *s = g_new0(PS2MouseState, 1);
 
     trace_ps2_mouse_init(s);
     s->common.update_irq = update_irq;
diff --git a/hw/input/pxa2xx_keypad.c b/hw/input/pxa2xx_keypad.c
index 2b70bbb95c..016b095e94 100644
--- a/hw/input/pxa2xx_keypad.c
+++ b/hw/input/pxa2xx_keypad.c
@@ -310,7 +310,7 @@ PXA2xxKeyPadState *pxa27x_keypad_init(MemoryRegion *sysmem,
 {
     PXA2xxKeyPadState *s;
 
-    s = (PXA2xxKeyPadState *) g_malloc0(sizeof(PXA2xxKeyPadState));
+    s = g_new0(PXA2xxKeyPadState, 1);
     s->irq = irq;
 
     memory_region_init_io(&s->iomem, NULL, &pxa2xx_keypad_ops, s,
diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
index eb5320af40..34dd4ea0da 100644
--- a/hw/input/tsc2005.c
+++ b/hw/input/tsc2005.c
@@ -485,8 +485,7 @@ void *tsc2005_init(qemu_irq pintdav)
 {
     TSC2005State *s;
 
-    s = (TSC2005State *)
-            g_malloc0(sizeof(TSC2005State));
+    s = g_new0(TSC2005State, 1);
     s->x = 400;
     s->y = 240;
     s->pressure = false;
-- 
2.14.2
