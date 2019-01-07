Received: from eggs.gnu.org ([209.51.188.92]:46077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ggOSg-0008Be-Pj
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 01:32:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ggOSf-0004Qj-ST
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 01:32:34 -0500
References: <20190104175847.6290-1-philmd@redhat.com>
	<20190104175847.6290-4-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5d940a10-85c9-7361-86e0-99f9e1e8e737@redhat.com>
Date: Mon, 7 Jan 2019 07:32:07 +0100
MIME-Version: 1.0
In-Reply-To: <20190104175847.6290-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/16] hw/devices: Remove unused
 TC6393XB_RAM definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>, Richard Henderson <rth@twiddle.net>, Jan Kiszka <jan.kiszka@web.de>, Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Chubb <peter.chubb@nicta.com.au>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Rob Herring <robh@kernel.org>

On 2019-01-04 18:58, Philippe Mathieu-Daud=C3=A9 wrote:
> Introduced in 64b40bc54a9, this definition is no more used since
> a0b753dfd39. Remove it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  include/hw/devices.h | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/include/hw/devices.h b/include/hw/devices.h
> index 0e27feb0c2..4019b3be17 100644
> --- a/include/hw/devices.h
> +++ b/include/hw/devices.h
> @@ -51,7 +51,6 @@ void retu_key_event(void *retu, int state);
> =20
>  /* tc6393xb.c */
>  typedef struct TC6393xbState TC6393xbState;
> -#define TC6393XB_RAM	0x110000 /* amount of ram for Video and USB */
>  TC6393xbState *tc6393xb_init(struct MemoryRegion *sysmem,
>                               uint32_t base, qemu_irq irq);
>  void tc6393xb_gpio_out_set(TC6393xbState *s, int line,
>=20

I think I'd simply squash this into the next patch and mention it in the
patch description there that you removed the #define.

 Thomas
