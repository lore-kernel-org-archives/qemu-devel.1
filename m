Received: from eggs.gnu.org ([2001:4830:134:3::10]:43442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cSA-00023S-0j
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:54:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cS9-0007lv-Ch
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:54:50 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:50:07 -0300
Message-Id: <20171006235023.11952-73-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 72/88] hw/block/nvme: use g_new() family of
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, qemu-block@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/block/nvme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 9aa32692a3..ff712fa8cc 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -454,7 +454,7 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd *cmd)
     if (!(NVME_SQ_FLAGS_PC(qflags))) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
-    sq = g_malloc0(sizeof(*sq));
+    sq = g_new0(NvmeSQueue, 1);
     nvme_init_sq(sq, n, prp1, sqid, cqid, qsize + 1);
     return NVME_SUCCESS;
 }
@@ -532,7 +532,7 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
-    cq = g_malloc0(sizeof(*cq));
+    cq = g_new0(NvmeCQueue, 1);
     nvme_init_cq(cq, n, prp1, cqid, vector, qsize + 1,
         NVME_CQ_FLAGS_IEN(qflags));
     return NVME_SUCCESS;
-- 
2.14.2
