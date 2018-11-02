Received: from eggs.gnu.org ([2001:4830:134:3::10]:33394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gIWBz-0008Im-CL
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 05:56:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gIWBv-0006hP-4Q
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 05:56:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gIWBr-0006du-03
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 05:56:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id r10-v6so1340593wrv.6
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 02:56:22 -0700 (PDT)
References: <20181101102303.16439-1-sameo@linux.intel.com>
	<20181101102303.16439-4-sameo@linux.intel.com>
	<a7c05368-908e-0249-5702-63a844f9dc71@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0a0f830b-e9a3-8cb4-12f5-d3fc234036cc@redhat.com>
Date: Fri, 2 Nov 2018 10:56:18 +0100
MIME-Version: 1.0
In-Reply-To: <a7c05368-908e-0249-5702-63a844f9dc71@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Shannon Zhao <shannon.zhaosl@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "open list:ARM ACPI Subsystem" <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi,

On 2/11/18 10:20, Shannon Zhao wrote:
> Hi,
> 
> On 2018/11/1 18:22, Samuel Ortiz wrote:
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index f28a2faa53..0ed132b79b 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -367,7 +367,7 @@ static void acpi_dsdt_add_power_button(Aml *scope)
>>   }
>>   /* RSDP */
>> -static GArray *
>> +static void
>>   build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned 
>> xsdt_tbl_offset)
>>   {
>>       AcpiRsdpDescriptor *rsdp = acpi_data_push(rsdp_table, sizeof 
>> *rsdp);
> 
> Why change this? It's not related to your patch purpose.

This patch updates include/hw/acpi/aml-build.h to export the 
build_rsdp() function.
Since this file includes this header, the orototype needs to match.

Regards,

Phil.

> 
> Thanks,
> Shannon
> 
