Received: from eggs.gnu.org ([2001:4830:134:3::10]:50571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eYfJ7-0001bH-Fy
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:50:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eYfJ6-00031w-It
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:50:13 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:32828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eYfJ6-00031G-CR
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:50:12 -0500
Received: by mail-wr0-x241.google.com with SMTP id p6so12238361wrd.0
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 13:50:12 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180103212436.15762-13-f4bug@amsat.org>
References: <20180103212436.15762-1-f4bug@amsat.org>
	<20180103212436.15762-13-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 8 Jan 2018 13:49:40 -0800
Message-ID: <CAKmqyKOZD_dk5YPLdEV3ogVMZMw=Dof4i_bRxtQnwO9+e1pnrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 12/25] sdcard: use a 16-bit integer for
 the 16-bit RCA register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Olbrich <m.olbrich@pengutronix.de>, Andrzej Zaborowski <balrogg@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Paul Brook <paul@codesourcery.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On Wed, Jan 3, 2018 at 1:24 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index e0550cd174..e6a6e0b2ad 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -854,7 +854,7 @@ static void sd_lock_command(SDState *sd)
>
>  static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>  {
> -    uint32_t rca =3D 0x0000;
> +    uint16_t rca =3D 0x0000;
>      uint64_t addr =3D (sd->ocr & (1 << 30)) ? (uint64_t) req.arg << 9 : =
req.arg;
>
>      if (req.cmd !=3D 55 || sd->expecting_acmd) {
> --
> 2.15.1
>
>
