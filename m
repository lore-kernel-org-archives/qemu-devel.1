Received: from eggs.gnu.org ([209.51.188.92]:44848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2M7J-0000rG-8C
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2M7G-0006uH-HU
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1h2M7F-0006o8-85
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:13 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Mar 2019 15:28:50 -0500
Message-Id: <20190308202858.26636-10-jsnow@redhat.com>
In-Reply-To: <20190308202858.26636-1-jsnow@redhat.com>
References: <20190308202858.26636-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 09/17] blockdev: remove unused paio parameter
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org

This field isn't present anymore.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190223000614.13894-10-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index b4d790131e..8e002cf681 100644
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
