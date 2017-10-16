Received: from eggs.gnu.org ([2001:4830:134:3::10]:37945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e4BJd-0002E8-NK
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 15:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e4BJa-0006lI-Cx
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 15:44:45 -0400
References: <20170922154014.29350-1-f4bug@amsat.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <f49c0fb8-5232-ff31-e18b-217c79afb7ee@msgid.tls.msk.ru>
Date: Mon, 16 Oct 2017 22:44:40 +0300
MIME-Version: 1.0
In-Reply-To: <20170922154014.29350-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/34] remove i386/pc dependency from
 non-PC world (part 1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

This was an old(ish) patchset. Aplying it now.

22.09.2017 18:39, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi,
>=20
> quite a bunch of patches and files modified, but the diffstat is not th=
at big.
>=20
> First part is from clean-includes script,
> Then comes code movement, about no logical changes.
>=20
> Now some non-x86 builds and cocci spatch run a bit faster :)
>=20
> I updated some MAINTAINERS entries while here.
>=20
> Also I couldn't test the KVM/XEN/HAX part.
>=20
> Regards,
>=20
> Phil.
>=20
> Philippe Mathieu-Daud=C3=A9 (34):
>   hw: use "qemu/osdep.h" as first #include in source files
applied
>   hw: remove "qemu/osdep.h" from header files
not applied, doing two things, suggested split-up
(I'm fine with it as it is)
>   block: remove "qemu/osdep.h" from header file
applied
>   misc: remove headers implicitly included
applied
>   misc: remove duplicated includes
applied
>   ppc: remove duplicated includes
applied
>   i386/hax: remove duplicated includes
applied (note it can be trimmed more)
>   nios2: remove duplicated includes
applied
>   misc: avoid "include/" in include path
not applied, probably should be split, but I'm fine with it as it is
>   amd_iommu: avoid needless includes in header file
applied
>   i386/pc: use TYPE_PORT92
applied
>   misc: remove old i386 dependency
applied
>   hw/ide: remove old i386 dependency
applied
>   hw/ipmi: remove old i386 dependency
applied
>   hw/i2c: remove old i386 dependency
applied
>   hw/tpm: remove old i386 dependency
applied
>   hw/virtio-balloon: remove old i386 dependency
applied
>   hw/unicore32: restrict hw addr defines to source file
applied
>   hw/acpi: ACPI_PM_* defines are not restricted to i386 arch
applied
>   hw/timer/i8254: rename pit_init() -> i8254_pit_init()
not applied, split?
>   hw/display/vga: remove the old i386/pc dependency
somehow I can't find this patch, neither in my inbox nor in patchwork
>   hw/input/i8042: extract API from hw/i386/pc.h
CHECK
>   hw/dma/i8257: rename DMA_init() to i8257_dma_init()
not applied, pending **errp addition
>   hw/timer/mc146818: rename rtc_init() -> mc146818_init()
applied
>   hw/timer/m48t59: use TYPE_M48T59_ISA, add entries to MAINTAINERS
not applied, it went out of context without i8257_dma_init rename
btw, why do we prefer these TYPE_XXX things instead of simple "xxx" stuff=
?
>   hw/net/ne2000: extract ne2k-isa code from i386/pc to ne2000-isa.c
applied
>   hw/pci: declare pci_nic_init_nofail() in "hw/net/pci.h"
not applied, it does more than mentioned

>   hw/net/e1000: use TYPE_PCI_E1000
>   hw/net/e1000e: use TYPE_PCI_E1000E
>   hw/net/pcnet: use TYPE_PCI_PCNET
>   hw/net/rtl8139: use TYPE_PCI_RTL8139
>   hw/net/ne2000: use TYPE_PCI_NE2000

Not applied, at least not yet, why do we use these TYPE_XX stuff to
start with?

>   hw/alpha: remove old i386 dependency
not applied

>   misc: drop old i386 dependency
applied, except of the MAINTAINERS part.

Applying these series is quite a bit boring task I'd say :)

Thanks,

/mjt
