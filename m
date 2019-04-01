Received: from eggs.gnu.org ([209.51.188.92]:46135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <n.alekseev2104@gmail.com>) id 1hAtIo-00068y-1d
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:32:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n.alekseev2104@gmail.com>) id 1hAtIn-00015x-4v
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:32:26 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:35573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n.alekseev2104@gmail.com>)
	id 1hAtIm-00015F-QJ
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:32:25 -0400
Received: by mail-lj1-x241.google.com with SMTP id t4so7474809ljc.2
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 02:32:23 -0700 (PDT)
From: n.alekseev2104@gmail.com
Date: Mon,  1 Apr 2019 12:30:51 +0300
Message-Id: <20190401093051.16488-1-n.alekseev2104@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] Add coroutine_fn to bdrv_check_co_entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, jusual@mail.ru, kwolf@redhat.com, mreitz@redhat.com, Nikita Alekseev <n.alekseev2104@gmail.com>

From: Nikita Alekseev <n.alekseev2104@gmail.com>

bdrv_check_co_entry calls bdrv_co_check, which is a coroutine function.
Thus, it also needs to be marked as a coroutine.

Signed-off-by: Nikita Alekseev <n.alekseev2104@gmail.com>
---
 block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 0a93ee9ac8..776c43f177 100644
--- a/block.c
+++ b/block.c
@@ -4121,7 +4121,7 @@ typedef struct CheckCo {
     int ret;
 } CheckCo;
 
-static void bdrv_check_co_entry(void *opaque)
+static void coroutine_fn bdrv_check_co_entry(void *opaque)
 {
     CheckCo *cco = opaque;
     cco->ret = bdrv_co_check(cco->bs, cco->res, cco->fix);
-- 
2.21.0
