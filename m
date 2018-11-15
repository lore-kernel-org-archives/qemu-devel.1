Received: from eggs.gnu.org ([2001:4830:134:3::10]:60487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gNIZX-0004U2-DT
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:24:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gNIZT-00005R-T6
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:24:43 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:39366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gNIZT-0008Vc-OF
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:24:39 -0500
Received: by mail-yb1-f194.google.com with SMTP id w17-v6so8400082ybl.6
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 06:24:37 -0800 (PST)
MIME-Version: 1.0
References: <1533076661-8030-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1533076661-8030-1-git-send-email-linux@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Nov 2018 15:24:25 +0100
Message-ID: <CAAdtpL6dAKVj3bBLRS_6x4B3Pmed9hodd6-kh2imBbs81txV8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/sd: Mark sd-card as storage device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Aug 1, 2018 at 12:37 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> sd-card is currently listed as uncategorized device.
> Mark it as storage device.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  hw/sd/sd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index d4356e9..aaab15f 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -2121,6 +2121,7 @@ static void sd_class_init(ObjectClass *klass, void =
*data)
>      dc->vmsd =3D &sd_vmstate;
>      dc->reset =3D sd_reset;
>      dc->bus_type =3D TYPE_SD_BUS;
> +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>
>      sc->set_voltage =3D sd_set_voltage;
>      sc->get_dat_lines =3D sd_get_dat_lines;
> --
> 2.7.4
>
