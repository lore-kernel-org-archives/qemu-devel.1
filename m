Received: from eggs.gnu.org ([2001:4830:134:3::10]:50579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eR6Wt-00088g-2T
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 20:17:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eR6Ws-0000a1-9K
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 20:17:11 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171215031547.31006-9-f4bug@amsat.org>
References: <20171215031547.31006-1-f4bug@amsat.org>
	<20171215031547.31006-9-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 18 Dec 2017 17:16:38 -0800
Message-ID: <CAKmqyKPyzuwX7zhH8YuYw0Ru==R4=pk=CopH2bDuNqsd58Lxjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 08/20] sdhci: use qemu_log_mask(UNIMP)
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
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, Andrzej Zaborowski <balrogg@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>

On Thu, Dec 14, 2017 at 7:15 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sdhci.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 53c1f11855..ca71a70148 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -945,7 +945,8 @@ static uint64_t sdhci_read(void *opaque, hwaddr offse=
t, unsigned size)
>          ret =3D (SD_HOST_SPECv2_VERS << 16) | sdhci_slotint(s);
>          break;
>      default:
> -        ERRPRINT("bad %ub read: addr[0x%04x]\n", size, (int)offset);
> +        qemu_log_mask(LOG_UNIMP, "SDHC rd_%ub @0x%02" HWADDR_PRIx " "
> +                      "not implemented\n", size, offset);
>          break;
>      }
>
> @@ -1149,8 +1150,8 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t v=
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
