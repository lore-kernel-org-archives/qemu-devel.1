Received: from eggs.gnu.org ([2001:4830:134:3::10]:41662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cPr-0008M1-Mj
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cPr-0005st-2x
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:52:27 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:28 -0300
Message-Id: <20171006235023.11952-34-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 33/88] qom: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 qom/object.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 6a7bd9257b..3273f9c1f0 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -940,7 +940,7 @@ object_property_add(Object *obj, const char *name, const char *type,
         return NULL;
     }
 
-    prop = g_malloc0(sizeof(*prop));
+    prop = g_new0(ObjectProperty, 1);
 
     prop->name = g_strdup(name);
     prop->type = g_strdup(type);
@@ -973,7 +973,7 @@ object_class_property_add(ObjectClass *klass,
         return NULL;
     }
 
-    prop = g_malloc0(sizeof(*prop));
+    prop = g_new0(ObjectProperty, 1);
 
     prop->name = g_strdup(name);
     prop->type = g_strdup(type);
@@ -2281,7 +2281,7 @@ void object_property_add_alias(Object *obj, const char *name,
         prop_type = g_strdup(target_prop->type);
     }
 
-    prop = g_malloc(sizeof(*prop));
+    prop = g_new(AliasProperty, 1);
     prop->target_obj = target_obj;
     prop->target_name = g_strdup(target_name);
 
-- 
2.14.2
