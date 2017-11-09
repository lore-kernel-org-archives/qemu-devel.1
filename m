Received: from eggs.gnu.org ([2001:4830:134:3::10]:34985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCpvH-0006T5-Nb
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:43:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCpvC-0007GN-SO
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:43:23 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:44200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCpvC-0007G2-N9
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:43:18 -0500
Received: by mail-qt0-x241.google.com with SMTP id 8so8425817qtv.1
	for <qemu-devel@nongnu.org>; Thu, 09 Nov 2017 08:43:18 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171109154645.70920-1-marcel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c86aa3a9-6992-0f4b-1fcf-14992798a6a1@amsat.org>
Date: Thu, 9 Nov 2017 13:43:06 -0300
MIME-Version: 1.0
In-Reply-To: <20171109154645.70920-1-marcel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V5] hw/pcie-pci-bridge: restrict to X86 and
 ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, Paul Burton <paul.burton@mips.com>, Yongbok Kim <yongbok.kim@mips.com>
Cc: thuth@redhat.com, cohuck@redhat.com, zuban32s@gmail.com, mst@redhat.com, Paul Burton <paul.burton@imgtec.com>, Yongbok Kim <yongbok.kim@imgtec.com>

Hi Marcel,

Cc'ing Paul and Yongbok Since I'm not sure their Boston board could also
use it.

On 11/09/2017 12:46 PM, Marcel Apfelbaum wrote:
> The PCIE-PCI bridge is specific to "pure" PCIe systems
> (on QEMU we have X86 and ARM), it does not make sense to
> have it in other archs.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> ---
> 
> V4 -> V5
>   - Since all other tries failed, conditioned the
>     device on the PCIe Root Port.
> 
> V3 -> V4:
>  - Move the config line to pci.mak  (Thomas)
> 
> V2 -> V3:
>  - Another tweak in subject s/if/it (Cornelia) 
> 
> V1 -> V2:
>  Addressed Thomas and Cornelia comments:
>  - Conditioned the pcie-pci-bridge compilation on
>    the PCIe Root CONFIG_PCIE_PORT
>  - Tweaked subject PCI -> PCIe
> 
>  Thanks,
>  Marcel
> 
> 
>  hw/pci-bridge/Makefile.objs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/pci-bridge/Makefile.objs b/hw/pci-bridge/Makefile.objs
> index 666db37da2..1b05023662 100644
> --- a/hw/pci-bridge/Makefile.objs
> +++ b/hw/pci-bridge/Makefile.objs
> @@ -1,5 +1,5 @@
> -common-obj-y += pci_bridge_dev.o pcie_pci_bridge.o
> -common-obj-$(CONFIG_PCIE_PORT) += pcie_root_port.o gen_pcie_root_port.o
> +common-obj-y += pci_bridge_dev.o
> +common-obj-$(CONFIG_PCIE_PORT) += pcie_root_port.o gen_pcie_root_port.o pcie_pci_bridge.o

KISS :)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>  common-obj-$(CONFIG_PXB) += pci_expander_bridge.o
>  common-obj-$(CONFIG_XIO3130) += xio3130_upstream.o xio3130_downstream.o
>  common-obj-$(CONFIG_IOH3420) += ioh3420.o
> 
