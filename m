Received: from eggs.gnu.org ([209.51.188.92]:59685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjgsM-0003QR-6u
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 03:48:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjgsJ-00005D-V7
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 03:48:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gjgsJ-0008Dz-JM
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 03:48:39 -0500
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-9-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b566b841-df63-5b48-ae85-4cfdf3e5d129@redhat.com>
Date: Wed, 16 Jan 2019 09:48:16 +0100
MIME-Version: 1.0
In-Reply-To: <20190115141108.934-9-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 08/37] hw/sh4/Makefile.objs: New
 CONFIG_* varibales created for sh4 boards and device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, =?UTF-8?B?w4Frb3MgS292w6Fjcw==?= <akoskovacs@gmx.com>, pbonzini@redhat.com, ehabkost@redhat.com, Aurelien Jarno <aurelien@aurel32.net>, Magnus Damm <magnus.damm@gmail.com>

On 2019-01-15 15:10, Yang Zhong wrote:
> From: =C3=81kos Kov=C3=A1cs <akoskovacs@gmx.com>
>=20
> Make hw/sh4 configurable and add new CONFIG_* to the default-configs/sh=
4*-softmmu.mak.
>=20
> Signed-off-by: =C3=81kos Kov=C3=A1cs <akoskovacs@gmx.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  default-configs/sh4-softmmu.mak   | 3 +++
>  default-configs/sh4eb-softmmu.mak | 3 +++
>  hw/sh4/Makefile.objs              | 6 +++---
>  3 files changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/default-configs/sh4-softmmu.mak b/default-configs/sh4-soft=
mmu.mak
> index caeccd55be..4b65489624 100644
> --- a/default-configs/sh4-softmmu.mak
> +++ b/default-configs/sh4-softmmu.mak
> @@ -19,3 +19,6 @@ CONFIG_PCSPK=3Dy
>  CONFIG_I82374=3Dy
>  CONFIG_I8257=3Dy
>  CONFIG_MC146818RTC=3Dy
> +CONFIG_R2D=3Dy
> +CONFIG_SHIX=3Dy
> +CONFIG_SH7750=3Dy
> diff --git a/default-configs/sh4eb-softmmu.mak b/default-configs/sh4eb-=
softmmu.mak
> index 53b9cd7b5a..af71aa7f42 100644
> --- a/default-configs/sh4eb-softmmu.mak
> +++ b/default-configs/sh4eb-softmmu.mak
> @@ -19,3 +19,6 @@ CONFIG_PCSPK=3Dy
>  CONFIG_I82374=3Dy
>  CONFIG_I8257=3Dy
>  CONFIG_MC146818RTC=3Dy
> +CONFIG_R2D=3Dy
> +CONFIG_SHIX=3Dy
> +CONFIG_SH7750=3Dy
> diff --git a/hw/sh4/Makefile.objs b/hw/sh4/Makefile.objs
> index 2393702c57..70903d79a9 100644
> --- a/hw/sh4/Makefile.objs
> +++ b/hw/sh4/Makefile.objs
> @@ -1,4 +1,4 @@
> -obj-y +=3D shix.o r2d.o
> -
> -obj-y +=3D sh7750.o sh7750_regnames.o
> +obj-$(CONFIG_R2D) +=3D  r2d.o
> +obj-$(CONFIG_SHIX) +=3D shix.o
> +obj-$(CONFIG_SH7750) +=3D sh7750.o sh7750_regnames.o
>  obj-y +=3D sh_pci.o
>=20

sh7750.o and sh7750_regnames.o are "common" code of the r2d and shix
machine, and do not define a separate machine ... not sure whether we
need a separate CONFIG_SH7750 switch for this? I'd rather treat these
two file like sh_pci.o instead, and always include them unconditionally,
I think... Or do I miss something?

 Thomas
