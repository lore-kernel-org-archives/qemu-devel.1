Received: from eggs.gnu.org ([209.51.188.92]:44251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hEMWo-0000rW-3J
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 19:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hEMWn-0007of-3B
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 19:21:14 -0400
MIME-Version: 1.0
References: <CANnJOVHbCGcgnHT3qVbHGFh_Ba0=FqABSoM2SG9ddf-fawwaYg@mail.gmail.com>
In-Reply-To: <CANnJOVHbCGcgnHT3qVbHGFh_Ba0=FqABSoM2SG9ddf-fawwaYg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 10 Apr 2019 16:19:36 -0700
Message-ID: <CAKmqyKNfm2jL+qDmnoXfur7CM2XGLOV2Vu6jNY5kNkxRcYFZpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/riscv: Remove unused include of
 riscv_htif.h for virt board
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

On Wed, Apr 10, 2019 at 9:30 AM Jonathan Behrens <fintelia@gmail.com> wrote:
>
> Unless I'm missing something, the virt board doesn't support HTIF and
> should not be including this header.

Thanks for the patch!

You aren't missing anything, it can be removed.

>
> Jonathan

Can you send a v2 without the uncertainty in the commit message? Can
you also remove your name from the message? For such a small patch the
commit title by itself will be enough.

>
> Signed-off-by: Jonathan Behrens <fintelia@gmail.com>

With an updated commit message:

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
