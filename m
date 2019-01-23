Received: from eggs.gnu.org ([209.51.188.92]:40808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmKv0-0006ay-Fp
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:58:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmKuz-0005Hk-Iu
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:58:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gmKuz-0005HD-B3
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:58:21 -0500
References: <20190123065618.3520-1-yang.zhong@intel.com>
	<20190123065618.3520-10-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f7425c73-1d63-4b3c-1cd0-ff9351b9bcb6@redhat.com>
Date: Wed, 23 Jan 2019 16:58:15 +0100
MIME-Version: 1.0
In-Reply-To: <20190123065618.3520-10-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v4 09/44] hw/sh4/Makefile.objs: New
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, =?UTF-8?B?w4Frb3MgS292w6Fjcw==?= <akoskovacs@gmx.com>, pbonzini@redhat.com, sameo@linux.intel.com, Aurelien Jarno <aurelien@aurel32.net>, Magnus Damm <magnus.damm@gmail.com>

On 2019-01-23 07:55, Yang Zhong wrote:
> From: =C3=81kos Kov=C3=A1cs <akoskovacs@gmx.com>
>=20
> Make hw/sh4 configurable and add new CONFIG_* to the default-configs/sh=
4*-softmmu.mak.
>=20
> Signed-off-by: =C3=81kos Kov=C3=A1cs <akoskovacs@gmx.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  default-configs/sh4-softmmu.mak   | 2 ++
>  default-configs/sh4eb-softmmu.mak | 2 ++
>  hw/sh4/Makefile.objs              | 4 ++--
>  3 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/default-configs/sh4-softmmu.mak b/default-configs/sh4-soft=
mmu.mak
> index caeccd55be..1fdb009151 100644
> --- a/default-configs/sh4-softmmu.mak
> +++ b/default-configs/sh4-softmmu.mak
> @@ -19,3 +19,5 @@ CONFIG_PCSPK=3Dy
>  CONFIG_I82374=3Dy
>  CONFIG_I8257=3Dy
>  CONFIG_MC146818RTC=3Dy
> +CONFIG_R2D=3Dy
> +CONFIG_SHIX=3Dy
> diff --git a/default-configs/sh4eb-softmmu.mak b/default-configs/sh4eb-=
softmmu.mak
> index 53b9cd7b5a..3b550a5fe8 100644
> --- a/default-configs/sh4eb-softmmu.mak
> +++ b/default-configs/sh4eb-softmmu.mak
> @@ -19,3 +19,5 @@ CONFIG_PCSPK=3Dy
>  CONFIG_I82374=3Dy
>  CONFIG_I8257=3Dy
>  CONFIG_MC146818RTC=3Dy
> +CONFIG_R2D=3Dy
> +CONFIG_SHIX=3Dy
> diff --git a/hw/sh4/Makefile.objs b/hw/sh4/Makefile.objs
> index 2393702c57..2a707f9473 100644
> --- a/hw/sh4/Makefile.objs
> +++ b/hw/sh4/Makefile.objs
> @@ -1,4 +1,4 @@
> -obj-y +=3D shix.o r2d.o
> -
>  obj-y +=3D sh7750.o sh7750_regnames.o
>  obj-y +=3D sh_pci.o
> +obj-$(CONFIG_R2D) +=3D  r2d.o
> +obj-$(CONFIG_SHIX) +=3D shix.o

Reviewed-by: Thomas Huth <thuth@redhat.com>
