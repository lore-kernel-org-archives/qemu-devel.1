Received: from eggs.gnu.org ([2001:4830:134:3::10]:59674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ee7Tr-0001JR-6m
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:55:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ee7Tq-0006qf-7y
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:55:51 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:43460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ee7Tq-0006pf-0P
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:55:50 -0500
Received: by mail-lf0-x241.google.com with SMTP id o89so2697712lfg.10
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 14:55:49 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180123032135.28863-5-f4bug@amsat.org>
References: <20180123032135.28863-1-f4bug@amsat.org>
	<20180123032135.28863-5-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 23 Jan 2018 14:55:17 -0800
Message-ID: <CAKmqyKNCia91fMqFb4LugS4FN-Sg+DYDji5gUoaTq+NnkzvEMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 04/12] sdcard: replace fprintf() by
 qemu_hexdump()
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

On Mon, Jan 22, 2018 at 7:21 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sd.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 3590099ce8..03263e08ae 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -44,13 +44,6 @@
>
>  //#define DEBUG_SD 1
>
> -#ifdef DEBUG_SD
> -#define DPRINTF(fmt, ...) \
> -do { fprintf(stderr, "SD: " fmt , ## __VA_ARGS__); } while (0)
> -#else
> -#define DPRINTF(fmt, ...) do {} while(0)
> -#endif
> -
>  #define ACMD41_ENQUIRY_MASK     0x00ffffff
>  #define OCR_POWER_UP            0x80000000
>  #define OCR_POWER_DELAY_NS      500000 /* 0.5ms */
> @@ -1630,13 +1623,7 @@ send_response:
>      }
>
>  #ifdef DEBUG_SD
> -    if (rsplen) {
> -        int i;
> -        DPRINTF("Response:");
> -        for (i =3D 0; i < rsplen; i++)
> -            fprintf(stderr, " %02x", response[i]);
> -        fputc('\n', stderr);
> -    }
> +    qemu_hexdump((const char *)response, stderr, "Response", rsplen);
>  #endif
>
>      return rsplen;
> --
> 2.15.1
>
>
