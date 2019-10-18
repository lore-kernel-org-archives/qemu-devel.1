Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C47ECA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:11:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0B1F20869
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ac+F9Tsz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B1F20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLWii-0001al-Uj
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 14:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLWfd-0006fd-Oj
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:08:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLWfa-0004Vo-VP
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:08:13 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45663)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iLWfa-0004VX-M8
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:08:10 -0400
Received: by mail-ot1-x344.google.com with SMTP id 41so5696491oti.12
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 11:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=gBbnAATkBcjmXSSHFQ5AP+JWZK4XTYwawB47ZLHnvKQ=;
 b=Ac+F9TszlbbvjqTVr7vEZVYt9vfd+X5tNmPhBJx2omcaPqOHpz9FeBCIc2a1EtYymW
 EhWBXhyJGqfijQHD5rHqx5+eKvaYre6brFuWaNpHptAVTs3VB/+I0hdf2jVuBB7tLw8/
 VBOzWUjCHC174mBWli6u23oYgdZ9l4rXKO9ubZ1u2yYIhmv7pL846rsuYt9BwpehS5rr
 aiEKqymILNFAfd6VPkHMfHWVwbxf3vhyzZHl9/dTRZWRgIhOoCJPgGSysaqJ+kJn/PeI
 e+Q3enGkCHFWFMNsr+7cesm80QU3NHbZ4pwls/E4nzs1hYC8ao+dFMpBWJX8Bs/4EeGu
 J0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=gBbnAATkBcjmXSSHFQ5AP+JWZK4XTYwawB47ZLHnvKQ=;
 b=M6XR6VyIaFd6EBC4H+L5QAQmRJfj5QxCaPHDBB3nLDhsvRGG24y/OZgqpoxWxxMisZ
 P26LNoVHGSxy6lkMIJInuQEt5MX52Lnlmihvz5SkFjFhV6WC7Zp+oJvKwBsSNceMc0fx
 SaV8YWeai7SWW2qcM9YpVFeGmuZXsdS2XYWZ27KdPLzu3Ok5WhlBdzJvKZLEH60JsLyN
 2Gth4GPxyJizbAYzQb6e7+Vl7LA6PRMq+BZQ+OgqBm2QUuNUKUtPbIBZZaILdRMd7o/h
 +XqxTbZzUt8wN/FqbphHxV/cfd0XZP4Q37XGTZnp34W7o/OCO2s/IFfvcQKYKVxbO7r5
 S+Qg==
X-Gm-Message-State: APjAAAW+f4K4wq4BLvKnnaV3g1nK8KzlIDs7ocXbYnJMKLickCVp6H+c
 OdRUUH0XnWDJvdPM67QTomKop95Y4QcSYudAxRw=
X-Google-Smtp-Source: APXvYqwnq1vezI95YZY1CVPqezNB/ixvy4eon1wR49vQa1lnuzq4/3CAagv9zCm9yS1MdryBW7dCGqdej0PlHNf5RAk=
X-Received: by 2002:a9d:5914:: with SMTP id t20mr8655214oth.306.1571422089786; 
 Fri, 18 Oct 2019 11:08:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Fri, 18 Oct 2019 11:08:09
 -0700 (PDT)
In-Reply-To: <CAL1e-=g4H84RAX231Gg1+MXMh-YzRV0fuUj4u98QASLJ1xzd=A@mail.gmail.com>
References: <20191014161843.84845-1-mrolnik@gmail.com>
 <20191014161843.84845-5-mrolnik@gmail.com>
 <CAL1e-=g9ER4tuqEL2ubqb7oAbatcVR8x+A0LAydSwBJEnk9_ow@mail.gmail.com>
 <CAK4993gm=8tVXyprjHPMiNZuKZRkx0iDYnXh76cQfMwUayqcWQ@mail.gmail.com>
 <CAL1e-=hGJQqVnvAu=ZJRV-AdoAWpkSvdf5ex=b7EwkodUGKpUg@mail.gmail.com>
 <CAK4993jaqFrzcmAyz7neJoq5cQgnB_o35dZhdh9_uVyOfKGG-Q@mail.gmail.com>
 <CAL1e-=ixhb1z8h9f6DrNAuEn69pPaV2qvvd=BvVnFKCdW+XMwg@mail.gmail.com>
 <CAK4993h6p2ZHx7a_JZhP_GE21UjfDmBJoSoBSPSo0pDwRmyK=Q@mail.gmail.com>
 <CAL1e-=gjP5CJ5x-e9MCw5T2-y41KuWD=CiSVecCFB1StsP5nFw@mail.gmail.com>
 <CAK4993j44GK=zyuGbo86Li=7Gt2BrwWuzdLe3rggnOtMPR7f2Q@mail.gmail.com>
 <CAL1e-=g4H84RAX231Gg1+MXMh-YzRV0fuUj4u98QASLJ1xzd=A@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 18 Oct 2019 20:08:09 +0200
Message-ID: <CAL1e-=jm=zKZBHuPBzyf2-dh3swKNrzi7fhKwvtfsteZg4cR4Q@mail.gmail.com>
Subject: Re: [PATCH v32 04/13] target/avr: Add instruction translation -
 Registers definition
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000074385c05953337a5"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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

--00000000000074385c05953337a5
Content-Type: text/plain; charset="UTF-8"

On Friday, October 18, 2019, Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

>
>
> On Friday, October 18, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:
>
>> On Fri, Oct 18, 2019 at 4:23 PM Aleksandar Markovic
>> <aleksandar.m.mail@gmail.com> wrote:
>> >
>> >
>> >
>> > On Friday, October 18, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:
>> >>
>> >>
>> >>
>> >> On Fri, Oct 18, 2019 at 11:52 AM Aleksandar Markovic <
>> aleksandar.m.mail@gmail.com> wrote:
>> >>>
>> >>>
>> >>>
>> >>> On Thursday, October 17, 2019, Michael Rolnik <mrolnik@gmail.com>
>> wrote:
>> >>>>
>> >>>> On Thu, Oct 17, 2019 at 11:17 PM Aleksandar Markovic
>> >>>> <aleksandar.m.mail@gmail.com> wrote:
>> >>>> >>
>> >>>> >>
>> >>>> >> >> +static TCGv cpu_Cf;
>> >>>> >> >> +static TCGv cpu_Zf;
>> >>>> >> >> +static TCGv cpu_Nf;
>> >>>> >> >> +static TCGv cpu_Vf;
>> >>>> >> >> +static TCGv cpu_Sf;
>> >>>> >> >> +static TCGv cpu_Hf;
>> >>>> >> >> +static TCGv cpu_Tf;
>> >>>> >> >> +static TCGv cpu_If;
>> >>>> >> >> +
>> >>>> >> >
>> >>>> >> >
>> >>>> >> > Hello, Michael,
>> >>>> >> >
>> >>>> >> > Is there any particular reason or motivation beyond modelling
>> status register flags as TCGv variables?
>> >>>> >>
>> >>>> >>
>> >>>> >>
>> >>>> >> I think it's easier this way as I don't need to convert flag
>> values to
>> >>>> >> bits or bits to flag values.
>> >>>> >
>> >>>> >
>> >>>> > Ok. But, how do you map 0/1 flag value to the value of a TCGv
>> variable and vice versa? In other words, what value or values (out of 2^32
>> vales) of a TCGv variable mean the flag is 1? And the same question for 0.
>> >>>> >
>> >>>> > Is 0110000111000010100 one or zero?
>> >>>> >
>> >>>> > Besides, in such arrangement, how do you display the 8-bit status
>> register in gdb, if at all?
>> >>>>
>> >>>> each flag register is either 0 or 1,....
>> >>>>
>> >>>>
>> >>>>
>> >>>
>> >>> Michael,
>> >>>
>> >>> If this is true, why is there a special handling of two flags in the
>> following code:
>> >>>
>> >>>
>> >>> static inline uint8_t cpu_get_sreg(CPUAVRState *env)
>> >>> {
>> >>> uint8_t sreg;
>> >>> sreg = (env->sregC & 0x01) << 0
>> >>> | (env->sregZ == 0 ? 1 : 0) << 1
>> >>> | (env->sregN) << 2
>> >>> | (env->sregV) << 3
>> >>> | (env->sregS) << 4
>> >>> | (env->sregH) << 5
>> >>> | (env->sregT) << 6
>> >>> | (env->sregI) << 7;
>> >>> return sreg;
>> >>> }
>> >>> static inline void cpu_set_sreg(CPUAVRState *env, uint8_t sreg)
>> >>> {
>> >>> env->sregC = (sreg >> 0) & 0x01;
>> >>> env->sregZ = (sreg >> 1) & 0x01 ? 0 : 1;
>> >>> env->sregN = (sreg >> 2) & 0x01;
>> >>> env->sregV = (sreg >> 3) & 0x01;
>> >>> env->sregS = (sreg >> 4) & 0x01;
>> >>> env->sregH = (sreg >> 5) & 0x01;
>> >>> env->sregT = (sreg >> 6) & 0x01;
>> >>> env->sregI = (sreg >> 7) & 0x01;
>> >>> }
>> >>>  ?
>> >>>
>> >> Aleksandar,
>> >>
>> >> If I understand your question correctly cpu_get_sreg assembles SREG
>> value to be presented by GDB, and cpu_set_sreg sets flags values when GDB
>> modifies SREG.
>> >>
>> >> Michael
>> >
>> >
>> >
>> >
>
> Why is handling of sregC and sregZ flags different than handling of other
>> flags? This contradicts your previos statement that 1 (in TCGv) means 1
>> (flag), and 0 (in TCGv) means 0 (flag)?
>> >
>> >
>> > Whatever is the explanation, ot should be included, in my opinion, in
>> code comments.
>> >
>> > Please, Michael, let's first clarify the issue from the question above.
>> >
>> > Thanks, Aleksandar
>> >
>> >
>> there is a comment here
>> https://github.com/michaelrolnik/qemu-avr/blob/master/
>> target/avr/cpu.h#L122-L129
>> >
>
>
>
> ...but it does explain WHY of my question.
>

I meant to say  "does not", not "does".

Michael, don't be discouraged by lenghty review process, just be persistent
and available for communication with reviewers.

Sincerely,
Aleksandar



>
> The reason I insist on your explanation is that when we model a cpu or a
> device in QEMU, a goal is that the model is as close to the hardware as
> possible. One may not, for pletora of reasons, succeed in reaching that
> goal, or, I can imagine, on purpose depart from that goal for some reason -
> perhaps that was the case in your implementation, where you modelled a
> single 8-bit status register with 8 TCGv variables.
>
> But, even that way of modelling was done inconsistently across bits of the
> status register. In that light, I want to know the justification for that,
> so repeat my question: Why is handling of sregC and sregZ flags different
> than handling of other flags in functions cpu_get_sreg()
> and cpu_get_sreg()? This was not explained in any comment or commit
> message. And is in contradiction with one of your previous answers.
>
> Yours,
> Aleksandar
>
>
>> >
>> >
>> >>>
>> >>> Thanks,
>> >>> A.
>> >>>>
>> >>>>
>> >>>>  they are calculated here
>> >>>> 1. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/
>> target/avr/translate.c#L146-L148
>> >>>> 2. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/
>> target/avr/translate.c#L166
>> >>>> 3. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/
>> target/avr/translate.c#L185-L187
>> >>>> 4. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/
>> target/avr/translate.c#L205
>> >>>> 5. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/
>> target/avr/translate.c#L214-L215
>> >>>> 6. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/
>> target/avr/translate.c#L222-L223
>> >>>> The COU itself never uses SREG at all, only the flags.
>> >>>>
>> >>>> As for the GDB it's get assembled/disassembled here
>> >>>> 1. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/
>> target/avr/cpu.h#L219-L243
>> >>>> 2. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/
>> target/avr/gdbstub.c#L35-L37
>> >>>> 3. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/
>> target/avr/gdbstub.c#L66-L68
>> >>>>
>> >>>> >
>> >>>> > A.
>> >>>> >
>> >>>> >>
>> >>>> >> >
>> >>>> >> > A.
>> >>>> >> >
>> >>>> >> >
>> >>>> >> >
>> >>>> >> >>
>> >>>> >> >> +static TCGv cpu_rampD;
>> >>>> >> >> +static TCGv cpu_rampX;
>> >>>> >> >> +static TCGv cpu_rampY;
>> >>>> >> >> +static TCGv cpu_rampZ;
>> >>>> >> >> +
>> >>>> >> >> +static TCGv cpu_r[NO_CPU_REGISTERS];
>> >>>> >> >> +static TCGv cpu_eind;
>> >>>> >> >> +static TCGv cpu_sp;
>> >>>> >> >> +
>> >>>> >> >> +static TCGv cpu_skip;
>> >>>> >> >> +
>> >>>> >> >> +static const char reg_names[NO_CPU_REGISTERS][8] = {
>> >>>> >> >> +    "r0",  "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
>> >>>> >> >> +    "r8",  "r9",  "r10", "r11", "r12", "r13", "r14", "r15",
>> >>>> >> >> +    "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
>> >>>> >> >> +    "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
>> >>>> >> >> +};
>> >>>> >> >> +#define REG(x) (cpu_r[x])
>> >>>> >> >> +
>> >>>> >> >> +enum {
>> >>>> >> >> +    DISAS_EXIT   = DISAS_TARGET_0,  /* We want return to the
>> cpu main loop.  */
>> >>>> >> >> +    DISAS_LOOKUP = DISAS_TARGET_1,  /* We have a variable
>> condition exit.  */
>> >>>> >> >> +    DISAS_CHAIN  = DISAS_TARGET_2,  /* We have a single
>> condition exit.  */
>> >>>> >> >> +};
>> >>>> >> >> +
>> >>>> >> >> +typedef struct DisasContext DisasContext;
>> >>>> >> >> +
>> >>>> >> >> +/* This is the state at translation time. */
>> >>>> >> >> +struct DisasContext {
>> >>>> >> >> +    TranslationBlock *tb;
>> >>>> >> >> +
>> >>>> >> >> +    CPUAVRState *env;
>> >>>> >> >> +    CPUState *cs;
>> >>>> >> >> +
>> >>>> >> >> +    target_long npc;
>> >>>> >> >> +    uint32_t opcode;
>> >>>> >> >> +
>> >>>> >> >> +    /* Routine used to access memory */
>> >>>> >> >> +    int memidx;
>> >>>> >> >> +    int bstate;
>> >>>> >> >> +    int singlestep;
>> >>>> >> >> +
>> >>>> >> >> +    TCGv skip_var0;
>> >>>> >> >> +    TCGv skip_var1;
>> >>>> >> >> +    TCGCond skip_cond;
>> >>>> >> >> +    bool free_skip_var0;
>> >>>> >> >> +};
>> >>>> >> >> +
>> >>>> >> >> +static int to_A(DisasContext *ctx, int indx) { return 16 +
>> (indx % 16); }
>> >>>> >> >> +static int to_B(DisasContext *ctx, int indx) { return 16 +
>> (indx % 8); }
>> >>>> >> >> +static int to_C(DisasContext *ctx, int indx) { return 24 +
>> (indx % 4) * 2; }
>> >>>> >> >> +static int to_D(DisasContext *ctx, int indx) { return (indx %
>> 16) * 2; }
>> >>>> >> >> +
>> >>>> >> >> +static uint16_t next_word(DisasContext *ctx)
>> >>>> >> >> +{
>> >>>> >> >> +    return cpu_lduw_code(ctx->env, ctx->npc++ * 2);
>> >>>> >> >> +}
>> >>>> >> >> +
>> >>>> >> >> +static int append_16(DisasContext *ctx, int x)
>> >>>> >> >> +{
>> >>>> >> >> +    return x << 16 | next_word(ctx);
>> >>>> >> >> +}
>> >>>> >> >> +
>> >>>> >> >> +
>> >>>> >> >> +static bool avr_have_feature(DisasContext *ctx, int feature)
>> >>>> >> >> +{
>> >>>> >> >> +    if (!avr_feature(ctx->env, feature)) {
>> >>>> >> >> +        gen_helper_unsupported(cpu_env);
>> >>>> >> >> +        ctx->bstate = DISAS_NORETURN;
>> >>>> >> >> +        return false;
>> >>>> >> >> +    }
>> >>>> >> >> +    return true;
>> >>>> >> >> +}
>> >>>> >> >> +
>> >>>> >> >> +static bool decode_insn(DisasContext *ctx, uint16_t insn);
>> >>>> >> >> +#include "decode_insn.inc.c"
>> >>>> >> >> +
>> >>>> >> >> --
>> >>>> >> >> 2.17.2 (Apple Git-113)
>> >>>> >> >>
>> >>>> >>
>> >>>> >>
>> >>>> >> --
>> >>>> >> Best Regards,
>> >>>> >> Michael Rolnik
>> >>>>
>> >>>>
>> >>>>
>> >>>> --
>> >>>> Best Regards,
>> >>>> Michael Rolnik
>> >>
>> >>
>> >>
>> >> --
>> >> Best Regards,
>> >> Michael Rolnik
>>
>>
>>
>> --
>> Best Regards,
>> Michael Rolnik
>>
>

--00000000000074385c05953337a5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, October 18, 2019, Aleksandar Markovic &lt;<a href=3D"mai=
lto:aleksandar.m.mail@gmail.com">aleksandar.m.mail@gmail.com</a>&gt; wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex"><br><br>On Friday, October 18, 2019, Mic=
hael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" target=3D"_blank">mrol=
nik@gmail.com</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Fri, Oct =
18, 2019 at 4:23 PM Aleksandar Markovic<br>
&lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com" target=3D"_blank">aleksa=
ndar.m.mail@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Friday, October 18, 2019, Michael Rolnik &lt;<a href=3D"mailto:mrol=
nik@gmail.com" target=3D"_blank">mrolnik@gmail.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On Fri, Oct 18, 2019 at 11:52 AM Aleksandar Markovic &lt;<a href=
=3D"mailto:aleksandar.m.mail@gmail.com" target=3D"_blank">aleksandar.m.mail=
@gmail.com</a>&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On Thursday, October 17, 2019, Michael Rolnik &lt;<a href=3D"m=
ailto:mrolnik@gmail.com" target=3D"_blank">mrolnik@gmail.com</a>&gt; wrote:=
<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On Thu, Oct 17, 2019 at 11:17 PM Aleksandar Markovic<br>
&gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com" target=
=3D"_blank">aleksandar.m.mail@gmail.com</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +static TCGv cpu_Cf;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +static TCGv cpu_Zf;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +static TCGv cpu_Nf;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +static TCGv cpu_Vf;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +static TCGv cpu_Sf;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +static TCGv cpu_Hf;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +static TCGv cpu_Tf;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +static TCGv cpu_If;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt; Hello, Michael,<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt; Is there any particular reason or motivation=
 beyond modelling status register flags as TCGv variables?<br>
&gt;&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; I think it&#39;s easier this way as I don&#39;t n=
eed to convert flag values to<br>
&gt;&gt;&gt;&gt; &gt;&gt; bits or bits to flag values.<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; Ok. But, how do you map 0/1 flag value to the value o=
f a TCGv variable and vice versa? In other words, what value or values (out=
 of 2^32 vales) of a TCGv variable mean the flag is 1? And the same questio=
n for 0.<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; Is 0110000111000010100 one or zero?<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; Besides, in such arrangement, how do you display the =
8-bit status register in gdb, if at all?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; each flag register is either 0 or 1,....<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Michael,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; If this is true, why is there a special handling of two flags =
in the following code:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; static inline uint8_t cpu_get_sreg(CPUAVRState *env)<br>
&gt;&gt;&gt; {<br>
&gt;&gt;&gt; uint8_t sreg;<br>
&gt;&gt;&gt; sreg =3D (env-&gt;sregC &amp; 0x01) &lt;&lt; 0<br>
&gt;&gt;&gt; | (env-&gt;sregZ =3D=3D 0 ? 1 : 0) &lt;&lt; 1<br>
&gt;&gt;&gt; | (env-&gt;sregN) &lt;&lt; 2<br>
&gt;&gt;&gt; | (env-&gt;sregV) &lt;&lt; 3<br>
&gt;&gt;&gt; | (env-&gt;sregS) &lt;&lt; 4<br>
&gt;&gt;&gt; | (env-&gt;sregH) &lt;&lt; 5<br>
&gt;&gt;&gt; | (env-&gt;sregT) &lt;&lt; 6<br>
&gt;&gt;&gt; | (env-&gt;sregI) &lt;&lt; 7;<br>
&gt;&gt;&gt; return sreg;<br>
&gt;&gt;&gt; }<br>
&gt;&gt;&gt; static inline void cpu_set_sreg(CPUAVRState *env, uint8_t sreg=
)<br>
&gt;&gt;&gt; {<br>
&gt;&gt;&gt; env-&gt;sregC =3D (sreg &gt;&gt; 0) &amp; 0x01;<br>
&gt;&gt;&gt; env-&gt;sregZ =3D (sreg &gt;&gt; 1) &amp; 0x01 ? 0 : 1;<br>
&gt;&gt;&gt; env-&gt;sregN =3D (sreg &gt;&gt; 2) &amp; 0x01;<br>
&gt;&gt;&gt; env-&gt;sregV =3D (sreg &gt;&gt; 3) &amp; 0x01;<br>
&gt;&gt;&gt; env-&gt;sregS =3D (sreg &gt;&gt; 4) &amp; 0x01;<br>
&gt;&gt;&gt; env-&gt;sregH =3D (sreg &gt;&gt; 5) &amp; 0x01;<br>
&gt;&gt;&gt; env-&gt;sregT =3D (sreg &gt;&gt; 6) &amp; 0x01;<br>
&gt;&gt;&gt; env-&gt;sregI =3D (sreg &gt;&gt; 7) &amp; 0x01;<br>
&gt;&gt;&gt; }<br>
&gt;&gt;&gt;=C2=A0 ?<br>
&gt;&gt;&gt;<br>
&gt;&gt; Aleksandar,<br>
&gt;&gt;<br>
&gt;&gt; If I understand your question correctly cpu_get_sreg assembles SRE=
G value to be presented by GDB, and cpu_set_sreg sets flags values when GDB=
 modifies SREG.<br>
&gt;&gt;<br>
&gt;&gt; Michael<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span style=3D"color:=
rgb(34,34,34);font-size:14px;line-height:22.1200008392334px">Why is handlin=
g of sregC and sregZ flags different than handling of other flags? </span>T=
his contradicts your previos statement=C2=A0that 1 (in TCGv) means 1 (flag)=
, and 0 (in TCGv) means 0 (flag)?<br>
&gt;<br>
&gt;<br>
&gt; Whatever is the explanation, ot should be included, in my opinion, in =
code comments.<br>
&gt;<br>
&gt; Please, Michael, let&#39;s first clarify the issue from the question a=
bove.<br>
&gt;<br>
&gt; Thanks, Aleksandar<br>
&gt;<br>
&gt;<br>
there is a comment here<br>
<a href=3D"https://github.com/michaelrolnik/qemu-avr/blob/master/target/avr=
/cpu.h#L122-L129" target=3D"_blank">https://github.com/michaelroln<wbr>ik/q=
emu-avr/blob/master/<wbr>target/avr/cpu.h#L122-L129</a><br>
&gt;</blockquote><div><br></div><div><br></div><div>...but it does explain =
WHY of my question.</div></blockquote><div><br></div><div>I meant to say =
=C2=A0&quot;does not&quot;, not &quot;does&quot;.</div><div><br></div><div>=
Michael, don&#39;t be discouraged by lenghty review process, just be persis=
tent and available for communication with reviewers.</div><div><br></div><d=
iv>Sincerely,</div><div>Aleksandar</div><div><br></div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex"><div><br></div><div>The reason I insist on your=
 explanation is that when we model a cpu or a device in QEMU, a goal is tha=
t the model is as close to the hardware as possible. One may not, for pleto=
ra of reasons, succeed in reaching that goal, or, I can imagine, on purpose=
 depart from that goal for some reason - perhaps that was the case in your =
implementation, where you modelled a single 8-bit status register with 8 TC=
Gv variables.</div><div><br></div><div>But, even that way of modelling was =
done inconsistently across bits of the status register. In that light,=C2=
=A0I want to know the justification for that, so=C2=A0repeat my question:=
=C2=A0<span style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.1200=
008392334px">Why is handling of sregC and sregZ flags different than handli=
ng of other flags in functions=C2=A0</span>cpu_get_sreg() and=C2=A0cpu_get_=
sreg()? This was not explained in any comment or commit message. And is in =
contradiction with one of your previous answers.</div><div><br></div><div>Y=
ours,</div><div>Aleksandar</div><div>=C2=A0<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">
&gt;<br>
&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Thanks,<br>
&gt;&gt;&gt; A.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;=C2=A0 they are calculated here<br>
&gt;&gt;&gt;&gt; 1. <a href=3D"https://github.com/michaelrolnik/qemu-avr/bl=
ob/avr-v32/target/avr/translate.c#L146-L148" target=3D"_blank">https://gith=
ub.com/michaelroln<wbr>ik/qemu-avr/blob/avr-v32/<wbr>target/avr/translate.c=
#L146-<wbr>L148</a><br>
&gt;&gt;&gt;&gt; 2. <a href=3D"https://github.com/michaelrolnik/qemu-avr/bl=
ob/avr-v32/target/avr/translate.c#L166" target=3D"_blank">https://github.co=
m/michaelroln<wbr>ik/qemu-avr/blob/avr-v32/<wbr>target/avr/translate.c#L166=
</a><br>
&gt;&gt;&gt;&gt; 3. <a href=3D"https://github.com/michaelrolnik/qemu-avr/bl=
ob/avr-v32/target/avr/translate.c#L185-L187" target=3D"_blank">https://gith=
ub.com/michaelroln<wbr>ik/qemu-avr/blob/avr-v32/<wbr>target/avr/translate.c=
#L185-<wbr>L187</a><br>
&gt;&gt;&gt;&gt; 4. <a href=3D"https://github.com/michaelrolnik/qemu-avr/bl=
ob/avr-v32/target/avr/translate.c#L205" target=3D"_blank">https://github.co=
m/michaelroln<wbr>ik/qemu-avr/blob/avr-v32/<wbr>target/avr/translate.c#L205=
</a><br>
&gt;&gt;&gt;&gt; 5. <a href=3D"https://github.com/michaelrolnik/qemu-avr/bl=
ob/avr-v32/target/avr/translate.c#L214-L215" target=3D"_blank">https://gith=
ub.com/michaelroln<wbr>ik/qemu-avr/blob/avr-v32/<wbr>target/avr/translate.c=
#L214-<wbr>L215</a><br>
&gt;&gt;&gt;&gt; 6. <a href=3D"https://github.com/michaelrolnik/qemu-avr/bl=
ob/avr-v32/target/avr/translate.c#L222-L223" target=3D"_blank">https://gith=
ub.com/michaelroln<wbr>ik/qemu-avr/blob/avr-v32/<wbr>target/avr/translate.c=
#L222-<wbr>L223</a><br>
&gt;&gt;&gt;&gt; The COU itself never uses SREG at all, only the flags.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; As for the GDB it&#39;s get assembled/disassembled here<br=
>
&gt;&gt;&gt;&gt; 1. <a href=3D"https://github.com/michaelrolnik/qemu-avr/bl=
ob/avr-v32/target/avr/cpu.h#L219-L243" target=3D"_blank">https://github.com=
/michaelroln<wbr>ik/qemu-avr/blob/avr-v32/<wbr>target/avr/cpu.h#L219-L243</=
a><br>
&gt;&gt;&gt;&gt; 2. <a href=3D"https://github.com/michaelrolnik/qemu-avr/bl=
ob/avr-v32/target/avr/gdbstub.c#L35-L37" target=3D"_blank">https://github.c=
om/michaelroln<wbr>ik/qemu-avr/blob/avr-v32/<wbr>target/avr/gdbstub.c#L35-L=
37</a><br>
&gt;&gt;&gt;&gt; 3. <a href=3D"https://github.com/michaelrolnik/qemu-avr/bl=
ob/avr-v32/target/avr/gdbstub.c#L66-L68" target=3D"_blank">https://github.c=
om/michaelroln<wbr>ik/qemu-avr/blob/avr-v32/<wbr>target/avr/gdbstub.c#L66-L=
68</a><br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; A.<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt; A.<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +static TCGv cpu_rampD;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +static TCGv cpu_rampX;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +static TCGv cpu_rampY;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +static TCGv cpu_rampZ;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +static TCGv cpu_r[NO_CPU_REGISTERS];<br=
>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +static TCGv cpu_eind;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +static TCGv cpu_sp;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +static TCGv cpu_skip;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +static const char reg_names[NO_CPU_REGI=
STERS][8] =3D {<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 &quot;r0&quot;,=C2=A0 &qu=
ot;r1&quot;,=C2=A0 &quot;r2&quot;,=C2=A0 &quot;r3&quot;,=C2=A0 &quot;r4&quo=
t;,=C2=A0 &quot;r5&quot;,=C2=A0 &quot;r6&quot;,=C2=A0 &quot;r7&quot;,<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 &quot;r8&quot;,=C2=A0 &qu=
ot;r9&quot;,=C2=A0 &quot;r10&quot;, &quot;r11&quot;, &quot;r12&quot;, &quot=
;r13&quot;, &quot;r14&quot;, &quot;r15&quot;,<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 &quot;r16&quot;, &quot;r1=
7&quot;, &quot;r18&quot;, &quot;r19&quot;, &quot;r20&quot;, &quot;r21&quot;=
, &quot;r22&quot;, &quot;r23&quot;,<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 &quot;r24&quot;, &quot;r2=
5&quot;, &quot;r26&quot;, &quot;r27&quot;, &quot;r28&quot;, &quot;r29&quot;=
, &quot;r30&quot;, &quot;r31&quot;,<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +};<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +#define REG(x) (cpu_r[x])<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +enum {<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 DISAS_EXIT=C2=A0 =C2=A0=
=3D DISAS_TARGET_0,=C2=A0 /* We want return to the cpu main loop.=C2=A0 */<=
br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 DISAS_LOOKUP =3D DISAS_TA=
RGET_1,=C2=A0 /* We have a variable condition exit.=C2=A0 */<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 DISAS_CHAIN=C2=A0 =3D DIS=
AS_TARGET_2,=C2=A0 /* We have a single condition exit.=C2=A0 */<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +};<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +typedef struct DisasContext DisasContex=
t;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +/* This is the state at translation tim=
e. */<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +struct DisasContext {<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 TranslationBlock *tb;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 CPUAVRState *env;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 CPUState *cs;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 target_long npc;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 uint32_t opcode;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 /* Routine used to access=
 memory */<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 int memidx;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 int bstate;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 int singlestep;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 TCGv skip_var0;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 TCGv skip_var1;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 TCGCond skip_cond;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 bool free_skip_var0;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +};<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +static int to_A(DisasContext *ctx, int =
indx) { return 16 + (indx % 16); }<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +static int to_B(DisasContext *ctx, int =
indx) { return 16 + (indx % 8); }<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +static int to_C(DisasContext *ctx, int =
indx) { return 24 + (indx % 4) * 2; }<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +static int to_D(DisasContext *ctx, int =
indx) { return (indx % 16) * 2; }<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +static uint16_t next_word(DisasContext =
*ctx)<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +{<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 return cpu_lduw_code(ctx-=
&gt;env, ctx-&gt;npc++ * 2);<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +}<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +static int append_16(DisasContext *ctx,=
 int x)<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +{<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 return x &lt;&lt; 16 | ne=
xt_word(ctx);<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +}<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +static bool avr_have_feature(DisasConte=
xt *ctx, int feature)<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +{<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 if (!avr_feature(ctx-&gt;=
env, feature)) {<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_=
unsupported(cpu_env<wbr>);<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;bst=
ate =3D DISAS_NORETURN;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return fals=
e;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 return true;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +}<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +static bool decode_insn(DisasContext *c=
tx, uint16_t insn);<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +#include &quot;decode_insn.inc.c&quot;<=
br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; +<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; --<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt; 2.17.2 (Apple Git-113)<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; --<br>
&gt;&gt;&gt;&gt; &gt;&gt; Best Regards,<br>
&gt;&gt;&gt;&gt; &gt;&gt; Michael Rolnik<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt; Best Regards,<br>
&gt;&gt;&gt;&gt; Michael Rolnik<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Best Regards,<br>
&gt;&gt; Michael Rolnik<br>
<br>
<br>
<br>
-- <br>
Best Regards,<br>
Michael Rolnik<br>
</blockquote>
</blockquote>

--00000000000074385c05953337a5--

