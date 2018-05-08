Received: from eggs.gnu.org ([2001:4830:134:3::10]:46751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fGBGi-000089-En
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fGBGh-0003S0-Ai
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:39:36 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:36735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fGBGh-0003Ra-3K
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:39:35 -0400
Received: by mail-lf0-x243.google.com with SMTP id t129-v6so8889307lff.3
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 15:39:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180508144242.13370-1-f4bug@amsat.org>
References: <20180508144242.13370-1-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 8 May 2018 15:39:02 -0700
Message-ID: <CAKmqyKM9OrAq2j_Z6z6ioES-BO3qTUYh+VPtFz6eQAcLYL-_Rg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] RISC-V: Remove unnecessary header include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <alistair@alistair23.me>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Tue, May 8, 2018 at 7:42 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv_htif.c | 1 -
>  hw/riscv/sifive_e.c   | 1 -
>  hw/riscv/sifive_u.c   | 1 -
>  hw/riscv/spike.c      | 1 -
>  hw/riscv/virt.c       | 1 -
>  5 files changed, 5 deletions(-)
>
> diff --git a/hw/riscv/riscv_htif.c b/hw/riscv/riscv_htif.c
> index 3e17f30251..43533f9dc2 100644
> --- a/hw/riscv/riscv_htif.c
> +++ b/hw/riscv/riscv_htif.c
> @@ -29,7 +29,6 @@
>  #include "chardev/char-fe.h"
>  #include "hw/riscv/riscv_htif.h"
>  #include "qemu/timer.h"
> -#include "exec/address-spaces.h"
>  #include "qemu/error-report.h"
>
>  #define RISCV_DEBUG_HTIF 0
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index e4ecb7aa4b..d3d11e849b 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -46,7 +46,6 @@
>  #include "hw/riscv/sifive_e.h"
>  #include "chardev/char.h"
>  #include "sysemu/arch_init.h"
> -#include "exec/address-spaces.h"
>  #include "elf.h"
>
>  static const struct MemmapEntry {
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index c05dcbba95..07f8644695 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -44,7 +44,6 @@
>  #include "chardev/char.h"
>  #include "sysemu/arch_init.h"
>  #include "sysemu/device_tree.h"
> -#include "exec/address-spaces.h"
>  #include "elf.h"
>
>  #include <libfdt.h>
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index f94e2b6707..aecdf296cc 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -39,7 +39,6 @@
>  #include "chardev/char.h"
>  #include "sysemu/arch_init.h"
>  #include "sysemu/device_tree.h"
> -#include "exec/address-spaces.h"
>  #include "elf.h"
>
>  #include <libfdt.h>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index ad03113e0f..d967624bcc 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -37,7 +37,6 @@
>  #include "chardev/char.h"
>  #include "sysemu/arch_init.h"
>  #include "sysemu/device_tree.h"
> -#include "exec/address-spaces.h"
>  #include "elf.h"
>
>  #include <libfdt.h>
> --
> 2.17.0
>
>
