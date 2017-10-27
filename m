Received: from eggs.gnu.org ([2001:4830:134:3::10]:57248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e86j9-00008m-Jc
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 11:39:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e86j8-00066Y-KX
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 11:39:19 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:52880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e86j8-00066T-Fe
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 11:39:18 -0400
Received: by mail-qk0-x241.google.com with SMTP id b15so8811472qkg.9
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 08:39:18 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1509106789-8626-1-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f6792a63-383a-de72-53d9-0609b598c383@amsat.org>
Date: Fri, 27 Oct 2017 12:39:15 -0300
MIME-Version: 1.0
In-Reply-To: <1509106789-8626-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv2 0/4] sun4m: implement memory region IOMMU
 translation and DMA API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, atar4qemu@gmail.com
Cc: qemu-devel@nongnu.org

On 10/27/2017 09:19 AM, Mark Cave-Ayland wrote:
> The original sun4m IOMMU/DMA code dates from before the introduction of the QEMU
> memory region API (in particular IOMMU memory regions) and the DMA API.
> 
> This patchset removes these sun4m-specific implementations and replaces them with
> the more up-to-date QEMU APIs instead.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Based-on: 1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk ([PATCHv4 00/13] sun4m: sparc32_dma tidy-ups)
> 
> v2:
> - Rebase onto v4 sparc32_dma tidy-up patchset
> - Change TYPE_SUN4M_IOMMU macro from "iommu" to "sun4m-iommu" as suggested by Philippe
> 
> 
> Mark Cave-Ayland (4):
>   sun4m: implement IOMMU translation using IOMMU memory region
>   sparc32_dma: switch over to using IOMMU memory region and DMA API
>   sun4m_iommu: remove legacy sparc_iommu_memory_rw() function
>   sun4m: change TYPE_SUN4M_IOMMU macro from "iommu" to "sun4m-iommu"

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
