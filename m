Received: from eggs.gnu.org ([2001:4830:134:3::10]:47918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eCnRN-0006Gu-Ma
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:04:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eCnRH-0002pC-Nk
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:04:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eCnRH-0002ow-HC
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:04:15 -0500
References: <151023266893.360.2441014157612423993@bafd83ae6430>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <775f71a5-4975-da5f-1e42-c4dfe8f589ef@redhat.com>
Date: Thu, 9 Nov 2017 15:03:52 +0100
MIME-Version: 1.0
In-Reply-To: <151023266893.360.2441014157612423993@bafd83ae6430>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V4] hw/pcie-pci-bridge: restrict to X86 and
 ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, marcel@redhat.com
Cc: famz@redhat.com, cohuck@redhat.com, zuban32s@gmail.com, mst@redhat.com

On 09.11.2017 14:04, no-reply@patchew.org wrote:
> Hi,
> 
> This series failed automatic build test. Please find the testing commands and
> their output below. If you have docker installed, you can probably reproduce it
> locally.
[...]
>   CC      aarch64-softmmu/hw/scsi/virtio-scsi.o
>   CC      aarch64-softmmu/hw/scsi/virtio-scsi-dataplane.o
> make[1]: *** No rule to make target `../hw/pci-bridge/pcie_pci_bridge.o', needed by `qemu-system-x86_64'.  Stop.
> make[1]: *** Waiting for unfinished jobs....
>   CC      aarch64-softmmu/hw/scsi/vhost-scsi-common.o
>   CC      aarch64-softmmu/hw/scsi/vhost-scsi.o
>   CC      aarch64-softmmu/hw/scsi/vhost-user-scsi.o
>   CC      aarch64-softmmu/hw/sd/omap_mmc.o
>   CC      aarch64-softmmu/hw/sd/pxa2xx_mmci.o
>   CC      aarch64-softmmu/hw/sd/bcm2835_sdhost.o
> make: *** [subdir-x86_64-softmmu] Error 2
> make: *** Waiting for unfinished jobs....
>   CC      aarch64-softmmu/hw/ssi/omap_spi.o
>   CC      aarch64-softmmu/hw/ssi/imx_spi.o
>   CC      aarch64-softmmu/hw/timer/exynos4210_mct.o
>   CC      aarch64-softmmu/hw/timer/exynos4210_pwm.o
[...]
>   CC      aarch64-softmmu/hw/timer/exynos4210_rtc.o
>   CC      aarch64-softmmu/target/arm/translate-a64.o
> make[1]: *** No rule to make target `../hw/pci-bridge/pcie_pci_bridge.o', needed by `qemu-system-aarch64'.  Stop.
> make[1]: *** Waiting for unfinished jobs..../tmp/qemu-test/src/target/arm/translate-a64.c: In function 'handle_shri_with_rndacc':

Hmm, looks like this was not working as expected?

 Thomas
