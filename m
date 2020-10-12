Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3569DC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 08:35:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C4F520714
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 08:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tdb0yc+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C4F520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRtJB-0000dI-C5
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 04:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRtIF-00005F-Kp
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 04:34:55 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40845)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRtID-0008HB-Nq
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 04:34:55 -0400
Received: by mail-wm1-x344.google.com with SMTP id k18so16682280wmj.5
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 01:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3XX/4EeXgZcsnPUFe6urrwG6ANl754l/e2KyLGmas9A=;
 b=Tdb0yc+zrWFbaEfC9WwlHsXrx3WFoYUiQVN44w/f/rqeUe6e1XIcLmFdLXUH16Vq54
 SMsc4PHZdUotouL4geLtmqnarUwWkqxo6yDotgz5oyif37fUrl5jkiU11z+gUOrTVqgl
 TrdUFqnAsQNvbtFaI6AXJpXGnsdS28c92Ig6PGfuw5CSUl6nmicRmlUGQvBfcsn+Ixcn
 5P5eVfSpuk1PV68hAgC3nZabkE1L/ev+R9ks45017TCBa8Qk9Nqdki0nKJIhMQk21EEd
 sb+PiZEVDQcaWB1mFH16RCsGC2GcQ80BomiAWpjQ9FK9UEmkPACEUwrE7TRWQHgm5YV3
 ld3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3XX/4EeXgZcsnPUFe6urrwG6ANl754l/e2KyLGmas9A=;
 b=j1H6vQAwEglMz5eLkKi1Pz2ah3syNkoiJGFDsxh1GzI5vmbWYLiqJjULIS86TkEFRb
 utSueqe8N2pMcA8dpe2ipnVr9vvRcSiun8zs0h+fFI8/AbR0kDuZEJ5IV6c8ftwG0Vda
 pfEOh8vJJBN+zO7esvbRnJM31cBUUWiDMuOxSAWXZ9kawUqr7jKmVH0/47DzRDB2WMM5
 fbxsgR70WCGyr5ns3j1G4pjBImbK7ldcrLTEaVZp2/hxj76+D99kaZ6u7TEHiwjYP00T
 FDKFgiHxkZs1e2E1e+2ML0KTDDwN+8lPjad6Dy7GeubxVVf3eevjfSkdaUE04IPkX+QT
 HaxQ==
X-Gm-Message-State: AOAM530f2pXmM6aQFcF9pl7ZGuLibt7CGG1bFQIAwFg4Oy/Uk9sj3+n2
 lNK4/XH0EmyGKHDExxdkLAo=
X-Google-Smtp-Source: ABdhPJwz7PKhBgJJFLIifBGqsx3k73ZYYyLITRIZLUTRSKx8MwbpSERVZJPkDTzRAVVfTU4YPuBZvg==
X-Received: by 2002:a1c:b40b:: with SMTP id d11mr9604438wmf.152.1602491690691; 
 Mon, 12 Oct 2020 01:34:50 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id e7sm24852053wrm.6.2020.10.12.01.34.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2020 01:34:49 -0700 (PDT)
Subject: Re: [PATCH v3 12/20] hw/mips/r4k: Explicit CPU frequency is 200 MHz
To: chen huacai <zltjiangshi@gmail.com>
References: <20201010204319.3119239-1-f4bug@amsat.org>
 <20201010204319.3119239-13-f4bug@amsat.org>
 <CABDp7Voq177fvHUJRXqrYtH2etqnKNmhYeVOZAForw=6oY5sTg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2c0fde77-4618-d5c2-3281-56ed706a9d2d@amsat.org>
Date: Mon, 12 Oct 2020 10:34:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CABDp7Voq177fvHUJRXqrYtH2etqnKNmhYeVOZAForw=6oY5sTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 Igor Mammedov <imammedo@redhat.com>, qemu-level <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Huacai,

On 10/11/20 5:52 AM, chen huacai wrote:
> Hi, Philippe,
> 
> On Sun, Oct 11, 2020 at 4:43 AM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> Since its introduction in commit 6af0bf9c7c3,
>> the 'r4k' machine runs at 200 MHz.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   hw/mips/r4k.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/mips/r4k.c b/hw/mips/r4k.c
>> index 3487013a4a1..e64687b505a 100644
>> --- a/hw/mips/r4k.c
>> +++ b/hw/mips/r4k.c
>> @@ -37,6 +37,7 @@
>>   #include "sysemu/reset.h"
>>   #include "sysemu/runstate.h"
>>   #include "qemu/error-report.h"
>> +#include "hw/qdev-clock.h"
>>
>>   #define MAX_IDE_BUS 2
>>
>> @@ -184,6 +185,7 @@ void mips_r4k_init(MachineState *machine)
>>       int bios_size;
>>       MIPSCPU *cpu;
>>       CPUMIPSState *env;
>> +    Clock *cpuclk;
>>       ResetData *reset_info;
>>       int i;
>>       qemu_irq *i8259;
>> @@ -193,7 +195,11 @@ void mips_r4k_init(MachineState *machine)
>>       int be;
>>
>>       /* init CPUs */
>> -    cpu = MIPS_CPU(cpu_create(machine->cpu_type));
>> +    cpu = MIPS_CPU(object_new(machine->cpu_type));
>> +    cpuclk = clock_new(OBJECT(machine), "cpu-refclk");
>> +    clock_set_hz(cpuclk, 200000000); /* 200 MHz */
>> +    qdev_connect_clock_in(DEVICE(cpu), "clk-in", cpuclk);
>> +    qdev_realize(DEVICE(cpu), NULL, &error_abort);
 >
> Can we add a new parameter to cpu_create() and set the freq in the core code?

Adding a new parameter seems a good idea.

Both maintainers of the core code are reluctant to add
a CPU clock to the core code, see:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg747589.html
https://www.mail-archive.com/qemu-devel@nongnu.org/msg747612.html
Which is why I restricted that to the MIPS CPUs.

On ARM, Damien started to use clocks on the Zynq SoC (merged):
https://www.mail-archive.com/qemu-devel@nongnu.org/msg694604.html
Luc is working on adding a clock manager to the Broadcom SoC:
https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg02840.html

I also started converting one UART devices:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg727972.html

So IMO the core code will soon require this. Maybe we will add it
during the next development window.

Meanwhile I can add a mips_cpu_create_with_clock() in preparation
of cpu_create_with_clock().

> 
> Huacai
>>       env = &cpu->env;
>>
>>       reset_info = g_malloc0(sizeof(ResetData));
>> --
>> 2.26.2
>>
> 
> 

