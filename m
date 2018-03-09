Received: from eggs.gnu.org ([2001:4830:134:3::10]:52171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euKBb-0004JY-Au
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:44:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euKBa-0003AN-Fr
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:43:59 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:39712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1euKBa-0003A2-BQ
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:43:58 -0500
Received: by mail-oi0-x244.google.com with SMTP id t185so7270112oif.6
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 07:43:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180309153654.13518-8-f4bug@amsat.org>
References: <20180309153654.13518-1-f4bug@amsat.org>
	<20180309153654.13518-8-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Mar 2018 15:43:37 +0000
Message-ID: <CAFEAcA93d8TgbAx0RBmkpCFJtn43fF32jgcMiiy98L0bv6As+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 7/8] sdhci: Fix a typo in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair@alistair23.me>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>

On 9 March 2018 at 15:36, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/sd/sdhci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 97b4a473c8..1b828b104d 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -433,13 +433,13 @@ static void sdhci_read_block_from_card(SDHCIState *=
s)
>      for (index =3D 0; index < blk_size; index++) {
>          data =3D sdbus_read_data(&s->sdbus);
>          if (!FIELD_EX32(s->hostctl2, SDHC_HOSTCTL2, EXECUTE_TUNING)) {
> -            /* Device is not in tunning */
> +            /* Device is not in tuning */
>              s->fifo_buffer[index] =3D data;
>          }
>      }
>
>      if (FIELD_EX32(s->hostctl2, SDHC_HOSTCTL2, EXECUTE_TUNING)) {
> -        /* Device is in tunning */
> +        /* Device is in tuning */
>          s->hostctl2 &=3D ~R_SDHC_HOSTCTL2_EXECUTE_TUNING_MASK;
>          s->hostctl2 |=3D R_SDHC_HOSTCTL2_SAMPLING_CLKSEL_MASK;
>          s->prnsts &=3D ~(SDHC_DAT_LINE_ACTIVE | SDHC_DOING_READ |
> --
> 2.16.2

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
