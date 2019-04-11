Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43322C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 12:07:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0614A206B7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 12:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0614A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47862 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEYUX-00040j-Ah
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 08:07:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hEYTW-0003Ru-TD
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:06:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hEYTV-00059y-6D
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:06:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hEYTU-00058p-Od; Thu, 11 Apr 2019 08:06:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CCB48368FF;
	Thu, 11 Apr 2019 12:06:35 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5AC825D6A9;
	Thu, 11 Apr 2019 12:06:34 +0000 (UTC)
Date: Thu, 11 Apr 2019 14:06:29 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <20190411140629.3a672b39@redhat.com>
In-Reply-To: <9043c3a6bc54faa98ed9fedc0c6c929c993a0bf9.1554937288.git.alistair.francis@wdc.com>
References: <cover.1554937288.git.alistair.francis@wdc.com>
	<9043c3a6bc54faa98ed9fedc0c6c929c993a0bf9.1554937288.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Thu, 11 Apr 2019 12:06:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for 4.1 v3 6/6] riscv: Add a generic spike
 machine
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>,
	"palmer@sifive.com" <palmer@sifive.com>,
	"qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"ijc@hellion.org.uk" <ijc@hellion.org.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411120629.zWYx-KJjoctqpI8Je4c-uKw7CxhP4s72FcW0INA0QRw@z>

On Wed, 10 Apr 2019 23:11:00 +0000
Alistair Francis <Alistair.Francis@wdc.com> wrote:

> Add a generic spike machine (not tied to a version) and deprecate the
> spike mahines that are tied to a specific version. As we can now specify
> the CPU via the command line we no londer need specific versions of the
> spike machines.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

For cpu and initial RAM related parts:

Acked-by: Igor Mammedov <imammedo@redhat.com>

a couple of questions below.
> ---
>  hw/riscv/spike.c | 106 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 105 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index 2a000a5800..9d3f7cec4d 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -39,6 +39,7 @@
>  #include "chardev/char.h"
>  #include "sysemu/arch_init.h"
>  #include "sysemu/device_tree.h"
> +#include "sysemu/qtest.h"
>  #include "exec/address-spaces.h"
>  #include "elf.h"
>  
> @@ -160,7 +161,89 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
>          qemu_fdt_add_subnode(fdt, "/chosen");
>          qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
>      }
> - }
> +}
> +
> +static void spike_board_init(MachineState *machine)
> +{
> +    const struct MemmapEntry *memmap = spike_memmap;
> +
> +    SpikeState *s = g_new0(SpikeState, 1);
> +    MemoryRegion *system_memory = get_system_memory();
> +    MemoryRegion *main_mem = g_new(MemoryRegion, 1);
> +    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
> +    int i;
> +
> +    /* Initialize SOC */
> +    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
> +                            TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
> +    object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-type",
> +                            &error_abort);
> +    object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
> +                            &error_abort);
> +    object_property_set_bool(OBJECT(&s->soc), true, "realized",
> +                            &error_abort);
> +
> +    /* register system main memory (actual RAM) */
> +    memory_region_init_ram(main_mem, NULL, "riscv.spike.ram",
> +                           machine->ram_size, &error_fatal);
do you really care about migration? if not then _nomigrate flavor would
be more suitable.

> +    memory_region_add_subregion(system_memory, memmap[SPIKE_DRAM].base,
> +        main_mem);
> +
> +    /* create device tree */
> +    create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
> +
> +    /* boot rom */
> +    memory_region_init_rom(mask_rom, NULL, "riscv.spike.mrom",
> +                           memmap[SPIKE_MROM].size, &error_fatal);
> +    memory_region_add_subregion(system_memory, memmap[SPIKE_MROM].base,
> +                                mask_rom);
> +
> +    if (machine->kernel_filename) {
> +        load_kernel(machine->kernel_filename);
> +    }
> +
> +    /* reset vector */
> +    uint32_t reset_vec[8] = {
> +        0x00000297,                  /* 1:  auipc  t0, %pcrel_hi(dtb) */
> +        0x02028593,                  /*     addi   a1, t0, %pcrel_lo(1b) */
> +        0xf1402573,                  /*     csrr   a0, mhartid  */
> +#if defined(TARGET_RISCV32)
> +        0x0182a283,                  /*     lw     t0, 24(t0) */
> +#elif defined(TARGET_RISCV64)
> +        0x0182b283,                  /*     ld     t0, 24(t0) */
> +#endif
> +        0x00028067,                  /*     jr     t0 */
> +        0x00000000,
> +        memmap[SPIKE_DRAM].base,     /* start: .dword DRAM_BASE */
> +        0x00000000,
> +                                     /* dtb: */
> +    };
> +
> +    /* copy in the reset vector in little_endian byte order */
> +    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
> +        reset_vec[i] = cpu_to_le32(reset_vec[i]);
> +    }
> +    rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
> +                          memmap[SPIKE_MROM].base, &address_space_memory);
> +
> +    /* copy in the device tree */
> +    if (fdt_pack(s->fdt) || fdt_totalsize(s->fdt) >
> +            memmap[SPIKE_MROM].size - sizeof(reset_vec)) {
> +        error_report("not enough space to store device-tree");
> +        exit(1);
> +    }
> +    qemu_fdt_dumpdtb(s->fdt, fdt_totalsize(s->fdt));
> +    rom_add_blob_fixed_as("mrom.fdt", s->fdt, fdt_totalsize(s->fdt),
> +                          memmap[SPIKE_MROM].base + sizeof(reset_vec),
> +                          &address_space_memory);
> +
> +    /* initialize HTIF using symbols found in load_kernel */
> +    htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
> +
> +    /* Core Local Interruptor (timer and IPI) */
> +    sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
> +        smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
> +}
>  
>  static void spike_v1_10_0_board_init(MachineState *machine)
>  {
> @@ -172,6 +255,12 @@ static void spike_v1_10_0_board_init(MachineState *machine)
>      MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
>      int i;
>  
> +    if (!qtest_enabled()) {
> +        info_report("The Spike v1.10.0 machine has been depreceated. "
> +                    "Please use the deneric spike machine and specify the ISA "
> +                    "versions using -cpu.");
> +    }
Did you mean deprecated in sense that machines will be removed in 2 releases
according to QEMU's deprecation policy?

> +
>      /* Initialize SOC */
>      object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
>                              TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
> @@ -254,6 +343,12 @@ static void spike_v1_09_1_board_init(MachineState *machine)
>      MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
>      int i;
>  
> +    if (!qtest_enabled()) {
> +        info_report("The Spike v1.09.1 machine has been depreceated. "
> +                    "Please use the deneric spike machine and specify the ISA "
> +                    "versions using -cpu.");
> +    }
> +
>      /* Initialize SOC */
>      object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
>                              TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
> @@ -359,8 +454,17 @@ static void spike_v1_10_0_machine_init(MachineClass *mc)
>      mc->desc = "RISC-V Spike Board (Privileged ISA v1.10)";
>      mc->init = spike_v1_10_0_board_init;
>      mc->max_cpus = 1;
> +}
> +
> +static void spike_machine_init(MachineClass *mc)
> +{
> +    mc->desc = "RISC-V Spike Board";
> +    mc->init = spike_board_init;
> +    mc->max_cpus = 1;
>      mc->is_default = 1;
> +    mc->default_cpu_type = SPIKE_V1_10_0_CPU;
>  }
>  
>  DEFINE_MACHINE("spike_v1.9.1", spike_v1_09_1_machine_init)
>  DEFINE_MACHINE("spike_v1.10", spike_v1_10_0_machine_init)
> +DEFINE_MACHINE("spike", spike_machine_init)


