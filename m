Received: from eggs.gnu.org ([2001:4830:134:3::10]:46203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLT9L-0004oN-ED
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:45:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLT9H-000692-GT
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:45:51 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:45974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLT9H-00068u-9b
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:45:47 -0400
Received: by mail-qk0-x243.google.com with SMTP id a8-v6so17278059qkj.12
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 05:45:47 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
	<1527034517-7851-30-git-send-email-mjc@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <82d26b5c-c6a6-62d6-d167-aebc23366885@amsat.org>
Date: Wed, 23 May 2018 09:45:41 -0300
MIME-Version: 1.0
In-Reply-To: <1527034517-7851-30-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 29/30] RISC-V: Don't add NULL bootargs
 to device-tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: patches@groups.riscv.org

On 05/22/2018 09:15 PM, Michael Clark wrote:

With your Signed-off-by:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/riscv/sifive_u.c | 4 +++-
>  hw/riscv/spike.c    | 6 ++++--
>  hw/riscv/virt.c     | 4 +++-
>  3 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 326b0f434cff..02721d43c474 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -206,7 +206,9 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>  
>      qemu_fdt_add_subnode(fdt, "/chosen");
>      qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
> -    qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
> +    if (cmdline) {
> +        qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
> +    }
>      g_free(nodename);
>  }
>  
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index f94e2b670799..5dd7d28aed4e 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -156,8 +156,10 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
>      g_free(cells);
>      g_free(nodename);
>  
> -    qemu_fdt_add_subnode(fdt, "/chosen");
> -    qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
> +    if (cmdline) {
> +        qemu_fdt_add_subnode(fdt, "/chosen");
> +        qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
> +    }
>   }
>  
>  static void spike_v1_10_0_board_init(MachineState *machine)
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 321fa6e8122a..c889aa3cd269 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -253,7 +253,9 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>  
>      qemu_fdt_add_subnode(fdt, "/chosen");
>      qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
> -    qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
> +    if (cmdline) {
> +        qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
> +    }
>      g_free(nodename);
>  
>      return fdt;
> 
