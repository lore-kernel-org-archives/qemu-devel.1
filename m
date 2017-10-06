Received: from eggs.gnu.org ([2001:4830:134:3::10]:44170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cSy-0002tT-0t
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:55:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cSw-0000FJ-W8
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:55:39 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:50:22 -0300
Message-Id: <20171006235023.11952-88-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 87/88] hw/net/rocker: use g_new() family of
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/net/rocker/rocker_of_dpa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_dpa.c
index 191a58e0a7..990f4157a0 100644
--- a/hw/net/rocker/rocker_of_dpa.c
+++ b/hw/net/rocker/rocker_of_dpa.c
@@ -2306,7 +2306,7 @@ static void of_dpa_flow_fill(void *cookie, void *value, void *user_data)
         return;
     }
 
-    new = g_malloc0(sizeof(*new));
+    new = g_new0(RockerOfDpaFlowList, 1);
     nflow = new->value = g_malloc0(sizeof(*nflow));
     nkey = nflow->key = g_malloc0(sizeof(*nkey));
     nmask = nflow->mask = g_malloc0(sizeof(*nmask));
@@ -2478,7 +2478,7 @@ static void of_dpa_group_fill(void *key, void *value, void *user_data)
         return;
     }
 
-    new = g_malloc0(sizeof(*new));
+    new = g_new0(RockerOfDpaGroupList, 1);
     ngroup = new->value = g_malloc0(sizeof(*ngroup));
 
     ngroup->id = group->id;
-- 
2.14.2
