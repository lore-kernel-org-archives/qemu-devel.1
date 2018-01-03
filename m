Received: from eggs.gnu.org ([2001:4830:134:3::10]:42163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eWWg6-0002KE-2s
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:13:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eWWg5-00072j-8g
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:13:06 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:43900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eWWg5-00072P-1u
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:13:05 -0500
Received: by mail-wr0-x242.google.com with SMTP id w68so71275wrc.10
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 16:13:05 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171229174933.1781-14-f4bug@amsat.org>
References: <20171229174933.1781-1-f4bug@amsat.org>
	<20171229174933.1781-14-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 2 Jan 2018 16:12:33 -0800
Message-ID: <CAKmqyKME07gNWYsi6GcH+NCCgkYuHFazFn70x-3XC6vXUnTo8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 13/42] sdhci: rename the SDHC_CAPAB
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Fri, Dec 29, 2017 at 9:49 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sdhci-internal.h | 2 +-
>  hw/sd/sdhci.c          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
> index df240ea046..b7475a1b7b 100644
> --- a/hw/sd/sdhci-internal.h
> +++ b/hw/sd/sdhci-internal.h
> @@ -176,7 +176,7 @@ FIELD(SDHC_PRNSTS, WRITE_PROTECT,      19, 1);
>  #define SDHC_ACMD12ERRSTS              0x3C
>
>  /* HWInit Capabilities Register 0x05E80080 */
> -#define SDHC_CAPAREG                   0x40
> +#define SDHC_CAPAB                     0x40
>  #define SDHC_CAN_DO_DMA                0x00400000
>  #define SDHC_CAN_DO_ADMA2              0x00080000
>  #define SDHC_CAN_DO_ADMA1              0x00100000
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index b5ecbc9969..604ad525f6 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -903,7 +903,7 @@ static uint64_t sdhci_read(void *opaque, hwaddr offse=
t, unsigned size)
>      case SDHC_ACMD12ERRSTS:
>          ret =3D s->acmd12errsts;
>          break;
> -    case SDHC_CAPAREG:
> +    case SDHC_CAPAB:
>          ret =3D s->capareg;
>          break;
>      case SDHC_MAXCURR:
> --
> 2.15.1
>
>
