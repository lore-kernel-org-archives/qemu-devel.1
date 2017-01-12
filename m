Received: from eggs.gnu.org ([2001:4830:134:3::10]:47932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cRk38-0000vh-T6
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:24:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cRk37-0002L0-QB
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:24:34 -0500
From: Laszlo Ersek <lersek@redhat.com>
Date: Thu, 12 Jan 2017 19:24:13 +0100
Message-Id: <20170112182417.9548-1-lersek@redhat.com>
Subject: [Qemu-devel] [PATCH v6 wave 1 0/4] fw-cfg: support writeable blobs
 and more files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel list <qemu-devel@nongnu.org>
Cc: "Gabriel L. Somlo" <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, Anthony Perard <anthony.perard@citrix.com>, Artyom Tarasenko <atar4qemu@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Michael Walle <michael@walle.cc>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-arm@nongnu.org

Previous version (v5):
http://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg01897.html

Changes in v6 (see the individual patches for details):
- pick up feedback tags
- rename the "file_slots" property to "x-file-slots" [Eduardo, Michael]

Cc: "Gabriel L. Somlo" <somlo@cmu.edu>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alexander Graf <agraf@suse.de>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Gabriel Somlo <somlo@cmu.edu>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Michael Walle <michael@walle.cc>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-arm@nongnu.org

Thanks!
Laszlo

Eduardo Habkost (1):
  pc: Add 2.9 machine-types

Laszlo Ersek (2):
  fw-cfg: turn FW_CFG_FILE_SLOTS into a device property
  fw-cfg: bump "x-file-slots" to 0x20 for 2.9+ machine types

Michael S. Tsirkin (1):
  fw-cfg: support writeable blobs

 docs/specs/fw_cfg.txt          |  36 ++++++++++----
 hw/lm32/lm32_hwsetup.h         |   2 +-
 include/hw/compat.h            |  10 +++-
 include/hw/i386/pc.h           |   2 +
 include/hw/loader.h            |   7 +--
 include/hw/nvram/fw_cfg.h      |   3 +-
 include/hw/nvram/fw_cfg_keys.h |   3 +-
 hw/arm/virt-acpi-build.c       |   2 +-
 hw/core/loader.c               |  18 ++++---
 hw/i386/acpi-build.c           |   4 +-
 hw/i386/pc_piix.c              |  15 ++++--
 hw/i386/pc_q35.c               |  13 ++++-
 hw/nvram/fw_cfg.c              | 110 +++++++++++++++++++++++++++++++++++------
 13 files changed, 177 insertions(+), 48 deletions(-)

-- 
2.9.3
