Received: from eggs.gnu.org ([2001:4830:134:3::10]:55188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4CaR-0001Mt-5d
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4CaQ-00012S-BH
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:33:55 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 28 Apr 2017 22:33:09 +0200
Message-Id: <1493411622-5343-2-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
References: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/34] block: Constify data passed by pointer to
 blk_name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Krzysztof Kozlowski <krzk@kernel.org>

blk_name() is not modifying data passed to it through pointer and it
returns also a pointer to const so the argument can be made const for
code safeness.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/block-backend.c          | 2 +-
 include/sysemu/block-backend.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 7405024..ae3d771 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -420,7 +420,7 @@ void monitor_remove_blk(BlockBackend *blk)
  * Return @blk's name, a non-null string.
  * Returns an empty string iff @blk is not referenced by the monitor.
  */
-const char *blk_name(BlockBackend *blk)
+const char *blk_name(const BlockBackend *blk)
 {
     return blk->name ?: "";
 }
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backen=
d.h
index 7462228..133e542 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -99,7 +99,7 @@ int blk_get_refcnt(BlockBackend *blk);
 void blk_ref(BlockBackend *blk);
 void blk_unref(BlockBackend *blk);
 void blk_remove_all_bs(void);
-const char *blk_name(BlockBackend *blk);
+const char *blk_name(const BlockBackend *blk);
 BlockBackend *blk_by_name(const char *name);
 BlockBackend *blk_next(BlockBackend *blk);
 bool monitor_add_blk(BlockBackend *blk, const char *name, Error **errp);
--=20
1.8.3.1
