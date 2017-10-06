Received: from eggs.gnu.org ([2001:4830:134:3::10]:41532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cPf-0008BH-AB
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:52:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cPe-0005lh-Fs
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:52:15 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:24 -0300
Message-Id: <20171006235023.11952-30-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 29/88] SPARC: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: split of disas/sparc.c change]
---
 hw/sparc/leon3.c     | 2 +-
 hw/sparc64/sparc64.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index ec2816bf94..05e7adefb8 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -132,7 +132,7 @@ static void leon3_generic_hw_init(MachineState *machine)
     cpu_sparc_set_id(env, 0);
 
     /* Reset data */
-    reset_info        = g_malloc0(sizeof(ResetData));
+    reset_info        = g_new0(ResetData, 1);
     reset_info->cpu   = cpu;
     reset_info->sp    = 0x40000000 + ram_size;
     qemu_register_reset(main_cpu_reset, reset_info);
diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
index 097d529ff1..6f2197fc13 100644
--- a/hw/sparc64/sparc64.c
+++ b/hw/sparc64/sparc64.c
@@ -160,7 +160,7 @@ static CPUTimer *cpu_timer_create(const char *name, SPARCCPU *cpu,
                                   QEMUBHFunc *cb, uint32_t frequency,
                                   uint64_t disabled_mask, uint64_t npt_mask)
 {
-    CPUTimer *timer = g_malloc0(sizeof(CPUTimer));
+    CPUTimer *timer = g_new0(CPUTimer, 1);
 
     timer->name = name;
     timer->frequency = frequency;
@@ -368,7 +368,7 @@ SPARCCPU *sparc64_cpu_devinit(const char *cpu_model,
                                     hstick_frequency, TICK_INT_DIS,
                                     TICK_NPT_MASK);
 
-    reset_info = g_malloc0(sizeof(ResetData));
+    reset_info = g_new0(ResetData, 1);
     reset_info->cpu = cpu;
     reset_info->prom_addr = prom_addr;
     qemu_register_reset(main_cpu_reset, reset_info);
-- 
2.14.2
