Received: from eggs.gnu.org ([2001:4830:134:3::10]:58329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ffX8K-0000si-PK
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 17:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ffX8J-0002PD-KZ
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 17:03:44 -0400
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:34865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ffX8J-0002P1-Eg
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 17:03:43 -0400
Received: by mail-oi0-x232.google.com with SMTP id i12-v6so4712273oik.2
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 14:03:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8a6a1a1a1056023dc79179399c11e059fbdcde1a.1531859179.git.alistair.francis@wdc.com>
References: <cover.1531859179.git.alistair.francis@wdc.com>
	<8a6a1a1a1056023dc79179399c11e059fbdcde1a.1531859179.git.alistair.francis@wdc.com>
From: Michael Clark <mjc@sifive.com>
Date: Wed, 18 Jul 2018 09:03:42 +1200
Message-ID: <CAHNT7Nvkcv=R_18O_f_Th4RyBwNRKvuA0pgrXRJoCgPMbf4hzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 3/5] virt: Fix crash when introspecting
 the device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>

On Wed, Jul 18, 2018 at 8:28 AM, Alistair Francis <alistair.francis@wdc.com>
wrote:

> Use the new object_initialize_child() and sysbus_init_child_obj() to
> fix the issue.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>

Reviewed-by: Michael Clark <mjc@sifive.com>


> ---
>  hw/riscv/virt.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index aeada2498d..248bbdffd3 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -274,9 +274,8 @@ static void riscv_virt_board_init(MachineState
> *machine)
>      void *fdt;
>
>      /* Initialize SOC */
> -    object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_HART_ARRAY);
> -    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
> -                              &error_abort);
> +    object_initialize_child(OBJECT(machine), "soc", &s->soc,
> sizeof(s->soc),
> +                            TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
>      object_property_set_str(OBJECT(&s->soc), VIRT_CPU, "cpu-type",
>                              &error_abort);
>      object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
> --
> 2.17.1
>
>
