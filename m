Received: from eggs.gnu.org ([2001:4830:134:3::10]:46117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1egv5M-00080l-ER
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:18:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1egv5L-00073q-Fi
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:18:08 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:33010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1egv5L-00073L-6z
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:18:07 -0500
Received: by mail-lf0-x242.google.com with SMTP id t139so21591653lff.0
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 08:18:07 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180123033034.29493-4-f4bug@amsat.org>
References: <20180123033034.29493-1-f4bug@amsat.org>
	<20180123033034.29493-4-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 31 Jan 2018 08:17:35 -0800
Message-ID: <CAKmqyKMNdCi_CUxk_i8x3SR4EzTuK3=eKCEU40Fw7-sROkO8aA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 03/18] sdcard: fix the 'maximum data
 transfer rate' to 25MHz
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Mon, Jan 22, 2018 at 7:30 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> To comply with Spec v1.10 (and 2.00, 3.01):
>
> . TRAN_SPEED
>
> for current SD Memory Cards that field must be always 0_0110_010b (032h) =
which is
> equal to 25MHz - the mandatory maximum operating frequency of SD Memory C=
ard.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index f6318c6fdb..56df5b660a 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -356,7 +356,7 @@ static void sd_reset_csd(SDState *sd, uint64_t size)
>          sd->csd[0] =3D 0x00;     /* CSD structure */
>          sd->csd[1] =3D 0x26;     /* Data read access-time-1 */
>          sd->csd[2] =3D 0x00;     /* Data read access-time-2 */
> -        sd->csd[3] =3D 0x5a;     /* Max. data transfer rate */
> +        sd->csd[3] =3D 0x32;  /* Max. data transfer rate: 25 MHz */
>          sd->csd[4] =3D 0x5f;     /* Card Command Classes */
>          sd->csd[5] =3D 0x50 |    /* Max. read data block length */
>              HWBLOCK_SHIFT;
> --
> 2.15.1
>
>
