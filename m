Received: from eggs.gnu.org ([2001:4830:134:3::10]:33195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1cxarP-0001sF-6u
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:04:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1cxarL-000122-6S
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:04:07 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:33455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1cxarK-000117-W9
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:04:03 -0400
Received: by mail-wr0-x22b.google.com with SMTP id l28so21460180wre.0
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 08:04:01 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 10 Apr 2017 16:03:49 +0100
Message-Id: <20170410150350.3267-1-ard.biesheuvel@linaro.org>
Subject: [Qemu-devel] [PATCH v3 1/2] hw/acpi-defs: replace leading X with x_
 in FADT field names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, lersek@redhat.com
Cc: phil@philjordan.eu, mst@redhat.com, imammedo@redhat.com, drjones@redhat.com, zhaoshenglong@huawei.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>

At the request of Michael, replace the leading capital X in the FADT
field name Xfacs and Xdsdt with lower case x + underscore.

Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/hw/acpi/acpi-defs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 4cc3630e613e..db48807056b3 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -165,8 +165,8 @@ struct AcpiFadtDescriptorRev5_1 {
     /* ARM-Specific Boot Flags (see below for individual flags) (ACPI 5.1) */
     uint16_t arm_boot_flags;
     uint8_t minor_revision;  /* FADT Minor Revision (ACPI 5.1) */
-    uint64_t Xfacs;          /* 64-bit physical address of FACS */
-    uint64_t Xdsdt;          /* 64-bit physical address of DSDT */
+    uint64_t x_facs;         /* 64-bit physical address of FACS */
+    uint64_t x_dsdt;         /* 64-bit physical address of DSDT */
     /* 64-bit Extended Power Mgt 1a Event Reg Blk address */
     struct AcpiGenericAddress xpm1a_event_block;
     /* 64-bit Extended Power Mgt 1b Event Reg Blk address */
-- 
2.9.3
