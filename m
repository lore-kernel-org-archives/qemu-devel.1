Received: from eggs.gnu.org ([209.51.188.92]:36861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h2Bet-0005dE-HE
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:19:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h2Bes-00007Z-Px
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:19:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h2Beq-0008Tv-Qj
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:19:14 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  8 Mar 2019 10:18:39 +0100
Message-Id: <1552036723-1949-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1552036723-1949-1-git-send-email-thuth@redhat.com>
References: <1552036723-1949-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/7] hw/devices: Remove unused TC6393XB_RAM
 definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Introduced in 64b40bc54a9, this definition is no more used since
a0b753dfd39. Remove it.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/devices.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/hw/devices.h b/include/hw/devices.h
index b5f1662..1ed5be3 100644
--- a/include/hw/devices.h
+++ b/include/hw/devices.h
@@ -52,7 +52,6 @@ void retu_key_event(void *retu, int state);
=20
 /* tc6393xb.c */
 typedef struct TC6393xbState TC6393xbState;
-#define TC6393XB_RAM	0x110000 /* amount of ram for Video and USB */
 TC6393xbState *tc6393xb_init(struct MemoryRegion *sysmem,
                              uint32_t base, qemu_irq irq);
 void tc6393xb_gpio_out_set(TC6393xbState *s, int line,
--=20
1.8.3.1
