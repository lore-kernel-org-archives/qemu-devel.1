Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF31C47256
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 05:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97F26206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 05:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hA0vNcoR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F26206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVqGh-00045t-Lt
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 01:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVqG2-00037I-KO
 for qemu-devel@nongnu.org; Tue, 05 May 2020 01:36:42 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36151)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVqG1-0000Pi-N0
 for qemu-devel@nongnu.org; Tue, 05 May 2020 01:36:42 -0400
Received: by mail-wm1-x342.google.com with SMTP id u127so816001wmg.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 22:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EQlRqJvgXWWWJ6knTRuEkwjmJ3l974XtsswEaxhE2Ns=;
 b=hA0vNcoRaRjBSRj7GiwRJ5aI3OoIZIwEdJbTWRihj2IKZnUia/3TBuR/H1FpxM8rej
 ajRMrUP9l7BGgEQeBNVuJuSpJiTXKd1Q/WZAfZCa+Lpn4yRhxFqrq+qMJzonHHMUc9SW
 tT0LxZ6HRQJDlABGIkSpQgAOeCaEGaUesu7Z3Cq7YPKf7+XV7K+CNFkcZuWVlr8vWeYQ
 zMCjp5by9je+2tEbmyCSeirnKgmgiVuR5WS0rHbvkSyGqsc2H58V97g48KFjvbPHJoUF
 RMtIgfdaFZoDIzNn5DiKhLancAkHdXtmW9l6CeQUTd7kfzYpanwo38JQPCxdheShoUsW
 +1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EQlRqJvgXWWWJ6knTRuEkwjmJ3l974XtsswEaxhE2Ns=;
 b=hn4bNa0w0VimRsd2J4Y4DXIRO93zKj3D1v7xfYoTRBc1sTJxs/GaTeCxfwmh2++WvK
 voBjfjNBnRFTQFTg/3kk3ROK5J7SvRaexLdLYCPu0jtLikKNpi74viM9TLy8EF/VRpw/
 Ey8eGHeIxOSAHW1xnc0gUS5Nu7xwY2C5M3JygqDvMo9rgPoJ5C9cI/aU81TqD3b7NSek
 JL8POW7+t7bCy7oT5OX2Wva7MJneJF2R3O7UPMHAfW8EyXE9MhAPBn1nZEnUTfYjspKa
 IZW7jgW7pe6TVRx4qDVsAoFEMYRAqQeGa+IA435YVpmEfy/fzYgP3TFIoQNYPXOJD0VO
 4zSw==
X-Gm-Message-State: AGi0Pub+n/6izSMmWZUR3LCCL8tgmXpjzCuJ16zOS2e2k7Cj/ANy8JAy
 mq9yOmRE3RFOfYhhCUC83kU=
X-Google-Smtp-Source: APiQypIbFH/hJ3t3Kqj7AYNt3Lfjq05XNnn0Os/sXXRTsjdCJ7uhSG4eJa0rD4+icBBNLhUwB6gybg==
X-Received: by 2002:a1c:6455:: with SMTP id y82mr1212702wmb.128.1588657000149; 
 Mon, 04 May 2020 22:36:40 -0700 (PDT)
Received: from [192.168.1.39] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id v16sm1932127wml.30.2020.05.04.22.36.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 22:36:39 -0700 (PDT)
Subject: Re: [PATCH 4/4] hw/i386: Make vmmouse helpers static
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200504083342.24273-1-f4bug@amsat.org>
 <20200504083342.24273-5-f4bug@amsat.org>
 <f01f89f6-10e8-5173-c68d-0fb779f77d0e@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <09da6f09-d6a2-39f1-0f47-278334e272dc@amsat.org>
Date: Tue, 5 May 2020 07:36:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <f01f89f6-10e8-5173-c68d-0fb779f77d0e@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 7:29 PM, Richard Henderson wrote:
> On 5/4/20 1:33 AM, Philippe Mathieu-Daudé wrote:
>> +++ b/hw/i386/vmport.c
>> @@ -23,10 +23,10 @@
>>    */
>>   #include "qemu/osdep.h"
>>   #include "hw/isa/isa.h"
>> -#include "hw/i386/pc.h"
>>   #include "sysemu/hw_accel.h"
>>   #include "qemu/log.h"
>>   #include "vmport.h"
>> +#include "cpu.h"
>>   #include "trace.h"
>>   
>>   #define VMPORT_CMD_GETVERSION 0x0a
>> @@ -109,27 +109,6 @@ static uint32_t vmport_cmd_ram_size(void *opaque, uint32_t addr)
>>       return ram_size;
>>   }
>>   
>> -/* vmmouse helpers */
>> -void vmmouse_get_data(uint32_t *data)
>> -{
>> -    X86CPU *cpu = X86_CPU(current_cpu);
>> -    CPUX86State *env = &cpu->env;
>> -
>> -    data[0] = env->regs[R_EAX]; data[1] = env->regs[R_EBX];
>> -    data[2] = env->regs[R_ECX]; data[3] = env->regs[R_EDX];
>> -    data[4] = env->regs[R_ESI]; data[5] = env->regs[R_EDI];
>> -}
> 
> Why are you adding "cpu.h" when removing code?

Because this file still use the X86 register definitions:

   static uint32_t vmport_cmd_get_version(void *opaque, uint32_t addr)
   {
       X86CPU *cpu = X86_CPU(current_cpu);

       cpu->env.regs[R_EBX] = VMPORT_MAGIC;
       return 6;
   }

> Does that mean you don't need to add "cpu.h" to vmmouse.c?

Now both files vmmouse/vmport uses the X86 register definitions, but 
they don't use anything declared in "hw/i386/pc.h".

> 
> 
> r~
> 

