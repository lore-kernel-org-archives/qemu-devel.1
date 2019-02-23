Received: from eggs.gnu.org ([209.51.188.92]:55764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gxKqU-0000Dz-Bc
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 19:07:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gxKqS-0001hv-EQ
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 19:07:10 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 22 Feb 2019 19:06:13 -0500
Message-Id: <20190223000614.13894-10-jsnow@redhat.com>
In-Reply-To: <20190223000614.13894-1-jsnow@redhat.com>
References: <20190223000614.13894-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v3 09/10] blockdev: remove unused paio
 parameter documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, libvir-list@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>

This field isn't present anymore.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index 1aaadb6128..cbce44877d 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1255,7 +1255,6 @@ out_aio_context:
  * @node: The name of the BDS node to search for bitmaps
  * @name: The name of the bitmap to search for
  * @pbs: Output pointer for BDS lookup, if desired. Can be NULL.
- * @paio: Output pointer for aio_context acquisition, if desired. Can be NULL.
  * @errp: Output pointer for error information. Can be NULL.
  *
  * @return: A bitmap object on success, or NULL on failure.
-- 
2.17.2
