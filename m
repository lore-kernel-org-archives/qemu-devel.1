Received: from eggs.gnu.org ([209.51.188.92]:49693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guGdx-0002tT-S2
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:01:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guGUD-0006nF-8K
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 07:51:31 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guGU2-0006Xe-OK
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 07:51:22 -0500
Received: by mail-wm1-x344.google.com with SMTP id v26so5975960wmh.3
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 04:51:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 12:51:00 +0000
Message-Id: <20190214125107.22178-8-peter.maydell@linaro.org>
In-Reply-To: <20190214125107.22178-1-peter.maydell@linaro.org>
References: <20190214125107.22178-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 07/14] hw/char/pl011: Use '0x' prefix when
 logging hex numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

The pl011 logs when the guest makes a bad access. It prints
the address offset in hex but confusingly omits the '0x'
prefix; add it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/pl011.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 29f4e5eb224..e5dd448f854 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -143,7 +143,7 @@ static uint64_t pl011_read(void *opaque, hwaddr offset,
         break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "pl011_read: Bad offset %x\n", (int)offset);
+                      "pl011_read: Bad offset 0x%x\n", (int)offset);
         r = 0;
         break;
     }
@@ -232,7 +232,7 @@ static void pl011_write(void *opaque, hwaddr offset,
         break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "pl011_write: Bad offset %x\n", (int)offset);
+                      "pl011_write: Bad offset 0x%x\n", (int)offset);
     }
 }
 
-- 
2.20.1
