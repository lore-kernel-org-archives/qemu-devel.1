Received: from eggs.gnu.org ([2001:4830:134:3::10]:43727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cSR-0002NH-Lf
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:55:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cSQ-000873-Un
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:55:07 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:50:12 -0300
Message-Id: <20171006235023.11952-78-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 77/88] dump: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 dump.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/dump.c b/dump.c
index 7ebcf553b2..884221a904 100644
--- a/dump.c
+++ b/dump.c
@@ -1825,29 +1825,28 @@ void qmp_dump_guest_memory(bool paging, const char *file,
 DumpGuestMemoryCapability *qmp_query_dump_guest_memory_capability(Error **errp)
 {
     DumpGuestMemoryFormatList *item;
-    DumpGuestMemoryCapability *cap =
-                                  g_malloc0(sizeof(DumpGuestMemoryCapability));
+    DumpGuestMemoryCapability *cap = g_new0(DumpGuestMemoryCapability, 1);
 
     /* elf is always available */
-    item = g_malloc0(sizeof(DumpGuestMemoryFormatList));
+    item = g_new0(DumpGuestMemoryFormatList, 1);
     cap->formats = item;
     item->value = DUMP_GUEST_MEMORY_FORMAT_ELF;
 
     /* kdump-zlib is always available */
-    item->next = g_malloc0(sizeof(DumpGuestMemoryFormatList));
+    item->next = g_new0(DumpGuestMemoryFormatList, 1);
     item = item->next;
     item->value = DUMP_GUEST_MEMORY_FORMAT_KDUMP_ZLIB;
 
     /* add new item if kdump-lzo is available */
 #ifdef CONFIG_LZO
-    item->next = g_malloc0(sizeof(DumpGuestMemoryFormatList));
+    item->next = g_new0(DumpGuestMemoryFormatList, 1);
     item = item->next;
     item->value = DUMP_GUEST_MEMORY_FORMAT_KDUMP_LZO;
 #endif
 
     /* add new item if kdump-snappy is available */
 #ifdef CONFIG_SNAPPY
-    item->next = g_malloc0(sizeof(DumpGuestMemoryFormatList));
+    item->next = g_new0(DumpGuestMemoryFormatList, 1);
     item = item->next;
     item->value = DUMP_GUEST_MEMORY_FORMAT_KDUMP_SNAPPY;
 #endif
-- 
2.14.2
