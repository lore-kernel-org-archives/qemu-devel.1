Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5D7C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:54:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 669CE21882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 669CE21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiiWk-0003OO-Lw
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 12:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41195)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hiiVe-00021u-3i
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hiiVb-0005u5-8Z
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:53:29 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39294)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hiiVb-0005t4-2I
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:53:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id z23so3166656wma.4
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 09:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E37j4BpX3BZF5h2oUDDuHiS6QR9k8bhW8GZOQLRKgJ0=;
 b=HkPJnLsAy1zMxBYSWqyUXojaByDU0NxPsNjnUMKqTkTD1sSYLvTd5HAMq/zTq5US0f
 7mtqPllMh7YbIavhBI0cG5IV3Oqw6OPd+Wf8B0JzyknqtKv23KlJOkmZpUWZ5n7GYqfw
 o/7Aryhu3yhXSytx6/16Cb17yh1BrYwJTqOkX5aUfw2UA8VTXg1NBU6qaPcbeOnbQpJ3
 4RcRlak9K1pAcB8e89MUWtPn9/T++PsdrMJHWLCwdvOVHEBG62tE4H/ouxYbre/z149H
 nNZuEnPO08F8DTNA1TmhTzSB3yHmAqHCPjaYRlV1Njbif95qyaJGUZYSnRXrJ+8I1VnX
 FiLw==
X-Gm-Message-State: APjAAAXKg22HltofrExY0GuB0Tcs1j+6Atns5kY5DngMqCpNAqwgvf+W
 HQVY7eZ6gSCsNHlvcwQjYkHQ9A==
X-Google-Smtp-Source: APXvYqwgj/GdMOH0tI4azvlKeASk3sU/wySnd8D/VUrrMUoh00qfyOgTVKdEE/GvoAvdFu0dhF47GA==
X-Received: by 2002:a7b:c455:: with SMTP id l21mr8888260wmi.114.1562172805333; 
 Wed, 03 Jul 2019 09:53:25 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id o12sm3062674wrx.63.2019.07.03.09.53.24
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jul 2019 09:53:24 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190703155244.28166-1-alex.bennee@linaro.org>
 <20190703155244.28166-5-alex.bennee@linaro.org>
 <2c0b9e7f-f4d1-b52b-1f3a-4100bf50c151@redhat.com>
 <87lfxfvzj1.fsf@zen.linaroharston>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e593b2ba-675e-947a-4188-33b87e1c29a4@redhat.com>
Date: Wed, 3 Jul 2019 18:53:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87lfxfvzj1.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v1 4/4] target/arm: remove run time
 semihosting checks
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/19 6:44 PM, Alex Bennée wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> Hi Alex, Peter.
>>
>> On 7/3/19 5:52 PM, Alex Bennée wrote:
>>> Now we do all our checking and use a common EXCP_SEMIHOST for
>>> semihosting operations we can make helper code a lot simpler.
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>  target/arm/helper.c | 84 +++++++++------------------------------------
>>>  1 file changed, 17 insertions(+), 67 deletions(-)
>>>
>>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>>> index ad29dc4072..5c1f741380 100644
>>> --- a/target/arm/helper.c
>>> +++ b/target/arm/helper.c
>>> @@ -10364,83 +10364,33 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
>>>                    new_el, env->pc, pstate_read(env));
>>>  }
>>>
>>> -static inline bool check_for_semihosting(CPUState *cs)
>>> +/*
>>> + * Check whether this exception is a semihosting call; if so
>>> + * then handle it and return true; otherwise return false.
>>> + *
>>> + * All the permission and validity checks are done at translate time.
>>> + */
>>> +static inline bool handle_semihosting(CPUState *cs)
>>>  {
>>> -    /* Check whether this exception is a semihosting call; if so
>>> -     * then handle it and return true; otherwise return false.
>>> -     */
>>>      ARMCPU *cpu = ARM_CPU(cs);
>>>      CPUARMState *env = &cpu->env;
>>>
>>> -    if (is_a64(env)) {
>>> -        if (cs->exception_index == EXCP_SEMIHOST) {
>>> -            /* This is always the 64-bit semihosting exception.
>>> -             * The "is this usermode" and "is semihosting enabled"
>>> -             * checks have been done at translate time.
>>> -             */
>>> +    if (cs->exception_index == EXCP_SEMIHOST) {
>>> +        if (is_a64(env)) {
>>>              qemu_log_mask(CPU_LOG_INT,
>>>                            "...handling as semihosting call 0x%" PRIx64 "\n",
>>>                            env->xregs[0]);
>>>              env->xregs[0] = do_arm_semihosting(env);
>>> -            return true;
>>> -        }
>>> -        return false;
>>> -    } else {
>>> -        uint32_t imm;
>>> -
>>> -        /* Only intercept calls from privileged modes, to provide some
>>> -         * semblance of security.
>>> -         */
>>> -        if (cs->exception_index != EXCP_SEMIHOST &&
>>> -            (!semihosting_enabled() ||
>>> -             ((env->uncached_cpsr & CPSR_M) == ARM_CPU_MODE_USR))) {
>>> -            return false;
>>> -        }
>>> -
>>> -        switch (cs->exception_index) {
>>> -        case EXCP_SEMIHOST:
>>> -            /* This is always a semihosting call; the "is this usermode"
>>> -             * and "is semihosting enabled" checks have been done at
>>> -             * translate time.
>>> -             */
>>> -            break;
>>> -        case EXCP_SWI:
>>> -            /* Check for semihosting interrupt.  */
>>> -            if (env->thumb) {
>>> -                imm = arm_lduw_code(env, env->regs[15] - 2, arm_sctlr_b(env))
>>> -                    & 0xff;
>>> -                if (imm == 0xab) {
>>> -                    break;
>>> -                }
>>> -            } else {
>>> -                imm = arm_ldl_code(env, env->regs[15] - 4, arm_sctlr_b(env))
>>> -                    & 0xffffff;
>>> -                if (imm == 0x123456) {
>>> -                    break;
>>> -                }
>>> -            }
>>> -            return false;
>>> -        case EXCP_BKPT:
>>> -            /* See if this is a semihosting syscall.  */
>>> -            if (env->thumb) {
>>> -                imm = arm_lduw_code(env, env->regs[15], arm_sctlr_b(env))
>>> -                    & 0xff;
>>> -                if (imm == 0xab) {
>>> -                    env->regs[15] += 2;
>>> -                    break;
>>> -                }
>>> -            }
>>> -            return false;
>>> -        default:
>>> -            return false;
>>> +        } else {
>>> +            qemu_log_mask(CPU_LOG_INT,
>>> +                          "...handling as semihosting call 0x%x\n",
>>> +                          env->regs[0]);
>>> +            env->regs[0] = do_arm_semihosting(env);
>>>          }
>>> -
>>> -        qemu_log_mask(CPU_LOG_INT,
>>> -                      "...handling as semihosting call 0x%x\n",
>>> -                      env->regs[0]);
>>> -        env->regs[0] = do_arm_semihosting(env);
>>>          return true;
>>>      }
>>> +
>>> +    return false;
>>>  }
>>>
>>>  /* Handle a CPU exception for A and R profile CPUs.
>>> @@ -10476,7 +10426,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
>>>       * code that caused the exception, not the target exception level,
>>>       * so must be handled here.
>>>       */
>>> -    if (check_for_semihosting(cs)) {
>>> +    if (handle_semihosting(cs)) {
>>>          return;
>>>      }
>>>
>>>
>>
>> This patch clashes with this one:
>> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg00343.html
>> that Peter already queued:
>> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg00692.html
>>
>> Peter, if you want this for 4.1, it might be easier to dequeue "Restrict
>> semi-hosting to TCG", apply Alex series, and re-apply "Restrict
>> semi-hosting to TCG", the conflicts should be trivial (function name
>> changed check_for_semihosting -> handle_semihosting).
> 
> This isn't 4.1 material - unless I can figure out the weird single-step
> while semihosting bug.

Well I'm not sure it is ARM-specific... I remember something similar
with MIPS.

>>
>> Thanks,
>>
>> Phil.

