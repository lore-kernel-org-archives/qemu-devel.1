Received: from eggs.gnu.org ([209.51.188.92]:37475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hIz2U-0005mK-Ix
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:17:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hIz2T-0006Qa-4m
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:17:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hIz2S-0006Ov-V9
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:17:01 -0400
From: Laszlo Ersek <lersek@redhat.com>
Date: Tue, 23 Apr 2019 19:15:20 +0200
Message-Id: <20190423171520.4511-13-lersek@redhat.com>
In-Reply-To: <20190423171520.4511-1-lersek@redhat.com>
References: <20190423171520.4511-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/12] MAINTAINERS: add the "EDK2 Firmware"
 subsystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com, eblake@redhat.com, f4bug@amsat.org, imammedo@redhat.com, kraxel@redhat.com, mprivozn@redhat.com, mst@redhat.com, peter.maydell@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org

We now have the edk2 submodule, somewhat elaborate build helpers for it,
and even a UEFI application written against edk2 whose genuine home is th=
e
QEMU repository. Add the "EDK2 Firmware" subsystem such that all relevant
pathnames be covered.

Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---

Notes:
    pull:
   =20
    - pick up Igor's R-b
   =20
    v4:
   =20
    - no change
   =20
    v3:
   =20
    - pick up Michal's R-b
   =20
    - pick up Phil's R-b/T-b
   =20
    - pick up Igor's T-b
   =20
    - pick up Michael's R-b
   =20
    v2:
   =20
    - new patch [Dan, Michael, Phil]
   =20
    - compared to the suggestions, upgrade the maintenance status ("S") f=
rom
      Maintained to Supported

 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 56139ac8ab05..d7505e074a0d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2222,6 +2222,18 @@ F: include/hw/i2c/smbus_master.h
 F: include/hw/i2c/smbus_slave.h
 F: include/hw/i2c/smbus_eeprom.h
=20
+EDK2 Firmware
+M: Laszlo Ersek <lersek@redhat.com>
+M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
+S: Supported
+F: pc-bios/descriptors/??-edk2-*.json
+F: pc-bios/edk2-*
+F: roms/Makefile.edk2
+F: roms/edk2
+F: roms/edk2-*
+F: tests/data/uefi-boot-images/
+F: tests/uefi-test-tools/
+
 Usermode Emulation
 ------------------
 Overall
--=20
2.19.1.3.g30247aa5d201
