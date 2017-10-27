Received: from eggs.gnu.org ([2001:4830:134:3::10]:57462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e89tt-0000v4-CU
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 15:02:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e89to-0005jZ-EJ
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 15:02:37 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:56318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e89to-0005jP-8d
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 15:02:32 -0400
Received: by mail-qt0-x242.google.com with SMTP id v41so9617050qtv.12
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 12:02:32 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1508947167-5304-4-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2bb5e6ed-47b5-69a1-be20-9a7d5480ee69@amsat.org>
Date: Fri, 27 Oct 2017 16:02:22 -0300
MIME-Version: 1.0
In-Reply-To: <1508947167-5304-4-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv4 03/13] sparc32_dma: move type
 declarations from sparc32_dma.c to sparc32_dma.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com

> diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
> index e4ff4a8..ae8fa06 100644
> --- a/hw/dma/sparc32_dma.c
> +++ b/hw/dma/sparc32_dma.c
> @@ -40,7 +40,6 @@
>   * http://www.ibiblio.org/pub/historic-linux/early-ports/Sparc/NCR/DMA2.txt
>   */
>  
> -#define DMA_REGS 4
>  #define DMA_SIZE (4 * sizeof(uint32_t))
>  /* We need the mask, because one instance of the device is not page
>     aligned (ledma, start address 0x0010) */

#define DMA_MAX_REG_OFFSET (2 * DMA_SIZE - 1)

^ You can also remove this

> @@ -61,39 +60,6 @@
>  /* XXX SCSI and ethernet should have different read-only bit masks */
>  #define DMA_CSR_RO_MASK 0xfe000007
