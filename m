Received: from eggs.gnu.org ([2001:4830:134:3::10]:49581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fBjz7-0005gp-BE
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:43:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fBjz6-0005BX-AC
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:43:05 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:37946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fBjz6-0005AG-1F
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:43:04 -0400
Received: by mail-lf0-x243.google.com with SMTP id z130-v6so31735960lff.5
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 09:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <1524699938-6764-1-git-send-email-mjc@sifive.com>
	<1524699938-6764-10-git-send-email-mjc@sifive.com>
In-Reply-To: <1524699938-6764-10-git-send-email-mjc@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 26 Apr 2018 16:42:36 +0000
Message-ID: <CAKmqyKNayXzEHiy_igKPB6x2U5+hs87ng2=B9ewTQ33Q8Y-vng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 09/35] RISC-V: Remove EM_RISCV
 ELF_MACHINE indirection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, patches@groups.riscv.org, palmer@sifive.com, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On Wed, Apr 25, 2018 at 4:51 PM Michael Clark <mjc@sifive.com> wrote:

> Pointless indirection. Other ports use EM_ constants directly.

> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   hw/riscv/sifive_e.c | 2 +-
>   hw/riscv/sifive_u.c | 2 +-
>   hw/riscv/spike.c    | 2 +-
>   hw/riscv/virt.c     | 2 +-
>   target/riscv/cpu.h  | 1 -
>   5 files changed, 4 insertions(+), 5 deletions(-)

> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index 4872b68..39e4cb4 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -88,7 +88,7 @@ static uint64_t load_kernel(const char *kernel_filename=
)

>       if (load_elf(kernel_filename, NULL, NULL,
>                    &kernel_entry, NULL, &kernel_high,
> -                 0, ELF_MACHINE, 1, 0) < 0) {
> +                 0, EM_RISCV, 1, 0) < 0) {
>           error_report("qemu: could not load kernel '%s'",
kernel_filename);
>           exit(1);
>       }
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 2412b5d..115618b 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -74,7 +74,7 @@ static uint64_t load_kernel(const char *kernel_filename=
)

>       if (load_elf(kernel_filename, NULL, NULL,
>                    &kernel_entry, NULL, &kernel_high,
> -                 0, ELF_MACHINE, 1, 0) < 0) {
> +                 0, EM_RISCV, 1, 0) < 0) {
>           error_report("qemu: could not load kernel '%s'",
kernel_filename);
>           exit(1);
>       }
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index f370f12..3f6bd0a 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -64,7 +64,7 @@ static uint64_t load_kernel(const char *kernel_filename=
)
>       uint64_t kernel_entry, kernel_high;

>       if (load_elf_ram_sym(kernel_filename, NULL, NULL,
> -            &kernel_entry, NULL, &kernel_high, 0, ELF_MACHINE, 1, 0,
> +            &kernel_entry, NULL, &kernel_high, 0, EM_RISCV, 1, 0,
>               NULL, true, htif_symbol_callback) < 0) {
>           error_report("qemu: could not load kernel '%s'",
kernel_filename);
>           exit(1);
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 782996c..090befe 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -68,7 +68,7 @@ static uint64_t load_kernel(const char *kernel_filename=
)

>       if (load_elf(kernel_filename, NULL, NULL,
>                    &kernel_entry, NULL, &kernel_high,
> -                 0, ELF_MACHINE, 1, 0) < 0) {
> +                 0, EM_RISCV, 1, 0) < 0) {
>           error_report("qemu: could not load kernel '%s'",
kernel_filename);
>           exit(1);
>       }
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 41e06ac..9871e6f 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -34,7 +34,6 @@

>   #define TCG_GUEST_DEFAULT_MO 0

> -#define ELF_MACHINE EM_RISCV
>   #define CPUArchState struct CPURISCVState

>   #include "qemu-common.h"
> --
> 2.7.0
