Received: from eggs.gnu.org ([2001:4830:134:3::10]:55971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePXjs-00054B-20
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:56:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePXjq-0007Bs-RM
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:56:08 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ePXjq-0007AI-Ll
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:56:06 -0500
Received: by mail-wm0-x243.google.com with SMTP id y82so27305136wmg.1
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 09:56:06 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171213195852.30439-13-f4bug@amsat.org>
References: <20171213195852.30439-1-f4bug@amsat.org>
	<20171213195852.30439-13-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 14 Dec 2017 09:55:34 -0800
Message-ID: <CAKmqyKPCfjm9Z6VBNBTKHeXdp4KLpbPWZT3UHmJj08bYNdp04Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 12/14] sdhci: add a trace event for the LED
 control
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
> It blinks to caution the user not to remove the card while the SD card is
> being accessed.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

If you turn this on does it just fill the trace log?

It seems like this will generate too much output if it happens on
every LED blink.

Alistair

> ---
>  hw/sd/sdhci.c      | 1 +
>  hw/sd/trace-events | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index aa2d2fa3d3..dadc4787b2 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1041,6 +1041,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t v=
al, unsigned size)
>                  !(s->capareg & (1 << (31 - ((s->pwrcon >> 1) & 0x7))))) =
{
>              s->pwrcon &=3D ~SDHC_POWER_ON;
>          }
> +        trace_sdhci_led(s->hostctl & 1);
>          break;
>      case SDHC_CLKCON:
>          if (!(mask & 0xFF000000)) {
> diff --git a/hw/sd/trace-events b/hw/sd/trace-events
> index f7a85be53d..11f8fa4fc1 100644
> --- a/hw/sd/trace-events
> +++ b/hw/sd/trace-events
> @@ -13,6 +13,7 @@ sdhci_adma_transfer_completed(void) "ADMA transfer comp=
leted"
>  sdhci_access(const char *access, unsigned int size, uint64_t offset, con=
st char *dir, uint64_t val, uint64_t val2) "%s %ub: addr[0x%04" HWADDR_PRIx=
 "] %s %" PRIu64 "(0x%" PRIx64 ")"
>  sdhci_read_dataport(uint16_t data_count) "all %u bytes of data have been=
 read from input buffer"
>  sdhci_write_dataport(uint16_t data_count) "write buffer filled with %u b=
ytes of data"
> +sdhci_led(bool state) "LED: %u"
>
>  # hw/sd/milkymist-memcard.c
>  milkymist_memcard_memory_read(uint32_t addr, uint32_t value) "addr 0x%08=
x value 0x%08x"
> --
> 2.15.1
>
>
