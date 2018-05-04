Received: from eggs.gnu.org ([2001:4830:134:3::10]:51231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEkEF-00056f-NM
	for qemu-devel@nongnu.org; Fri, 04 May 2018 19:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEkEE-00079z-Q5
	for qemu-devel@nongnu.org; Fri, 04 May 2018 19:35:07 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:37623)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fEkEE-00079Z-IH
	for qemu-devel@nongnu.org; Fri, 04 May 2018 19:35:06 -0400
Received: by mail-lf0-x242.google.com with SMTP id b23-v6so33109988lfg.4
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 16:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180504155918.21287-1-f4bug@amsat.org>
	<20180504155918.21287-9-f4bug@amsat.org>
In-Reply-To: <20180504155918.21287-9-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 04 May 2018 23:34:39 +0000
Message-ID: <CAKmqyKNdfLhzM-YTPfX-yfmUs5gUDXydXwLpf66gO0oTqTh1hQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/20] sdcard: Fix sd_crc*() style
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>, Stefan Hajnoczi <stefanha@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Fri, May 4, 2018 at 9:03 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
wrote:

> Fix style to keep patchew/checkpatch happy when moving this code
> in the next patch.

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   hw/sd/sd.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)

> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 3708ec1d72..a28ef8de5e 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -243,12 +243,14 @@ static uint8_t sd_crc7(const void *message, size_t
width)
>       uint8_t shift_reg =3D 0x00;
>       const uint8_t *msg =3D (const uint8_t *)message;

> -    for (i =3D 0; i < width; i ++, msg ++)
> -        for (bit =3D 7; bit >=3D 0; bit --) {
> +    for (i =3D 0; i < width; i++, msg++) {
> +        for (bit =3D 7; bit >=3D 0; bit--) {
>               shift_reg <<=3D 1;
> -            if ((shift_reg >> 7) ^ ((*msg >> bit) & 1))
> +            if ((shift_reg >> 7) ^ ((*msg >> bit) & 1)) {
>                   shift_reg ^=3D 0x89;
> +            }
>           }
> +    }

>       return shift_reg;
>   }
> @@ -260,12 +262,14 @@ static uint16_t sd_crc16(const void *message,
size_t width)
>       const uint16_t *msg =3D (const uint16_t *)message;
>       width <<=3D 1;

> -    for (i =3D 0; i < width; i ++, msg ++)
> -        for (bit =3D 15; bit >=3D 0; bit --) {
> +    for (i =3D 0; i < width; i++, msg++) {
> +        for (bit =3D 15; bit >=3D 0; bit--) {
>               shift_reg <<=3D 1;
> -            if ((shift_reg >> 15) ^ ((*msg >> bit) & 1))
> +            if ((shift_reg >> 15) ^ ((*msg >> bit) & 1)) {
>                   shift_reg ^=3D 0x1011;
> +            }
>           }
> +    }

>       return shift_reg;
>   }
> --
> 2.17.0
