Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A0FC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 14:26:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93E820674
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 14:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93E820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54571 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIwNp-0007zJ-Sy
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 10:26:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIwMA-0006cJ-P8
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:25:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIwHl-0002kb-1d
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:20:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hIwHk-0002k5-NE
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:20:36 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so307359wml.1
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 07:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=L5zb98ZXIT96fLsM7LJ3+ribCeNgDW3II+LAx929vtU=;
	b=uDiS/27O7lFx+WiaSK9TkCC3G8FgRj7Z0etX2i/D9m2V8AbkrwBKvRLUV8cQAOp7Q2
	Zcuj0IvI4xaj+7dCBbtdrelGmWVDIBcs7Q4CcpXT1jgD3r6+lEU4la99jFuka8Ak60X4
	pK9JnB5lMZ8eJAjPzp0yR+N6xE4MCJCZU2CaK5glktXpvLDUU5Rkiu2oH1x3EX/VBSUK
	4ShgDSkvNzjs5bhe5l3CUOAYQXghRGS95ir/NUm5I2jbB+hINJGQwcv1cikktts8E0Ho
	BWLlnRbQ6tsaZMmuFFD8ki+Vv9jLnz8mE03oAdkg4IHdwy/TK2FoN+UlYeSx0fCgaysW
	nXKA==
X-Gm-Message-State: APjAAAVhbPAqzIJOh7AmYihRki0vzA0P186t7blz+HDc8+CDMNciX4Qz
	LCqNIJg9awOWG1jX5MYrzKPFWA==
X-Google-Smtp-Source: APXvYqxq4GUPa4fVuupnYxQi+ZpYe7/C6ZFXHNUSQ8LsXf39FP2pKJokiJxPII4x8bxWjrtgW9A97g==
X-Received: by 2002:a7b:c086:: with SMTP id r6mr2420577wmh.123.1556029235491; 
	Tue, 23 Apr 2019 07:20:35 -0700 (PDT)
Received: from [192.168.1.25] (atoulouse-656-1-803-163.w86-221.abo.wanadoo.fr.
	[86.221.12.163]) by smtp.gmail.com with ESMTPSA id
	17sm12583561wmk.39.2019.04.23.07.20.34
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 07:20:34 -0700 (PDT)
To: KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org
References: <1555669092-10351-1-git-send-email-frederic.konrad@adacore.com>
	<1555669092-10351-2-git-send-email-frederic.konrad@adacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e16760fd-1dc5-1be5-8a47-91f5c2a883ec@redhat.com>
Date: Tue, 23 Apr 2019 16:20:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555669092-10351-2-git-send-email-frederic.konrad@adacore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH V1 1/3] leon3: add a little bootloader
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
Cc: peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk,
	chouteau@adacore.com, atar4qemu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423142033.nDihnP9t2K-l4p9_l5wVgXbtGjDVt6E3ZBugy5YlK6o@z>

Hi Frederic,

On 4/19/19 12:18 PM, KONRAD Frederic wrote:
> This adds a little bootloader to the leon3_machine when a ram image is
> given through the kernel parameter and no bios are provided:
>   * The UART transmiter is enabled.
>   * The TIMER is initialized.
> 
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> ---
>  hw/sparc/leon3.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 70 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index 774639a..2c6f486 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -1,7 +1,7 @@
>  /*
>   * QEMU Leon3 System Emulator
>   *
> - * Copyright (c) 2010-2011 AdaCore
> + * Copyright (c) 2010-2019 AdaCore
>   *
>   * Permission is hereby granted, free of charge, to any person obtaining a copy
>   * of this software and associated documentation files (the "Software"), to deal
> @@ -44,6 +44,8 @@
>  #define CPU_CLK (40 * 1000 * 1000)
>  
>  #define PROM_FILENAME        "u-boot.bin"
> +#define LEON3_PROM_OFFSET    (0x00000000)
> +#define LEON3_RAM_OFFSET     (0x40000000)

I'd have split this patch in 2, first add/use these definitions, then
the bootloader code, but that's OK.

>  
>  #define MAX_PILS 16
>  
> @@ -53,6 +55,55 @@ typedef struct ResetData {
>      target_ulong sp;            /* initial stack pointer */
>  } ResetData;
>  
> +static uint32_t *gen_write_to_addr(uint32_t *code, hwaddr addr, uint32_t val)

Can you rename that gen_store_u32()?
If you prefer gen_write_to_addr() that's fine.

> +{
> +    stl_p(code++, 0x82100000); /* mov %g0, %g1                */
> +    stl_p(code++, 0x84100000); /* mov %g0, %g2                */
> +    stl_p(code++, 0x03000000 +
> +      extract32(addr, 10, 22));
> +                               /* sethi %hi(addr), %g1        */
> +    stl_p(code++, 0x82106000 +
> +      extract32(addr, 0, 10));
> +                               /* or %g1, addr, %g1           */
> +    stl_p(code++, 0x05000000 +
> +      extract32(val, 10, 22));
> +                               /* sethi %hi(val), %g2         */
> +    stl_p(code++, 0x8410a000 +
> +      extract32(val, 0, 10));
> +                               /* or %g2, val, %g2            */
> +    stl_p(code++, 0xc4204000); /* st %g2, [ %g1 ]             */
> +
> +    return code;
> +}
> +
> +/*
> + * When loading a kernel in RAM the machine is expected to be in a different
> + * state (eg: initialized by the bootloader). This little code reproduces
> + * this behavior.
> + */
> +static void write_bootloader(CPUSPARCState *env, uint8_t *base,
> +                             hwaddr kernel_addr)
> +{
> +    uint32_t *p = (uint32_t *) base;
> +
> +    /* Initialize the UARTs                                */
> +    p = gen_write_to_addr(p, 0x80000108, 3);

Can you add comments?
Here are the notes I took while reviewing, they might be enough:

// *UART_CONTROL = UART_RECEIVE_ENABLE | UART_TRANSMIT_ENABLE;

> +
> +    /* Initialize the TIMER 0                              */
> +    p = gen_write_to_addr(p, 0x80000304, 39);

// *GPTIMER_SCALER_RELOAD = 40 - 1;

> +    p = gen_write_to_addr(p, 0x80000314, 0xFFFFFFFE);

// *GPTIMER0_COUNTER_RELOAD = 0xFFFE;

> +    p = gen_write_to_addr(p, 0x80000318, 3);

// *GPTIMER0_CONFIG = GPTIMER_ENABLE | GPTIMER_RESTART;

> +
> +    /* JUMP to the entry point                             */
> +    stl_p(p++, 0x82100000); /* mov %g0, %g1                */
> +    stl_p(p++, 0x03000000 + extract32(kernel_addr, 10, 22));
> +                            /* sethi %hi(kernel_addr), %g1 */
> +    stl_p(p++, 0x82106000 + extract32(kernel_addr, 0, 10));
> +                            /* or kernel_addr, %g1 */
> +    stl_p(p++, 0x81c04000); /* jmp  %g1 */
> +    stl_p(p++, 0x01000000); /* nop */
> +}

Thanks for adding write_bootloader(), I really appreciate your effort.

With the comments:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +
>  static void main_cpu_reset(void *opaque)
>  {
>      ResetData *s   = (ResetData *)opaque;
> @@ -131,11 +182,12 @@ static void leon3_generic_hw_init(MachineState *machine)
>      /* Reset data */
>      reset_info        = g_malloc0(sizeof(ResetData));
>      reset_info->cpu   = cpu;
> -    reset_info->sp    = 0x40000000 + ram_size;
> +    reset_info->sp    = LEON3_RAM_OFFSET + ram_size;
>      qemu_register_reset(main_cpu_reset, reset_info);
>  
>      /* Allocate IRQ manager */
> -    grlib_irqmp_create(0x80000200, env, &cpu_irqs, MAX_PILS, &leon3_set_pil_in);
> +    grlib_irqmp_create(0x80000200, env, &cpu_irqs, MAX_PILS,
> +                       &leon3_set_pil_in);
>  
>      env->qemu_irq_ack = leon3_irq_manager;
>  
> @@ -148,13 +200,13 @@ static void leon3_generic_hw_init(MachineState *machine)
>      }
>  
>      memory_region_allocate_system_memory(ram, NULL, "leon3.ram", ram_size);
> -    memory_region_add_subregion(address_space_mem, 0x40000000, ram);
> +    memory_region_add_subregion(address_space_mem, LEON3_RAM_OFFSET, ram);
>  
>      /* Allocate BIOS */
>      prom_size = 8 * MiB;
>      memory_region_init_ram(prom, NULL, "Leon3.bios", prom_size, &error_fatal);
>      memory_region_set_readonly(prom, true);
> -    memory_region_add_subregion(address_space_mem, 0x00000000, prom);
> +    memory_region_add_subregion(address_space_mem, LEON3_PROM_OFFSET, prom);
>  
>      /* Load boot prom */
>      if (bios_name == NULL) {
> @@ -174,7 +226,7 @@ static void leon3_generic_hw_init(MachineState *machine)
>      }
>  
>      if (bios_size > 0) {
> -        ret = load_image_targphys(filename, 0x00000000, bios_size);
> +        ret = load_image_targphys(filename, LEON3_PROM_OFFSET, bios_size);
>          if (ret < 0 || ret > prom_size) {
>              error_report("could not load prom '%s'", filename);
>              exit(1);
> @@ -198,10 +250,18 @@ static void leon3_generic_hw_init(MachineState *machine)
>              exit(1);
>          }
>          if (bios_size <= 0) {
> -            /* If there is no bios/monitor, start the application.  */
> -            env->pc = entry;
> -            env->npc = entry + 4;
> -            reset_info->entry = entry;
> +            /*
> +             * If there is no bios/monitor just start the application but put
> +             * the machine in an initialized state through a little
> +             * bootloader.
> +             */
> +            uint8_t *bootloader_entry;
> +
> +            bootloader_entry = memory_region_get_ram_ptr(prom);
> +            write_bootloader(env, bootloader_entry, entry);
> +            env->pc = LEON3_PROM_OFFSET;
> +            env->npc = LEON3_PROM_OFFSET + 4;
> +            reset_info->entry = LEON3_PROM_OFFSET;
>          }
>      }
>  
> 

