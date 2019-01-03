Received: from eggs.gnu.org ([208.118.235.92]:40906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gf41D-000355-P4
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:30:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gf415-0000VH-IG
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:30:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gf414-0000RV-VZ
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:30:35 -0500
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-3-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c01fee3f-efd0-3b86-171f-f00e461bc871@redhat.com>
Date: Thu, 3 Jan 2019 15:30:28 +0100
MIME-Version: 1.0
In-Reply-To: <20181227063419.12981-3-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 02/25] hw/i386/Makefile.objs: Build
 pc_piix* and pc_q35 boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, sameo@linux.intel.com, ehabkost@redhat.com, peter.maydell@linaro.org, =?UTF-8?B?w4Frb3MgS292w6Fjcw==?= <akoskovacs@gmx.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On 2018-12-27 07:33, Yang Zhong wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
>=20
> CONFIG_PIIX and CONFIG_Q35 created for the pc board object files. These
> are enabled automatically at default-configs/i386-softmmu.mak and
> default-configs/x86_64-softmmu.mak
>=20
> Signed-off-by: =C3=81kos Kov=C3=A1cs <akoskovacs@gmx.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  default-configs/i386-softmmu.mak | 2 ++
>  hw/i386/Makefile.objs            | 4 +++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-so=
ftmmu.mak
> index 64c998c4c8..65ef98be18 100644
> --- a/default-configs/i386-softmmu.mak
> +++ b/default-configs/i386-softmmu.mak
> @@ -67,3 +67,5 @@ CONFIG_I2C=3Dy
>  CONFIG_SEV=3D$(CONFIG_KVM)
>  CONFIG_VTD=3Dy
>  CONFIG_AMD_IOMMU=3Dy
> +CONFIG_I440FX=3Dy
> +CONFIG_Q35=3Dy
> diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
> index fa87a14152..3de7ca2bb9 100644
> --- a/hw/i386/Makefile.objs
> +++ b/hw/i386/Makefile.objs
> @@ -1,6 +1,8 @@
>  obj-$(CONFIG_KVM) +=3D kvm/
>  obj-y +=3D multiboot.o
> -obj-y +=3D pc.o pc_piix.o pc_q35.o
> +obj-y +=3D pc.o
> +obj-$(CONFIG_I440FX) +=3D pc_piix.o
> +obj-$(CONFIG_Q35) +=3D pc_q35.o
>  obj-y +=3D pc_sysfw.o
>  obj-$(CONFIG_VTD) +=3D x86-iommu.o intel_iommu.o
>  obj-$(CONFIG_AMD_IOMMU) +=3D x86-iommu.o amd_iommu.o
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
