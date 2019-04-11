Received: from eggs.gnu.org ([209.51.188.92]:54770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hEdiO-0006OJ-Gi
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:42:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hEdiN-00051O-LZ
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:42:20 -0400
MIME-Version: 1.0
References: <CANnJOVF2gE3b-C5zSb85SGoP+9cD9xOQQ5Z4tmsGouagR3xo0Q@mail.gmail.com>
In-Reply-To: <CANnJOVF2gE3b-C5zSb85SGoP+9cD9xOQQ5Z4tmsGouagR3xo0Q@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 11 Apr 2019 10:40:43 -0700
Message-ID: <CAKmqyKO_hggjML2-0d3QCoEM=ByfSKuP-jdRqnhpVHrGmVVVxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] target/riscv: Remove unused include of
 riscv_htif.h for virt board riscv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jonathan Behrens <fintelia@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, "open list:RISC-V" <qemu-riscv@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Thu, Apr 11, 2019 at 8:10 AM Jonathan Behrens <fintelia@gmail.com> wrote:
>
> Signed-off-by: Jonathan Behrens <fintelia@gmail.com>

Awesome! Thanks for the patch.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index fc4c6b306e..3526463034 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -29,7 +29,6 @@
>  #include "hw/sysbus.h"
>  #include "hw/char/serial.h"
>  #include "target/riscv/cpu.h"
> -#include "hw/riscv/riscv_htif.h"
>  #include "hw/riscv/riscv_hart.h"
>  #include "hw/riscv/sifive_plic.h"
>  #include "hw/riscv/sifive_clint.h"
> --
> 2.20.1
