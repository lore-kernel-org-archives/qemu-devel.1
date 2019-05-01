Received: from eggs.gnu.org ([209.51.188.92]:52646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hLu8n-0004Bv-4V
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hLu8m-000422-76
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:39:37 -0400
References: <20190430071405.16714-1-thuth@redhat.com>
	<20190430071405.16714-3-thuth@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <63dddb9d-457c-8bf4-701f-6fe34f555605@redhat.com>
Date: Wed, 1 May 2019 14:39:10 -0400
MIME-Version: 1.0
In-Reply-To: <20190430071405.16714-3-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 02/30] hw/ide/ahci: Add a Kconfig switch
 for the AHCI-ICH9 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Rob Herring <robh@kernel.org>, qemu-block@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>, Antony Pavlov <antonynpavlov@gmail.com>, Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>, Cedric Le Goater <clg@kaod.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Philippe Mathieu-Daude <f4bug@amsat.org>, Jean-Christophe Dubois <jcd@tribudubois.net>, Andrew Jeffery <andrew@aj.id.au>, Peter Chubb <peter.chubb@nicta.com.au>, Aurelien Jarno <aurelien@aurel32.net>



On 4/30/19 3:13 AM, Thomas Huth wrote:
> Some of our machines (like the ARM cubieboard) use CONFIG_AHCI for an A=
HCI
> sysbus device, but do not use CONFIG_PCI since they do not feature a PC=
I
> bus. With CONFIG_AHCI but without CONFIG_PCI, currently linking fails:
>=20
>     ../hw/ide/ich.o: In function `pci_ich9_ahci_realize':
>     hw/ide/ich.c:124: undefined reference to `pci_allocate_irq'
>     hw/ide/ich.c:126: undefined reference to `pci_register_bar'
>     hw/ide/ich.c:128: undefined reference to `pci_register_bar'
>     hw/ide/ich.c:131: undefined reference to `pci_add_capability'
>     hw/ide/ich.c:147: undefined reference to `msi_init'
>     ../hw/ide/ich.o: In function `pci_ich9_uninit':
>     hw/ide/ich.c:158: undefined reference to `msi_uninit'
>     ../hw/ide/ich.o:(.data.rel+0x50): undefined reference to `vmstate_p=
ci_device'
>=20
> We must only compile ich.c if CONFIG_PCI is available, too, so introduc=
e a
> new config switch for this device.
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: John Snow <jsnow@redhat.com>
