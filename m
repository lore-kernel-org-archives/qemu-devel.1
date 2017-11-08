Received: from eggs.gnu.org ([2001:4830:134:3::10]:54563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eCTaR-0002DF-6X
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:52:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eCTaM-0007tN-Bv
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:52:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eCTaM-0007qa-51
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:52:18 -0500
References: <20171108152023.80780-1-marcel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3722f599-31b4-adb6-270b-aff5819f1bd3@redhat.com>
Date: Wed, 8 Nov 2017 17:52:08 +0100
MIME-Version: 1.0
In-Reply-To: <20171108152023.80780-1-marcel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/pcie-pci-bridge: restrict to X86 and ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, zuban32s@gmail.com, cohuck@redhat.com

On 08.11.2017 16:20, Marcel Apfelbaum wrote:
> The PCIE-PCI bridge is specific to "pure" PCI systems

s/PCI/PCIe/ ?

> (on QEMU we have X86 and ARM), it does not make sense to
> have if in other archs.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> ---
>  default-configs/arm-softmmu.mak    | 1 +
>  default-configs/i386-softmmu.mak   | 1 +
>  default-configs/x86_64-softmmu.mak | 1 +
>  hw/pci-bridge/Makefile.objs        | 3 ++-
>  4 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 5059d134c8..33934b1dc4 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -122,6 +122,7 @@ CONFIG_FSL_IMX25=y
>  CONFIG_IMX_I2C=y
>  
>  CONFIG_PCIE_PORT=y
> +CONFIG_PCIE_PCI_BRIDGE=y

Actually, why not simply use CONFIG_PCIE_PORT instead to determine
whether the PCIe-to-PCI bridge should be included? The device only makes
sense if there is a PCIe root port available on the system...

 Thomas
