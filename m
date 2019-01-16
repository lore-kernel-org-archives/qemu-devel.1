Received: from eggs.gnu.org ([209.51.188.92]:47417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjh7t-0005zR-2t
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:04:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjh7s-0001KR-0o
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:04:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gjh7r-0001D2-JB
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:04:43 -0500
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-10-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <129a9d5b-1cc6-16b3-c82b-78234a55def1@redhat.com>
Date: Wed, 16 Jan 2019 10:04:25 +0100
MIME-Version: 1.0
In-Reply-To: <20190115141108.934-10-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 09/37] hw/sparc/Makefile.objs:
 CONFIG_* for sun4m and leon3 created
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, =?UTF-8?B?w4Frb3MgS292w6Fjcw==?= <akoskovacs@gmx.com>, pbonzini@redhat.com, ehabkost@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Fabien Chouteau <chouteau@adacore.com>

On 2019-01-15 15:10, Yang Zhong wrote:
> From: =C3=81kos Kov=C3=A1cs <akoskovacs@gmx.com>
>=20
> CONFIG_LEON3 added to default-configs/sparc-softmmu.mak.
>=20
> Signed-off-by: =C3=81kos Kov=C3=A1cs <akoskovacs@gmx.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  default-configs/sparc-softmmu.mak | 2 ++
>  hw/sparc/Makefile.objs            | 4 +++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/default-configs/sparc-softmmu.mak b/default-configs/sparc-=
softmmu.mak
> index 12f97eeb20..59a4a3d693 100644
> --- a/default-configs/sparc-softmmu.mak
> +++ b/default-configs/sparc-softmmu.mak
> @@ -18,4 +18,6 @@ CONFIG_CS4231=3Dy
>  CONFIG_GRLIB=3Dy
>  CONFIG_STP2000=3Dy
>  CONFIG_ECCMEMCTL=3Dy
> +
>  CONFIG_SUN4M=3Dy
> +CONFIG_LEON3=3Dy
> diff --git a/hw/sparc/Makefile.objs b/hw/sparc/Makefile.objs
> index e2d0828c39..d57e33f83e 100644
> --- a/hw/sparc/Makefile.objs
> +++ b/hw/sparc/Makefile.objs
> @@ -1 +1,3 @@
> -obj-y +=3D sun4m_iommu.o sun4m.o leon3.o
> +obj-$(CONFIG_SUN4M) +=3D sun4m_iommu.o
> +obj-$(CONFIG_SUN4M) +=3D sun4m.o
> +obj-$(CONFIG_LEON3) +=3D leon3.o
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
