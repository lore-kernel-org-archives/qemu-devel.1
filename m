Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15DBC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 07:41:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA2F820665
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 07:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIsHYoIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2F820665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPL7I-00077p-SN
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 03:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPL5r-0006NY-RP
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 03:39:36 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44850)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPL5o-0001VW-Ir
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 03:39:33 -0400
Received: by mail-wr1-x443.google.com with SMTP id s12so8313281wrw.11
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 00:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=u7/3ZYjrDiSTRtpD01Uuzh1ZkBI1UjOidLmRUtfaw80=;
 b=LIsHYoIZ31Veu/PYYzQDg41ddXcMQx4bvbLAM/W8uL0l8NKTEd2sEtQ1Vqh1zQU+L9
 TL4VUz2hCRFys8KVphRZoiW1WTrbz/ip85E30hx0EVTSDSCyphIFiqZEdWGbuwXbftIU
 S7DuugyZukSb14J5sHFam/8Gy+XL+0JZUGnFVpwc41xIEortK3ToOISCjyS9Rq/M29Fy
 PLZdkpOz70LowbBroXBCZdjIEngTWCX1y0+HE0dnJ8IomfDIaJElNM1R3orQL+rgo/l7
 ilMwfXBM+y7AsnuYmMtTwBnpt21pJMbu8o5b4zWRLddrHe0VETdwOTjZz7EiaRaJUXSb
 i5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u7/3ZYjrDiSTRtpD01Uuzh1ZkBI1UjOidLmRUtfaw80=;
 b=A1NjBkiSYt/SZkh5Epp+eypAwxMebDyJeO3HuoQCJrUSTCuLIS+8xIw8T3EUWqS4vI
 DWVt3caWE3cb3m3jf7/zSIM25HeMYW5IgoIaP2V7Zl5b8r/Z7Qg5LF2vsaHDqLugdRn/
 DJ66k74crLBTu6J4LDxSxhGEFEhcJ0eRl+3Bk0bCmnEcXoDoP6Y8UuI6WrB/8jJ0+2yt
 FMHrjAitn4qXzxI6SgOBOCL+ZsOEYAcEqk/3bv7iWGQa2X1NWyZ1uwflCC50DG7IiTpq
 Z3WVBb1nRUgKs6rNipV/EZPxle+EURGmOjXgu2RxgRSiBorH3ar2JNNdfZNhn/FN/ayp
 r1sw==
X-Gm-Message-State: AOAM530YrNn5oHpRG0KGPFyvaD75AmlMmdHZd0ydsSaOM2QV8vYdOFhC
 E7n9m8P39ACX6cxMSYpPTTQ=
X-Google-Smtp-Source: ABdhPJx6SryB5GScwhnf1zbT/cfoWJbjvzjtqi5cQx1fXsLdaWqSz9wBnK3dQj5HbuFWYHTxNIsPsw==
X-Received: by 2002:a5d:4c52:: with SMTP id n18mr15668574wrt.267.1601883570873; 
 Mon, 05 Oct 2020 00:39:30 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 18sm11471532wmj.28.2020.10.05.00.39.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 00:39:30 -0700 (PDT)
Subject: Re: [PATCH 15/16] target/mips/cpu: Do not allow system-mode use
 without input clock
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20200928171539.788309-1-f4bug@amsat.org>
 <20200928171539.788309-16-f4bug@amsat.org>
 <20200929150154.04f77949@redhat.com>
 <35db3210-8165-6fe8-c835-22970fb31c93@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2e1ef61c-688d-0a1d-ae0a-1cc11d555cd4@amsat.org>
Date: Mon, 5 Oct 2020 09:39:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <35db3210-8165-6fe8-c835-22970fb31c93@amsat.org>
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Cleber Rosa <crosa@redhat.com>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Thomas for qtest

On 9/29/20 4:40 PM, Philippe Mathieu-Daudé wrote:
> On 9/29/20 3:01 PM, Igor Mammedov wrote:
>> On Mon, 28 Sep 2020 19:15:38 +0200
>> Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>>> Now than all QOM users provides the input clock, do not allow
>>> using a CPU core without its input clock connected on system-mode
>>> emulation. For user-mode, keep providing a fixed 200 MHz clock,
>>> as it used by the RDHWR instruction (see commit cdfcad788394).
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>> Cc: Igor Mammedov <imammedo@redhat.com>
>>>
>>> We need the qtest check for tests/qtest/machine-none-test.c
>>> which instanciate a CPU with the none machine. Igor, is it
>>> better to remove the MIPS targets from the test cpus_map[]?
>>
>> I don't get idea, could you rephrase/elaborate?
> 
> cpu_class_init sets:
> 
>     /*
>      * Reason: CPUs still need special care by board code: wiring up
>      * IRQs, adding reset handlers, halting non-first CPUs, ...
>      */
>     dc->user_creatable = false;
> 
> but the CPUs are created via another path in vl.c:
> 
>         current_machine->cpu_type = parse_cpu_option(cpu_option);
> 
> The machine-none-test assumes CPU objects are user-creatable.
> 
> With this patch I enforce MIPS CPU to have an input clock
> connected, so they are not user-creatable anymore.
> 
> I tried this code ...:
> 
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -229,7 +229,11 @@ static const TypeInfo mips_cpu_type_info = {
>  static void mips_cpu_cpudef_class_init(ObjectClass *oc, void *data)
>  {
>      MIPSCPUClass *mcc = MIPS_CPU_CLASS(oc);
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +
>      mcc->cpu_def = data;
> +    /* Reason: clock need to be wired up */
> +    dc->user_creatable = false;
>  }
> 
> ... but it is ignored, the CPU can still be created.
> 
> Not sure how to handle this.
> 
>>
>>> ---
>>>  target/mips/cpu.c | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
>>> index 2f75216c324..cc4ee75af30 100644
>>> --- a/target/mips/cpu.c
>>> +++ b/target/mips/cpu.c
>>> @@ -25,6 +25,7 @@
>>>  #include "kvm_mips.h"
>>>  #include "qemu/module.h"
>>>  #include "sysemu/kvm.h"
>>> +#include "sysemu/qtest.h"
>>>  #include "exec/exec-all.h"
>>>  #include "hw/qdev-clock.h"
>>>  #include "hw/qdev-properties.h"
>>> @@ -159,11 +160,18 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
>>>      Error *local_err = NULL;
>>>  
>>>      if (!clock_get(cs->clock)) {
>>> +#ifdef CONFIG_USER_ONLY
>>>          /*
>>>           * Initialize the frequency to 200MHz in case
>>>           * the clock remains unconnected.
>>>           */
>>>          clock_set_hz(cs->clock, 200000000);
>>> +#else
>>> +        if (!qtest_enabled()) {
>>> +            error_setg(errp, "CPU clock must be connected to a clock source");
>>> +            return;
>>> +        }
>>> +#endif
>>>      }
>>>      mips_cpu_clk_update(cs);
>>>  
>>
> 


