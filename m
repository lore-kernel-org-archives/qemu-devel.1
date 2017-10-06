Received: from eggs.gnu.org ([2001:4830:134:3::10]:40814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cOj-0007BQ-4q
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:51:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cOg-0004zB-Ng
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:51:17 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:07 -0300
Message-Id: <20171006235023.11952-13-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 12/88] backends/hostmem: use g_new() family of
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 backends/hostmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index ee2c2d5bfd..6a12f920c2 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -78,7 +78,7 @@ host_memory_backend_get_host_nodes(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    *node = g_malloc0(sizeof(**node));
+    *node = g_new0(uint16List, 1);
     (*node)->value = value;
     node = &(*node)->next;
 
@@ -88,7 +88,7 @@ host_memory_backend_get_host_nodes(Object *obj, Visitor *v, const char *name,
             break;
         }
 
-        *node = g_malloc0(sizeof(**node));
+        *node = g_new0(uint16List, 1);
         (*node)->value = value;
         node = &(*node)->next;
     } while (true);
-- 
2.14.2
