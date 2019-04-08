Received: from eggs.gnu.org ([209.51.188.92]:37639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hDZXh-0001kA-Vk
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:02:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hDZXe-0007HN-DL
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:02:52 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  8 Apr 2019 14:02:33 -0500
Message-Id: <20190408190233.10321-5-eblake@redhat.com>
In-Reply-To: <20190408190233.10321-1-eblake@redhat.com>
References: <20190408190233.10321-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/4] nbd/client: Fix error message for server
 with unusable sizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

Add a missing space to the error message used when giving up on a
server that insists on an alignment which renders the last few bytes
of the export unreadable.

Fixes: 3add3ab78
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190404145226.32649-1-eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 nbd/client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nbd/client.c b/nbd/client.c
index 427980bdd22..4de30630c73 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -428,7 +428,7 @@ static int nbd_opt_info_or_go(QIOChannel *ioc, uint32=
_t opt,
             }
             if (info->min_block &&
                 !QEMU_IS_ALIGNED(info->size, info->min_block)) {
-                error_setg(errp, "export size %" PRIu64 "is not multiple=
 of "
+                error_setg(errp, "export size %" PRIu64 " is not multipl=
e of "
                            "minimum block size %" PRIu32, info->size,
                            info->min_block);
                 nbd_send_opt_abort(ioc);
--=20
2.20.1
