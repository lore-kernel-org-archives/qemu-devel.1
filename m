Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD24C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:41:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE47A21527
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9wlkKuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE47A21527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW14K-00037X-FZ
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 13:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kW12E-0001cL-1q
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 13:39:26 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:36570)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kW12C-00027l-5l
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 13:39:25 -0400
Received: by mail-wm1-x333.google.com with SMTP id e2so2722355wme.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 10:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=O6aqUefLW9GBb8KwKTuT3BFpgSVPbZXotiNam4qAmuQ=;
 b=N9wlkKuJOSDKlGb9kL5kE5gADNOuolwxyT7DOfS53bi5hjpcGbKdzbodNOmCt7tdIP
 vpkcdbsG+8CylJ1s8K1wEaBWJEKYa2k45yrwDUzX5b/F1VvuuN3PEUjoxDQBVE+2btvQ
 jU5yrX5muN8emwvY91r1e7zF+dmMlpkCDiJ0NJxBsNplmLXQLGcUjC2OawZMDYbyHxxd
 Lz1FfJ2u9mnwtnWmqDhT4vYzE3ESNVbvBBf0mKbqO2cd1iQutTr8N4tresRS2CDbhRt9
 E7Sag6lrlF+HKpM1UTseBy3sI9b+KBwzJyH4UDB1Hwe7opOJPMpS3G3OaR29tE/KLoI7
 OzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=O6aqUefLW9GBb8KwKTuT3BFpgSVPbZXotiNam4qAmuQ=;
 b=DSePYl3QB5gbLlJ4UAN8BVMGwS9N6Khs6dH8bcfiXPOjTf5wgndqN/gcZvt/QV/UG8
 aIyme1O41Ow7pNksy3k0yesgshHDaCu1M9TnF7ryzOUO4fwXQVAD2WhZFDeRMJkGgmSl
 50PaVuKscGv6xNMI3TPVYA6TQhRgQ2zYQOMboDwykDJiZrmYb7Q7n6mrXgdP8vWdDp/Q
 nXm8tUbDkSy77cMIieFfbyIJp5/dSFqN/uwfvu7G07obG3bQUQpEx824RACH8CMG3E2Q
 WF7tT8ja025QH4XbZacWx6y8TH7HsQG5aDlBXFOYWqnd0htSDZ1t7Sns212AciVtFBbk
 8heg==
X-Gm-Message-State: AOAM530SSAqwybd6kj4n52Z/Jd4u9hqoh6GdkdOXpQCyhcNEcn0Gd+Xb
 6uDpAGFA5hD1GWw08G8fRrr/c0zrBCQ=
X-Google-Smtp-Source: ABdhPJwcxQlGBTGOoq8zUwz56z2BsuCnOO27kwbOiulbn46YM1PNJ4JtJL8buAgXt43OnzjkMYcz2g==
X-Received: by 2002:a7b:cd8f:: with SMTP id y15mr518199wmj.9.1603474758789;
 Fri, 23 Oct 2020 10:39:18 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id 1sm4959362wre.61.2020.10.23.10.39.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 10:39:17 -0700 (PDT)
Subject: Re: [PULL 25/33] tests/acceptance: Add a test for the N800 and N810
 arm machines
To: Igor Mammedov <imammedo@redhat.com>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
 <20200228163840.23585-26-peter.maydell@linaro.org>
 <a049110f-b7cb-52bd-de77-6e1193b5b6de@amsat.org>
 <6ce6a790-c68e-e3ed-962e-ba6f49244315@redhat.com>
 <f02d74fb-af6e-6e04-7ce7-48ab09a20e4f@amsat.org>
 <f2f276a9-a6ad-a2f8-2fbc-f1aca5423f79@amsat.org>
 <20201023174351.31838a86@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c80350d2-3591-6541-abf3-960b69cedf7d@amsat.org>
Date: Fri, 23 Oct 2020 19:39:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201023174351.31838a86@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x333.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.108,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/20 5:43 PM, Igor Mammedov wrote:
> On Mon, 19 Oct 2020 11:43:13 +0200
> Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>>> FYI this test is failing:
>>>>>
>>>>> qemu-system-arm: kernel 'meego-arm-n8x0-1.0.80.20100712.1431-vml
>>>>> inuz-2.6.35~rc4-129.1-n8x0' is too large to fit in RAM (kernel size
>>>>> 1964608,
>>>>> RAM size 0)
>>>
>>> FWIW:
>>>
>>> 7998beb9c2e280f0b7424223747941f106e2e854 is the first bad commit
>>> commit 7998beb9c2e280f0b7424223747941f106e2e854
>>> Author: Igor Mammedov <imammedo@redhat.com>
>>> Date:   Wed Feb 19 11:08:59 2020 -0500
>>>
>>>       arm/nseries: use memdev for RAM
>>>
>>>       memory_region_allocate_system_memory() API is going away, so
>>>       replace it with memdev allocated MemoryRegion. The later is
>>>       initialized by generic code, so board only needs to opt in
>>>       to memdev scheme by providing
>>>         MachineClass::default_ram_id
>>>       and using MachineState::ram instead of manually initializing
>>>       RAM memory region.
>>>
>>>       PS:
>>>        while at it add check for user supplied RAM size and error
>>>        out if it mismatches board expected value.
>>>
>>>       Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>>       Reviewed-by: Andrew Jones <drjones@redhat.com>
>>>       Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>>       Message-Id: <20200219160953.13771-26-imammedo@redhat.com>
>>
>> This fixes the issue:
>>
>> -- >8 --
>> diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
>> index e48092ca047..76fd7fe9854 100644
>> --- a/hw/arm/nseries.c
>> +++ b/hw/arm/nseries.c
>> @@ -1318,6 +1318,7 @@ static void n8x0_init(MachineState *machine,
>>            g_free(sz);
>>            exit(EXIT_FAILURE);
>>        }
>> +    binfo->ram_size = machine->ram_size;
>>
>>        memory_region_add_subregion(get_system_memory(), OMAP2_Q2_BASE,
>>                                    machine->ram);
> 
> we really should replace binfo->ram_size with machine->ram_size to avoid
> duplicating the same data, but as a quick fix this should fix issue.

Hmm this is the 'ARM kernel loader' API in "arm/boot.h":

struct arm_boot_info {
     uint64_t ram_size;
     const char *kernel_filename;
     const char *kernel_cmdline;
     const char *initrd_filename;
     const char *dtb_filename;

and:

   void (*write_secondary_boot)(ARMCPU *cpu,
                                const struct arm_boot_info *info);
   void (*secondary_cpu_reset_hook)(ARMCPU *cpu,
                                    const struct arm_boot_info *info);

Are you saying arm_boot_info should hold a pointer to MachineState*
instead of duplicating?

