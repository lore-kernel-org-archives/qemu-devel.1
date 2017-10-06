Received: from eggs.gnu.org ([2001:4830:134:3::10]:43557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cSE-00027G-D2
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cSD-0007qq-Ff
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:54:54 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:50:08 -0300
Message-Id: <20171006235023.11952-74-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 73/88] hw/block/xen_disk: avoid use of g_new0()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jan Beulich <jbeulich@suse.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, qemu-block@nongnu.org, Paul Durrant <paul.durrant@citrix.com>, Anthony Perard <anthony.perard@citrix.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Jan Beulich <jbeulich@suse.com>

Prefer g_new() / g_new0() to be farther backwards compatible with older
glib versions. As there's no point in zeroing the allocation here (the
loop right afterwards fully initializes the memory), use the former.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Reviewed-by: Paul Durrant <paul.durrant@citrix.com>
Acked-by: Anthony Perard <anthony.perard@citrix.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: rebase & subject tweak]
---
 hw/block/xen_disk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
index 536e2ee735..6d2fd4d284 100644
--- a/hw/block/xen_disk.c
+++ b/hw/block/xen_disk.c
@@ -1232,7 +1232,7 @@ static int blk_connect(struct XenDevice *xendev)
         return -1;
     }
 
-    domids = g_new0(uint32_t, blkdev->nr_ring_ref);
+    domids = g_new(uint32_t, blkdev->nr_ring_ref);
     for (i = 0; i < blkdev->nr_ring_ref; i++) {
         domids[i] = blkdev->xendev.dom;
     }
-- 
2.14.2
