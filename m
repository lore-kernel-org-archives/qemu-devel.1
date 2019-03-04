Received: from eggs.gnu.org ([209.51.188.92]:42076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h0s2V-0002bj-In
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:10:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h0s2U-0004yc-Q1
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:10:11 -0500
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:46657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1h0s2U-0004xB-Ip
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:10:10 -0500
From: Sven Schnelle <svens@stackframe.org>
Date: Mon,  4 Mar 2019 19:09:20 +0100
Message-Id: <20190304180920.21534-5-svens@stackframe.org>
In-Reply-To: <20190304180920.21534-1-svens@stackframe.org>
References: <20190304180920.21534-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 5/5] lsi: return dfifo value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sven Schnelle <svens@stackframe.org>, Fam Zheng <fam@euphon.net>, "open list:All patches CC here" <qemu-devel@nongnu.org>

Code was assigning DFIFO, but didn't return the value to users.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 hw/scsi/lsi53c895a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index f635d56e0f..a0e0c57b9b 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -1683,7 +1683,7 @@ static uint8_t lsi_reg_readb(LSIState *s, int offset)
         break;
     CASE_GET_REG32(temp, 0x1c)
     case 0x20: /* DFIFO */
-        ret = 0;
+        ret = s->dfifo;
         break;
     case 0x21: /* CTEST4 */
         ret = s->ctest4;
-- 
2.20.1
