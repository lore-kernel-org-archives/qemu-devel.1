Received: from eggs.gnu.org ([2001:4830:134:3::10]:37552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eBuA1-0007TL-4B
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 22:02:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eBuA0-0003Pl-7n
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 22:02:45 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon,  6 Nov 2017 21:02:29 -0600
Message-Id: <20171107030236.23633-2-eblake@redhat.com>
In-Reply-To: <20171107030236.23633-1-eblake@redhat.com>
References: <20171107030236.23633-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 1/8] nbd-client: Fix error message typos
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Provide missing spaces that are required when using string
concatenation to break error messages across source lines.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd-client.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index b44d4d4a01..de6c153328 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -248,7 +248,7 @@ static int nbd_parse_error_payload(NBDStructuredReplyChunk *chunk,

     error = nbd_errno_to_system_errno(payload_advance32(&payload));
     if (error == 0) {
-        error_setg(errp, "Protocol error: server sent structured error chunk"
+        error_setg(errp, "Protocol error: server sent structured error chunk "
                          "with error = 0");
         return -EINVAL;
     }
@@ -257,7 +257,7 @@ static int nbd_parse_error_payload(NBDStructuredReplyChunk *chunk,
     message_size = payload_advance16(&payload);

     if (message_size > chunk->length - sizeof(error) - sizeof(message_size)) {
-        error_setg(errp, "Protocol error: server sent structured error chunk"
+        error_setg(errp, "Protocol error: server sent structured error chunk "
                          "with incorrect message size");
         return -EINVAL;
     }
@@ -408,7 +408,7 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
     if (chunk->type == NBD_REPLY_TYPE_NONE) {
         if (!(chunk->flags & NBD_REPLY_FLAG_DONE)) {
             error_setg(errp, "Protocol error: NBD_REPLY_TYPE_NONE chunk without"
-                             "NBD_REPLY_FLAG_DONE flag set");
+                       " NBD_REPLY_FLAG_DONE flag set");
             return -EINVAL;
         }
         return 0;
-- 
2.13.6
