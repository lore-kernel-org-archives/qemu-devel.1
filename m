Received: from eggs.gnu.org ([209.51.188.92]:45424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h1GA8-0006MV-RW
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:55:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h1GA8-0005yg-9G
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:55:40 -0500
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:36718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1h1GA8-0005xw-13
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:55:40 -0500
From: Sven Schnelle <svens@stackframe.org>
Date: Tue,  5 Mar 2019 20:55:19 +0100
Message-Id: <20190305195519.24303-6-svens@stackframe.org>
In-Reply-To: <20190305195519.24303-1-svens@stackframe.org>
References: <20190305195519.24303-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 5/5] lsi: return dfifo value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Sven Schnelle <svens@stackframe.org>, Fam Zheng <fam@euphon.net>

Code was assigning DFIFO, but didn't return the value to users.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 hw/scsi/lsi53c895a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 7d66d1a870..3783779da6 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -1688,7 +1688,7 @@ static uint8_t lsi_reg_readb(LSIState *s, int offset)
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
