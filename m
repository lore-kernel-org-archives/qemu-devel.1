Received: from eggs.gnu.org ([209.51.188.92]:47802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h3J4O-000629-5N
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 07:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h3IwJ-0003fZ-LV
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 07:17:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39001)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h3IwJ-0003ea-6s
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 07:17:51 -0400
References: <20190311005618.19007-1-philmd@redhat.com>
	<20190311005618.19007-3-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <50e483c6-9580-dcdb-65aa-a8d66040c5a7@redhat.com>
Date: Mon, 11 Mar 2019 12:17:44 +0100
MIME-Version: 1.0
In-Reply-To: <20190311005618.19007-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/7] hw/mips: Express dependencies of
 the Jazz machine with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: James Hogan <jhogan@kernel.org>, Yang Zhong <yang.zhong@intel.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Paul Burton <pburton@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>

On 11/03/2019 01.56, Philippe Mathieu-Daud=C3=A9 wrote:
> The Jazz use the RC4030 Asic to provide an EISA bus and DMA/IRQ. The
> framebuffer display is managed by a G364, the network card is a Sonic
> DP83932. A QLogic ESP216 provides a SCSI bus.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v3: Keep CONFIG_JAZZ in default-configs/mips64el-softmmu.mak (Thomas)
> ---
>  default-configs/mips-softmmu-common.mak |  1 -
>  default-configs/mips64-softmmu.mak      |  5 -----
>  default-configs/mips64el-softmmu.mak    |  5 -----
>  hw/mips/Kconfig                         | 17 +++++++++++++++++
>  4 files changed, 17 insertions(+), 11 deletions(-)
>=20
> diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/=
mips-softmmu-common.mak
> index 8c5fdf5ee1..caebafd416 100644
> --- a/default-configs/mips-softmmu-common.mak
> +++ b/default-configs/mips-softmmu-common.mak
> @@ -3,7 +3,6 @@
>  CONFIG_ISA_BUS=3Dy
>  CONFIG_PCI=3Dy
>  CONFIG_PCI_DEVICES=3Dy
> -CONFIG_ESP=3Dy
>  CONFIG_VGA_ISA=3Dy
>  CONFIG_VGA_ISA_MM=3Dy
>  CONFIG_VGA_CIRRUS=3Dy
> diff --git a/default-configs/mips64-softmmu.mak b/default-configs/mips6=
4-softmmu.mak
> index bad7496672..a169738635 100644
> --- a/default-configs/mips64-softmmu.mak
> +++ b/default-configs/mips64-softmmu.mak
> @@ -1,9 +1,4 @@
>  # Default configuration for mips64-softmmu
> =20
>  include mips-softmmu-common.mak
> -CONFIG_RC4030=3Dy
> -CONFIG_DP8393X=3Dy
> -CONFIG_DS1225Y=3Dy
>  CONFIG_JAZZ=3Dy
> -CONFIG_G364FB=3Dy
> -CONFIG_JAZZ_LED=3Dy
> diff --git a/default-configs/mips64el-softmmu.mak b/default-configs/mip=
s64el-softmmu.mak
> index 8b255efc54..a7b88318b2 100644
> --- a/default-configs/mips64el-softmmu.mak
> +++ b/default-configs/mips64el-softmmu.mak
> @@ -2,13 +2,8 @@
> =20
>  include mips-softmmu-common.mak
>  CONFIG_IDE_VIA=3Dy
> -CONFIG_RC4030=3Dy
> -CONFIG_DP8393X=3Dy
> -CONFIG_DS1225Y=3Dy
>  CONFIG_FULONG=3Dy
>  CONFIG_JAZZ=3Dy
> -CONFIG_G364FB=3Dy
> -CONFIG_JAZZ_LED=3Dy
>  CONFIG_VT82C686=3Dy
>  CONFIG_AHCI=3Dy
>  CONFIG_MIPS_BOSTON=3Dy
> diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
> index 3433e97e1a..ab006477c7 100644
> --- a/hw/mips/Kconfig
> +++ b/hw/mips/Kconfig
> @@ -12,6 +12,23 @@ config MIPSSIM
> =20
>  config JAZZ
>      bool
> +    select ISA_BUS
> +    select RC4030
> +    select I8259
> +    select I8254
> +    select I8257
> +    select PCSPK
> +    select VGA_ISA_MM
> +    select G364FB
> +    select DP8393X

Looking at the code, it seems like you can also run the machine with
"-net none", so I'd rather use "imply DP8393X" here instead.

 Thomas
