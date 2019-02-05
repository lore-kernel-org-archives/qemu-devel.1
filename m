Received: from eggs.gnu.org ([209.51.188.92]:55237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqs5Y-0000hM-Mo
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 23:12:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqs5W-0004rh-S4
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 23:12:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gqs5U-0004qt-Rl
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 23:11:58 -0500
References: <20190204202609.26956-1-philmd@redhat.com>
	<20190204202609.26956-4-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <22042877-e949-9afc-4ee9-98d4a87f1bf1@redhat.com>
Date: Tue, 5 Feb 2019 05:11:48 +0100
MIME-Version: 1.0
In-Reply-To: <20190204202609.26956-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/6] mips: Express dependencies of the
 r4k platform with kconfig
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
> This platform use standard PC devices connected to an ISA bus.
> Networking is provided by a ne2000 chipset.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/mips/Kconfig | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
> index ab006477c7..ee6290d497 100644
> --- a/hw/mips/Kconfig
> +++ b/hw/mips/Kconfig
> @@ -1,5 +1,15 @@
>  config R4K
>      bool
> +    select ISA_BUS
> +    select SERIAL_ISA
> +    select I8259
> +    select I8254
> +    select MC146818RTC
> +    select VGA_ISA
> +    select NE2000_ISA
> +    select IDE_ISA
> +    # I8042
> +    select PCKBD

I think you can now also remove "CONFIG_NE2000_ISA=3Dy" from
default-configs/mips-softmmu-common.mak.

 Thomas
