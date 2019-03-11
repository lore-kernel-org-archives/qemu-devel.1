Received: from eggs.gnu.org ([209.51.188.92]:60945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODk-0007H2-PI
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODj-0003cu-1e
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:12 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:53912)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h3ODg-0003Wt-HF
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:09 -0400
Received: by mail-wm1-x332.google.com with SMTP id e74so5328307wmg.3
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 09:56:07 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 11 Mar 2019 17:55:30 +0100
Message-Id: <1552323335-46779-27-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
References: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL v2 26/31] lsi: return dfifo value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>

From: Sven Schnelle <svens@stackframe.org>

Code was assigning DFIFO, but didn't return the value to users.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Message-Id: <20190305195519.24303-6-svens@stackframe.org>
---
 hw/scsi/lsi53c895a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 66f217f..bf6b6a5 100644
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
1.8.3.1
