Received: from eggs.gnu.org ([2001:4830:134:3::10]:51814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGp07-0006j2-9h
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:00:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGp03-0000ZQ-J3
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:00:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dGp03-0000YC-A7
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:00:31 -0400
From: Laszlo Ersek <lersek@redhat.com>
Date: Fri,  2 Jun 2017 18:00:02 +0200
Message-Id: <20170602160006.1748-4-lersek@redhat.com>
In-Reply-To: <20170602160006.1748-1-lersek@redhat.com>
References: <c76b36de-ebf9-c662-d454-0a95b43901e8@redhat.com>
	<20170602160006.1748-1-lersek@redhat.com>
Subject: [Qemu-devel] [qemu PATCH 3/7] hw/acpi/bios-linker-loader: introduce
 BIOS_LINKER_LOADER_ALLOC_ZONE_64BIT
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

Using this allocation zone permits the guest firmware to allocate the blob
being downloaded anywhere in the 64-bit address space. QEMU code that
generates ADD_POINTER commands with @src_file set to such a blob is
responsible for using @dst_patched_offset_size=8.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Ben Warren <ben@skyportsystems.com>
Cc: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---
 include/hw/acpi/bios-linker-loader.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/hw/acpi/bios-linker-loader.h b/include/hw/acpi/bios-linker-loader.h
index 5202fd14977d..621de7bd98e8 100644
--- a/include/hw/acpi/bios-linker-loader.h
+++ b/include/hw/acpi/bios-linker-loader.h
@@ -11,10 +11,13 @@ typedef enum BIOSLinkerLoaderAllocZone {
     /* request blob allocation in 32-bit memory */
     BIOS_LINKER_LOADER_ALLOC_ZONE_HIGH = 0x1,
 
     /* request blob allocation in FSEG zone (useful for the RSDP ACPI table) */
     BIOS_LINKER_LOADER_ALLOC_ZONE_FSEG = 0x2,
+
+    /* request blob allocation in 64-bit memory */
+    BIOS_LINKER_LOADER_ALLOC_ZONE_64BIT = 0x3,
 } BIOSLinkerLoaderAllocZone;
 
 typedef enum BIOSLinkerLoaderAllocContent {
     /* the blob may or may not contain ACPI tables */
     BIOS_LINKER_LOADER_ALLOC_CONTENT_MIXED = 0x00,
-- 
2.9.3
