Received: from eggs.gnu.org ([2001:4830:134:3::10]:59250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1ccZGo-0008DB-82
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 10:07:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1ccZGn-000723-3g
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 10:07:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1ccZGm-00071x-U2
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 10:07:25 -0500
From: P J P <ppandit@redhat.com>
Date: Sat, 11 Feb 2017 20:36:59 +0530
Message-Id: <20170211150701.23391-3-ppandit@redhat.com>
In-Reply-To: <20170211150701.23391-1-ppandit@redhat.com>
References: <20170211150701.23391-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/4] sd: sdhci: mask transfer mode register
 value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair23@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Wjjzhang <wjjzhang@tencent.com>, Jiang Xin <jiangxin1@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

In SDHCI protocol, the transfer mode register is defined
to be of 6 bits. Mask its value with '0x0037' so that an
invalid value couldn't be assigned.

Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/sd/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Update: mask s->trnmod register value
  -> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg02354.html

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index a9c744b..0307b8c 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1050,7 +1050,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         if (!(s->capareg & SDHC_CAN_DO_DMA)) {
             value &= ~SDHC_TRNS_DMA;
         }
-        MASKED_WRITE(s->trnmod, mask, value);
+        MASKED_WRITE(s->trnmod, mask, value & 0x0037);
         MASKED_WRITE(s->cmdreg, mask >> 16, value >> 16);
 
         /* Writing to the upper byte of CMDREG triggers SD command generation */
-- 
2.9.3
