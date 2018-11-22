Received: from eggs.gnu.org ([2001:4830:134:3::10]:55145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gPpIs-0003Av-Mo
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 08:45:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gPpIr-00060K-Tx
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 08:45:58 -0500
References: <1542891760-13937-1-git-send-email-thuth@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <114155bf-fe75-4523-bce3-c1b763df6a43@vivier.eu>
Date: Thu, 22 Nov 2018 14:45:38 +0100
MIME-Version: 1.0
In-Reply-To: <1542891760-13937-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] MAINTAINERS: Add missing
 hw/pci-host entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Paul Burton <pburton@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, David Gibson <david@gibson.dropbear.id.au>

On 22/11/2018 14:02, Thomas Huth wrote:
> Bonito belongs to Fulong-2E, Sabre belongs to Sun4u, and Mac-Newworld
> and Mips-Boston were missing the header files.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6522621..46a5581 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -876,7 +876,7 @@ R: Stefan Markovic <smarkovic@wavecomp.com>
>  S: Odd Fixes
>  F: hw/mips/mips_fulong2e.c
>  F: hw/isa/vt82c686.c
> -
> +F: hw/pci-host/bonito.c
>  F: include/hw/isa/vt82c686.h
>  
>  Boston
> @@ -886,6 +886,7 @@ S: Maintained
>  F: hw/core/loader-fit.c
>  F: hw/mips/boston.c
>  F: hw/pci-host/xilinx-pcie.c
> +F: include/hw/pci-host/xilinx-pcie.h
>  
>  OpenRISC Machines
>  -----------------
> @@ -938,6 +939,7 @@ F: hw/nvram/mac_nvram.c
>  F: include/hw/misc/macio/
>  F: include/hw/misc/mos6522.h
>  F: include/hw/ppc/mac_dbdma.h
> +F: include/hw/pci-host/uninorth.h
>  
>  Old World
>  M: David Gibson <david@gibson.dropbear.id.au>
> @@ -1029,6 +1031,8 @@ M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>  S: Maintained
>  F: hw/sparc64/sun4u.c
>  F: pc-bios/openbios-sparc64
> +F: hw/pci-host/sabre.c
> +F: include/hw/pci-host/sabre.h
>  
>  Sun4v
>  M: Artyom Tarasenko <atar4qemu@gmail.com>
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
