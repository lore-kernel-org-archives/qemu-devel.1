Received: from eggs.gnu.org ([2001:4830:134:3::10]:59491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHBLP-0006I1-Iy
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHBLJ-0004bm-Fe
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:28:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gHBLJ-0004Yq-10
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:28:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id p2-v6so8764190wmc.2
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 10:28:43 -0700 (PDT)
References: <20181029170159.3801-1-sameo@linux.intel.com>
	<20181029170159.3801-20-sameo@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7023e8f9-a7e3-ae11-e1d7-429434e895d3@redhat.com>
Date: Mon, 29 Oct 2018 18:28:39 +0100
MIME-Version: 1.0
In-Reply-To: <20181029170159.3801-20-sameo@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 19/19] hw: i386: Implement the ACPI
 builder interface for PC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On 29/10/2018 18:01, Samuel Ortiz wrote:
> @@ -1556,6 +1557,7 @@ void acpi_build(AcpiBuildTables *tables,
>      GArray *tables_blob = tables->table_data;
>      AcpiSlicOem slic_oem = { .id = NULL, .table_id = NULL };
>      Object *vmgenid_dev;
> +    AcpiBuilder *ab = ACPI_BUILDER(machine);
>  
>      acpi_get_pm_info(&pm);
>      acpi_get_misc_info(&misc);
> @@ -1605,7 +1607,8 @@ void acpi_build(AcpiBuildTables *tables,
>      aml_len += tables_blob->len - fadt;
>  
>      acpi_add_table(table_offsets, tables_blob);
> -    build_madt(tables_blob, tables->linker, machine, conf);
> +    acpi_builder_madt(ab, tables_blob, tables->linker,
> +                      machine, conf);
>  
>      vmgenid_dev = find_vmgenid_dev();
>      if (vmgenid_dev) {

Just a quick question before I go and actually apply the patches to look
at the resulting code: is there any reason why you didn't add the
MachineState and/or AcpiBuilder to AcpiBuildState, similar to how it was
in v1?

Thanks,

Paolo
