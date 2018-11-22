Received: from eggs.gnu.org ([2001:4830:134:3::10]:44883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPeTb-0005dx-6Y
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 21:12:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPeTY-0005XF-2J
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 21:12:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34669)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gPeTX-0005V3-RT
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 21:12:15 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu, 22 Nov 2018 03:11:39 +0100
Message-Id: <20181122021139.1486-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.1] MAINTAINERS: Add an entry for the
 Firmware Configuration (fw_cfg) device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Li Qiang <liq3ea@gmail.com>

Step in to maintain it, with Laszlo (EDK2) and Gerd (SeaBIOS)
as designated reviewers.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Note than OpenBIOS also consumes this device (PPC/Sparc).

 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1032406c56..b28ec13963 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1534,6 +1534,19 @@ F: hw/display/edid*
 F: include/hw/display/edid.h
 F: qemu-edid.c
=20
+Firmware configuration (fw_cfg)
+M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
+R: Laszlo Ersek <lersek@redhat.com>
+R: Gerd Hoffmann <kraxel@redhat.com>
+S: Supported
+F: docs/specs/fw_cfg.txt
+F: hw/nvram/fw_cfg.c
+F: include/hw/nvram/fw_cfg.h
+F: include/standard-headers/linux/qemu_fw_cfg.h
+F: tests/libqos/fw_cfg.c
+F: tests/fw_cfg-test.c
+T: git https://github.com/philmd/qemu.git fw_cfg-next
+
 Subsystems
 ----------
 Audio
--=20
2.17.2
