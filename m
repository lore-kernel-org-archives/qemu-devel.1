Received: from eggs.gnu.org ([209.51.188.92]:42346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h3Eme-0002Br-NV
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 02:51:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h3Eig-0002jG-P0
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 02:47:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h3Eig-0002iZ-GE
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 02:47:30 -0400
References: <20190310235351.1863-1-philmd@redhat.com>
	<20190310235351.1863-3-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cfb987fd-8190-c100-80b9-657c060eb20f@redhat.com>
Date: Mon, 11 Mar 2019 07:47:19 +0100
MIME-Version: 1.0
In-Reply-To: <20190310235351.1863-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/8] hw/input: Add 8042 PS/2 Keyboard
 Controller to Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

On 11/03/2019 00.53, Philippe Mathieu-Daud=C3=A9 wrote:
> The Intel 8042 chipset also includes some functions unrelated to
> the keyboard, such the A20-Gate.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/input/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/hw/input/Kconfig b/hw/input/Kconfig
> index e2e66f0858..83e4546a28 100644
> --- a/hw/input/Kconfig
> +++ b/hw/input/Kconfig
> @@ -10,6 +10,10 @@ config PCKBD
>      default y
>      depends on ISA_BUS
> =20
> +config I8042
> +    bool
> +    select PCKBD

I fail to see why you need this config switch. There is a "select I8042"
in a later patch, but that's it - you never use this switch to decide
anything (like including a file in the Makefiles or toggle other
switches), so this seems to be just a defunc switch to me. Or do I miss
something?

 Thomas
