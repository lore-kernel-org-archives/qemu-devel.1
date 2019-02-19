Received: from eggs.gnu.org ([209.51.188.92]:43612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gw4MC-0007Yn-8c
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:18:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gw4MB-0000cv-KD
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:18:40 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gw4MB-0000a1-AE
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:18:39 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so2510248wmh.4
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 04:18:39 -0800 (PST)
References: <1550565421-10944-1-git-send-email-thuth@redhat.com>
	<1550565421-10944-2-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1f5be43d-8958-85b9-c5c8-e7534397baeb@redhat.com>
Date: Tue, 19 Feb 2019 13:18:37 +0100
MIME-Version: 1.0
In-Reply-To: <1550565421-10944-2-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/14] MAINTAINERS: Add some missing
 entries for the sun4m machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 2/19/19 9:36 AM, Thomas Huth wrote:
> These files / devices are only used by SPARC machines, so we can sort
> them into the corresponding categories in the MAINTAINERS file.
> 
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  MAINTAINERS | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b1d786c..7e4f70a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1082,12 +1082,15 @@ M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>  S: Maintained
>  F: hw/sparc/sun4m.c
>  F: hw/sparc/sun4m_iommu.c
> +F: hw/display/cg3.c
> +F: hw/display/tcx.c
>  F: hw/dma/sparc32_dma.c
>  F: hw/misc/eccmemctl.c
> -F: hw/misc/slavio_misc.c
> +F: hw/*/slavio_*.c
> +F: include/hw/nvram/sun_nvram.h
>  F: include/hw/sparc/sparc32_dma.h
> -F: pc-bios/openbios-sparc32
>  F: include/hw/sparc/sun4m_iommu.h
> +F: pc-bios/openbios-sparc32
>  
>  Sun4u
>  M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
