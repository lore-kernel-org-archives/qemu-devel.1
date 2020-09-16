Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AEBC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 10:48:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 181C320738
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 10:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tQ5aU+8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181C320738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIUyz-0007II-Q2
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 06:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIUy3-0006XX-6N
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 06:47:15 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43453)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIUy1-000821-HN
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 06:47:14 -0400
Received: by mail-wr1-x441.google.com with SMTP id k15so6365456wrn.10
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 03:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=y1ogJ3lOSdGxdFehYgZ8kLiqS6o4v04EcSwsxgvxk90=;
 b=tQ5aU+8RVzrjMmg+u8qikedPXrhtEGHsJWzllHIvn9Mb/Necs4ZUXA+q7s846YYlfi
 sGUzckdAUbYw7mVcTuCk6WMfGJJcPX58G6J72qv+bn9oVRZ17s3eERg8zYdN0n6vmKg4
 jQXZldgzG6q4s17sIroRbiD4szJN+WGLm5slVVzdhrlHgSE1JgHdLr9cN7kVXvxi8SBa
 OotxtcH+KP9SJxFe86gFse/UsEBQlvbAvpyl7Fj04z4+ibvBluoe3nACqP0AqnSBg4+O
 M6AT47XXxGq1svSAz7+/FuilzLvKkUy7JIVcMGwlRaWDnsCjG0dQdfNFtZLWzjkcftQT
 24Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=y1ogJ3lOSdGxdFehYgZ8kLiqS6o4v04EcSwsxgvxk90=;
 b=fudxNtJT6pYuwPbr7fCaDE9Sg6LBiLyshB28CQyNXNy/0IrlQavcpg0adgxve7ko5Q
 qLcZW5oDdjDVM+H5vaEYF+aTGsxItkx7v+XhSEAjU82Be7m8oXJDl9Hr8P8f/+dBLi0H
 X7QeyVNipnRoXr7+heP9fT/Jm4soOQBm3pQmGb4TBCFmY1Brrp8EohV0Oc3hpZlI6be5
 CUgJdl79bmEu5j+wp3DjJ+86+60ycKRjQAp28L8Jyxzd86d0jGHmbPf/pM4mPqDGubQP
 XT/Rox/ezYajIeDFLvofqJJUy3put5QIWX2vZQu3P7DOu0ETTeLWZMMm0wtnYjCQZ3vf
 QqlQ==
X-Gm-Message-State: AOAM531caYBZW/FBYW9grpuo+G0JKoXyioNa9Dm+pq/s1IVn+AcYH+pB
 ecm8UWT1xe3S0+8mFDmiaUA=
X-Google-Smtp-Source: ABdhPJy8UjaKSln7urlJBH0hKdVgc7mdRs0WF29p6Q53TbTkkC2TztAYvunZNN96Mu5jU+2/h5fplw==
X-Received: by 2002:a5d:6acf:: with SMTP id u15mr25836596wrw.221.1600253231971; 
 Wed, 16 Sep 2020 03:47:11 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id c16sm2206629wrx.31.2020.09.16.03.47.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2020 03:47:11 -0700 (PDT)
Subject: Re: [PATCH V9 6/6] hw/mips: Add Loongson-3 machine support
To: Huacai Chen <chenhuacai@gmail.com>
References: <1600222344-16808-1-git-send-email-chenhc@lemote.com>
 <1600222344-16808-7-git-send-email-chenhc@lemote.com>
 <c3804617-7c65-4082-de76-81e718f6d139@amsat.org>
 <CAAhV-H5OysVNvGzD066eVqA+-k2+GJDjwSGR0hJT0VUh3Ld83A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <63a89ba1-a920-c2b9-bd4f-7f523fdda895@amsat.org>
Date: Wed, 16 Sep 2020 12:47:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5OysVNvGzD066eVqA+-k2+GJDjwSGR0hJT0VUh3Ld83A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
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
Cc: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/20 11:49 AM, Huacai Chen wrote:
> On Wed, Sep 16, 2020 at 3:56 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> On 9/16/20 4:12 AM, Huacai Chen wrote:
[...]
>>> +static void mips_loongson3_virt_init(MachineState *machine)
>>> +{
>>> +    int i;
>>> +    long bios_size;
>>> +    MIPSCPU *cpu;
>>> +    CPUMIPSState *env;
>>> +    DeviceState *liointc;
>>> +    char *filename;
>>> +    const char *kernel_cmdline = machine->kernel_cmdline;
>>> +    const char *kernel_filename = machine->kernel_filename;
>>> +    const char *initrd_filename = machine->initrd_filename;
>>> +    ram_addr_t ram_size = machine->ram_size;
>>> +    MemoryRegion *address_space_mem = get_system_memory();
>>> +    MemoryRegion *ram = g_new(MemoryRegion, 1);
>>> +    MemoryRegion *bios = g_new(MemoryRegion, 1);
>>> +    MemoryRegion *iomem = g_new(MemoryRegion, 1);
>>> +
>>> +    /* TODO: TCG will support all CPU types */
>>> +    if (!kvm_enabled()) {
>>> +        if (!machine->cpu_type) {
>>> +            machine->cpu_type = MIPS_CPU_TYPE_NAME("Loongson-3A1000");
>>> +        }
>>> +        if (!strstr(machine->cpu_type, "Loongson-3A1000")) {
>>> +            error_report("Loongson-3/TCG need cpu type Loongson-3A1000");
>>> +            exit(1);
>>> +        }
>>> +    } else {
>>> +        if (!machine->cpu_type) {
>>> +            machine->cpu_type = MIPS_CPU_TYPE_NAME("Loongson-3A4000");
>>> +        }
>>> +        if (!strstr(machine->cpu_type, "Loongson-3A4000")) {
>>> +            error_report("Loongson-3/KVM need cpu type Loongson-3A4000");
>>> +            exit(1);
>>> +        }
>>> +    }
>>> +
>>> +    if (ram_size < 512 * MiB) {
>>> +        error_report("Loongson-3 need at least 512MB memory");
>>
>> Typo "needs", but why?
> Though you told me "QEMU shouldn't assume anything about the guest",
> but Loongson-3 machine really need at least 512M memory. And as you
> said, this can simplify the memsize/highmemsize process (always larger
> than 256).

OK, that's fine.

> 
>>
>>> +        exit(1);
>>> +    }
>>> +
>>> +    /*
>>> +     * The whole MMIO range among configure registers doesn't generate
>>> +     * exception when accessing invalid memory. Create an empty slot to
>>> +     * emulate this feature.
>>> +     */
>>> +    empty_slot_init("fallback", 0, 0x80000000);
>>
>> Again, this doesn't look correct (no comment in my previous review).
> This is written by Jiaxun because this is only needed by TCG, and he
> said that malta also uses empty_slot_init() here.

IIRC for Malta this is a GT64120 specific hole.

In this case I'd like to know the justification first.
Maybe you want to add this hole in the LOONGSON_LIOINTC device...

> 
>>
>>> +
>>> +    liointc = qdev_new("loongson.liointc");
>>> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(liointc), &error_fatal);
>>> +
>>> +    sysbus_mmio_map(SYS_BUS_DEVICE(liointc), 0, virt_memmap[VIRT_LIOINTC].base);
>>> +
>>> +    for (i = 0; i < machine->smp.cpus; i++) {
>>> +        int ip;
>>> +
>>> +        /* init CPUs */
>>> +        cpu = MIPS_CPU(cpu_create(machine->cpu_type));
>>> +
>>> +        /* Init internal devices */
>>> +        cpu_mips_irq_init_cpu(cpu);
>>> +        cpu_mips_clock_init(cpu);
>>> +        qemu_register_reset(main_cpu_reset, cpu);
>>> +
>>> +        if (i >= 4) {
>>> +            continue; /* Only node-0 can be connected to LIOINTC */
>>> +        }
>>> +
>>> +        for (ip = 0; ip < 4 ; ip++) {
>>> +            int pin = i * 4 + ip;
>>> +            sysbus_connect_irq(SYS_BUS_DEVICE(liointc),
>>> +                               pin, cpu->env.irq[ip + 2]);
>>> +        }
>>> +    }
>>> +    env = &MIPS_CPU(first_cpu)->env;
>>> +
>>> +    /* Allocate RAM/BIOS, 0x00000000~0x10000000 is alias of 0x80000000~0x90000000 */
>>> +    memory_region_init_rom(bios, NULL, "loongson3.bios",
>>> +                           virt_memmap[VIRT_BIOS_ROM].size, &error_fatal);
>>> +    memory_region_init_alias(ram, NULL, "loongson3.lowmem",
>>> +                           machine->ram, 0, virt_memmap[VIRT_LOWMEM].size);
>>> +    memory_region_init_io(iomem, NULL, &loongson3_pm_ops,
>>> +                           NULL, "loongson3_pm", virt_memmap[VIRT_PM].size);
>>> +
>>> +    memory_region_add_subregion(address_space_mem,
>>> +                      virt_memmap[VIRT_LOWMEM].base, ram);
>>> +    memory_region_add_subregion(address_space_mem,
>>> +                      virt_memmap[VIRT_BIOS_ROM].base, bios);
>>> +    memory_region_add_subregion(address_space_mem,
>>> +                      virt_memmap[VIRT_HIGHMEM].base, machine->ram);
>>> +    memory_region_add_subregion(address_space_mem,
>>> +                      virt_memmap[VIRT_PM].base, iomem);
>>> +
[...]

