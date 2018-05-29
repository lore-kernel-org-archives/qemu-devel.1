Received: from eggs.gnu.org ([2001:4830:134:3::10]:58349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fNoLb-0003cx-AZ
	for qemu-devel@nongnu.org; Tue, 29 May 2018 19:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fNoLa-0008VE-6i
	for qemu-devel@nongnu.org; Tue, 29 May 2018 19:48:11 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:38400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fNoLZ-0008UV-T3
	for qemu-devel@nongnu.org; Tue, 29 May 2018 19:48:10 -0400
Received: by mail-lf0-x244.google.com with SMTP id z142-v6so1388273lff.5
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 16:48:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1527034517-7851-18-git-send-email-mjc@sifive.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
	<1527034517-7851-18-git-send-email-mjc@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 29 May 2018 16:47:38 -0700
Message-ID: <CAKmqyKOQjz60Miv1xg9C8k3T8Y1o-z9KP95mT_vwVwnYazBwDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 17/30] RISC-V: Replace
 __builtin_popcount with ctpop8 in PLIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, patches@groups.riscv.org

On Tue, May 22, 2018 at 5:15 PM, Michael Clark <mjc@sifive.com> wrote:
> The mode variable only uses the lower 4-bits (M,H,S,U) so
> replace the GCC specific __builtin_popcount with ctpop8.
>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/sifive_plic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
> index b267ff88902d..dc6f4924e282 100644
> --- a/hw/riscv/sifive_plic.c
> +++ b/hw/riscv/sifive_plic.c
> @@ -383,7 +383,7 @@ static void parse_hart_config(SiFivePLICState *plic)
>      p = plic->hart_config;
>      while ((c = *p++)) {
>          if (c == ',') {
> -            addrid += __builtin_popcount(modes);
> +            addrid += ctpop8(modes);
>              modes = 0;
>              hartid++;
>          } else {
> @@ -397,7 +397,7 @@ static void parse_hart_config(SiFivePLICState *plic)
>          }
>      }
>      if (modes) {
> -        addrid += __builtin_popcount(modes);
> +        addrid += ctpop8(modes);
>      }
>      hartid++;
>
> --
> 2.7.0
>
>
