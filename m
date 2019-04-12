Received: from eggs.gnu.org ([209.51.188.92]:54289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEzRm-0000rt-O5
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:54:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEzRk-0006j8-N8
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:54:38 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 12 Apr 2019 18:54:07 +0200
Message-Id: <20190412165416.7977-4-philmd@redhat.com>
In-Reply-To: <20190412165416.7977-1-philmd@redhat.com>
References: <20190412165416.7977-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 03/12] hw/display/tc6393xb: Remove unused
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

No code used the tc6393xb_gpio_in_get() and tc6393xb_gpio_out_set()
functions since their introduction in commit 88d2c950b002. Time to
remove them.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/display/tc6393xb.c | 16 ----------------
 include/hw/devices.h  |  3 ---
 2 files changed, 19 deletions(-)

diff --git a/hw/display/tc6393xb.c b/hw/display/tc6393xb.c
index e1b1e302f23..6d133d9a66c 100644
--- a/hw/display/tc6393xb.c
+++ b/hw/display/tc6393xb.c
@@ -137,11 +137,6 @@ struct TC6393xbState {
              blanked : 1;
 };
=20
-qemu_irq *tc6393xb_gpio_in_get(TC6393xbState *s)
-{
-    return s->gpio_in;
-}
-
 static void tc6393xb_gpio_set(void *opaque, int line, int level)
 {
 //    TC6393xbState *s =3D opaque;
@@ -154,17 +149,6 @@ static void tc6393xb_gpio_set(void *opaque, int line=
, int level)
     // FIXME: how does the chip reflect the GPIO input level change?
 }
=20
-void tc6393xb_gpio_out_set(TC6393xbState *s, int line,
-                    qemu_irq handler)
-{
-    if (line >=3D TC6393XB_GPIOS) {
-        fprintf(stderr, "TC6393xb: no GPIO pin %d\n", line);
-        return;
-    }
-
-    s->handler[line] =3D handler;
-}
-
 static void tc6393xb_gpio_handler_update(TC6393xbState *s)
 {
     uint32_t level, diff;
diff --git a/include/hw/devices.h b/include/hw/devices.h
index 1ed5be32967..0850f697451 100644
--- a/include/hw/devices.h
+++ b/include/hw/devices.h
@@ -54,9 +54,6 @@ void retu_key_event(void *retu, int state);
 typedef struct TC6393xbState TC6393xbState;
 TC6393xbState *tc6393xb_init(struct MemoryRegion *sysmem,
                              uint32_t base, qemu_irq irq);
-void tc6393xb_gpio_out_set(TC6393xbState *s, int line,
-                    qemu_irq handler);
-qemu_irq *tc6393xb_gpio_in_get(TC6393xbState *s);
 qemu_irq tc6393xb_l3v_get(TC6393xbState *s);
=20
 #endif
--=20
2.20.1
