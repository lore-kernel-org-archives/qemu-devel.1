Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A266AC43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 14:00:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F19EB2100A
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 14:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AG14vLvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F19EB2100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJdPM-0005nQ-7R
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 10:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJdOb-0005N4-4F
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 09:59:21 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45992)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJdOZ-0007Xr-DX
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 09:59:20 -0400
Received: by mail-wr1-x443.google.com with SMTP id x14so8300543wrl.12
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2020 06:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7l7WKLfzd38Lyzh4hVQq9PFrc/tNLxDpYsxlXHCfn1g=;
 b=AG14vLvAHLBK2IJ8IflzWm8plYVeJCE/AMyPziLfm2ZKzU7WXkbwkgvMEQRApB1BNl
 j+na5zMlB26NyPdpF2ojna+GEp7mgzElXkMq4zzqlU/Sc+H5VxQzkGt+lUXQPI66cco+
 x40+Fz9btpivtcT+o2Obn/Sk2qOaRt2pwkJG5uIvj0DcFE/7NOAhc/BnFSbgvlJqWIef
 ++4U8qT+SwAhQSKtiVelY18UCa2I2L2XP3rYcSxIt7JMscCOk/5btOgjxDCmVF6Hu2bw
 G62C7s9JikUlRV5v6E01D5+kXvSOmhNTQZo127W8OtLBjtb07uKoSqHh1GcYAfGOz44u
 dQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7l7WKLfzd38Lyzh4hVQq9PFrc/tNLxDpYsxlXHCfn1g=;
 b=A3sTWWpEbIXG4hEyEj8eQPPOQA/Ib7xm+elUABGNProNl7LEmpclHuAyNfpoc7Qrca
 HMyrATHDZafSSmDMz2K53/hXN+J4V67ddQFPoRI5tRLxXkPAi6um1cUfq0fBfVTwU3M8
 +IL1srkCaNVmBWdSs14MjBGk2w1O43/WEs8a14Eh4ZYRreBDxG4mkYGLQ/UuooLmfDbw
 dymGDW/EMjmpE9gSlWWDoDS1CzfViOllY0mbjynvl1EzoEqzTGsDgOX+WFHh7jCq/Yww
 meYUiVSSSatu4sxD9PcTMMVD0g0yrvOjk82UYKMq1b+eJviQ6xJjQKRuHN+CY01imbGE
 LaUw==
X-Gm-Message-State: AOAM533QNfHWIfD0HCeUTZ+MB77cHHMMYQ/0ZagcYfABWZeWS+U0uJ0c
 dOKSYe3m9KRrEXQPbpBwrNg=
X-Google-Smtp-Source: ABdhPJzrpje11fIUwgSpfOc0kU0/DSixgZTUrT8+oz1JImbuyzT170NSimOvU4KizTB0Tb9+W2PhUQ==
X-Received: by 2002:adf:dd44:: with SMTP id u4mr41377533wrm.22.1600523957610; 
 Sat, 19 Sep 2020 06:59:17 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id y6sm10957981wrs.7.2020.09.19.06.59.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Sep 2020 06:59:16 -0700 (PDT)
Subject: Re: [PATCH V9 6/6] hw/mips: Add Loongson-3 machine support
To: Huacai Chen <chenhuacai@gmail.com>
References: <1600222344-16808-1-git-send-email-chenhc@lemote.com>
 <1600222344-16808-7-git-send-email-chenhc@lemote.com>
 <c3804617-7c65-4082-de76-81e718f6d139@amsat.org>
 <CAAhV-H5OysVNvGzD066eVqA+-k2+GJDjwSGR0hJT0VUh3Ld83A@mail.gmail.com>
 <63a89ba1-a920-c2b9-bd4f-7f523fdda895@amsat.org>
 <31d4f14f-bba5-a5a5-d024-668558416083@amsat.org>
 <CAAhV-H71RPoqf046-BJWEHkSumNM5mohxhwShSD9PyELTEzEtw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ff3c4df0-6c11-ef9c-a26e-0397e13fc628@amsat.org>
Date: Sat, 19 Sep 2020 15:59:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H71RPoqf046-BJWEHkSumNM5mohxhwShSD9PyELTEzEtw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248, NICE_REPLY_A=-0.001,
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
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/19/20 3:00 AM, Huacai Chen wrote:
> Hi, Philippe,
> 
> On Thu, Sep 17, 2020 at 3:53 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> On 9/16/20 12:47 PM, Philippe Mathieu-Daudé wrote:
>>> On 9/16/20 11:49 AM, Huacai Chen wrote:
>>>> On Wed, Sep 16, 2020 at 3:56 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>>> On 9/16/20 4:12 AM, Huacai Chen wrote:
>>> [...]
>>>>>> +static void mips_loongson3_virt_init(MachineState *machine)
>>>>>> +{
>>>>>> +    int i;
>>>>>> +    long bios_size;
>>>>>> +    MIPSCPU *cpu;
>>>>>> +    CPUMIPSState *env;
>>>>>> +    DeviceState *liointc;
>>>>>> +    char *filename;
>>>>>> +    const char *kernel_cmdline = machine->kernel_cmdline;
>>>>>> +    const char *kernel_filename = machine->kernel_filename;
>>>>>> +    const char *initrd_filename = machine->initrd_filename;
>>>>>> +    ram_addr_t ram_size = machine->ram_size;
>>>>>> +    MemoryRegion *address_space_mem = get_system_memory();
>>>>>> +    MemoryRegion *ram = g_new(MemoryRegion, 1);
>>>>>> +    MemoryRegion *bios = g_new(MemoryRegion, 1);
>>>>>> +    MemoryRegion *iomem = g_new(MemoryRegion, 1);
>>>>>> +
>>>>>> +    /* TODO: TCG will support all CPU types */
>>>>>> +    if (!kvm_enabled()) {
>>>>>> +        if (!machine->cpu_type) {
>>>>>> +            machine->cpu_type = MIPS_CPU_TYPE_NAME("Loongson-3A1000");
>>>>>> +        }
>>>>>> +        if (!strstr(machine->cpu_type, "Loongson-3A1000")) {
>>>>>> +            error_report("Loongson-3/TCG need cpu type Loongson-3A1000");
>>>>>> +            exit(1);
>>>>>> +        }
>>>>>> +    } else {
>>>>>> +        if (!machine->cpu_type) {
>>>>>> +            machine->cpu_type = MIPS_CPU_TYPE_NAME("Loongson-3A4000");
>>>>>> +        }
>>>>>> +        if (!strstr(machine->cpu_type, "Loongson-3A4000")) {
>>>>>> +            error_report("Loongson-3/KVM need cpu type Loongson-3A4000");
>>>>>> +            exit(1);
>>>>>> +        }
>>>>>> +    }
>>>>>> +
>>>>>> +    if (ram_size < 512 * MiB) {
>>>>>> +        error_report("Loongson-3 need at least 512MB memory");
>>>>>
>>>>> Typo "needs", but why?
>>>> Though you told me "QEMU shouldn't assume anything about the guest",
>>>> but Loongson-3 machine really need at least 512M memory. And as you
>>>> said, this can simplify the memsize/highmemsize process (always larger
>>>> than 256).
>>>
>>> OK, that's fine.
>>>
>>>>
>>>>>
>>>>>> +        exit(1);
>>>>>> +    }
>>>>>> +
>>>>>> +    /*
>>>>>> +     * The whole MMIO range among configure registers doesn't generate
>>>>>> +     * exception when accessing invalid memory. Create an empty slot to
>>>>>> +     * emulate this feature.
>>>>>> +     */
>>>>>> +    empty_slot_init("fallback", 0, 0x80000000);
>>>>>
>>>>> Again, this doesn't look correct (no comment in my previous review).
>>>> This is written by Jiaxun because this is only needed by TCG, and he
>>>> said that malta also uses empty_slot_init() here.
>>>
>>> IIRC for Malta this is a GT64120 specific hole.
>>>
>>> In this case I'd like to know the justification first.
>>> Maybe you want to add this hole in the LOONGSON_LIOINTC device...
>>
>> Which makes me also wonder why are you splitting out 256MB of the RAM?
>>
>> This was a physical restriction of the GT64120 on 32-bit targets.
>> Your hardware is virtual and 64-bit...
> The physical memory address layout of Loongson-3:
> 0-0x40000000  Low RAM (256MB)
> 0x40000000-0x80000000 Hole for several MMIO registers (256MB)
> 0x80000000-TopOfMemory High RAM
> 
> Thogh this is a virtual platform, but the kernel link address is in
> CKSEG0, so "Low RAM" should exist. Though MMIO is different from real
> hardware, but put it in the same hole can make life easy.

OK...

> 
> Then it seems there is really a mistake of empty_slot_init() but has
> nothing to do with liointc, and the right one should be
> empty_slot_init("fallback", 0x40000000, 0x40000000);

The EMPTY_SLOT models physical slot for busses that don't
generate bus error when the slot is accessed and there is
nothing there.

If the 256MiB region starting at 0x40000000 is reserved for
MMIO registers, you certainly want to get a bus error if the
CPU tries to address an unmapped/illegal address.

If you know some area belong to a device that might be accessed
by firmware/kernel but it isn't important to model it, then you
can create an UNIMP_DEVICE with create_unimplemented_device(),
which behaves as RAZ/WI accesses on the bus.

Regards,

Phil.

> 
> Huacai
> 

