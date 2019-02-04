Received: from eggs.gnu.org ([209.51.188.92]:33675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqZu1-0004N4-SE
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 03:46:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqZu0-0004x8-Kw
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 03:46:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gqZu0-0004fo-8A
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 03:46:52 -0500
References: <20190203220744.11734-1-philmd@redhat.com>
	<20190203220744.11734-7-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d6594582-7fea-0c8a-e2a9-7ff90c0c55dc@redhat.com>
Date: Mon, 4 Feb 2019 09:46:30 +0100
MIME-Version: 1.0
In-Reply-To: <20190203220744.11734-7-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/6] mips: Express dependencies of the
 Loongson 2E machine with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Yang Zhong <yang.zhong@intel.com>, Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, James Hogan <jhogan@kernel.org>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On 2019-02-03 23:07, Philippe Mathieu-Daud=C3=A9 wrote:
> The Loongson 2E uses a Bonito64 system controller as North Bridge and a
> VT82C686 chipset as South Bridge. The network card chipset is a RTL8139=
D.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
[...]
> diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
> index 2940ff39ab..16b2bdb068 100644
> --- a/hw/mips/Kconfig
> +++ b/hw/mips/Kconfig
> @@ -42,6 +42,11 @@ config JAZZ
> =20
>  config FULONG
>      bool
> +    select PCI_BONITO
> +    select VT82C686
> +    select SMBUS_EEPROM
> +    select RTL8139_PCI

If I've got the code right, the RTL8139 is optional for this board, i.e.
when you run with -nodefaults or -net none, then the board is still
usable. So this is not a hard requirement and thus I think it would be
nicer to drop the "select RTL8139_PCI" and rely on the "default y if
PCI_DEVICES" in the hw/net/Kconfig file.

 Thomas
