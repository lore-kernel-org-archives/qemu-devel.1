Received: from eggs.gnu.org ([2001:4830:134:3::10]:51717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGozx-0006aO-2t
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:00:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGozt-0000Or-9c
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:00:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dGozt-0000O9-1h
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:00:21 -0400
From: Laszlo Ersek <lersek@redhat.com>
Date: Fri,  2 Jun 2017 17:59:59 +0200
Message-Id: <20170602160006.1748-1-lersek@redhat.com>
In-Reply-To: <c76b36de-ebf9-c662-d454-0a95b43901e8@redhat.com>
References: <c76b36de-ebf9-c662-d454-0a95b43901e8@redhat.com>
Subject: [Qemu-devel] [qemu PATCH 0/7] bios-linker-loader: introduce the
 NOACPI hint and the 64-bit zone for ALLOCATE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: SeaBIOS@seabios.org, qemu-devel@nongnu.org, edk2-devel@lists.01.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Ben Warren <ben@skyportsystems.com>, Dongjiu Geng <gengdongjiu@huawei.com>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>

Please see the parent blurb
<http://mid.mail-archive.com/c76b36de-ebf9-c662-d454-0a95b43901e8@redhat.com>
for a high level description.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Ben Warren <ben@skyportsystems.com>
Cc: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: Xiao Guangrong <guangrong.xiao@linux.intel.com>

Thanks
Laszlo

Laszlo Ersek (7):
  hw/acpi/bios-linker-loader: expose allocation zone as an enum
  hw/acpi/bios-linker-loader: introduce "no ACPI tables" content hint
    for ALLOC
  hw/acpi/bios-linker-loader: introduce
    BIOS_LINKER_LOADER_ALLOC_ZONE_64BIT
  hw/acpi/nvdimm: ask the firmware to allocate NVDIMM_DSM_MEM_FILE as
    NOACPI
  hw/acpi/vmgenid: ask the fw to alloc VMGENID_GUID_FW_CFG_FILE as
    NOACPI
  hw/i386/acpi-build: ask the fw to alloc ACPI_BUILD_TPMLOG_FILE with
    64bit/NOACPI
  hw/arm/virt-acpi-build: make the fw alloc blobs with ACPI tables as
    64bit

 docs/specs/vmgenid.txt               | 49 ++++++++++++++++--------------------
 include/hw/acpi/bios-linker-loader.h | 22 +++++++++++++++-
 include/hw/acpi/vmgenid.h            |  3 ---
 hw/acpi/bios-linker-loader.c         | 18 ++++++-------
 hw/acpi/nvdimm.c                     |  4 ++-
 hw/acpi/vmgenid.c                    | 25 ++++++------------
 hw/arm/virt-acpi-build.c             |  6 +++--
 hw/i386/acpi-build.c                 |  9 ++++---
 8 files changed, 70 insertions(+), 66 deletions(-)

-- 
2.9.3
