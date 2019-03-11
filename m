Received: from eggs.gnu.org ([209.51.188.92]:44132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h3EtI-00064e-K3
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 02:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h3EtH-0008QD-Nn
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 02:58:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h3EtH-0008Pm-F6
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 02:58:27 -0400
References: <20190311005618.19007-1-philmd@redhat.com>
	<20190311005618.19007-4-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bbd425da-0cb9-40d6-5d24-7ef7e0dec097@redhat.com>
Date: Mon, 11 Mar 2019 07:58:17 +0100
MIME-Version: 1.0
In-Reply-To: <20190311005618.19007-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/7] hw/mips: Express dependencies of
 the r4k platform with Kconfig
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
> This platform use standard PC devices connected to an ISA bus.
> Networking is provided by a ne2000 chipset.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v3: remove CONFIG_NE2000_ISA (Thomas)
>     add PFLASH_CFI01
> ---
>  default-configs/mips-softmmu-common.mak |  1 -
>  hw/mips/Kconfig                         | 11 +++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/=
mips-softmmu-common.mak
> index caebafd416..2ca57bfee1 100644
> --- a/default-configs/mips-softmmu-common.mak
> +++ b/default-configs/mips-softmmu-common.mak
> @@ -24,7 +24,6 @@ CONFIG_I8257=3Dy
>  CONFIG_PIIX4=3Dy
>  CONFIG_IDE_ISA=3Dy
>  CONFIG_IDE_PIIX=3Dy
> -CONFIG_NE2000_ISA=3Dy
>  CONFIG_PFLASH_CFI01=3Dy
>  CONFIG_I8259=3Dy
>  CONFIG_MC146818RTC=3Dy
> diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
> index ab006477c7..5678c9cf15 100644
> --- a/hw/mips/Kconfig
> +++ b/hw/mips/Kconfig
> @@ -1,5 +1,16 @@
>  config R4K
>      bool
> +    select ISA_BUS
> +    select SERIAL_ISA
> +    select I8259
> +    select I8254
> +    select MC146818RTC
> +    select VGA_ISA
> +    select NE2000_ISA

Since Paolo now also introduced the "imply" keyword, I think you should
use "imply" instead of "select" for both, VGA_ISA and NE2000_ISA, since
the r4k machine can work without both when you specify -vga none and
-net none.

 Thomas
