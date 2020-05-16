Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBC0C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 05:20:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9725206D4
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 05:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heRrp1qE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9725206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZpF0-0006Z4-15
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 01:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jZpEG-0005zl-Be; Sat, 16 May 2020 01:19:20 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40404)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jZpEE-0004lr-3i; Sat, 16 May 2020 01:19:19 -0400
Received: by mail-wm1-x343.google.com with SMTP id n18so409883wmj.5;
 Fri, 15 May 2020 22:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=G7+PzDFZT7BSCXwDo8JVay4mYNjka/hIHExTbrAwud4=;
 b=heRrp1qEKmkOyKWfuFSp86/OuIqorj6BgalL5RYh+QVXqX7bD2tPMZPB4WvHPMhWgJ
 GLnlMMh6GbiAYq9/MX9QcwpT5tl0gyU1hCfSJdUMlvlm/KJc47lvXIKT1DeqSR5Z6UKv
 J7ofAQJPFtqXJjqTxbDW7OZf7EpOHTkoh2AHHFTe7aom8Fx/qPDGCURYyWIDyEKb/U66
 KRGWrYCh9Ob4o+bRUEUX4DsfpIEjASUnB/wVqDU/O5yAWj6nsCzwwRRHDlR37Cvo7NpY
 sMF9uK/dSjiNISMV+Uf6+wrYzQ/kwrLEZyYAo15H3cQp1BUNR+NfyGhxjs9lf02n+CHP
 imdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G7+PzDFZT7BSCXwDo8JVay4mYNjka/hIHExTbrAwud4=;
 b=LLA5NZnKN2duEMqv6PPdpDB2ctOF/k7MXN9dPS9ZKiCyyMNkAuCR7Tu7nWmbLws+q0
 WZZOFd/K+MFmH1V+oWuuCKoWSV+D+L3+VFIPRgju+0hiZk36fh6GpWN2lqW1hkGA+euR
 O2XF1X7izW0p+AnxgdDvLicNWzM2+/uAdqR2rWOL+FJbdfpy51fkRWE0pNctdb2NJXyQ
 H0Q6RtszhK2HJ2o0XrM11IoERHGDS91pcr+N0sypwtlyQKYqhZeozkOCa3JPog0Eyzce
 auhv7DbQavGQ1Diao6AP7go3SOKXGVQf0NWPKbGofhhawoHq6n6i5z/08iGQaIZ4j0Ec
 MCMQ==
X-Gm-Message-State: AOAM530wY8MWvHRcEg7PUUk1FXOht76fMq3dtUXphSm5PTbF8WNGkP4Z
 kdK+daiJ8AfL8gXnWtHqvWc=
X-Google-Smtp-Source: ABdhPJw4TcKC+ObFD1r/WQsKWUmJQdzOQNLfl33CvIYYu2oaLSISRDf+i2H3Vcn1KjPLXQElMMSJ8A==
X-Received: by 2002:a1c:a74a:: with SMTP id q71mr7488146wme.23.1589606356438; 
 Fri, 15 May 2020 22:19:16 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id g10sm6235298wrx.4.2020.05.15.22.19.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 22:19:15 -0700 (PDT)
Subject: Re: [PATCH] target/arm: Allow user-mode code to write CPSR.E via MSR
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Randy Yates <yates@ieee.org>
References: <20200515185026.30080-1-peter.maydell@linaro.org>
 <327074ea-2c2f-ad45-b53f-1c4dcb69f9bf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8c049fb3-7122-3ac5-e7bd-0c905bd459e4@amsat.org>
Date: Sat, 16 May 2020 07:19:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <327074ea-2c2f-ad45-b53f-1c4dcb69f9bf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/20 11:26 PM, Richard Henderson wrote:
> On 5/15/20 11:50 AM, Peter Maydell wrote:
>> Using the MSR instruction to write to CPSR.E is deprecated, but it is
>> required to work from any mode including unprivileged code.  We were
>> incorrectly forbidding usermode code from writing it because
>> CPSR_USER did not include the CPSR_E bit.
>>
>> We use CPSR_USER in only three places:
>>   * as the mask of what to allow userspace MSR to write to CPSR
>>   * when deciding what bits a linux-user signal-return should be
>>     able to write from the sigcontext structure
>>   * in target_user_copy_regs() when we set up the initial
>>     registers for the linux-user process
>>
>> In the first two cases not being able to update CPSR.E is a
>> bug, and in the third case it doesn't matter because CPSR.E
>> is always 0 there. So we can fix both bugs by adding CPSR_E
>> to CPSR_EXEC.
> 
> Wrong variable in description here.

Indeed CPSR_EXEC -> CPSR_USER typo.

> 
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~
> 
>>
>> (The recommended way to change CPSR.E is to use the 'SETEND'
>> instruction, which we do correctly allow from usermode code.)
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> Bug reported on IRC.

Similar to commit a1ecb4381829d7:

Reported-by: Randy Yates <yates@ieee.org>

> Quick-and-dirty test case at:
>>   https://people.linaro.org/~peter.maydell/msr-setend.c
>>
>>   target/arm/cpu.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 5d995368d4f..677584e5da0 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -1230,7 +1230,7 @@ void pmu_init(ARMCPU *cpu);
>>   #define CACHED_CPSR_BITS (CPSR_T | CPSR_AIF | CPSR_GE | CPSR_IT | CPSR_Q \
>>       | CPSR_NZCV)
>>   /* Bits writable in user mode.  */
>> -#define CPSR_USER (CPSR_NZCV | CPSR_Q | CPSR_GE)
>> +#define CPSR_USER (CPSR_NZCV | CPSR_Q | CPSR_GE | CPSR_E)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>>   /* Execution state bits.  MRS read as zero, MSR writes ignored.  */
>>   #define CPSR_EXEC (CPSR_T | CPSR_IT | CPSR_J | CPSR_IL)
>>   
>>
> 
> 


