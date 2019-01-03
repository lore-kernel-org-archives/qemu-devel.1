Received: from eggs.gnu.org ([208.118.235.92]:50111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gf320-0002Xp-PG
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:27:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gf31x-0003fX-Im
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:27:28 -0500
Received: from m12-16.163.com ([220.181.12.16]:34678)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gf31w-0003ek-TO
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:27:25 -0500
From: Li Qiang <liq3ea@163.com>
Date: Thu,  3 Jan 2019 05:26:05 -0800
Message-Id: <20190103132605.49476-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH] usb: dev-mtp: fix memory leak in error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, Li Qiang <liq3ea@163.com>

Spotted by Coverity: CID 1397074

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/usb/dev-mtp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 6098005cd4..b19b576278 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1729,6 +1729,7 @@ static void usb_mtp_write_metadata(MTPState *s, uint64_t dlen)
     if (strchr(filename, '/')) {
         usb_mtp_queue_result(s, RES_PARAMETER_NOT_SUPPORTED, d->trans,
                              0, 0, 0, 0);
+        g_free(filename);
         return;
     }
 
-- 
2.17.1
