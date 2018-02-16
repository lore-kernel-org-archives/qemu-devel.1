Received: from eggs.gnu.org ([2001:4830:134:3::10]:57988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1emn9e-0005BM-7r
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 16:02:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1emn9d-0006A0-Dn
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 16:02:50 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:45378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1emn9d-00069U-7G
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 16:02:49 -0500
Received: by mail-lf0-x242.google.com with SMTP id x196so5723695lfd.12
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 13:02:49 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180216022933.10945-7-f4bug@amsat.org>
References: <20180216022933.10945-1-f4bug@amsat.org>
	<20180216022933.10945-7-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 16 Feb 2018 13:02:17 -0800
Message-ID: <CAKmqyKMSb9hU7PHMF3JJ6=+Og64BkUFmpJ3Y+ffuuvWTQCZ=Ew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 6/7] hw/sd: make sd_data_ready() static
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Stefan Weil <sw@weilnetz.de>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Michael Walle <michael@walle.cc>

On Thu, Feb 15, 2018 at 6:29 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> It belongs to the legacy API (the last user has been converted).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  include/hw/sd/sd.h | 1 -
>  hw/sd/sd.c         | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
> index bf1eb0713c..4491db98de 100644
> --- a/include/hw/sd/sd.h
> +++ b/include/hw/sd/sd.h
> @@ -138,7 +138,6 @@ int sd_do_command(SDState *sd, SDRequest *req,
>  void sd_write_data(SDState *sd, uint8_t value);
>  uint8_t sd_read_data(SDState *sd);
>  void sd_set_cb(SDState *sd, qemu_irq readonly, qemu_irq insert);
> -bool sd_data_ready(SDState *sd);
>  /* sd_enable should not be used -- it is only used on the nseries boards=
,
>   * where it is part of a broken implementation of the MMC card slot swit=
ch
>   * (there should be two card slots which are multiplexed to a single MMC
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 9ac9b63ff8..72d32f7845 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1885,7 +1885,7 @@ uint8_t sd_read_data(SDState *sd)
>      return ret;
>  }
>
> -bool sd_data_ready(SDState *sd)
> +static bool sd_data_ready(SDState *sd)
>  {
>      return sd->state =3D=3D sd_sendingdata_state;
>  }
> --
> 2.16.1
>
>
