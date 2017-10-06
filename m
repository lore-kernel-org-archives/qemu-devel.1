Received: from eggs.gnu.org ([2001:4830:134:3::10]:41318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cPK-0007rV-En
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:51:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cPJ-0005OO-Hn
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:51:54 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:18 -0300
Message-Id: <20171006235023.11952-24-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 23/88] M68K: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <huth@tuxfamily.org>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: squashed commits]
---
 hw/m68k/mcf5206.c | 4 ++--
 hw/m68k/mcf5208.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index b81901fdfd..df45e99547 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -137,7 +137,7 @@ static m5206_timer_state *m5206_timer_init(qemu_irq irq)
     m5206_timer_state *s;
     QEMUBH *bh;
 
-    s = (m5206_timer_state *)g_malloc0(sizeof(m5206_timer_state));
+    s = g_new0(m5206_timer_state, 1);
     bh = qemu_bh_new(m5206_timer_trigger, s);
     s->timer = ptimer_init(bh, PTIMER_POLICY_DEFAULT);
     s->irq = irq;
@@ -533,7 +533,7 @@ qemu_irq *mcf5206_init(MemoryRegion *sysmem, uint32_t base, M68kCPU *cpu)
     m5206_mbar_state *s;
     qemu_irq *pic;
 
-    s = (m5206_mbar_state *)g_malloc0(sizeof(m5206_mbar_state));
+    s = g_new0(m5206_mbar_state, 1);
 
     memory_region_init_io(&s->iomem, NULL, &m5206_mbar_ops, s,
                           "mbar", 0x00001000);
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index b9dde75106..9b93af5fbd 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -183,7 +183,7 @@ static void mcf5208_sys_init(MemoryRegion *address_space, qemu_irq *pic)
     memory_region_add_subregion(address_space, 0xfc0a8000, iomem);
     /* Timers.  */
     for (i = 0; i < 2; i++) {
-        s = (m5208_timer_state *)g_malloc0(sizeof(m5208_timer_state));
+        s = g_new0(m5208_timer_state, 1);
         bh = qemu_bh_new(m5208_timer_trigger, s);
         s->timer = ptimer_init(bh, PTIMER_POLICY_DEFAULT);
         memory_region_init_io(&s->iomem, NULL, &m5208_timer_ops, s,
-- 
2.14.2
