Received: from eggs.gnu.org ([2001:4830:134:3::10]:51452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eR6YH-0000tV-G2
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 20:18:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eR6YG-0001TC-I8
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 20:18:37 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171215031547.31006-14-f4bug@amsat.org>
References: <20171215031547.31006-1-f4bug@amsat.org>
	<20171215031547.31006-14-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 18 Dec 2017 17:18:04 -0800
Message-ID: <CAKmqyKOSHhEsgA_a5SE2Q2NwJO2UCxYJ=HRT=FMKBNhiH5AN8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 13/20] sdhci: Implement write method of
 ACMD12ERRSTS register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, Andrzej Zaborowski <balrogg@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Jason Wang <jasowang@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>

On Thu, Dec 14, 2017 at 7:15 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> From: Andrey Smirnov <andrew.smirnov@gmail.com>
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sdhci.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 9c1b28d9dd..64a9b26e0d 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1124,6 +1124,9 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t v=
al, unsigned size)
>      case SDHC_ADMASYSADDR + 4:
>          s->admasysaddr =3D deposit64(s->admasysaddr, 32, 32, value);
>          break;
> +    case SDHC_ACMD12ERRSTS:
> +        MASKED_WRITE(s->acmd12errsts, mask, value);
> +        break;
>      case SDHC_FEAER:
>          s->acmd12errsts |=3D value;
>          s->errintsts |=3D (value >> 16) & s->errintstsen;
> --
> 2.15.1
>
>
