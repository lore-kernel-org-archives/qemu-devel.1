Received: from eggs.gnu.org ([209.51.188.92]:59820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqZoS-0001tH-UM
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 03:41:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqZoS-0004mw-6y
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 03:41:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gqZoR-0004mR-Uo
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 03:41:08 -0500
References: <20190203220744.11734-1-philmd@redhat.com>
	<20190203220744.11734-6-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <811d5fda-1cd0-7e23-a45e-9ae959ddfdaa@redhat.com>
Date: Mon, 4 Feb 2019 09:40:59 +0100
MIME-Version: 1.0
In-Reply-To: <20190203220744.11734-6-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/6] hw/pci-host: Use CONFIG_PCI_BONITO to
 select the Bonito North Bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Yang Zhong <yang.zhong@intel.com>, Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, James Hogan <jhogan@kernel.org>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On 2019-02-03 23:07, Philippe Mathieu-Daud=C3=A9 wrote:
> Ease the kconfig selection by introducing CONFIG_PCI_BONITO to select
> the Bonito North Bridge. Select it for the Loongson 2E machine.

I think you should either rather drop the last sentence here (since the
"select" is only done in the next patch), or even merge this patch with
the next one.

 Thomas


> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  default-configs/mips64el-softmmu.mak | 1 +
>  hw/pci-host/Kconfig                  | 4 ++++
>  hw/pci-host/Makefile.objs            | 2 +-
>  3 files changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/default-configs/mips64el-softmmu.mak b/default-configs/mip=
s64el-softmmu.mak
> index ac44df1d0d..ee583758e1 100644
> --- a/default-configs/mips64el-softmmu.mak
> +++ b/default-configs/mips64el-softmmu.mak
> @@ -3,4 +3,5 @@
>  include mips-softmmu-common.mak
>  CONFIG_IDE_VIA=3Dy
>  CONFIG_FULONG=3Dy
> +CONFIG_PCI_BONITO=3Dy
>  CONFIG_VT82C686=3Dy
> diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
> index b39ea297ba..9abadafaf5 100644
> --- a/hw/pci-host/Kconfig
> +++ b/hw/pci-host/Kconfig
> @@ -49,3 +49,7 @@ config PCI_EXPRESS_XILINX
>  config PCI_EXPRESS_DESIGNWARE
>      bool
>      select PCI_EXPRESS
> +
> +config PCI_BONITO
> +    select PCI
> +    bool
> diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
> index a9cd3e022d..d6e86b9b89 100644
> --- a/hw/pci-host/Makefile.objs
> +++ b/hw/pci-host/Makefile.objs
> @@ -12,7 +12,7 @@ common-obj-$(CONFIG_PPCE500_PCI) +=3D ppce500.o
>  common-obj-$(CONFIG_VERSATILE_PCI) +=3D versatile.o
> =20
>  common-obj-$(CONFIG_PCI_SABRE) +=3D sabre.o
> -common-obj-$(CONFIG_FULONG) +=3D bonito.o
> +common-obj-$(CONFIG_PCI_BONITO) +=3D bonito.o
>  common-obj-$(CONFIG_PCI_PIIX) +=3D piix.o
>  common-obj-$(CONFIG_PCI_EXPRESS_Q35) +=3D q35.o
>  common-obj-$(CONFIG_PCI_EXPRESS_GENERIC_BRIDGE) +=3D gpex.o
>=20
