Received: from eggs.gnu.org ([209.51.188.92]:56740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hM7oH-0005AL-GE
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hM7oG-0008As-JO
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:15:21 -0400
References: <20190427141459.19728-1-philmd@redhat.com>
	<20190427141459.19728-4-philmd@redhat.com>
	<bb31dd2a-8cd6-0dfe-a71f-4c47ec3d9687@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <65906ce9-944a-0845-5126-2355b1a2f150@vivier.eu>
Date: Thu, 2 May 2019 11:12:08 +0200
MIME-Version: 1.0
In-Reply-To: <bb31dd2a-8cd6-0dfe-a71f-4c47ec3d9687@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH 3/3] hw/dma: Do not build
 the xlnx_dpdma device for the MicroBlaze machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Maydell <peter.maydell@linaro.org>

On 27/04/2019 16:46, Thomas Huth wrote:
> On 27/04/2019 16.14, Philippe Mathieu-Daudé wrote:
>> The xlnx_dpdma device is only used by the ZynqMP AArch64 machine
>> (not the MicroBlaze PMU). Remove it from the ZynqMP generic objects.
>> (Note, this entry was duplicated for the AArch64).
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/dma/Makefile.objs | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/hw/dma/Makefile.objs b/hw/dma/Makefile.objs
>> index 79affecc390..a5b1276f52a 100644
>> --- a/hw/dma/Makefile.objs
>> +++ b/hw/dma/Makefile.objs
>> @@ -8,7 +8,6 @@ common-obj-$(CONFIG_XILINX_AXI) += xilinx_axidma.o
>>  common-obj-$(CONFIG_ZYNQ_DEVCFG) += xlnx-zynq-devcfg.o
>>  common-obj-$(CONFIG_ETRAXFS) += etraxfs_dma.o
>>  common-obj-$(CONFIG_STP2000) += sparc32_dma.o
>> -obj-$(CONFIG_XLNX_ZYNQMP) += xlnx_dpdma.o
>>  obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx_dpdma.o
>>  common-obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx-zdma.o
>>  
>>
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
