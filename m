Received: from eggs.gnu.org ([2001:4830:134:3::10]:45658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1e7OB2-0004cd-Q2
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 12:05:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1e7OB1-0005R8-SH
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 12:05:08 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:49642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1e7OB1-0005Q8-Mr
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 12:05:07 -0400
Received: by mail-io0-x243.google.com with SMTP id n137so1543125iod.6
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 09:05:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 25 Oct 2017 18:04:46 +0200
Message-ID: <CACXAS8DjrV+k_6Hp508z+DFvUmw4eNPRYQigYrSGvzVrV_bVJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCHv4 00/13] sun4m: sparc32_dma tidy-ups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Wed, Oct 25, 2017 at 5:59 PM, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> This patchset aims to tidy-up the sparc32_dma code by improving the
> modelling of the espdma/ledma devices using both QOM and the memory
> API which didn't exist when the code was first written.
>
> The result is that it is now possible to remove both the iommu_opaque
> and is_ledma workarounds from the code, and the code for wiring up
> the espdma/ledma and respective devices is also a lot more readable.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

>
> v4:
> - Rebase onto git master
> - Update patch 9 to move lance QOM macros/SysBusPCNetState from sun4m.h to lance.h as suggested by Peter
> - Add Reviewed-by from Peter for patch 7
>
> v3:
> - Add missing sysbus.h include to esp.h in patch 7
>
> v2:
> - Make esp/lance devices children of espdma/ledma devices respectively
> - Add len parameter to ledma/espdma tracepoints
>
>
> Mark Cave-Ayland (13):
>   sparc32_dma: rename SPARC32_DMA type to SPARC32_DMA_DEVICE
>   sparc32_dma: split esp and le into separate DMA devices
>   sparc32_dma: move type declarations from sparc32_dma.c to
>     sparc32_dma.h
>   sun4m: move DMA device wiring from sparc32_dma_init() to
>     sun4m_hw_init()
>   sun4m_iommu: move TYPE_SUN4M_IOMMU declaration to sun4m.h
>   sparc32_dma: use object link instead of qdev property to pass IOMMU
>     reference
>   esp: move TYPE_ESP and SysBusESPState from esp.c to esp.h
>   sparc32_dma: make esp device child of espdma device
>   lance: move TYPE_LANCE and SysBusPCNetState from lance.c to lance.h
>   sparc32_dma: make lance device child of ledma device
>   sparc32_dma: introduce new SPARC32_DMA type container object
>   sparc32_dma: remove is_ledma hack and replace with memory region
>     alias
>   sparc32_dma: add len to esp/le DMA memory tracing
>
>  hw/dma/sparc32_dma.c           |  235 +++++++++++++++++++++++++++++-----------
>  hw/dma/sun4m_iommu.c           |   14 ---
>  hw/dma/trace-events            |    8 +-
>  hw/net/lance.c                 |   11 +-
>  hw/scsi/esp.c                  |   13 ---
>  hw/sparc/sun4m.c               |   82 ++++++--------
>  include/hw/net/lance.h         |   41 +++++++
>  include/hw/scsi/esp.h          |   14 +++
>  include/hw/sparc/sparc32_dma.h |   55 ++++++++++
>  include/hw/sparc/sun4m.h       |   16 +++
>  10 files changed, 336 insertions(+), 153 deletions(-)
>  create mode 100644 include/hw/net/lance.h
>
> --
> 1.7.10.4
>



-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu
