Received: from eggs.gnu.org ([209.51.188.92]:56578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghfra-0005Yo-3D
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 14:19:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghfrX-0000JL-OZ
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 14:19:33 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 10 Jan 2019 13:18:58 -0600
Message-Id: <20190110191901.5082-5-eblake@redhat.com>
In-Reply-To: <20190110191901.5082-1-eblake@redhat.com>
References: <20190110191901.5082-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 4/6] qemu: Prefer '(x * MiB)' over 'S_xiB'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lbloch@janustech.com, armbru@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Now that QemuOpts can accept true integer defaults, we no longer
have to be careful about the spelling of our default macros because
we are no longer applying stringify() to any of the macros.
Although it is slightly more verbose to call out an integer times
a scale, it avoids the need to have a list of S_*iB macros that
were used in commit b6a95c6d.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index a98d24500b2..d8db6622774 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -50,11 +50,11 @@

 /* 8 MB refcount table is enough for 2 PB images at 64k cluster size
  * (128 GB for 512 byte clusters, 2 EB for 2 MB clusters) */
-#define QCOW_MAX_REFTABLE_SIZE S_8MiB
+#define QCOW_MAX_REFTABLE_SIZE (8 * MiB)

 /* 32 MB L1 table is enough for 2 PB images at 64k cluster size
  * (128 GB for 512 byte clusters, 2 EB for 2 MB clusters) */
-#define QCOW_MAX_L1_SIZE S_32MiB
+#define QCOW_MAX_L1_SIZE (32 * MiB)

 /* Allow for an average of 1k per snapshot table entry, should be plenty=
 of
  * space for snapshot names and IDs */
@@ -81,15 +81,15 @@
 #define MIN_REFCOUNT_CACHE_SIZE 4 /* clusters */

 #ifdef CONFIG_LINUX
-#define DEFAULT_L2_CACHE_MAX_SIZE S_32MiB
+#define DEFAULT_L2_CACHE_MAX_SIZE (32 * MiB)
 #define DEFAULT_CACHE_CLEAN_INTERVAL 600  /* seconds */
 #else
-#define DEFAULT_L2_CACHE_MAX_SIZE S_8MiB
+#define DEFAULT_L2_CACHE_MAX_SIZE (8 * MiB)
 /* Cache clean interval is currently available only on Linux, so must be=
 0 */
 #define DEFAULT_CACHE_CLEAN_INTERVAL 0
 #endif

-#define DEFAULT_CLUSTER_SIZE S_64KiB
+#define DEFAULT_CLUSTER_SIZE (64 * KiB)

 #define QCOW2_OPT_LAZY_REFCOUNTS "lazy-refcounts"
 #define QCOW2_OPT_DISCARD_REQUEST "pass-discard-request"
--=20
2.20.1
