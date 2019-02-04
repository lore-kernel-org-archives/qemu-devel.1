Received: from eggs.gnu.org ([209.51.188.92]:56896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqZfE-0006p5-OI
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 03:31:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqZfC-0002VG-To
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 03:31:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gqZfA-0002TM-Vj
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 03:31:34 -0500
References: <20190203220744.11734-1-philmd@redhat.com>
	<20190203220744.11734-2-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <162915fe-ef7f-c977-2fd2-985406b465d1@redhat.com>
Date: Mon, 4 Feb 2019 09:31:24 +0100
MIME-Version: 1.0
In-Reply-To: <20190203220744.11734-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/6] mips: Express dependencies of the
 MIPSsim machine with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, James Hogan <jhogan@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>, Yang Zhong <yang.zhong@intel.com>, Paul Burton <pburton@wavecomp.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>

On 2019-02-03 23:07, Philippe Mathieu-Daud=C3=A9 wrote:
> The MIPSsim machine only emulates an 8250 UART and a simple network
> controller, connected via an ISA bus.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  default-configs/mips-softmmu-common.mak | 2 --
>  hw/mips/Kconfig                         | 3 +++
>  2 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/=
mips-softmmu-common.mak
> index 0795d522db..aa73a4a822 100644
> --- a/default-configs/mips-softmmu-common.mak
> +++ b/default-configs/mips-softmmu-common.mak
> @@ -26,7 +26,6 @@ CONFIG_PIIX4=3Dy
>  CONFIG_IDE_ISA=3Dy
>  CONFIG_IDE_PIIX=3Dy
>  CONFIG_NE2000_ISA=3Dy
> -CONFIG_MIPSNET=3Dy
>  CONFIG_PFLASH_CFI01=3Dy
>  CONFIG_I8259=3Dy
>  CONFIG_MC146818RTC=3Dy
> @@ -35,7 +34,6 @@ CONFIG_MIPS_CPS=3Dy
>  CONFIG_MIPS_ITU=3Dy
>  CONFIG_R4K=3Dy
>  CONFIG_MALTA=3Dy
> -CONFIG_MIPSSIM=3Dy
>  CONFIG_ACPI_SMBUS=3Dy
>  CONFIG_SMBUS_EEPROM=3Dy
>  CONFIG_TEST_DEVICES=3Dy
> diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
> index cdc07e59b6..3433e97e1a 100644
> --- a/hw/mips/Kconfig
> +++ b/hw/mips/Kconfig
> @@ -6,6 +6,9 @@ config MALTA
> =20
>  config MIPSSIM
>      bool
> +    select ISA_BUS
> +    select SERIAL_ISA
> +    select MIPSNET
> =20
>  config JAZZ
>      bool
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
