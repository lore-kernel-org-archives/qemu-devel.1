Received: from eggs.gnu.org ([209.51.188.92]:46930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqrWm-0005OK-8q
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 22:36:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqrWk-0007ls-Va
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 22:36:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gqrWk-0007lP-O3
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 22:36:02 -0500
References: <20190204202609.26956-1-philmd@redhat.com>
	<20190204202609.26956-2-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <febf0da1-54bb-a88e-afef-d9ac202c01a1@redhat.com>
Date: Tue, 5 Feb 2019 04:35:52 +0100
MIME-Version: 1.0
In-Reply-To: <20190204202609.26956-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/6] mips: Express dependencies of the
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
Cc: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yang Zhong <yang.zhong@intel.com>, Paul Burton <pburton@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, James Hogan <jhogan@kernel.org>

On 2019-02-04 21:26, Philippe Mathieu-Daud=C3=A9 wrote:
> The MIPSsim machine only emulates an 8250 UART and a simple network
> controller, connected via an ISA bus.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  default-configs/mips-softmmu-common.mak | 1 -
>  hw/mips/Kconfig                         | 3 +++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/=
mips-softmmu-common.mak
> index 0795d522db..8c5fdf5ee1 100644
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
