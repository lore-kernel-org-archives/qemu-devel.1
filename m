Received: from eggs.gnu.org ([2001:4830:134:3::10]:41296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cPJ-0007ok-7O
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cPG-0005MS-5H
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:51:53 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:17 -0300
Message-Id: <20171006235023.11952-23-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 22/88] LM32: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Michael Walle <michael@walle.cc>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: squashed milkymist]
---
 hw/lm32/lm32_hwsetup.h | 2 +-
 hw/lm32/lm32_boards.c  | 4 ++--
 hw/lm32/milkymist.c    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/lm32/lm32_hwsetup.h b/hw/lm32/lm32_hwsetup.h
index a01f6bc5df..38ade3db0e 100644
--- a/hw/lm32/lm32_hwsetup.h
+++ b/hw/lm32/lm32_hwsetup.h
@@ -58,7 +58,7 @@ static inline HWSetup *hwsetup_init(void)
 {
     HWSetup *hw;
 
-    hw = g_malloc(sizeof(HWSetup));
+    hw = g_new(HWSetup, 1);
     hw->data = g_malloc0(TARGET_PAGE_SIZE);
     hw->ptr = hw->data;
 
diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
index b0bb3ef58a..a9c74e90d4 100644
--- a/hw/lm32/lm32_boards.c
+++ b/hw/lm32/lm32_boards.c
@@ -99,7 +99,7 @@ static void lm32_evr_init(MachineState *machine)
     int timer0_irq                 = 1;
     int timer1_irq                 = 3;
 
-    reset_info = g_malloc0(sizeof(ResetInfo));
+    reset_info = g_new0(ResetInfo, 1);
 
     if (cpu_model == NULL) {
         cpu_model = "lm32-full";
@@ -196,7 +196,7 @@ static void lm32_uclinux_init(MachineState *machine)
     hwaddr initrd_base  = 0x08400000;
     size_t initrd_max               = 0x01000000;
 
-    reset_info = g_malloc0(sizeof(ResetInfo));
+    reset_info = g_new0(ResetInfo, 1);
 
     if (cpu_model == NULL) {
         cpu_model = "lm32-full";
diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index 4db4d2d533..0335f0b322 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -106,7 +106,7 @@ milkymist_init(MachineState *machine)
     hwaddr cmdline_base = sdram_base + 0x1000000;
     size_t initrd_max = sdram_size - 0x1002000;
 
-    reset_info = g_malloc0(sizeof(ResetInfo));
+    reset_info = g_new0(ResetInfo, 1);
 
     if (cpu_model == NULL) {
         cpu_model = "lm32-full";
-- 
2.14.2
