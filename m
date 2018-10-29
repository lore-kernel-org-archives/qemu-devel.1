Received: from eggs.gnu.org ([2001:4830:134:3::10]:35566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHG5V-0007mV-PW
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 18:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHG5V-0006Bl-1D
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 18:32:45 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon, 29 Oct 2018 23:32:04 +0100
Message-Id: <20181029223207.31878-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] hw/arm: Enable USB OHCI/EHCI on Allwinner
 A10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Icenowy Zheng <icenowy@aosc.xyz>, Guenter Roeck <linux@roeck-us.net>, Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Hi, this series intend to salvage previous work from Guenter Roeck [1].

A similar series from Icenowy Zheng was later reviewed by Gerd Hoffmann:
https://lists.gnu.org/archive/html/qemu-arm/2017-01/msg00345.html [2].

I reviewed patches 1 and 3, Gerd already reviewed patch 2 ([2]), if he
agrees to add his R-b tag again, this series is fully reviewed.

Regards,

Phil.

[1] https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg06302.html

Guenter Roeck (3):
  arm: allwinner: Enable USB OHCI
  usb: ehci: Add support for Allwinner A10
  arm: allwinner: Enable USB EHCI

 hw/arm/allwinner-a10.c   |  9 +++++++++
 hw/usb/hcd-ehci-sysbus.c | 17 +++++++++++++++++
 hw/usb/hcd-ehci.h        |  1 +
 3 files changed, 27 insertions(+)

--=20
2.17.2
