Received: from eggs.gnu.org ([2001:4830:134:3::10]:35200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwTdn-0005H4-4Q
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:41:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwTdm-0006KH-BD
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:41:43 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 25 Sep 2017 08:41:26 -0500
Message-Id: <20170925134130.13262-2-eblake@redhat.com>
In-Reply-To: <20170925134130.13262-1-eblake@redhat.com>
References: <20170925134130.13262-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/4] nbd-client: Use correct macro
 parenthesization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

If 'bs' is a complex expression, we were only casting the front half
rather than the full expression.  Luckily, none of the callers were
passing bad arguments, but it's better to be robust up front.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170918214649.17550-1-eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/nbd-client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index ee7f758e68..cc05e73c2d 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -31,8 +31,8 @@
 #include "qapi/error.h"
 #include "nbd-client.h"

-#define HANDLE_TO_INDEX(bs, handle) ((handle) ^ ((uint64_t)(intptr_t)bs)=
)
-#define INDEX_TO_HANDLE(bs, index)  ((index)  ^ ((uint64_t)(intptr_t)bs)=
)
+#define HANDLE_TO_INDEX(bs, handle) ((handle) ^ (uint64_t)(intptr_t)(bs)=
)
+#define INDEX_TO_HANDLE(bs, index)  ((index)  ^ (uint64_t)(intptr_t)(bs)=
)

 static void nbd_recv_coroutines_wake_all(NBDClientSession *s)
 {
--=20
2.13.5
