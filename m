Received: from eggs.gnu.org ([2001:4830:134:3::10]:54580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d84zF-00026o-88
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:15:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d84zD-0003NX-0Z
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:15:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1d84zC-0003NP-Qh
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:15:30 -0400
Date: Tue, 9 May 2017 16:15:28 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1494330527-24163-2-git-send-email-mst@redhat.com>
References: <1494330527-24163-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1494330527-24163-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 1/8] hw/acpi-defs: replace leading X with x_ in
 FADT field names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

At the request of Michael, replace the leading capital X in the FADT
field name Xfacs and Xdsdt with lower case x + underscore.

Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/acpi-defs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 4cc3630..db48807 100644
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
MST
