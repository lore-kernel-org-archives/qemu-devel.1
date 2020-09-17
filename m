Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0FFC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B73EE206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hb1NG5SJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B73EE206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIp5x-0004FO-Tg
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 04:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIojT-0007QT-7U
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:53:31 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39626)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIojO-0005VX-Kq
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:53:28 -0400
Received: by mail-wr1-x443.google.com with SMTP id a17so949618wrn.6
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 00:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vjqs885BhMGr6YknflvQUiZtCv+iknyrorq318GxXH4=;
 b=Hb1NG5SJ0m+DC29LavQjR9SjvrjPStfigFQQlwMt0KWW4A7IQNYVzePkob/G0mQM+/
 MNh9rUNdH1Tx18vpFphotHLsgUePG4Ayy0Klada4l8Ne3qyqLJ8l7/yLoiMZ7RqxNVvj
 ZhiWFBqrgl9Orl6awesUX+nMH+ph/0DjORziCs1ttRUzgMOzo0uFh+06QA/dWPz2W5Pt
 3LJfO0VRfD/4p5RY83rOmVG/37bawWz4QzVke/wv8E8Zn22k4xm7ZKKd3FRoa6iXqlMg
 5LFC++CnbMmpYkw7P05YLx5E4ekf5t7fL475ZNnhdX02hxdOReP/w6hkuEHBTtF/OYah
 sxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=vjqs885BhMGr6YknflvQUiZtCv+iknyrorq318GxXH4=;
 b=hozX4y++ZTcLKcN/HudhsEXpJbsB9HFVMmx2nR5V2V2CLPgfePEjtKufmLWV7jXj0j
 nTv+vI8b11bTs2QmiGD9pVO3GLwWjCIVZZNvqx4aWZtGaNVlPlyCLvlL7Rb3HMDvjEAA
 jlUfpvDP4mgzgRZY8S6P4W8SlXmDDsKC597QHY8TlQiqH0Fnwb2G2r9VOqwgdYHPajEg
 jqgtiOXjetb3vMIhCoKdFq28jlwmmshAAyiuNjFRamQW1BJIpBGanBmOO0kQISDKcRg+
 Cm/xNi8bbxKRnLaAJhQ34OpgC54E+PqxJfG2C6hDcHAn8eTx3M9jVYnFDFkyIGnRGOHr
 K1Cg==
X-Gm-Message-State: AOAM533DvwgEX3Jkl5idXnZ4QqB/+RibX+vb8GfQpE4C2JmNLjG9DTHd
 msilRG4fvC5UvsTfug2XxmM=
X-Google-Smtp-Source: ABdhPJxC/8pUtYVpgH7e32YX3BAjO/eeNQV2lZpqkEIzRIYM35JR0BIJ0G2iukVBpO2rtW5ncc8QYg==
X-Received: by 2002:adf:df87:: with SMTP id z7mr31618161wrl.239.1600329204787; 
 Thu, 17 Sep 2020 00:53:24 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id a15sm39765071wrn.3.2020.09.17.00.53.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2020 00:53:24 -0700 (PDT)
Subject: Re: [PATCH V9 6/6] hw/mips: Add Loongson-3 machine support
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Huacai Chen <chenhuacai@gmail.com>
References: <1600222344-16808-1-git-send-email-chenhc@lemote.com>
 <1600222344-16808-7-git-send-email-chenhc@lemote.com>
 <c3804617-7c65-4082-de76-81e718f6d139@amsat.org>
 <CAAhV-H5OysVNvGzD066eVqA+-k2+GJDjwSGR0hJT0VUh3Ld83A@mail.gmail.com>
 <63a89ba1-a920-c2b9-bd4f-7f523fdda895@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <31d4f14f-bba5-a5a5-d024-668558416083@amsat.org>
Date: Thu, 17 Sep 2020 09:53:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <63a89ba1-a920-c2b9-bd4f-7f523fdda895@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.062,
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

On 9/16/20 12:47 PM, Philippe Mathieu-Daudé wrote:
> On 9/16/20 11:49 AM, Huacai Chen wrote:
>> On Wed, Sep 16, 2020 at 3:56 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>> On 9/16/20 4:12 AM, Huacai Chen wrote:
> [...]
>>>> +static void mips_loongson3_virt_init(MachineState *machine)
>>>> +{
>>>> +    int i;
>>>> +    long bios_size;
>>>> +    MIPSCPU *cpu;
>>>> +    CPUMIPSState *env;
>>>> +    DeviceState *liointc;
>>>> +    char *filename;
>>>> +    const char *kernel_cmdline = machine->kernel_cmdline;
>>>> +    const char *kernel_filename = machine->kernel_filename;
>>>> +    const char *initrd_filename = machine->initrd_filename;
>>>> +    ram_addr_t ram_size = machine->ram_size;
>>>> +    MemoryRegion *address_space_mem = get_system_memory();
>>>> +    MemoryRegion *ram = g_new(MemoryRegion, 1);
>>>> +    MemoryRegion *bios = g_new(MemoryRegion, 1);
>>>> +    MemoryRegion *iomem = g_new(MemoryRegion, 1);
>>>> +
>>>> +    /* TODO: TCG will support all CPU types */
>>>> +    if (!kvm_enabled()) {
>>>> +        if (!machine->cpu_type) {
>>>> +            machine->cpu_type = MIPS_CPU_TYPE_NAME("Loongson-3A1000");
>>>> +        }
>>>> +        if (!strstr(machine->cpu_type, "Loongson-3A1000")) {
>>>> +            error_report("Loongson-3/TCG need cpu type Loongson-3A1000");
>>>> +            exit(1);
>>>> +        }
>>>> +    } else {
>>>> +        if (!machine->cpu_type) {
>>>> +            machine->cpu_type = MIPS_CPU_TYPE_NAME("Loongson-3A4000");
>>>> +        }
>>>> +        if (!strstr(machine->cpu_type, "Loongson-3A4000")) {
>>>> +            error_report("Loongson-3/KVM need cpu type Loongson-3A4000");
>>>> +            exit(1);
>>>> +        }
>>>> +    }
>>>> +
>>>> +    if (ram_size < 512 * MiB) {
>>>> +        error_report("Loongson-3 need at least 512MB memory");
>>>
>>> Typo "needs", but why?
>> Though you told me "QEMU shouldn't assume anything about the guest",
>> but Loongson-3 machine really need at least 512M memory. And as you
>> said, this can simplify the memsize/highmemsize process (always larger
>> than 256).
> 
> OK, that's fine.
> 
>>
>>>
>>>> +        exit(1);
>>>> +    }
>>>> +
>>>> +    /*
>>>> +     * The whole MMIO range among configure registers doesn't generate
>>>> +     * exception when accessing invalid memory. Create an empty slot to
>>>> +     * emulate this feature.
>>>> +     */
>>>> +    empty_slot_init("fallback", 0, 0x80000000);
>>>
>>> Again, this doesn't look correct (no comment in my previous review).
>> This is written by Jiaxun because this is only needed by TCG, and he
>> said that malta also uses empty_slot_init() here.
> 
> IIRC for Malta this is a GT64120 specific hole.
> 
> In this case I'd like to know the justification first.
> Maybe you want to add this hole in the LOONGSON_LIOINTC device...

Which makes me also wonder why are you splitting out 256MB of the RAM?

This was a physical restriction of the GT64120 on 32-bit targets.
Your hardware is virtual and 64-bit...

