Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22020C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:36:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B72020BED
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="howKzk0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B72020BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJwX-0007Ed-N8
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kGJsN-0007wy-T1
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:32:23 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54262)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kGJsL-0003AG-TK
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:32:23 -0400
Received: by mail-wm1-x343.google.com with SMTP id x23so5108405wmi.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 03:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5xh7wv837macfwwoqI8RBz0PfCzNRCHtbFFiCb5IY+0=;
 b=howKzk0H9zZS5eS1RqjNz30yv9rfSr9xBqUmOAMT1J4urEMIYa7fmwiOhEIyGbj+qF
 nDJzeSec93FDdbUyJr2L7ULn2lU4EiWCfCUggdRAPRggII9sf6tyhzKsedP5c/diSFAZ
 UeyI16bfpbu9c22vHwvrZbqWT/JxhwKRhAJy8Xjiw/RiALOPwGz5E8gZwRv2N1v8LCJ9
 D5hOU9vqSHJ3NAeBDABnmkyr2KI0YR1nT1t3hCizwwr7UtIULcrAbh8E2eF92ITetAKD
 sTDuEdw9PQO9ztF1eSbr5FocLSLKLxUOnaCTvjiUwsyymCuHhT8Qg5/k4AHxIG82ebfR
 n30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5xh7wv837macfwwoqI8RBz0PfCzNRCHtbFFiCb5IY+0=;
 b=AsOXdqM/cPSTibrhiz1HTkTcDtjm8KWcujVtweftjw1iNaWW1RH9ndoxAsPb1SiIH0
 FgDB+IBlTdBQBpHy/cU5GiMN3z8ZaIIxydVvUMqI06c+Vk9zb8BKAdE8JWEEqgSlPYCa
 ixJ4fT0cQtPOQHo4lMpSn/yOxvn7ydQVKxmgs4KMeOA40lDlWy3+rM0hQ+OCRMEFm1Bp
 vKGz4dVsZwVmPIn2m7ib4429Ljw05N+iABRE2zatze38EsnTzunvW/2FKwC8FFWvyx8R
 gPa2szpFh9ErIS6cJNu3tgwBGTGAhWx3uISs3DR9CyFoOIKjAFQF+aV1BImTj0vwgUYE
 Aajw==
X-Gm-Message-State: AOAM532JF30yw5K2t+GPuJeFEM9Q5j27n7bQQ0jhudKidebWszYkCPT/
 ex1H9Dq9uNLpJ7NCGM9A4ZA=
X-Google-Smtp-Source: ABdhPJxwZkISP+KP90UsCSmrx+m+s8lODIY/PYCx4fxaH6TJ+i9b0nqyBE8SOH9WikbojoGehIXwnA==
X-Received: by 2002:a1c:5a56:: with SMTP id o83mr8101189wmb.77.1599733940224; 
 Thu, 10 Sep 2020 03:32:20 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id t203sm3032451wmg.43.2020.09.10.03.32.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2020 03:32:19 -0700 (PDT)
Subject: Re: [PULL 3/5] softmmu/cpus: Only set parallel_cpus for SMP
To: Claudio Fontana <cfontana@suse.de>
References: <20200903214101.1746878-1-richard.henderson@linaro.org>
 <20200903214101.1746878-4-richard.henderson@linaro.org>
 <1f573d2d-b3bb-21ab-bbcd-b759fc14ad2b@suse.de>
 <3dfae924-34c9-e36a-77bf-f3abcdeaf268@amsat.org>
 <7454d121-3ebd-623a-55a3-4ba6e7e870dc@suse.de>
 <e47376bf-8ced-57eb-93d5-a1229d258dd6@amsat.org>
 <75c313df-da09-f3c2-5d34-0bfaad4290a9@suse.de>
 <652516a1-6a63-89eb-8b04-728a95b76d5f@amsat.org>
 <1341d50a-87e7-c497-423e-fa0e618826ee@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c7f978df-e05a-47f5-130f-ae36e8378472@amsat.org>
Date: Thu, 10 Sep 2020 12:32:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1341d50a-87e7-c497-423e-fa0e618826ee@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-3.576,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, peter.maydell@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/10/20 10:28 AM, Claudio Fontana wrote:
> Hi Philippe,
> 
> On 9/8/20 9:56 AM, Philippe Mathieu-Daudé wrote:
>> +Laurent
>>
>> On 9/8/20 9:09 AM, Claudio Fontana wrote:
>>> On 9/7/20 6:49 PM, Philippe Mathieu-Daudé wrote:
>>>> On 9/7/20 6:30 PM, Claudio Fontana wrote:
>>>>> On 9/7/20 12:20 PM, Philippe Mathieu-Daudé wrote:
>>>>>> On 9/7/20 12:05 PM, Claudio Fontana wrote:
>>>>>>> Hi Richard,
>>>>>>>
>>>>>>> currently rebasing on top of this one,
>>>>>>> just a question, why is the patch not directly using "current_machine"?
>>>>>>
>>>>>> For user mode?
>>>>>
>>>>> In user mode I'd not expect softmmu/cpus.c to be built at all...
>>>>
>>>> Which is why :) current_machine is NULL in user-mode.
>>>
>>> Ciao Philippe,
>>>
>>> then why does the patch change softmmu/cpus.c in a way that accounts for user mode?
>>>
>>> The function that the patch changes is never called in user mode.
>>>
>>> The patch could instead use current_machine without any concern of it being NULL, it will always be set in vl.c .
>>
>> Better send a patch to prove your point :)
> 
> Yes, I am already testing without problems the cpus-refactoring series with this applied:
> 
> commit 53f6db772f1522025650441102b16be17773bdc9
> Author: Claudio Fontana <cfontana@suse.de>
> Date:   Tue Sep 8 10:59:07 2020 +0200
> 
>     accel/tcg: use current_machine as it is always set for softmmu
>     
>     current_machine is always set before accelerators are initialized,
>     so use that instead of MACHINE(qdev_get_machine()).
>     
>     Signed-off-by: Claudio Fontana <cfontana@suse.de>
> 
> diff --git a/accel/tcg/tcg-cpus.c b/accel/tcg/tcg-cpus.c
> index ec7158b55e..05af1168a2 100644
> --- a/accel/tcg/tcg-cpus.c
> +++ b/accel/tcg/tcg-cpus.c
> @@ -484,7 +484,7 @@ static void tcg_start_vcpu_thread(CPUState *cpu)
>           * then we will have cpus running in parallel.
>           */
>          if (qemu_tcg_mttcg_enabled()) {
> -            MachineState *ms = MACHINE(qdev_get_machine());
> +            MachineState *ms = current_machine;
>              if (ms->smp.max_cpus > 1) {
>                  parallel_cpus = true;
>              }
> 
> 
> 
>>
>> I have bad remember about the last time I tried to understand/modify
>> that part, because IIRC the user-mode creates some fake machine to
>> satisfy various QEMU generic code assumptions. Sincerely I now prefer
>> stay away from this; too many unmerged patches there.
> 
> 
> linux-user/main.c and bsd-user/main.c seem to use cpu_create() to create the cpus,
> then they have their own cpu_loop(), they do not use any of the cpus.c code.
> 
> By contrast, softmmu/vl.c initializes current_machine in qemu_init(),
> even before accelerator is chosen and configured.
> 
> So there is no chance currently that current_machine is not set correctly when
> the accelerator vcpu startup code in is called.

Thanks for checking and correcting me!

We are good then :)

> 
> Ciao,
> 
> CLaudio

