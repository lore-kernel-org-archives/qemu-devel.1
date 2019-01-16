Received: from eggs.gnu.org ([209.51.188.92]:33432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjglV-0001q3-Ls
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 03:41:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjglU-0000df-Lg
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 03:41:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gjglT-0000Wq-Kv
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 03:41:35 -0500
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-8-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6dc33418-7e61-efe3-be27-f627c9165519@redhat.com>
Date: Wed, 16 Jan 2019 09:41:19 +0100
MIME-Version: 1.0
In-Reply-To: <20190115141108.934-8-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 07/37] hw/ppc/Makefile.objs: Build
 all boards conditinally with CONFIG_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, =?UTF-8?B?w4Frb3MgS292w6Fjcw==?= <akoskovacs@gmx.com>, pbonzini@redhat.com, ehabkost@redhat.com

On 2019-01-15 15:10, Yang Zhong wrote:
> From: =C3=81kos Kov=C3=A1cs <akoskovacs@gmx.com>
>=20
> CONFIG_PPC405, CONFIG_PPC440, CONFIG_MAC_OLDWORLD, CONFIG_MAX_NEWWORLD
> and CONFIG_VIRTEX configuration options created for
> default-configs/ppc*-softmmu.mak.
>=20
> Signed-off-by: =C3=81kos Kov=C3=A1cs <akoskovacs@gmx.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  default-configs/ppc-softmmu.mak |  7 ++++++-
>  hw/ppc/Makefile.objs            | 12 ++++++------
>  2 files changed, 12 insertions(+), 7 deletions(-)
>=20
> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-soft=
mmu.mak
> index 23d871fb3e..96088f47ca 100644
> --- a/default-configs/ppc-softmmu.mak
> +++ b/default-configs/ppc-softmmu.mak
> @@ -34,7 +34,6 @@ CONFIG_M41T80=3Dy
>  CONFIG_VGA_CIRRUS=3Dy
> =20
>  # For Macs
> -CONFIG_MAC=3Dy
>  CONFIG_ESCC=3Dy
>  CONFIG_MACIO=3Dy
>  CONFIG_MACIO_GPIO=3Dy
> @@ -69,3 +68,9 @@ CONFIG_PC87312=3Dy
>  CONFIG_PCSPK=3Dy
>  CONFIG_IDE_ISA=3Dy
>  CONFIG_CS4231A=3Dy
> +
> +CONFIG_PPC405=3Dy
> +CONFIG_PPC440=3Dy
> +CONFIG_MAC_OLDWORLD=3Dy
> +CONFIG_MAC_NEWWORLD=3Dy
> +CONFIG_VIRTEX=3D

Could you please sort the new config switches into the right sections
here? e.g. CONFIG_MAC_NEW/OLDWORLD in the "# For Macs" section, and the
others into the "# For embedded PPC" section?

 Thanks,
  Thomas

> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
> index 4e0c1c0941..2ce7973219 100644
> --- a/hw/ppc/Makefile.objs
> +++ b/hw/ppc/Makefile.objs
> @@ -13,20 +13,20 @@ obj-y +=3D spapr_pci_vfio.o
>  endif
>  obj-$(CONFIG_PSERIES) +=3D spapr_rtas_ddw.o
>  # PowerPC 4xx boards
> -obj-y +=3D ppc4xx_devs.o ppc405_uc.o
> -obj-$(CONFIG_PPC4XX) +=3D ppc4xx_pci.o ppc405_boards.o
> -obj-$(CONFIG_PPC4XX) +=3D ppc440_bamboo.o ppc440_pcix.o ppc440_uc.o
> +obj-$(CONFIG_PPC405) +=3D ppc405_boards.o  ppc405_uc.o
> +obj-$(CONFIG_PPC440) +=3D ppc440_bamboo.o ppc440_pcix.o ppc440_uc.o
> +obj-$(CONFIG_PPC4XX) +=3D ppc4xx_pci.o ppc4xx_devs.o
>  obj-$(CONFIG_SAM460EX) +=3D sam460ex.o
>  # PReP
>  obj-$(CONFIG_PREP) +=3D prep.o
>  obj-$(CONFIG_PREP) +=3D prep_systemio.o
>  obj-${CONFIG_RS6000_MC} +=3D rs6000_mc.o
>  # OldWorld PowerMac
> -obj-$(CONFIG_MAC) +=3D mac_oldworld.o
> +obj-$(CONFIG_MAC_OLDWORLD) +=3D mac_oldworld.o
>  # NewWorld PowerMac
> -obj-$(CONFIG_MAC) +=3D mac_newworld.o
> +obj-$(CONFIG_MAC_NEWWORLD) +=3D mac_newworld.o
>  # e500
>  obj-$(CONFIG_E500) +=3D e500.o mpc8544ds.o e500plat.o
>  obj-$(CONFIG_E500) +=3D mpc8544_guts.o ppce500_spin.o
>  # PowerPC 440 Xilinx ML507 reference board.
> -obj-$(CONFIG_XILINX) +=3D virtex_ml507.o
> +obj-$(CONFIG_VIRTEX) +=3D virtex_ml507.o
>=20
