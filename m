Received: from eggs.gnu.org ([2001:4830:134:3::10]:40699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cOb-00075s-Nr
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:51:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cOa-0004vQ-JC
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:51:09 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:05 -0300
Message-Id: <20171006235023.11952-11-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 10/88] Character devices: use g_new() family of
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: squashed PC Chipsets: parallel + serial]
---
 hw/char/parallel.c  | 2 +-
 hw/char/serial.c    | 4 ++--
 hw/char/sh_serial.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index f79dc76543..da8566538e 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -614,7 +614,7 @@ bool parallel_mm_init(MemoryRegion *address_space,
 {
     ParallelState *s;
 
-    s = g_malloc0(sizeof(ParallelState));
+    s = g_new0(ParallelState, 1);
     s->irq = irq;
     qemu_chr_fe_init(&s->chr, chr, &error_abort);
     s->it_shift = it_shift;
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 376bd2f240..dcc25d649f 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -978,7 +978,7 @@ SerialState *serial_init(int base, qemu_irq irq, int baudbase,
 {
     SerialState *s;
 
-    s = g_malloc0(sizeof(SerialState));
+    s = g_new0(SerialState, 1);
 
     s->irq = irq;
     s->baudbase = baudbase;
@@ -1034,7 +1034,7 @@ SerialState *serial_mm_init(MemoryRegion *address_space,
 {
     SerialState *s;
 
-    s = g_malloc0(sizeof(SerialState));
+    s = g_new0(SerialState, 1);
 
     s->it_shift = it_shift;
     s->irq = irq;
diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 835b5378a0..0d1a67d450 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -365,7 +365,7 @@ void sh_serial_init(MemoryRegion *sysmem,
 {
     sh_serial_state *s;
 
-    s = g_malloc0(sizeof(sh_serial_state));
+    s = g_new0(sh_serial_state, 1);
 
     s->feat = feat;
     s->flags = SH_SERIAL_FLAG_TEND | SH_SERIAL_FLAG_TDE;
-- 
2.14.2
