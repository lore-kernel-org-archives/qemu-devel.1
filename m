Received: from eggs.gnu.org ([209.51.188.92]:52467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pburton@wavecomp.com>) id 1gzU8q-0003ee-KC
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 17:27:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pburton@wavecomp.com>) id 1gzU8p-0006cY-FB
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 17:27:00 -0500
Received: from mail-eopbgr720104.outbound.protection.outlook.com
	([40.107.72.104]:6335
	helo=NAM05-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pburton@wavecomp.com>)
	id 1gzU8n-0006bd-Oq
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 17:26:59 -0500
From: Paul Burton <pburton@wavecomp.com>
Date: Thu, 28 Feb 2019 22:26:53 +0000
Message-ID: <20190228222651.qzc3nihybd6sqz4s@pburton-laptop>
References: <20190204202609.26956-1-philmd@redhat.com>
	<20190204202609.26956-5-philmd@redhat.com>
In-Reply-To: <20190204202609.26956-5-philmd@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <8D2797FEE1480C46A21CC677253A8762@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 4/6] mips: Express dependencies of the
 Boston machine with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, =?iso-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yang Zhong <yang.zhong@intel.com>, Paul Burton <pburton@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, James Hogan <jhogan@kernel.org>, Thomas Huth <thuth@redhat.com>

On Mon, Feb 04, 2019 at 09:26:07PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Boston is built around a Xilinx FPGA, which includes a PCIe root port
> and an UART. An Intel EG20T PCH connects the I/O peripherals, but only
> the SATA bus is emulated.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Reviewed-by: Paul Burton <pburton@wavecomp.com>

Thanks,
    Paul

> ---
>  default-configs/mips64el-softmmu.mak | 4 ----
>  hw/mips/Kconfig                      | 5 +++++
>  2 files changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/default-configs/mips64el-softmmu.mak b/default-configs/mips6=
4el-softmmu.mak
> index 23445cfcf9..c6f1f9c9aa 100644
> --- a/default-configs/mips64el-softmmu.mak
> +++ b/default-configs/mips64el-softmmu.mak
> @@ -4,8 +4,4 @@ include mips-softmmu-common.mak
>  CONFIG_IDE_VIA=3Dy
>  CONFIG_FULONG=3Dy
>  CONFIG_VT82C686=3Dy
> -CONFIG_AHCI=3Dy
>  CONFIG_MIPS_BOSTON=3Dy
> -CONFIG_FITLOADER=3Dy
> -CONFIG_PCI_EXPRESS=3Dy
> -CONFIG_PCI_EXPRESS_XILINX=3Dy
> diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
> index ee6290d497..2940ff39ab 100644
> --- a/hw/mips/Kconfig
> +++ b/hw/mips/Kconfig
> @@ -49,3 +49,8 @@ config MIPS_CPS
> =20
>  config MIPS_BOSTON
>      bool
> +    select FITLOADER
> +    select MIPS_CPS
> +    select PCI_EXPRESS_XILINX
> +    select AHCI
> +    select SERIAL
> --=20
> 2.20.1
>=20
