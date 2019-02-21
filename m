Received: from eggs.gnu.org ([209.51.188.92]:52102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwtXo-0008S3-Ux
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:58:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwtXn-0007Qw-1g
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:58:04 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:34632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gwtXl-0007OW-4e
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:58:02 -0500
Received: by mail-wr1-x42f.google.com with SMTP id f14so31906694wrg.1
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 10:57:59 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	c18sm29065085wre.32.2019.02.21.10.57.57 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 21 Feb 2019 10:57:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Feb 2019 18:57:31 +0000
Message-Id: <20190221185739.25362-14-peter.maydell@linaro.org>
In-Reply-To: <20190221185739.25362-1-peter.maydell@linaro.org>
References: <20190221185739.25362-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/21] hw/char/pl011: Use '0x' prefix when
 logging hex numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The pl011 logs when the guest makes a bad access. It prints
the address offset in hex but confusingly omits the '0x'
prefix; add it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
