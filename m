Received: from eggs.gnu.org ([2001:4830:134:3::10]:54655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shannon.zhaosl@gmail.com>) id 1gIVdO-00032g-Iu
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 05:20:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shannon.zhaosl@gmail.com>) id 1gIVdN-0006vf-Ah
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 05:20:54 -0400
References: <20181101102303.16439-1-sameo@linux.intel.com>
	<20181101102303.16439-4-sameo@linux.intel.com>
From: Shannon Zhao <shannon.zhaosl@gmail.com>
Message-ID: <a7c05368-908e-0249-5702-63a844f9dc71@gmail.com>
Date: Fri, 2 Nov 2018 17:20:35 +0800
MIME-Version: 1.0
In-Reply-To: <20181101102303.16439-4-sameo@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 03/23] hw: acpi: Export the RSDP build
 API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "open list:ARM ACPI Subsystem" <qemu-arm@nongnu.org>, Richard Henderson <rth@twiddle.net>

Hi,

On 2018/11/1 18:22, Samuel Ortiz wrote:
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index f28a2faa53..0ed132b79b 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -367,7 +367,7 @@ static void acpi_dsdt_add_power_button(Aml *scope)
>   }
>   
>   /* RSDP */
> -static GArray *
> +static void
>   build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_offset)
>   {
>       AcpiRsdpDescriptor *rsdp = acpi_data_push(rsdp_table, sizeof *rsdp);

Why change this? It's not related to your patch purpose.

Thanks,
Shannon
