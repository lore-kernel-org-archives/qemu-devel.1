Received: from eggs.gnu.org ([2001:4830:134:3::10]:57291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJh6I-0004HB-Dj
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:47:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJgt9-00029y-4B
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:34:03 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34741)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJgt8-00029G-Hk
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:34:03 -0500
Received: by mail-oi1-x244.google.com with SMTP id i138-v6so4802226oib.1
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 07:34:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181102001303.32640-3-f4bug@amsat.org>
References: <20181102001303.32640-1-f4bug@amsat.org>
	<20181102001303.32640-3-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Nov 2018 15:33:40 +0000
Message-ID: <CAFEAcA_MCTODEZg0Ak841iaJRBJ43Feh4cw_UmLaxk7-thb1og@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 3.2 v2 2/7] hw/misc/bcm2835_property:
 Handle the 'domain state' property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Guenter Roeck <linux@roeck-us.net>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 2 November 2018 at 00:12, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/misc/bcm2835_property.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
> index 145427ae0f..5d332324bd 100644
> --- a/hw/misc/bcm2835_property.c
> +++ b/hw/misc/bcm2835_property.c
> @@ -121,6 +121,12 @@ static void bcm2835_property_mbox_push(BCM2835Proper=
tyState *s, uint32_t value)
>              resplen =3D 8;
>              break;
>
> +        case 0x00030030: /* domain state */
> +            qemu_log_mask(LOG_UNIMP,
> +                          "bcm2835_property: %x get domain state NYI\n",=
 tag);
> +            resplen =3D 8;
> +            break;
> +

Our handling of "Set power state" has a slightly more sophisticated
"always say yes" implementation, but we have other properties which
we handle unimplemented like this, so if the kernel is happy with
this we don't need to do anything more sophisticated.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
