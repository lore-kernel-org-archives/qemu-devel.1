Received: from eggs.gnu.org ([2001:4830:134:3::10]:41147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cPA-0007Zs-3B
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cP7-0005Ez-2R
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:51:44 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:14 -0300
Message-Id: <20171006235023.11952-20-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 19/88] exec: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 exec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/exec.c b/exec.c
index 7a80460725..e060c6fea7 100644
--- a/exec.c
+++ b/exec.c
@@ -836,7 +836,7 @@ int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
                      VADDR_PRIx ", len=%" VADDR_PRIu, addr, len);
         return -EINVAL;
     }
-    wp = g_malloc(sizeof(*wp));
+    wp = g_new(CPUWatchpoint, 1);
 
     wp->vaddr = addr;
     wp->len = len;
@@ -922,7 +922,7 @@ int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
 {
     CPUBreakpoint *bp;
 
-    bp = g_malloc(sizeof(*bp));
+    bp = g_new(CPUBreakpoint, 1);
 
     bp->pc = pc;
     bp->flags = flags;
@@ -1975,7 +1975,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
         return NULL;
     }
 
-    new_block = g_malloc0(sizeof(*new_block));
+    new_block = g_new0(RAMBlock, 1);
     new_block->mr = mr;
     new_block->used_length = size;
     new_block->max_length = size;
@@ -2036,7 +2036,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
 
     size = HOST_PAGE_ALIGN(size);
     max_size = HOST_PAGE_ALIGN(max_size);
-    new_block = g_malloc0(sizeof(*new_block));
+    new_block = g_new0(RAMBlock, 1);
     new_block->mr = mr;
     new_block->resized = resized;
     new_block->used_length = size;
-- 
2.14.2
