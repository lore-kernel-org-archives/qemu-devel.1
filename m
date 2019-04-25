Received: from eggs.gnu.org ([209.51.188.92]:55139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hJjcj-0008UF-VG
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 15:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hJjYc-0006i7-S1
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:57:19 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40661)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hJjYc-0006ey-Li
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:57:18 -0400
Received: by mail-pg1-x544.google.com with SMTP id d31so291960pgl.7
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 11:57:18 -0700 (PDT)
Date: Thu, 25 Apr 2019 11:57:16 -0700 (PDT)
In-Reply-To: <CANnJOVHbCGcgnHT3qVbHGFh_Ba0=FqABSoM2SG9ddf-fawwaYg@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-5ee2a059-0cd2-4dc6-8952-2560c4f76161@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
To: fintelia@gmail.com
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, sagark@eecs.berkeley.edu, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-riscv@nongnu.org

On Wed, 10 Apr 2019 09:29:11 PDT (-0700), fintelia@gmail.com wrote:
> Unless I'm missing something, the virt board doesn't support HTIF and
> should not be including this header.
>
> Jonathan
>
> Signed-off-by: Jonathan Behrens <fintelia@gmail.com>
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

Thanks!
