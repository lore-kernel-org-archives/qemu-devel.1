Received: from eggs.gnu.org ([209.51.188.92]:36018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmKa3-0002fv-OZ
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:36:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmKa3-0000ra-0J
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:36:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gmKa2-0000ql-Nb
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:36:42 -0500
References: <20190123065618.3520-1-yang.zhong@intel.com>
	<20190123065618.3520-8-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <72d40a20-00e0-3302-6f01-b283d05765db@redhat.com>
Date: Wed, 23 Jan 2019 16:36:37 +0100
MIME-Version: 1.0
In-Reply-To: <20190123065618.3520-8-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v4 07/44] hw/mips/Makefile.objs: Create
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, =?UTF-8?B?w4Frb3MgS292w6Fjcw==?= <akoskovacs@gmx.com>, pbonzini@redhat.com, sameo@linux.intel.com, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

On 2019-01-23 07:55, Yang Zhong wrote:
> From: =C3=81kos Kov=C3=A1cs <akoskovacs@gmx.com>
>=20
> Add the new configs to default-configs/mips*-sofmmu.mak.
>=20
> Signed-off-by: =C3=81kos Kov=C3=A1cs <akoskovacs@gmx.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  default-configs/mips-softmmu-common.mak | 3 +++
>  hw/mips/Makefile.objs                   | 6 ++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/=
mips-softmmu-common.mak
> index fae2347ee7..479fb4d900 100644
> --- a/default-configs/mips-softmmu-common.mak
> +++ b/default-configs/mips-softmmu-common.mak
> @@ -36,3 +36,6 @@ CONFIG_EMPTY_SLOT=3Dy
>  CONFIG_MIPS_CPS=3Dy
>  CONFIG_MIPS_ITU=3Dy
>  CONFIG_I2C=3Dy
> +CONFIG_R4K=3Dy
> +CONFIG_MALTA=3Dy
> +CONFIG_MIPSSIM=3Dy
> diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs
> index 17a311aaba..230866ae91 100644
> --- a/hw/mips/Makefile.objs
> +++ b/hw/mips/Makefile.objs
> @@ -1,7 +1,9 @@
> -obj-y +=3D mips_r4k.o mips_malta.o mips_mipssim.o
>  obj-y +=3D addr.o mips_int.o
> +obj-y +=3D gt64xxx_pci.o

The gt64xxx_pci.c file seems to belong to the Malta machine, so I think
you could mark this with $(CONFIG_MALTA), too. Apart from that:

Reviewed-by: Thomas Huth <thuth@redhat.com>

> +obj-$(CONFIG_R4K) +=3D mips_r4k.o
> +obj-$(CONFIG_MALTA) +=3D mips_malta.o
> +obj-$(CONFIG_MIPSSIM) +=3D mips_mipssim.o
>  obj-$(CONFIG_JAZZ) +=3D mips_jazz.o
>  obj-$(CONFIG_FULONG) +=3D mips_fulong2e.o
> -obj-y +=3D gt64xxx_pci.o
>  obj-$(CONFIG_MIPS_CPS) +=3D cps.o
>  obj-$(CONFIG_MIPS_BOSTON) +=3D boston.o
