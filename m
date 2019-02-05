Received: from eggs.gnu.org ([209.51.188.92]:53231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqry4-0005wy-Oj
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 23:04:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqry2-0002Fv-Mr
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 23:04:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gqry0-00029P-IH
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 23:04:14 -0500
References: <20190204202609.26956-1-philmd@redhat.com>
	<20190204202609.26956-3-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <670e437d-845c-22fa-24d6-f44dd2568e15@redhat.com>
Date: Tue, 5 Feb 2019 05:04:00 +0100
MIME-Version: 1.0
In-Reply-To: <20190204202609.26956-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/6] mips: Express dependencies of the
 Jazz machine with kconfig
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
> The Jazz use the RC4030 Asic to provide an EISA bus and DMA/IRQ. The
> framebuffer display is managed by a G364, the network card is a Sonic
> DP83932. A QLogic ESP216 provides a SCSI bus.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  default-configs/mips-softmmu-common.mak |  1 -
>  default-configs/mips64-softmmu.mak      |  5 -----
>  default-configs/mips64el-softmmu.mak    |  6 ------
>  hw/mips/Kconfig                         | 17 +++++++++++++++++
>  4 files changed, 17 insertions(+), 12 deletions(-)
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
> index 8b255efc54..23445cfcf9 100644
> --- a/default-configs/mips64el-softmmu.mak
> +++ b/default-configs/mips64el-softmmu.mak
> @@ -2,13 +2,7 @@
> =20
>  include mips-softmmu-common.mak
>  CONFIG_IDE_VIA=3Dy
> -CONFIG_RC4030=3Dy
> -CONFIG_DP8393X=3Dy
> -CONFIG_DS1225Y=3Dy
>  CONFIG_FULONG=3Dy
> -CONFIG_JAZZ=3Dy

Please keep the CONFIG_JAZZ line here.

 Thomas
