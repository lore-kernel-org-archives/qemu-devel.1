Received: from eggs.gnu.org ([2001:4830:134:3::10]:51153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePXbk-0005pE-AC
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:47:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePXbj-0005dK-9E
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:47:44 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:44792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ePXbj-0005cI-2O
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:47:43 -0500
Received: by mail-wr0-x243.google.com with SMTP id l22so5847465wrc.11
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 09:47:42 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171213195852.30439-11-f4bug@amsat.org>
References: <20171213195852.30439-1-f4bug@amsat.org>
	<20171213195852.30439-11-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 14 Dec 2017 09:47:11 -0800
Message-ID: <CAKmqyKOanQAp26iXxqWQ_HtrLtg_ctgC2_q8nU4qxLSpRt_eyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/14] sdhci: use qemu_log_mask(UNIMP)
 instead of fprintf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Dec 13, 2017 at 11:58 AM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/sd/sdhci.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 044e3d62f1..8fcd48f849 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -936,7 +936,8 @@ static uint64_t sdhci_read(void *opaque, hwaddr offse=
t, unsigned size)
>          ret =3D (SD_HOST_SPECv2_VERS << 16) | sdhci_slotint(s);
>          break;
>      default:
> -        ERRPRINT("bad %ub read: addr[0x%04x]\n", size, (int)offset);
> +        qemu_log_mask(LOG_UNIMP, "SDHC rd_%ub @0x%02" HWADDR_PRIx " "
> +                      "not implemented\n", size, offset);

Is this actually unimplemented? Or is it just a guest error?

Alistair

>          break;
>      }
>
> @@ -1140,8 +1141,8 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t v=
al, unsigned size)
>          sdhci_update_irq(s);
>          break;
>      default:
> -        ERRPRINT("bad %ub write offset: addr[0x%04x] <- %u(0x%x)\n",
> -                 size, (int)offset, value >> shift, value >> shift);
> +        qemu_log_mask(LOG_UNIMP, "SDHC wr_%ub @0x%02" HWADDR_PRIx " <- 0=
x%08x "
> +                      "not implemented\n", size, offset, value >> shift)=
;
>          break;
>      }
>      DPRINT_L2("write %ub: addr[0x%04x] <- %u(0x%x)\n",
> --
> 2.15.1
>
>
