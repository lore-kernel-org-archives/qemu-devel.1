Received: from eggs.gnu.org ([2001:4830:134:3::10]:44046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLT1d-0000Ya-8u
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:37:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLT1Z-0001wy-7M
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:37:53 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:40049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLT1Z-0001wg-38
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:37:49 -0400
Received: by mail-qk0-x243.google.com with SMTP id r66-v6so883520qkr.7
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 05:37:49 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
	<1527034517-7851-18-git-send-email-mjc@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2ee7008d-3ab4-0540-8c1a-9b9c001c3d70@amsat.org>
Date: Wed, 23 May 2018 09:37:45 -0300
MIME-Version: 1.0
In-Reply-To: <1527034517-7851-18-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, patches@groups.riscv.org

On 05/22/2018 09:15 PM, Michael Clark wrote:
> The mode variable only uses the lower 4-bits (M,H,S,U) so
> replace the GCC specific __builtin_popcount with ctpop8.
> 
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
> 
