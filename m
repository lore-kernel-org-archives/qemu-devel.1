Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66077CA9EA8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:08:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3314821925
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJ41IO2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3314821925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLSvY-0001lA-CZ
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iLSkh-0005iH-Kx
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:57:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iLSkf-0000si-UX
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:57:11 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:45073)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iLSkf-0000sS-N5
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:57:09 -0400
Received: by mail-qt1-x842.google.com with SMTP id c21so9130871qtj.12
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 06:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NF/5uJpTFqhNwKWsh3dEURXwJuWYCWEZnkkvzvb9Src=;
 b=jJ41IO2vsBt5quS7zX2N11BjoZaMvFXaLn1UGtaReZDVfdVKaQMcFyHN9HRefWeONL
 QnO0KWygwQnzvi7XjKuFMJ18Xsqa4onO1YnVWbgToDyuy/e2X1Wocdm9c8wZIARuWC+g
 XXM2wM5ABQ/b+Y9dOMD4agLprGBN+rg+VhyQcDsihDm9qeSX1Ii2VgaTIFs93JDkPAP0
 Iwhz1lu09XF0bXtLKkhyCxKZfNtod8Swv+95btpwlRn4YbPLsMzvEEJYGoraMbKyOkXS
 qV4v4iG2fzUHYgqMYkF6KWI+Lif34RNE3+qe9QG/sT8riQHjO3/RlnY99VXhtTkuuufM
 UMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NF/5uJpTFqhNwKWsh3dEURXwJuWYCWEZnkkvzvb9Src=;
 b=ET253g5wf8QkZ2WqTmyegw5s2sdxKVfkQOb3IV44OESd5m2A1/LwxTrWgkNPQwmuRq
 FFQzbVLa1drYUMuYzIPSO8utfQrbNS9zPw7V+DD79avF5mCob5RTdorw08bGmMsg/Yoq
 PBo5zhijxzanJh6Np5t8bcm1mnd9IO1vvESRH8eSWI4JcmWSzc00u+xHbclNFSJkAB3R
 XranMNAyK6J32N478Gc8LszNoKT1H6J77mX8P3g1CNg7CDp7M8AxESohioxLHENhrWNw
 w33Qi+PuT6RgqnBnboN9WcC7GqWkg1e3dKYedREpwAONilya+5GY/D7U8ZdRWuZ2Et1q
 Dh+A==
X-Gm-Message-State: APjAAAU+JQq+e5GUDOBK84QhAxhQhoeQoIjh86Vy7baE7E8xZRmcAmI8
 nj3y+8icnNizwO/RtlXzwzcNyycsB08L/IzQLsU=
X-Google-Smtp-Source: APXvYqwinHBgK5jCFnvCLrGS+1+yt4iMjtyVMd/vdTuh2youdepjB4vMsQ8hrN/CakAm8hbOtUTqnWHEromF/jAss4I=
X-Received: by 2002:ac8:3f66:: with SMTP id w35mr9899510qtk.382.1571407028370; 
 Fri, 18 Oct 2019 06:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <20191014161843.84845-1-mrolnik@gmail.com>
 <20191014161843.84845-5-mrolnik@gmail.com>
 <CAL1e-=g9ER4tuqEL2ubqb7oAbatcVR8x+A0LAydSwBJEnk9_ow@mail.gmail.com>
 <CAK4993gm=8tVXyprjHPMiNZuKZRkx0iDYnXh76cQfMwUayqcWQ@mail.gmail.com>
 <CAL1e-=hGJQqVnvAu=ZJRV-AdoAWpkSvdf5ex=b7EwkodUGKpUg@mail.gmail.com>
 <CAK4993jaqFrzcmAyz7neJoq5cQgnB_o35dZhdh9_uVyOfKGG-Q@mail.gmail.com>
 <CAL1e-=ixhb1z8h9f6DrNAuEn69pPaV2qvvd=BvVnFKCdW+XMwg@mail.gmail.com>
 <CAK4993h6p2ZHx7a_JZhP_GE21UjfDmBJoSoBSPSo0pDwRmyK=Q@mail.gmail.com>
 <CAL1e-=gjP5CJ5x-e9MCw5T2-y41KuWD=CiSVecCFB1StsP5nFw@mail.gmail.com>
In-Reply-To: <CAL1e-=gjP5CJ5x-e9MCw5T2-y41KuWD=CiSVecCFB1StsP5nFw@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Fri, 18 Oct 2019 16:56:15 +0300
Message-ID: <CAK4993j44GK=zyuGbo86Li=7Gt2BrwWuzdLe3rggnOtMPR7f2Q@mail.gmail.com>
Subject: Re: [PATCH v32 04/13] target/avr: Add instruction translation -
 Registers definition
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
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

On Fri, Oct 18, 2019 at 4:23 PM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
>
>
> On Friday, October 18, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:
>>
>>
>>
>> On Fri, Oct 18, 2019 at 11:52 AM Aleksandar Markovic <aleksandar.m.mail@gmail.com> wrote:
>>>
>>>
>>>
>>> On Thursday, October 17, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:
>>>>
>>>> On Thu, Oct 17, 2019 at 11:17 PM Aleksandar Markovic
>>>> <aleksandar.m.mail@gmail.com> wrote:
>>>> >>
>>>> >>
>>>> >> >> +static TCGv cpu_Cf;
>>>> >> >> +static TCGv cpu_Zf;
>>>> >> >> +static TCGv cpu_Nf;
>>>> >> >> +static TCGv cpu_Vf;
>>>> >> >> +static TCGv cpu_Sf;
>>>> >> >> +static TCGv cpu_Hf;
>>>> >> >> +static TCGv cpu_Tf;
>>>> >> >> +static TCGv cpu_If;
>>>> >> >> +
>>>> >> >
>>>> >> >
>>>> >> > Hello, Michael,
>>>> >> >
>>>> >> > Is there any particular reason or motivation beyond modelling status register flags as TCGv variables?
>>>> >>
>>>> >>
>>>> >>
>>>> >> I think it's easier this way as I don't need to convert flag values to
>>>> >> bits or bits to flag values.
>>>> >
>>>> >
>>>> > Ok. But, how do you map 0/1 flag value to the value of a TCGv variable and vice versa? In other words, what value or values (out of 2^32 vales) of a TCGv variable mean the flag is 1? And the same question for 0.
>>>> >
>>>> > Is 0110000111000010100 one or zero?
>>>> >
>>>> > Besides, in such arrangement, how do you display the 8-bit status register in gdb, if at all?
>>>>
>>>> each flag register is either 0 or 1,....
>>>>
>>>>
>>>>
>>>
>>> Michael,
>>>
>>> If this is true, why is there a special handling of two flags in the following code:
>>>
>>>
>>> static inline uint8_t cpu_get_sreg(CPUAVRState *env)
>>> {
>>> uint8_t sreg;
>>> sreg = (env->sregC & 0x01) << 0
>>> | (env->sregZ == 0 ? 1 : 0) << 1
>>> | (env->sregN) << 2
>>> | (env->sregV) << 3
>>> | (env->sregS) << 4
>>> | (env->sregH) << 5
>>> | (env->sregT) << 6
>>> | (env->sregI) << 7;
>>> return sreg;
>>> }
>>> static inline void cpu_set_sreg(CPUAVRState *env, uint8_t sreg)
>>> {
>>> env->sregC = (sreg >> 0) & 0x01;
>>> env->sregZ = (sreg >> 1) & 0x01 ? 0 : 1;
>>> env->sregN = (sreg >> 2) & 0x01;
>>> env->sregV = (sreg >> 3) & 0x01;
>>> env->sregS = (sreg >> 4) & 0x01;
>>> env->sregH = (sreg >> 5) & 0x01;
>>> env->sregT = (sreg >> 6) & 0x01;
>>> env->sregI = (sreg >> 7) & 0x01;
>>> }
>>>  ?
>>>
>> Aleksandar,
>>
>> If I understand your question correctly cpu_get_sreg assembles SREG value to be presented by GDB, and cpu_set_sreg sets flags values when GDB modifies SREG.
>>
>> Michael
>
>
>
> Why is handling of sregC and sregZ flags different than handling of other flags? This contradicts your previos statement that 1 (in TCGv) means 1 (flag), and 0 (in TCGv) means 0 (flag)?
>
>
> Whatever is the explanation, ot should be included, in my opinion, in code comments.
>
> Please, Michael, let's first clarify the issue from the question above.
>
> Thanks, Aleksandar
>
>
there is a comment here
https://github.com/michaelrolnik/qemu-avr/blob/master/target/avr/cpu.h#L122-L129
>
>
>
>>>
>>> Thanks,
>>> A.
>>>>
>>>>
>>>>  they are calculated here
>>>> 1. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/avr/translate.c#L146-L148
>>>> 2. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/avr/translate.c#L166
>>>> 3. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/avr/translate.c#L185-L187
>>>> 4. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/avr/translate.c#L205
>>>> 5. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/avr/translate.c#L214-L215
>>>> 6. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/avr/translate.c#L222-L223
>>>> The COU itself never uses SREG at all, only the flags.
>>>>
>>>> As for the GDB it's get assembled/disassembled here
>>>> 1. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/avr/cpu.h#L219-L243
>>>> 2. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/avr/gdbstub.c#L35-L37
>>>> 3. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/avr/gdbstub.c#L66-L68
>>>>
>>>> >
>>>> > A.
>>>> >
>>>> >>
>>>> >> >
>>>> >> > A.
>>>> >> >
>>>> >> >
>>>> >> >
>>>> >> >>
>>>> >> >> +static TCGv cpu_rampD;
>>>> >> >> +static TCGv cpu_rampX;
>>>> >> >> +static TCGv cpu_rampY;
>>>> >> >> +static TCGv cpu_rampZ;
>>>> >> >> +
>>>> >> >> +static TCGv cpu_r[NO_CPU_REGISTERS];
>>>> >> >> +static TCGv cpu_eind;
>>>> >> >> +static TCGv cpu_sp;
>>>> >> >> +
>>>> >> >> +static TCGv cpu_skip;
>>>> >> >> +
>>>> >> >> +static const char reg_names[NO_CPU_REGISTERS][8] = {
>>>> >> >> +    "r0",  "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
>>>> >> >> +    "r8",  "r9",  "r10", "r11", "r12", "r13", "r14", "r15",
>>>> >> >> +    "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
>>>> >> >> +    "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
>>>> >> >> +};
>>>> >> >> +#define REG(x) (cpu_r[x])
>>>> >> >> +
>>>> >> >> +enum {
>>>> >> >> +    DISAS_EXIT   = DISAS_TARGET_0,  /* We want return to the cpu main loop.  */
>>>> >> >> +    DISAS_LOOKUP = DISAS_TARGET_1,  /* We have a variable condition exit.  */
>>>> >> >> +    DISAS_CHAIN  = DISAS_TARGET_2,  /* We have a single condition exit.  */
>>>> >> >> +};
>>>> >> >> +
>>>> >> >> +typedef struct DisasContext DisasContext;
>>>> >> >> +
>>>> >> >> +/* This is the state at translation time. */
>>>> >> >> +struct DisasContext {
>>>> >> >> +    TranslationBlock *tb;
>>>> >> >> +
>>>> >> >> +    CPUAVRState *env;
>>>> >> >> +    CPUState *cs;
>>>> >> >> +
>>>> >> >> +    target_long npc;
>>>> >> >> +    uint32_t opcode;
>>>> >> >> +
>>>> >> >> +    /* Routine used to access memory */
>>>> >> >> +    int memidx;
>>>> >> >> +    int bstate;
>>>> >> >> +    int singlestep;
>>>> >> >> +
>>>> >> >> +    TCGv skip_var0;
>>>> >> >> +    TCGv skip_var1;
>>>> >> >> +    TCGCond skip_cond;
>>>> >> >> +    bool free_skip_var0;
>>>> >> >> +};
>>>> >> >> +
>>>> >> >> +static int to_A(DisasContext *ctx, int indx) { return 16 + (indx % 16); }
>>>> >> >> +static int to_B(DisasContext *ctx, int indx) { return 16 + (indx % 8); }
>>>> >> >> +static int to_C(DisasContext *ctx, int indx) { return 24 + (indx % 4) * 2; }
>>>> >> >> +static int to_D(DisasContext *ctx, int indx) { return (indx % 16) * 2; }
>>>> >> >> +
>>>> >> >> +static uint16_t next_word(DisasContext *ctx)
>>>> >> >> +{
>>>> >> >> +    return cpu_lduw_code(ctx->env, ctx->npc++ * 2);
>>>> >> >> +}
>>>> >> >> +
>>>> >> >> +static int append_16(DisasContext *ctx, int x)
>>>> >> >> +{
>>>> >> >> +    return x << 16 | next_word(ctx);
>>>> >> >> +}
>>>> >> >> +
>>>> >> >> +
>>>> >> >> +static bool avr_have_feature(DisasContext *ctx, int feature)
>>>> >> >> +{
>>>> >> >> +    if (!avr_feature(ctx->env, feature)) {
>>>> >> >> +        gen_helper_unsupported(cpu_env);
>>>> >> >> +        ctx->bstate = DISAS_NORETURN;
>>>> >> >> +        return false;
>>>> >> >> +    }
>>>> >> >> +    return true;
>>>> >> >> +}
>>>> >> >> +
>>>> >> >> +static bool decode_insn(DisasContext *ctx, uint16_t insn);
>>>> >> >> +#include "decode_insn.inc.c"
>>>> >> >> +
>>>> >> >> --
>>>> >> >> 2.17.2 (Apple Git-113)
>>>> >> >>
>>>> >>
>>>> >>
>>>> >> --
>>>> >> Best Regards,
>>>> >> Michael Rolnik
>>>>
>>>>
>>>>
>>>> --
>>>> Best Regards,
>>>> Michael Rolnik
>>
>>
>>
>> --
>> Best Regards,
>> Michael Rolnik



-- 
Best Regards,
Michael Rolnik

