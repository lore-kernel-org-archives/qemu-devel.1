Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F64AFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 20:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 200422089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 20:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQJXxAM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 200422089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLCdm-0004Tg-7D
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 16:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iLCcp-0003ew-Th
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 16:44:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iLCcn-0006DE-BK
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 16:43:59 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:38732)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iLCcn-0006Cz-7a
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 16:43:57 -0400
Received: by mail-qk1-x744.google.com with SMTP id p4so3219069qkf.5
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 13:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=znJaM4yXAXZ1huYG2YR0JYXPOgt9ggfLtiihvaHCQZc=;
 b=WQJXxAM3C6JTv2zJ3jI47DQPwwdVKYiwt81niXnZEDYSch38RdCqXfthIxyA6usNL3
 95l8+LOcr4Vh1R8kTg8i3SOE4J2aZTawO0eBluGCBD/67SOULzLnI/vZ3a38scE+gtmp
 PamjR2ORN8R77Lh0shlV6xiRoc91mDzUCs2HEWE99YkyB3pDp8kIYdWZRqeePoxWSNFU
 dn+w+z149R+BYjIafZBCrqMUCnrA/yVmJwIYGjcAsiVGBCaCXVUDnNb1btjNITmj/9O0
 aJ2s+EGsNJrKs3WZWq+wi6ZAaHS14qrgbky4QeTvoJUtx7hSoU38vdLenlSQ0iRJ3b1n
 P8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=znJaM4yXAXZ1huYG2YR0JYXPOgt9ggfLtiihvaHCQZc=;
 b=nyYcvf9MJWa/jqyNej6BXZkfS5nuNLvag2YLv2M6fcu0OTDD/95wMeFB21stUfQRwW
 7psqMI9xgIpV3VvQQkCOb8y4nMQMHlqleajhAnSMkBpkfZVYdsPLCi1Lqs3zMc3aMQV6
 BoP7px1shq8eMe4z2dCyZXDpOszw13sxW97L+DdGSjSbH2S+MvK/G/AzCU3UVr2MSSyt
 7Uaqd7PFl06EAvetkNSkvtHcR7b3uIhJYNKwMg+JRKUwhUwamUDLWWmHVRJHzyCtn+De
 oquVTqBBS7nzACWwV5RBcoMR8IQ2f2kHnYjTqPRcGxt5O39wc+mg1RpmGwnDg1yXj868
 P3dg==
X-Gm-Message-State: APjAAAUrPZ7DOV1gKOgnlbgvFatejglf7VQFKKCza6e/yVLXLjXP7QyR
 AlKuRw/ezYN3d3E7+FCctLCmBgpwzvbC06pY3kw=
X-Google-Smtp-Source: APXvYqzMpS4sEgIebH2zwXJC2Qrsm23eXkOeoIaWbIgq9pcIwf3iM3z2z0NEsb//KzD+yyz+0EGQgPsEqw8r6RMcuNM=
X-Received: by 2002:a05:620a:140d:: with SMTP id
 d13mr5221256qkj.460.1571345036295; 
 Thu, 17 Oct 2019 13:43:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191014161843.84845-1-mrolnik@gmail.com>
 <20191014161843.84845-5-mrolnik@gmail.com>
 <CAL1e-=g9ER4tuqEL2ubqb7oAbatcVR8x+A0LAydSwBJEnk9_ow@mail.gmail.com>
 <CAK4993gm=8tVXyprjHPMiNZuKZRkx0iDYnXh76cQfMwUayqcWQ@mail.gmail.com>
 <CAL1e-=hGJQqVnvAu=ZJRV-AdoAWpkSvdf5ex=b7EwkodUGKpUg@mail.gmail.com>
In-Reply-To: <CAL1e-=hGJQqVnvAu=ZJRV-AdoAWpkSvdf5ex=b7EwkodUGKpUg@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Thu, 17 Oct 2019 23:43:04 +0300
Message-ID: <CAK4993jaqFrzcmAyz7neJoq5cQgnB_o35dZhdh9_uVyOfKGG-Q@mail.gmail.com>
Subject: Re: [PATCH v32 04/13] target/avr: Add instruction translation -
 Registers definition
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 17, 2019 at 11:17 PM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>>
>>
>> >> +static TCGv cpu_Cf;
>> >> +static TCGv cpu_Zf;
>> >> +static TCGv cpu_Nf;
>> >> +static TCGv cpu_Vf;
>> >> +static TCGv cpu_Sf;
>> >> +static TCGv cpu_Hf;
>> >> +static TCGv cpu_Tf;
>> >> +static TCGv cpu_If;
>> >> +
>> >
>> >
>> > Hello, Michael,
>> >
>> > Is there any particular reason or motivation beyond modelling status register flags as TCGv variables?
>>
>>
>>
>> I think it's easier this way as I don't need to convert flag values to
>> bits or bits to flag values.
>
>
> Ok. But, how do you map 0/1 flag value to the value of a TCGv variable and vice versa? In other words, what value or values (out of 2^32 vales) of a TCGv variable mean the flag is 1? And the same question for 0.
>
> Is 0110000111000010100 one or zero?
>
> Besides, in such arrangement, how do you display the 8-bit status register in gdb, if at all?

each flag register is either 0 or 1, they are calculated here
1. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/avr/translate.c#L146-L148
2. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/avr/translate.c#L166
3. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/avr/translate.c#L185-L187
4. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/avr/translate.c#L205
5. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/avr/translate.c#L214-L215
6. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/avr/translate.c#L222-L223
The COU itself never uses SREG at all, only the flags.

As for the GDB it's get assembled/disassembled here
1. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/avr/cpu.h#L219-L243
2. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/avr/gdbstub.c#L35-L37
3. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/avr/gdbstub.c#L66-L68

>
> A.
>
>>
>> >
>> > A.
>> >
>> >
>> >
>> >>
>> >> +static TCGv cpu_rampD;
>> >> +static TCGv cpu_rampX;
>> >> +static TCGv cpu_rampY;
>> >> +static TCGv cpu_rampZ;
>> >> +
>> >> +static TCGv cpu_r[NO_CPU_REGISTERS];
>> >> +static TCGv cpu_eind;
>> >> +static TCGv cpu_sp;
>> >> +
>> >> +static TCGv cpu_skip;
>> >> +
>> >> +static const char reg_names[NO_CPU_REGISTERS][8] = {
>> >> +    "r0",  "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
>> >> +    "r8",  "r9",  "r10", "r11", "r12", "r13", "r14", "r15",
>> >> +    "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
>> >> +    "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
>> >> +};
>> >> +#define REG(x) (cpu_r[x])
>> >> +
>> >> +enum {
>> >> +    DISAS_EXIT   = DISAS_TARGET_0,  /* We want return to the cpu main loop.  */
>> >> +    DISAS_LOOKUP = DISAS_TARGET_1,  /* We have a variable condition exit.  */
>> >> +    DISAS_CHAIN  = DISAS_TARGET_2,  /* We have a single condition exit.  */
>> >> +};
>> >> +
>> >> +typedef struct DisasContext DisasContext;
>> >> +
>> >> +/* This is the state at translation time. */
>> >> +struct DisasContext {
>> >> +    TranslationBlock *tb;
>> >> +
>> >> +    CPUAVRState *env;
>> >> +    CPUState *cs;
>> >> +
>> >> +    target_long npc;
>> >> +    uint32_t opcode;
>> >> +
>> >> +    /* Routine used to access memory */
>> >> +    int memidx;
>> >> +    int bstate;
>> >> +    int singlestep;
>> >> +
>> >> +    TCGv skip_var0;
>> >> +    TCGv skip_var1;
>> >> +    TCGCond skip_cond;
>> >> +    bool free_skip_var0;
>> >> +};
>> >> +
>> >> +static int to_A(DisasContext *ctx, int indx) { return 16 + (indx % 16); }
>> >> +static int to_B(DisasContext *ctx, int indx) { return 16 + (indx % 8); }
>> >> +static int to_C(DisasContext *ctx, int indx) { return 24 + (indx % 4) * 2; }
>> >> +static int to_D(DisasContext *ctx, int indx) { return (indx % 16) * 2; }
>> >> +
>> >> +static uint16_t next_word(DisasContext *ctx)
>> >> +{
>> >> +    return cpu_lduw_code(ctx->env, ctx->npc++ * 2);
>> >> +}
>> >> +
>> >> +static int append_16(DisasContext *ctx, int x)
>> >> +{
>> >> +    return x << 16 | next_word(ctx);
>> >> +}
>> >> +
>> >> +
>> >> +static bool avr_have_feature(DisasContext *ctx, int feature)
>> >> +{
>> >> +    if (!avr_feature(ctx->env, feature)) {
>> >> +        gen_helper_unsupported(cpu_env);
>> >> +        ctx->bstate = DISAS_NORETURN;
>> >> +        return false;
>> >> +    }
>> >> +    return true;
>> >> +}
>> >> +
>> >> +static bool decode_insn(DisasContext *ctx, uint16_t insn);
>> >> +#include "decode_insn.inc.c"
>> >> +
>> >> --
>> >> 2.17.2 (Apple Git-113)
>> >>
>>
>>
>> --
>> Best Regards,
>> Michael Rolnik



-- 
Best Regards,
Michael Rolnik

