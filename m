Received: from eggs.gnu.org ([2001:4830:134:3::10]:51792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1e1pnz-0007Ox-67
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 04:22:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1e1pny-0005RS-1f
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 04:22:23 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:47824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1e1pnx-0005Qt-T4
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 04:22:21 -0400
Received: by mail-it0-x244.google.com with SMTP id p138so1474433itp.2
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 01:22:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1507583223-14819-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1507583223-14819-1-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Tue, 10 Oct 2017 10:21:59 +0200
Message-ID: <CACXAS8CO9K4967T_BdShaNGpznSDXWCYdsBa43mwdvBHh=KZng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/8] sun4m : sparc32_dma tidy-ups
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

On Mon, Oct 9, 2017 at 11:06 PM, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> This patchset aims to tidy-up the sparc32_dma code by improving the
> modelling of the espdma/ledma devices using both QOM and the memory
> API which didn't exist when the code was first written.
>
> The result is that it is now possible to remove both the iommu_opaque
> and is_ledma workarounds from the code.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

>
> Mark Cave-Ayland (8):
>   sparc32_dma: rename SPARC32_DMA type to SPARC32_DMA_DEVICE
>   sparc32_dma: split esp and le into separate DMA devices
>   sparc32_dma: move type declarations from sparc32_dma.c to
>     sparc32_dma.h
>   sun4m: move DMA device wiring from sparc32_dma_init() to
>     sun4m_hw_init()
>   sun4m_iommu: move TYPE_SUN4M_IOMMU declaration to sun4m.h
>   sparc32_dma: use object link instead of qdev property to pass IOMMU
>     reference
>   sparc32_dma: introduce new SPARC32_DMA type container object
>   sparc32_dma: remove is_ledma hack and replace with memory region
>     alias
>
>  hw/dma/sparc32_dma.c           |  165 ++++++++++++++++++++++++++--------------
>  hw/dma/sun4m_iommu.c           |   14 ----
>  hw/sparc/sun4m.c               |   40 +++++-----
>  include/hw/sparc/sparc32_dma.h |   49 ++++++++++++
>  include/hw/sparc/sun4m.h       |   16 ++++
>  5 files changed, 194 insertions(+), 90 deletions(-)
>
> --
> 1.7.10.4
>



-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu
