Received: from eggs.gnu.org ([2001:4830:134:3::10]:42127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cQX-0000Tw-14
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:53:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cQT-0006OC-UX
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:53:09 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:39 -0300
Message-Id: <20171006235023.11952-45-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 44/88] hw/core/loader: use g_new() family of
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/core/loader.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 4593061445..def4766dbb 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -899,7 +899,7 @@ int rom_add_file(const char *file, const char *fw_dir,
         return -1;
     }
 
-    rom = g_malloc0(sizeof(*rom));
+    rom = g_new0(Rom, 1);
     rom->name = g_strdup(file);
     rom->path = qemu_find_file(QEMU_FILE_TYPE_BIOS, rom->name);
     rom->as = as;
@@ -996,7 +996,7 @@ MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
     Rom *rom;
     MemoryRegion *mr = NULL;
 
-    rom           = g_malloc0(sizeof(*rom));
+    rom           = g_new0(Rom, 1);
     rom->name     = g_strdup(name);
     rom->as       = as;
     rom->addr     = addr;
@@ -1039,7 +1039,7 @@ int rom_add_elf_program(const char *name, void *data, size_t datasize,
 {
     Rom *rom;
 
-    rom           = g_malloc0(sizeof(*rom));
+    rom = g_new0(Rom, 1);
     rom->name     = g_strdup(name);
     rom->addr     = addr;
     rom->datasize = datasize;
-- 
2.14.2
