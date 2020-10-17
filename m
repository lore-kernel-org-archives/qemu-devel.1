Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53383C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 16:06:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96EA22076D
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 16:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ko8oN0wx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96EA22076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kToit-0004Lr-OL
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 12:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kToiH-0003p0-6Z; Sat, 17 Oct 2020 12:05:45 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33600)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kToiF-0000HT-EI; Sat, 17 Oct 2020 12:05:44 -0400
Received: by mail-wm1-x342.google.com with SMTP id z22so3096161wmi.0;
 Sat, 17 Oct 2020 09:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WHZuVOTboCsGH6ItzjjMVxR3Qu35ytxpNZkDxSO9LpI=;
 b=ko8oN0wxAWLTzsI/+wtV7Tj1XC5Fc69zQr5lnAp8IxyTKCYv88PBDNmI5dsrGacUnq
 beOvy5r1duPVO6jY9C+pphKzXUqrlWMV+Qe0gdX0YVjpXjyhwImpCEL0rUPj+FGpIK4r
 0tOpoCb7upb8FwdazP/HFJ1V3QUWJnBYKsHsDNLJsKgjiWNrEICqDdUgAWj4YV5O5aTV
 x5lIWAZ0nnqcedT+5sSCFZDohv5g+TS40RAwxFs58zzIeilv0UMcP5Z+aMeNhUvtZdBV
 7xu1ueBQnvotFA3wbnHfssheDKo4szvnF6LbdCM58ATfY+1Q/Bnjr89HWbAnolDhQAQF
 8+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WHZuVOTboCsGH6ItzjjMVxR3Qu35ytxpNZkDxSO9LpI=;
 b=UYi/3Sob18/p75dHSbKji20ErKXN5Xjep7BjsAiUStZvEgT1gYP9aB/Z8416TlBk6Q
 BlzNqM0vUiWs8IuEZ3TCgAT9BWw47GuMFlH5HLd9C2f5gB7iI2wKv1izk1U603y0BSrb
 B6QqDvOFTpFwovdwl21v4/2CG8on/TBjFExufSQ3EEdHMq2vsYgVZpaU8fDecP6dl32W
 L/vL++sZZkDA9llNnVRr8EAaTulc626ggmU1ZAD+3XMlN9wl+Lx14SKKbgCDa7egKw9D
 MkNupAHg41v94v7l74a1gKAIgAtv/FQY285MABuhu2Pw94ftnMnGEGpJygmkOA+9D2F9
 BvZQ==
X-Gm-Message-State: AOAM530/GxE8Bc/Vv0eNVXfIepkfZj8nhXtK/LDC1nVlHZD3CzyvrPh5
 BL9yxDPuE7ViiNeYDX8rKos=
X-Google-Smtp-Source: ABdhPJy+T5gW6zptFhURqJdDp47SQp99Yk8iZjlrX8RAy20N6NXl2s7NwvLoYgW2BoeXcPaBtE+55w==
X-Received: by 2002:a1c:3b8a:: with SMTP id i132mr9535169wma.189.1602950741159; 
 Sat, 17 Oct 2020 09:05:41 -0700 (PDT)
Received: from [192.168.1.36] (117.red-83-52-172.dynamicip.rima-tde.net.
 [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id q9sm9496887wrd.57.2020.10.17.09.05.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2020 09:05:40 -0700 (PDT)
Subject: Re: [PATCH v9] mac_oldworld: Allow loading binary ROM image
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Alistair Francis <alistair@alistair23.me>
References: <20201017155139.5A36A746331@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <11c1edab-bcbe-bb02-7c53-b4b0707779c2@amsat.org>
Date: Sat, 17 Oct 2020 18:05:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201017155139.5A36A746331@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.247,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Alistair for loader

On 10/17/20 5:47 PM, BALATON Zoltan via wrote:
> The beige G3 Power Macintosh has a 4MB firmware ROM. Fix the size of
> the rom region and fall back to loading a binary image with -bios if
> loading ELF image failed. This allows testing emulation with a ROM
> image from real hardware as well as using an ELF OpenBIOS image.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
> v9: Revert change from v8, back to the same as v7 rebased on latest
> 
>   hw/ppc/mac_oldworld.c | 29 ++++++++++++++++++++---------
>   1 file changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index 05e46ee6fe..0117ae17f5 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -59,6 +59,8 @@
>   #define NDRV_VGA_FILENAME "qemu_vga.ndrv"
>   
>   #define GRACKLE_BASE 0xfec00000
> +#define PROM_BASE 0xffc00000
> +#define PROM_SIZE (4 * MiB)
>   
>   static void fw_cfg_boot_set(void *opaque, const char *boot_device,
>                               Error **errp)
> @@ -100,6 +102,7 @@ static void ppc_heathrow_init(MachineState *machine)
>       SysBusDevice *s;
>       DeviceState *dev, *pic_dev;
>       BusState *adb_bus;
> +    uint64_t bios_addr;
>       int bios_size;
>       unsigned int smp_cpus = machine->smp.cpus;
>       uint16_t ppc_boot_device;
> @@ -128,24 +131,32 @@ static void ppc_heathrow_init(MachineState *machine)
>   
>       memory_region_add_subregion(sysmem, 0, machine->ram);
>   
> -    /* allocate and load BIOS */
> -    memory_region_init_rom(bios, NULL, "ppc_heathrow.bios", BIOS_SIZE,
> +    /* allocate and load firmware ROM */
> +    memory_region_init_rom(bios, NULL, "ppc_heathrow.bios", PROM_SIZE,
>                              &error_fatal);
> +    memory_region_add_subregion(sysmem, PROM_BASE, bios);
>   
> -    if (bios_name == NULL)
> +    if (!bios_name) {
>           bios_name = PROM_FILENAME;
> +    }
>       filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> -    memory_region_add_subregion(sysmem, PROM_ADDR, bios);
> -
> -    /* Load OpenBIOS (ELF) */
>       if (filename) {
> -        bios_size = load_elf(filename, NULL, 0, NULL, NULL, NULL, NULL, NULL,
> -                             1, PPC_ELF_MACHINE, 0, 0);
> +        /* Load OpenBIOS (ELF) */
> +        bios_size = load_elf(filename, NULL, NULL, NULL, NULL, &bios_addr,
> +                             NULL, NULL, 1, PPC_ELF_MACHINE, 0, 0);
> +        /* Unfortunately, load_elf sign-extends reading elf32 */

Maybe this is what translate_fn() is for?

uint64_t oldworld_phys(void *opaque, uint64_t addr)
{
     return addr & UINT32_MAX;
}

Using as (untested):

         bios_size = load_elf(filename, NULL, oldworld_phys, NULL,
                              NULL, &bios_addr, NULL,
                              NULL, 1, PPC_ELF_MACHINE, 0, 0);

> +        bios_addr = (uint32_t)bios_addr;
> +
> +        if (bios_size <= 0) {
> +            /* or load binary ROM image */
> +            bios_size = load_image_targphys(filename, PROM_BASE, PROM_SIZE);
> +            bios_addr = PROM_BASE;
> +        }
>           g_free(filename);
>       } else {
>           bios_size = -1;
>       }
> -    if (bios_size < 0 || bios_size > BIOS_SIZE) {
> +    if (bios_size < 0 || bios_addr - PROM_BASE + bios_size > PROM_SIZE) {
>           error_report("could not load PowerPC bios '%s'", bios_name);
>           exit(1);
>       }
> 


