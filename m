Received: from eggs.gnu.org ([2001:4830:134:3::10]:58458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ffX8t-0001Gn-It
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 17:04:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ffX8s-0002fX-Fz
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 17:04:19 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:46748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ffX8s-0002fF-7h
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 17:04:18 -0400
Received: by mail-oi0-x242.google.com with SMTP id y207-v6so4676758oie.13
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 14:04:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9495ff8a469ffcdeeaeaf3f0b59f999d20df8285.1531859179.git.alistair.francis@wdc.com>
References: <cover.1531859179.git.alistair.francis@wdc.com>
	<9495ff8a469ffcdeeaeaf3f0b59f999d20df8285.1531859179.git.alistair.francis@wdc.com>
From: Michael Clark <mjc@sifive.com>
Date: Wed, 18 Jul 2018 09:04:17 +1200
Message-ID: <CAHNT7NuAHubQd8_rUNJ4wpqOkA67K=gB=4U6Pa5t1Afc2CKT6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 5/5] spike: Fix crash when introspecting
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
>  hw/riscv/spike.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index f94e2b6707..c8c056c50b 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -171,9 +171,8 @@ static void spike_v1_10_0_board_init(MachineState
> *machine)
>      int i;
>
>      /* Initialize SOC */
> -    object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_HART_ARRAY);
> -    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
> -                              &error_abort);
> +    object_initialize_child(OBJECT(machine), "soc", &s->soc,
> sizeof(s->soc),
> +                            TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
>      object_property_set_str(OBJECT(&s->soc), SPIKE_V1_10_0_CPU,
> "cpu-type",
>                              &error_abort);
>      object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
> @@ -254,9 +253,8 @@ static void spike_v1_09_1_board_init(MachineState
> *machine)
>      int i;
>
>      /* Initialize SOC */
> -    object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_HART_ARRAY);
> -    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
> -                              &error_abort);
> +    object_initialize_child(OBJECT(machine), "soc", &s->soc,
> sizeof(s->soc),
> +                            TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
>      object_property_set_str(OBJECT(&s->soc), SPIKE_V1_09_1_CPU,
> "cpu-type",
>                              &error_abort);
>      object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
> --
> 2.17.1
>
>
