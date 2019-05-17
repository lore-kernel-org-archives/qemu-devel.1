Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A70C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 10:30:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC44B2089E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 10:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC44B2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45870 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRa7l-0007lq-Ur
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 06:30:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRa5k-0006HC-V1
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:27:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRa5X-0007rp-HC
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:27:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hRa5V-0007q3-LT
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:27:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id w8so6552659wrl.6
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 03:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=EL2wGqTF4L7t2vrlwOHKzdrmLCr6AKhserzf2vUKMvI=;
	b=Njdac0E5Ddit6qyn25/pt1jLaudIFmyKZ+tfKb7icdmEkQ6ZEmZeEiqiKriwtV8aEW
	Wq3lIZqNQvz1iKtPhnSZ9szAxzLbDGNm4m+8oIzjoT/olAIUXmx4AqdyQLpXTG65Bo/S
	0cZqpHSRDEos9ooZV5okmtQOiOCUPxN7OSNoycMEDWWX0N1GbnXc3ob9puTACYLZ7pqj
	CKw/C3XYrCW5X8oRmViV7+hvsUYMGKZbNN+NsEpPjlexx3GRFenyaitnkpKYyGcXZ9nC
	ep9meExBDddQ7GcCnXLyvJ+lCnG1RTmFUFHtVICF9wPNqSNdonzOYSFoZ9OtgrEEV9GU
	I2vw==
X-Gm-Message-State: APjAAAUrNGMb5hcHQgq+8f9e3PRIks/FTQ6sGgeobChPS9CXwF+xv0L7
	rvDtJLxoTr5OZivlkYSWH3nvqA==
X-Google-Smtp-Source: APXvYqwmujZV7mZVLzbGozaWV4HDNKsQbFIuQOXWxPPryhL8b32jC/LGaBTFNTeGiRnLrX0W0pkT+w==
X-Received: by 2002:a5d:40ca:: with SMTP id b10mr35505742wrq.10.1558088859242; 
	Fri, 17 May 2019 03:27:39 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	v12sm7392728wrw.23.2019.05.17.03.27.38
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 03:27:38 -0700 (PDT)
To: KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org
References: <1557923493-4836-1-git-send-email-frederic.konrad@adacore.com>
	<1557923493-4836-6-git-send-email-frederic.konrad@adacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <71a70280-9a7f-fccf-9fad-574cdb31446b@redhat.com>
Date: Fri, 17 May 2019 12:27:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557923493-4836-6-git-send-email-frederic.konrad@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v3 5/7] leon3: add a little bootloader
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

On 5/15/19 2:31 PM, KONRAD Frederic wrote:
> This adds a little bootloader to the leon3_machine when a ram image is
> given through the kernel parameter and no bios are provided:
>   * The UART transmiter is enabled.
>   * The TIMER is initialized.
> 
> Reviewed-by: Fabien Chouteau <chouteau@adacore.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/sparc/leon3.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 71 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index 4f58691..6ba63e6 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -44,6 +44,8 @@
>  #define CPU_CLK (40 * 1000 * 1000)
>  
>  #define LEON3_PROM_FILENAME "u-boot.bin"
> +#define LEON3_PROM_OFFSET    (0x00000000)
> +#define LEON3_RAM_OFFSET     (0x40000000)
>  
>  #define MAX_PILS 16
>  
> @@ -62,6 +64,59 @@ typedef struct ResetData {
>      target_ulong sp;            /* initial stack pointer */
>  } ResetData;
>  
> +static uint32_t *gen_store_u32(uint32_t *code, hwaddr addr, uint32_t val)
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
> +    /* Initialize the UARTs                                        */
> +    /* *UART_CONTROL = UART_RECEIVE_ENABLE | UART_TRANSMIT_ENABLE; */
> +    p = gen_store_u32(p, 0x80000108, 3);
> +
> +    /* Initialize the TIMER 0                                      */
> +    /* *GPTIMER_SCALER_RELOAD = 40 - 1;                            */
> +    p = gen_store_u32(p, 0x80000304, 39);
> +    /* *GPTIMER0_COUNTER_RELOAD = 0xFFFE;                          */
> +    p = gen_store_u32(p, 0x80000314, 0xFFFFFFFE);
> +    /* *GPTIMER0_CONFIG = GPTIMER_ENABLE | GPTIMER_RESTART;        */
> +    p = gen_store_u32(p, 0x80000318, 3);
> +
> +    /* JUMP to the entry point                                     */
> +    stl_p(p++, 0x82100000); /* mov %g0, %g1 */
> +    stl_p(p++, 0x03000000 + extract32(kernel_addr, 10, 22));
> +                            /* sethi %hi(kernel_addr), %g1 */
> +    stl_p(p++, 0x82106000 + extract32(kernel_addr, 0, 10));
> +                            /* or kernel_addr, %g1 */
> +    stl_p(p++, 0x81c04000); /* jmp  %g1 */
> +    stl_p(p++, 0x01000000); /* nop */
> +}
> +
>  static void main_cpu_reset(void *opaque)
>  {
>      ResetData *s   = (ResetData *)opaque;
> @@ -142,7 +197,7 @@ static void leon3_generic_hw_init(MachineState *machine)
>      /* Reset data */
>      reset_info        = g_malloc0(sizeof(ResetData));
>      reset_info->cpu   = cpu;
> -    reset_info->sp    = 0x40000000 + ram_size;
> +    reset_info->sp    = LEON3_RAM_OFFSET + ram_size;
>      qemu_register_reset(main_cpu_reset, reset_info);
>  
>      /* Allocate IRQ manager */
> @@ -164,13 +219,13 @@ static void leon3_generic_hw_init(MachineState *machine)
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
> @@ -190,7 +245,7 @@ static void leon3_generic_hw_init(MachineState *machine)
>      }
>  
>      if (bios_size > 0) {
> -        ret = load_image_targphys(filename, 0x00000000, bios_size);
> +        ret = load_image_targphys(filename, LEON3_PROM_OFFSET, bios_size);
>          if (ret < 0 || ret > prom_size) {
>              error_report("could not load prom '%s'", filename);
>              exit(1);
> @@ -220,10 +275,18 @@ static void leon3_generic_hw_init(MachineState *machine)
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

