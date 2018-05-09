Received: from eggs.gnu.org ([2001:4830:134:3::10]:49959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fGTMv-0000pm-4a
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fGTMu-0000d3-8X
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:59:13 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:38756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fGTMu-0000cE-1a
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:59:12 -0400
Received: by mail-lf0-x243.google.com with SMTP id z142-v6so8947820lff.5
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 10:59:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180509034658.26455-3-f4bug@amsat.org>
References: <20180509034658.26455-1-f4bug@amsat.org>
	<20180509034658.26455-3-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 9 May 2018 10:58:39 -0700
Message-ID: <CAKmqyKNs7L14CfUcsqLL2R_2YM-qNuTeUP3+-RpeZ+93u07y2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/14] sdcard: Constify sd_crc*()'s
 message argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>, Stefan Hajnoczi <stefanha@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Tue, May 8, 2018 at 8:46 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/sd/sd.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 235e0518d6..eb6dd5482e 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -236,11 +236,11 @@ static const int sd_cmd_class[SDMMC_CMD_MAX] =3D {
>      7,  7, 10,  7,  9,  9,  9,  8,  8, 10,  8,  8,  8,  8,  8,  8,
>  };
>
> -static uint8_t sd_crc7(void *message, size_t width)
> +static uint8_t sd_crc7(const void *message, size_t width)
>  {
>      int i, bit;
>      uint8_t shift_reg =3D 0x00;
> -    uint8_t *msg =3D (uint8_t *) message;
> +    const uint8_t *msg =3D (const uint8_t *)message;
>
>      for (i =3D 0; i < width; i ++, msg ++)
>          for (bit =3D 7; bit >=3D 0; bit --) {
> @@ -252,11 +252,11 @@ static uint8_t sd_crc7(void *message, size_t width)
>      return shift_reg;
>  }
>
> -static uint16_t sd_crc16(void *message, size_t width)
> +static uint16_t sd_crc16(const void *message, size_t width)
>  {
>      int i, bit;
>      uint16_t shift_reg =3D 0x0000;
> -    uint16_t *msg =3D (uint16_t *) message;
> +    const uint16_t *msg =3D (const uint16_t *)message;
>      width <<=3D 1;
>
>      for (i =3D 0; i < width; i ++, msg ++)
> --
> 2.17.0
>
>
