Received: from eggs.gnu.org ([2001:4830:134:3::10]:34387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dQhQJ-0005kY-JD
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 17:56:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dQhQF-0000QR-S1
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 17:56:27 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:36214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dQhQF-0000P2-L4
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 17:56:23 -0400
Received: by mail-lf0-x241.google.com with SMTP id f28so8682508lfi.3
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 14:56:21 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Fri, 30 Jun 2017 00:55:57 +0300
Message-Id: <1498773362-18675-2-git-send-email-zuban32s@gmail.com>
In-Reply-To: <1498773362-18675-1-git-send-email-zuban32s@gmail.com>
References: <1498773362-18675-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [PATCH RFC 1/6] hw/acpi: remove dead acpi code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, mst@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, Aleksandr Bezzubikov <zuban32s@gmail.com>

Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
---
 hw/i386/acpi-build.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index afcadac..6fce967 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1912,16 +1912,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         build_piix4_pci0_int(dsdt);
     } else {
         sb_scope = aml_scope("_SB");
-        aml_append(sb_scope,
-            aml_operation_region("PCST", AML_SYSTEM_IO, aml_int(0xae00), 0x0c));
-        aml_append(sb_scope,
-            aml_operation_region("PCSB", AML_SYSTEM_IO, aml_int(0xae0c), 0x01));
-        field = aml_field("PCSB", AML_ANY_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
-        aml_append(field, aml_named_field("PCIB", 8));
-        aml_append(sb_scope, field);
-        aml_append(dsdt, sb_scope);
-
-        sb_scope = aml_scope("_SB");
         dev = aml_device("PCI0");
         aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
         aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
-- 
2.7.4
