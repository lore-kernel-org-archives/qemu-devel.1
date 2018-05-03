Received: from eggs.gnu.org ([2001:4830:134:3::10]:46223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEMKC-0005Vb-Jo
	for qemu-devel@nongnu.org; Thu, 03 May 2018 18:03:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEMKB-0002Cs-DC
	for qemu-devel@nongnu.org; Thu, 03 May 2018 18:03:40 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:33900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fEMKB-0002B9-4t
	for qemu-devel@nongnu.org; Thu, 03 May 2018 18:03:39 -0400
Received: by mail-lf0-x242.google.com with SMTP id h4-v6so28205255lfc.1
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 15:03:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
	<20180503091922.28733-30-edgar.iglesias@gmail.com>
In-Reply-To: <20180503091922.28733-30-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 03 May 2018 22:03:12 +0000
Message-ID: <CAKmqyKMHcDXfaJyipFMKYbN=rRM9S8dWY=KJ6b03v26N5vf8vA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 29/29] target-microblaze: Allow address
 sizes between 32 and 64 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Edgar Iglesias <edgar.iglesias@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, Richard Henderson <richard.henderson@linaro.org>

On Thu, May 3, 2018 at 2:38 AM Edgar E. Iglesias <edgar.iglesias@gmail.com>
wrote:

> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

> Allow address sizes between 32 and 64 bits.

> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   target/microblaze/cpu.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index d0649fdaaa..8c1f850ab1 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -155,9 +155,8 @@ static void mb_cpu_realizefn(DeviceState *dev, Error
**errp)
>           return;
>       }

> -    if (cpu->cfg.addr_size != 32) {
> -        error_setg(errp, "addr-size %d is out of range. "
> -                   "Only 32bit is supported.",
> +    if (cpu->cfg.addr_size < 32 || cpu->cfg.addr_size > 64) {
> +        error_setg(errp, "addr-size %d is out of range (32 - 64)",
>                      cpu->cfg.addr_size);
>           return;
>       }
> --
> 2.14.1
