Received: from eggs.gnu.org ([209.51.188.92]:39059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjgee-0006rC-HO
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 03:34:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjgeZ-0003Ym-MY
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 03:34:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gjgeS-0003Tx-TV
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 03:34:23 -0500
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-7-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <56bbd753-dc3d-fef0-0416-cb204893f722@redhat.com>
Date: Wed, 16 Jan 2019 09:34:15 +0100
MIME-Version: 1.0
In-Reply-To: <20190115141108.934-7-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 06/37] hw/mips/Makefile.objs: Create
 CONFIG_* for r4k, malta, mipssim boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, sameo@linux.intel.com, ehabkost@redhat.com, =?UTF-8?B?w4Frb3MgS292w6Fjcw==?= <akoskovacs@gmx.com>

On 2019-01-15 15:10, Yang Zhong wrote:
> From: =C3=81kos Kov=C3=A1cs <akoskovacs@gmx.com>
>=20
> Add the new configs to default-configs/mips*-sofmmu.mak.
>=20
> Signed-off-by: =C3=81kos Kov=C3=A1cs <akoskovacs@gmx.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  default-configs/mips-softmmu-common.mak | 4 ++++
>  default-configs/mips64el-softmmu.mak    | 1 -
>  hw/mips/Makefile.objs                   | 6 ++++--
>  3 files changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/=
mips-softmmu-common.mak
> index fae2347ee7..77b40ec7d1 100644
> --- a/default-configs/mips-softmmu-common.mak
> +++ b/default-configs/mips-softmmu-common.mak
> @@ -36,3 +36,7 @@ CONFIG_EMPTY_SLOT=3Dy
>  CONFIG_MIPS_CPS=3Dy
>  CONFIG_MIPS_ITU=3Dy
>  CONFIG_I2C=3Dy
> +CONFIG_R4K=3Dy
> +CONFIG_MALTA=3Dy
> +CONFIG_MIPSSIM=3Dy
> +CONFIG_VT82C686=3Dy
> diff --git a/default-configs/mips64el-softmmu.mak b/default-configs/mip=
s64el-softmmu.mak
> index c2ae313f47..8244efb39c 100644
> --- a/default-configs/mips64el-softmmu.mak
> +++ b/default-configs/mips64el-softmmu.mak
> @@ -9,7 +9,6 @@ CONFIG_FULONG=3Dy
>  CONFIG_JAZZ=3Dy
>  CONFIG_G364FB=3Dy
>  CONFIG_JAZZ_LED=3Dy
> -CONFIG_VT82C686=3Dy

I think that change to the CONFIG_VT82C686 is unrelated and should not
be part of this patch. Also looking at commit

 dff4021730b112ca00522d4c98c24a15feeef5a0
 mips: Remove CONFIG_VT82C686 from non-Fulong configs

it seems like it should stay in mips64el-softmmu.mak and not be moved to
mips-softmmu-common.mak.

>  CONFIG_MIPS_BOSTON=3Dy
>  CONFIG_FITLOADER=3Dy
>  CONFIG_PCI_XILINX=3Dy
> diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs
> index 17a311aaba..230866ae91 100644
> --- a/hw/mips/Makefile.objs
> +++ b/hw/mips/Makefile.objs
> @@ -1,7 +1,9 @@
> -obj-y +=3D mips_r4k.o mips_malta.o mips_mipssim.o
>  obj-y +=3D addr.o mips_int.o
> +obj-y +=3D gt64xxx_pci.o
> +obj-$(CONFIG_R4K) +=3D mips_r4k.o
> +obj-$(CONFIG_MALTA) +=3D mips_malta.o
> +obj-$(CONFIG_MIPSSIM) +=3D mips_mipssim.o
>  obj-$(CONFIG_JAZZ) +=3D mips_jazz.o
>  obj-$(CONFIG_FULONG) +=3D mips_fulong2e.o
> -obj-y +=3D gt64xxx_pci.o
>  obj-$(CONFIG_MIPS_CPS) +=3D cps.o
>  obj-$(CONFIG_MIPS_BOSTON) +=3D boston.o
>=20

 Thomas
