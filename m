Received: from eggs.gnu.org ([2001:4830:134:3::10]:45117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d8WyW-0005iC-0Y
	for qemu-devel@nongnu.org; Wed, 10 May 2017 15:08:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d8WyS-0004ow-MD
	for qemu-devel@nongnu.org; Wed, 10 May 2017 15:08:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:65385)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1d8WyS-0004oK-Cj
	for qemu-devel@nongnu.org; Wed, 10 May 2017 15:08:36 -0400
Date: Wed, 10 May 2017 22:08:33 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1494443192-17177-10-git-send-email-mst@redhat.com>
References: <1494443192-17177-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1494443192-17177-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 9/9] acpi-defs: clean up open brace usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>

patchew has been saying:
ERROR: open brace '{' following struct go on the same line

Fix up acpi-defs.h to follow this rule.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/acpi-defs.h | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 91bae7f..72be675 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -81,8 +81,8 @@ typedef struct AcpiRsdpDescriptor AcpiRsdpDescriptor;
     uint32_t asl_compiler_revision;  /* ASL compiler revision number */
 
 
-struct AcpiTableHeader         /* ACPI common table header */
-{
+/* ACPI common table header */
+struct AcpiTableHeader {
     ACPI_TABLE_HEADER_DEF
 } QEMU_PACKED;
 typedef struct AcpiTableHeader AcpiTableHeader;
@@ -224,8 +224,7 @@ typedef struct AcpiSerialPortConsoleRedirection
 /*
  * ACPI 1.0 Root System Description Table (RSDT)
  */
-struct AcpiRsdtDescriptorRev1
-{
+struct AcpiRsdtDescriptorRev1 {
     ACPI_TABLE_HEADER_DEF       /* ACPI common table header */
     uint32_t table_offset_entry[0];  /* Array of pointers to other */
     /* ACPI tables */
@@ -235,8 +234,7 @@ typedef struct AcpiRsdtDescriptorRev1 AcpiRsdtDescriptorRev1;
 /*
  * ACPI 2.0 eXtended System Description Table (XSDT)
  */
-struct AcpiXsdtDescriptorRev2
-{
+struct AcpiXsdtDescriptorRev2 {
     ACPI_TABLE_HEADER_DEF       /* ACPI common table header */
     uint64_t table_offset_entry[0];  /* Array of pointers to other */
     /* ACPI tables */
@@ -246,8 +244,7 @@ typedef struct AcpiXsdtDescriptorRev2 AcpiXsdtDescriptorRev2;
 /*
  * ACPI 1.0 Firmware ACPI Control Structure (FACS)
  */
-struct AcpiFacsDescriptorRev1
-{
+struct AcpiFacsDescriptorRev1 {
     uint32_t signature;           /* ACPI Signature */
     uint32_t length;                 /* Length of structure, in bytes */
     uint32_t hardware_signature;     /* Hardware configuration signature */
@@ -273,8 +270,7 @@ typedef struct AcpiFacsDescriptorRev1 AcpiFacsDescriptorRev1;
 
 /* Master MADT */
 
-struct AcpiMultipleApicTable
-{
+struct AcpiMultipleApicTable {
     ACPI_TABLE_HEADER_DEF     /* ACPI common table header */
     uint32_t local_apic_address;     /* Physical address of local APIC */
     uint32_t flags;
@@ -310,8 +306,7 @@ typedef struct AcpiMultipleApicTable AcpiMultipleApicTable;
 
 /* Sub-structures for MADT */
 
-struct AcpiMadtProcessorApic
-{
+struct AcpiMadtProcessorApic {
     ACPI_SUB_HEADER_DEF
     uint8_t  processor_id;           /* ACPI processor id */
     uint8_t  local_apic_id;          /* Processor's local APIC id */
@@ -319,8 +314,7 @@ struct AcpiMadtProcessorApic
 } QEMU_PACKED;
 typedef struct AcpiMadtProcessorApic AcpiMadtProcessorApic;
 
-struct AcpiMadtIoApic
-{
+struct AcpiMadtIoApic {
     ACPI_SUB_HEADER_DEF
     uint8_t  io_apic_id;             /* I/O APIC ID */
     uint8_t  reserved;               /* Reserved - must be zero */
@@ -473,8 +467,7 @@ typedef struct Acpi20Hpet Acpi20Hpet;
  * SRAT (NUMA topology description) table
  */
 
-struct AcpiSystemResourceAffinityTable
-{
+struct AcpiSystemResourceAffinityTable {
     ACPI_TABLE_HEADER_DEF
     uint32_t    reserved1;
     uint32_t    reserved2[2];
@@ -486,8 +479,7 @@ typedef struct AcpiSystemResourceAffinityTable AcpiSystemResourceAffinityTable;
 #define ACPI_SRAT_PROCESSOR_x2APIC   2
 #define ACPI_SRAT_PROCESSOR_GICC     3
 
-struct AcpiSratProcessorAffinity
-{
+struct AcpiSratProcessorAffinity {
     ACPI_SUB_HEADER_DEF
     uint8_t     proximity_lo;
     uint8_t     local_apic_id;
@@ -509,8 +501,7 @@ struct AcpiSratProcessorX2ApicAffinity {
 } QEMU_PACKED;
 typedef struct AcpiSratProcessorX2ApicAffinity AcpiSratProcessorX2ApicAffinity;
 
-struct AcpiSratMemoryAffinity
-{
+struct AcpiSratMemoryAffinity {
     ACPI_SUB_HEADER_DEF
     uint32_t    proximity;
     uint16_t    reserved1;
@@ -522,8 +513,7 @@ struct AcpiSratMemoryAffinity
 } QEMU_PACKED;
 typedef struct AcpiSratMemoryAffinity AcpiSratMemoryAffinity;
 
-struct AcpiSratProcessorGiccAffinity
-{
+struct AcpiSratProcessorGiccAffinity {
     ACPI_SUB_HEADER_DEF
     uint32_t    proximity;
     uint32_t    acpi_processor_uid;
-- 
MST
