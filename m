Received: from eggs.gnu.org ([2001:4830:134:3::10]:35865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHG6n-0000c9-PH
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 18:34:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHG6m-0006rO-K7
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 18:34:05 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon, 29 Oct 2018 23:32:07 +0100
Message-Id: <20181029223207.31878-4-philmd@redhat.com>
In-Reply-To: <20181029223207.31878-1-philmd@redhat.com>
References: <20181029223207.31878-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] arm: allwinner: Enable USB EHCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Icenowy Zheng <icenowy@aosc.xyz>, Guenter Roeck <linux@roeck-us.net>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>

From: Guenter Roeck <linux@roeck-us.net>

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
[PMD: Intented tabs -> space]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/allwinner-a10.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 0a8ac929f5..92ab66354a 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -116,6 +116,8 @@ static void aw_a10_realize(DeviceState *dev, Error **=
errp)
     if (machine_usb(current_machine)) {
         sysbus_create_simple("sysbus-ohci", 0x01c14400, s->irq[64]);
         sysbus_create_simple("sysbus-ohci", 0x01c1c400, s->irq[65]);
+        sysbus_create_simple(TYPE_AW_A10_EHCI, 0x01c14000, s->irq[39]);
+        sysbus_create_simple(TYPE_AW_A10_EHCI, 0x01c1c000, s->irq[40]);
     }
 }
=20
--=20
2.17.2
