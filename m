Received: from eggs.gnu.org ([209.51.188.92]:44072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjhXZ-0004a8-JI
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:31:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjhXY-00027t-0V
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:31:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gjhXX-0001lt-GL
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:31:15 -0500
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-12-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7d5cbb41-cabf-01b1-ab45-44b4c6e78677@redhat.com>
Date: Wed, 16 Jan 2019 10:31:03 +0100
MIME-Version: 1.0
In-Reply-To: <20190115141108.934-12-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 11/37] hw/xtensa/Makefile.objs:
 Build xtensa_sim and xtensa_fpga conditionally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, =?UTF-8?B?w4Frb3MgS292w6Fjcw==?= <akoskovacs@gmx.com>, pbonzini@redhat.com, ehabkost@redhat.com, Max Filippov <jcmvbkbc@gmail.com>

On 2019-01-15 15:10, Yang Zhong wrote:
> From: =C3=81kos Kov=C3=A1cs <akoskovacs@gmx.com>
>=20
> Add the new CONFIG_* values to default-config/xtensa*-softmmu.mak.
>=20
> Signed-off-by: =C3=81kos Kov=C3=A1cs <akoskovacs@gmx.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  default-configs/xtensa-softmmu.mak   | 3 +++
>  default-configs/xtensaeb-softmmu.mak | 3 +++
>  hw/xtensa/Makefile.objs              | 4 ++--
>  3 files changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/default-configs/xtensa-softmmu.mak b/default-configs/xtens=
a-softmmu.mak
> index 9d8899cde7..baf90ca162 100644
> --- a/default-configs/xtensa-softmmu.mak
> +++ b/default-configs/xtensa-softmmu.mak
> @@ -3,3 +3,6 @@
>  CONFIG_SERIAL=3Dy
>  CONFIG_OPENCORES_ETH=3Dy
>  CONFIG_PFLASH_CFI01=3Dy
> +
> +CONFIG_XTENSA_SIM=3Dy
> +CONFIG_XTENSA_FPGA=3Dy
> diff --git a/default-configs/xtensaeb-softmmu.mak b/default-configs/xte=
nsaeb-softmmu.mak
> index 9d8899cde7..baf90ca162 100644
> --- a/default-configs/xtensaeb-softmmu.mak
> +++ b/default-configs/xtensaeb-softmmu.mak
> @@ -3,3 +3,6 @@
>  CONFIG_SERIAL=3Dy
>  CONFIG_OPENCORES_ETH=3Dy
>  CONFIG_PFLASH_CFI01=3Dy
> +
> +CONFIG_XTENSA_SIM=3Dy
> +CONFIG_XTENSA_FPGA=3Dy
> diff --git a/hw/xtensa/Makefile.objs b/hw/xtensa/Makefile.objs
> index cb4998d2bf..62e244fa53 100644
> --- a/hw/xtensa/Makefile.objs
> +++ b/hw/xtensa/Makefile.objs
> @@ -1,4 +1,4 @@
>  obj-y +=3D pic_cpu.o
> -obj-y +=3D sim.o
>  obj-y +=3D xtensa_memory.o
> -obj-y +=3D xtfpga.o
> +obj-$(CONFIG_XTENSA_SIM) +=3D sim.o
> +obj-$(CONFIG_XTENSA_FPGA) +=3D xtfpga.o
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
