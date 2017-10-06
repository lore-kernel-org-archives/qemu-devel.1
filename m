Received: from eggs.gnu.org ([2001:4830:134:3::10]:40675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cOa-00074j-DG
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:51:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cOX-0004tE-C3
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:51:08 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:04 -0300
Message-Id: <20171006235023.11952-10-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 09/88] Bootdevice: use g_new() family of
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Gonglei <arei.gonglei@huawei.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 bootdevice.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bootdevice.c b/bootdevice.c
index 1141009114..a2936503da 100644
--- a/bootdevice.c
+++ b/bootdevice.c
@@ -165,7 +165,7 @@ void add_boot_device_path(int32_t bootindex, DeviceState *dev,
 
     del_boot_device_path(dev, suffix);
 
-    node = g_malloc0(sizeof(FWBootEntry));
+    node = g_new0(FWBootEntry, 1);
     node->bootindex = bootindex;
     node->suffix = g_strdup(suffix);
     node->dev = dev;
-- 
2.14.2
