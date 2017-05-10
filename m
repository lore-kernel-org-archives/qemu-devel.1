Received: from eggs.gnu.org ([2001:4830:134:3::10]:54204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d8Qp3-0002fJ-3q
	for qemu-devel@nongnu.org; Wed, 10 May 2017 08:34:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d8Qp0-0007ZF-1E
	for qemu-devel@nongnu.org; Wed, 10 May 2017 08:34:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1d8Qoz-0007Yy-P2
	for qemu-devel@nongnu.org; Wed, 10 May 2017 08:34:25 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BAC9480C01
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 12:34:24 +0000 (UTC)
Date: Wed, 10 May 2017 14:34:21 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170510143421.15aa18a3@nial.brq.redhat.com>
In-Reply-To: <1494353524-5630-1-git-send-email-mst@redhat.com>
References: <1494353524-5630-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] acpi-defs: clean up open brace usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, 9 May 2017 21:12:09 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> patchew has been saying:
> ERROR: open brace '{' following struct go on the same line
> 
> Fix up acpi-defs.h to follow this rule.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: "Michael S. Tsirkin" <mst@redhat.com>

> ---
>  include/hw/acpi/acpi-defs.h | 37 +++++++++++++------------------------
>  1 file changed, 13 insertions(+), 24 deletions(-)
> 
> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> index dff6d4f..7316a02 100644
> --- a/include/hw/acpi/acpi-defs.h
> +++ b/include/hw/acpi/acpi-defs.h
> @@ -81,8 +81,8 @@ typedef struct AcpiRsdpDescriptor AcpiRsdpDescriptor;
>      uint32_t asl_compiler_revision;  /* ASL compiler revision number */
>  
>  
> -struct AcpiTableHeader         /* ACPI common table header */
> -{
> +/* ACPI common table header */
> +struct AcpiTableHeader {
>      ACPI_TABLE_HEADER_DEF
>  } QEMU_PACKED;
>  typedef struct AcpiTableHeader AcpiTableHeader;
> @@ -133,8 +133,7 @@ typedef struct AcpiTableHeader AcpiTableHeader;
>      uint8_t  mon_alrm;     /* Index to month-of-year alarm in RTC CMOS RAM */ \
>      uint8_t  century;      /* Index to century in RTC CMOS RAM */
>  
> -struct AcpiFadtDescriptorRev1
> -{
> +struct AcpiFadtDescriptorRev1 {
>      ACPI_FADT_COMMON_DEF
>      uint8_t  reserved4;              /* Reserved */
>      uint8_t  reserved4a;             /* Reserved */
> @@ -229,8 +228,7 @@ typedef struct AcpiSerialPortConsoleRedirection
>  /*
>   * ACPI 1.0 Root System Description Table (RSDT)
>   */
> -struct AcpiRsdtDescriptorRev1
> -{
> +struct AcpiRsdtDescriptorRev1 {
>      ACPI_TABLE_HEADER_DEF       /* ACPI common table header */
>      uint32_t table_offset_entry[0];  /* Array of pointers to other */
>      /* ACPI tables */
> @@ -240,8 +238,7 @@ typedef struct AcpiRsdtDescriptorRev1 AcpiRsdtDescriptorRev1;
>  /*
>   * ACPI 2.0 eXtended System Description Table (XSDT)
>   */
> -struct AcpiXsdtDescriptorRev2
> -{
> +struct AcpiXsdtDescriptorRev2 {
>      ACPI_TABLE_HEADER_DEF       /* ACPI common table header */
>      uint64_t table_offset_entry[0];  /* Array of pointers to other */
>      /* ACPI tables */
> @@ -251,8 +248,7 @@ typedef struct AcpiXsdtDescriptorRev2 AcpiXsdtDescriptorRev2;
>  /*
>   * ACPI 1.0 Firmware ACPI Control Structure (FACS)
>   */
> -struct AcpiFacsDescriptorRev1
> -{
> +struct AcpiFacsDescriptorRev1 {
>      uint32_t signature;           /* ACPI Signature */
>      uint32_t length;                 /* Length of structure, in bytes */
>      uint32_t hardware_signature;     /* Hardware configuration signature */
> @@ -278,8 +274,7 @@ typedef struct AcpiFacsDescriptorRev1 AcpiFacsDescriptorRev1;
>  
>  /* Master MADT */
>  
> -struct AcpiMultipleApicTable
> -{
> +struct AcpiMultipleApicTable {
>      ACPI_TABLE_HEADER_DEF     /* ACPI common table header */
>      uint32_t local_apic_address;     /* Physical address of local APIC */
>      uint32_t flags;
> @@ -315,8 +310,7 @@ typedef struct AcpiMultipleApicTable AcpiMultipleApicTable;
>  
>  /* Sub-structures for MADT */
>  
> -struct AcpiMadtProcessorApic
> -{
> +struct AcpiMadtProcessorApic {
>      ACPI_SUB_HEADER_DEF
>      uint8_t  processor_id;           /* ACPI processor id */
>      uint8_t  local_apic_id;          /* Processor's local APIC id */
> @@ -324,8 +318,7 @@ struct AcpiMadtProcessorApic
>  } QEMU_PACKED;
>  typedef struct AcpiMadtProcessorApic AcpiMadtProcessorApic;
>  
> -struct AcpiMadtIoApic
> -{
> +struct AcpiMadtIoApic {
>      ACPI_SUB_HEADER_DEF
>      uint8_t  io_apic_id;             /* I/O APIC ID */
>      uint8_t  reserved;               /* Reserved - must be zero */
> @@ -478,8 +471,7 @@ typedef struct Acpi20Hpet Acpi20Hpet;
>   * SRAT (NUMA topology description) table
>   */
>  
> -struct AcpiSystemResourceAffinityTable
> -{
> +struct AcpiSystemResourceAffinityTable {
>      ACPI_TABLE_HEADER_DEF
>      uint32_t    reserved1;
>      uint32_t    reserved2[2];
> @@ -491,8 +483,7 @@ typedef struct AcpiSystemResourceAffinityTable AcpiSystemResourceAffinityTable;
>  #define ACPI_SRAT_PROCESSOR_x2APIC   2
>  #define ACPI_SRAT_PROCESSOR_GICC     3
>  
> -struct AcpiSratProcessorAffinity
> -{
> +struct AcpiSratProcessorAffinity {
>      ACPI_SUB_HEADER_DEF
>      uint8_t     proximity_lo;
>      uint8_t     local_apic_id;
> @@ -514,8 +505,7 @@ struct AcpiSratProcessorX2ApicAffinity {
>  } QEMU_PACKED;
>  typedef struct AcpiSratProcessorX2ApicAffinity AcpiSratProcessorX2ApicAffinity;
>  
> -struct AcpiSratMemoryAffinity
> -{
> +struct AcpiSratMemoryAffinity {
>      ACPI_SUB_HEADER_DEF
>      uint32_t    proximity;
>      uint16_t    reserved1;
> @@ -527,8 +517,7 @@ struct AcpiSratMemoryAffinity
>  } QEMU_PACKED;
>  typedef struct AcpiSratMemoryAffinity AcpiSratMemoryAffinity;
>  
> -struct AcpiSratProcessorGiccAffinity
> -{
> +struct AcpiSratProcessorGiccAffinity {
>      ACPI_SUB_HEADER_DEF
>      uint32_t    proximity;
>      uint32_t    acpi_processor_uid;
