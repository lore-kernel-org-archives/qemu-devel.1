Received: from eggs.gnu.org ([2001:4830:134:3::10]:52312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfzD9-0007kD-Tu
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 21:58:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfzD9-0002OU-2I
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 21:58:04 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 10 Aug 2017 20:57:48 -0500
Message-Id: <20170811015749.20365-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] nbd: Fix trace message for disconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

NBD_CMD_DISC is a disconnect request, not a data discard request.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

Although this is not 2.10 material in isolation (it is only a
bad trace message), I don't mind including it in a larger pull
request; I'm still planning to fix the issue of a client hanging
on a malicious server in time for -rc3 (whether via Vladimir's
patch or a smaller one that I'm testing locally).

 nbd/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nbd/common.c b/nbd/common.c
index a2f28f2eec..e288d1b972 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -182,7 +182,7 @@ const char *nbd_cmd_lookup(uint16_t cmd)
     case NBD_CMD_WRITE:
         return "write";
     case NBD_CMD_DISC:
-        return "discard";
+        return "disconnect";
     case NBD_CMD_FLUSH:
         return "flush";
     case NBD_CMD_TRIM:
-- 
2.13.4
