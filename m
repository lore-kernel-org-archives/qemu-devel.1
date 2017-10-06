Received: from eggs.gnu.org ([2001:4830:134:3::10]:41478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cPY-00086U-C1
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:52:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cPX-0005db-FA
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:52:08 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:22 -0300
Message-Id: <20171006235023.11952-28-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 27/88] SH4: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: squashed R2D]
---
 hw/sh4/r2d.c        | 4 ++--
 hw/sh4/sh7750.c     | 2 +-
 hw/timer/sh_timer.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 16b9ed2db2..92d1fb99d7 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -186,7 +186,7 @@ static qemu_irq *r2d_fpga_init(MemoryRegion *sysmem,
 {
     r2d_fpga_t *s;
 
-    s = g_malloc0(sizeof(r2d_fpga_t));
+    s = g_new0(r2d_fpga_t, 1);
 
     s->irl = irl;
 
@@ -249,7 +249,7 @@ static void r2d_init(MachineState *machine)
     cpu = SUPERH_CPU(cpu_generic_init(TYPE_SUPERH_CPU, cpu_model));
     env = &cpu->env;
 
-    reset_info = g_malloc0(sizeof(ResetData));
+    reset_info = g_new0(ResetData, 1);
     reset_info->cpu = cpu;
     reset_info->vector = env->pc;
     qemu_register_reset(main_cpu_reset, reset_info);
diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index 166e4bd947..49c49c110b 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -728,7 +728,7 @@ SH7750State *sh7750_init(SuperHCPU *cpu, MemoryRegion *sysmem)
 {
     SH7750State *s;
 
-    s = g_malloc0(sizeof(SH7750State));
+    s = g_new0(SH7750State, 1);
     s->cpu = cpu;
     s->periph_freq = 60000000;	/* 60MHz */
     memory_region_init_io(&s->iomem, NULL, &sh7750_mem_ops, s,
diff --git a/hw/timer/sh_timer.c b/hw/timer/sh_timer.c
index 9afb2d048c..46f3eb9647 100644
--- a/hw/timer/sh_timer.c
+++ b/hw/timer/sh_timer.c
@@ -192,7 +192,7 @@ static void *sh_timer_init(uint32_t freq, int feat, qemu_irq irq)
     sh_timer_state *s;
     QEMUBH *bh;
 
-    s = (sh_timer_state *)g_malloc0(sizeof(sh_timer_state));
+    s = g_new0(sh_timer_state, 1);
     s->freq = freq;
     s->feat = feat;
     s->tcor = 0xffffffff;
@@ -313,7 +313,7 @@ void tmu012_init(MemoryRegion *sysmem, hwaddr base,
     tmu012_state *s;
     int timer_feat = (feat & TMU012_FEAT_EXTCLK) ? TIMER_FEAT_EXTCLK : 0;
 
-    s = (tmu012_state *)g_malloc0(sizeof(tmu012_state));
+    s = g_new0(tmu012_state, 1);
     s->feat = feat;
     s->timer[0] = sh_timer_init(freq, timer_feat, ch0_irq);
     s->timer[1] = sh_timer_init(freq, timer_feat, ch1_irq);
-- 
2.14.2
