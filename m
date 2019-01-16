Received: from eggs.gnu.org ([209.51.188.92]:50736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjgZ1-0004g0-65
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 03:28:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjgYy-0004VG-Ur
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 03:28:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gjgYy-0004R9-F6
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 03:28:40 -0500
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-6-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f40e9e42-062d-1651-4d11-1268c1ed7b2d@redhat.com>
Date: Wed, 16 Jan 2019 09:28:35 +0100
MIME-Version: 1.0
In-Reply-To: <20190115141108.934-6-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 05/37] hw/microblaze/Makefile.objs:
 Create configs for petalogix and xilinx boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, sameo@linux.intel.com, ehabkost@redhat.com, =?UTF-8?B?w4Frb3MgS292w6Fjcw==?= <akoskovacs@gmx.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

On 2019-01-15 15:10, Yang Zhong wrote:
> From: =C3=81kos Kov=C3=A1cs <akoskovacs@gmx.com>
>=20
> CONFIG_PETALOGIX_* and CONFIG_XLNX_*  configs added to
> default-configs/microblaze-softmmu.mak and
> default-configs/microblazeel-softmmu.mak.
>=20
> Signed-off-by: =C3=81kos Kov=C3=A1cs <akoskovacs@gmx.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  default-configs/microblaze-softmmu.mak | 3 +++
>  hw/microblaze/Makefile.objs            | 6 +++---
>  2 files changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/default-configs/microblaze-softmmu.mak b/default-configs/m=
icroblaze-softmmu.mak
> index 7fca8e4c99..14837cf74a 100644
> --- a/default-configs/microblaze-softmmu.mak
> +++ b/default-configs/microblaze-softmmu.mak
> @@ -10,3 +10,6 @@ CONFIG_XILINX_ETHLITE=3Dy
>  CONFIG_SSI=3Dy
>  CONFIG_SSI_M25P80=3Dy
>  CONFIG_XLNX_ZYNQMP=3Dy
> +CONFIG_PETALOGIX_S3ADSP1800=3Dy
> +CONFIG_PETALOGIX_ML605=3Dy
> +CONFIG_XLNX_ZYNQMP_PMU=3Dy
> diff --git a/hw/microblaze/Makefile.objs b/hw/microblaze/Makefile.objs
> index ae9fd40de7..8595a62f6c 100644
> --- a/hw/microblaze/Makefile.objs
> +++ b/hw/microblaze/Makefile.objs
> @@ -1,4 +1,4 @@
> -obj-y +=3D petalogix_s3adsp1800_mmu.o
> -obj-y +=3D petalogix_ml605_mmu.o
> -obj-y +=3D xlnx-zynqmp-pmu.o
> +obj-$(CONFIG_PETALOGIX_S3ADSP1800) +=3D petalogix_s3adsp1800_mmu.o
> +obj-$(CONFIG_PETALOGIX_ML605) +=3D petalogix_ml605_mmu.o
> +obj-$(CONFIG_XLNX_ZYNQMP_PMU) +=3D xlnx-zynqmp-pmu.o
>  obj-y +=3D boot.o

Reviewed-by: Thomas Huth <thuth@redhat.com>
