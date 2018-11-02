Received: from eggs.gnu.org ([2001:4830:134:3::10]:58680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shannon.zhaosl@gmail.com>) id 1gIVxA-0007ZC-Al
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 05:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shannon.zhaosl@gmail.com>) id 1gIVx9-0002Dq-Ky
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 05:41:20 -0400
References: <20181101102303.16439-1-sameo@linux.intel.com>
	<20181101102303.16439-7-sameo@linux.intel.com>
From: Shannon Zhao <shannon.zhaosl@gmail.com>
Message-ID: <ef5c7f5c-b5b0-ad0f-7e49-3c900e668429@gmail.com>
Date: Fri, 2 Nov 2018 17:41:00 +0800
MIME-Version: 1.0
In-Reply-To: <20181101102303.16439-7-sameo@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v4 06/23] hw: acpi: Generalize
 AML build routines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>, qemu-devel@nongnu.org
Cc: Yang Zhong <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>, "open list:ARM ACPI Subsystem" <qemu-arm@nongnu.org>, Richard Henderson <rth@twiddle.net>



On 2018/11/1 18:22, Samuel Ortiz wrote:
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 0a6a88380a..6822ee4eaa 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -546,7 +546,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>   }
>   
>   static void
> -build_mcfg(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> +virt_build_mcfg(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>   {
>       AcpiTableMcfg *mcfg;
>       const MemMapEntry *memmap = vms->memmap;
> @@ -791,7 +791,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>       build_gtdt(tables_blob, tables->linker, vms);
>   
>       acpi_add_table(table_offsets, tables_blob);
> -    build_mcfg(tables_blob, tables->linker, vms);
> +    virt_build_mcfg(tables_blob, tables->linker, vms);
Looks like it doesn't share build_mcfg with x86. Why you still export 
the x86 build_mcfg and introduce this unnecessary change?

Thanks,
Shannon
