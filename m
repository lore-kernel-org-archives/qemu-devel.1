Received: from eggs.gnu.org ([2001:4830:134:3::10]:53877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eJhY3-0000vX-F5
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:11:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eJhXu-0001wg-2H
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:11:42 -0500
Received: from mail-qt0-x229.google.com ([2607:f8b0:400d:c0d::229]:44047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eJhXt-0001wI-Ul
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:11:37 -0500
Received: by mail-qt0-x229.google.com with SMTP id j5so163869qth.11
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 07:11:37 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1511703326-25325-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1511703326-25325-9-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3aa9b8ef-27b8-b2c5-3392-f34e1a6606dc@amsat.org>
Date: Sun, 26 Nov 2017 12:18:08 -0300
MIME-Version: 1.0
In-Reply-To: <1511703326-25325-9-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 8/8] sun4u_iommu: add trace event for IOMMU
 translations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, atar4qemu@gmail.com

On 11/26/2017 10:35 AM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/sparc64/sun4u_iommu.c |    2 ++
>  hw/sparc64/trace-events  |    1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/hw/sparc64/sun4u_iommu.c b/hw/sparc64/sun4u_iommu.c
> index 51fbc39..4cf8e69 100644
> --- a/hw/sparc64/sun4u_iommu.c
> +++ b/hw/sparc64/sun4u_iommu.c
> @@ -184,6 +184,8 @@ static IOMMUTLBEntry sun4u_translate_iommu(IOMMUMemoryRegion *iommu,
>          ret.addr_mask = (IOMMU_PAGE_SIZE_8K - 1);
>      }
>  
> +    trace_sun4u_iommu_translate(ret.iova, ret.translated_addr, tte);
> +
>      return ret;
>  }
>  
> diff --git a/hw/sparc64/trace-events b/hw/sparc64/trace-events
> index 052352f..2ee2d75 100644
> --- a/hw/sparc64/trace-events
> +++ b/hw/sparc64/trace-events
> @@ -6,3 +6,4 @@ ebus_isa_irq_handler(int n, int level) "Set ISA IRQ %d level %d"
>  # hw/sparc64/sun4u_iommu.c
>  sun4u_iommu_mem_read(uint64_t addr, uint64_t val, int size) "addr: 0x%"PRIx64" val: 0x%"PRIx64" size: %d"
>  sun4u_iommu_mem_write(uint64_t addr, uint64_t val, int size) "addr: 0x%"PRIx64" val: 0x%"PRIx64" size: %d"
> +sun4u_iommu_translate(uint64_t addr, uint64_t trans_addr, uint64_t tte) "xlate 0x%"PRIx64" => pa 0x%"PRIx64" tte: 0x%"PRIx64
> 
