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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A398CA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:24:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6ED821925
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpRSBEop"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6ED821925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLSEt-0000xi-T1
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 09:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLSDj-0008Uy-7Y
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:23:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLSDg-0000jj-NP
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:23:07 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33825)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iLSDg-0000jG-Fd
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:23:04 -0400
Received: by mail-oi1-x242.google.com with SMTP id 83so5215787oii.1
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 06:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=FUKjRXizLEC2T0MdNMCzT1NMg/J9UV+yFSq+DVzWRJg=;
 b=OpRSBEopy/XYG7M9thypZWy6wwK9xB9XOn1zVFsCSAwb5BY7yWZG3yL8DcagvZbFMk
 JHFgvZt8Flcv6UtxQhUS5ZW5AhZUffzYb4RZMLY1WCQrKN4nwqJFdLQT+S4v3S1BOq8x
 moIAw5vZVwGWgiPSO5FxlnFS+unD6Tcww6ZmSV1ldaeeMEbK355uR9T8lXaI2HCkP/6J
 557TLt03cvSfZMt5sgK0bbkmEGsdAwCx7KAJZiM2+vzOZu8rS3UpSVNsURlNQQKbf+fz
 iVMXjks7R6H76VMK/LUZi2l676Pz3A/Aq+5JPFePlT6ib7X608PzmNVqpOB+y+aQnz6d
 Z5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=FUKjRXizLEC2T0MdNMCzT1NMg/J9UV+yFSq+DVzWRJg=;
 b=rjNrhvmzNn0UhSypt5Ewx4ri2QnRJxhvSkDF1aiQSYOkzJWzV6eAQP+0I8LwzoeLuJ
 R/sEwQr4FhXfz+HK7XU2YmOOtobUQDIRQwU8xHZH3JF/DbSlwt3WXlf5w9D/UB26ts40
 Q45lCiq5neUORfkdwdmVMaJcvygJkrwcmC8vbwvWhBrdnR3cPb8VnH689gM9ZzDKsf7F
 GHD7NNWsPxrjRCq/I0QyLMYNOFddnZ7q+PsuPiyXg9ManMWVbMnkjfTf5oWM0eJfTpxf
 bEREidBvJT99SDYnJtWS+RWBU0qjYaZrNAd+ECXmVWaWrzfiDeFlEerf+QSFdw7n2ECe
 Prrw==
X-Gm-Message-State: APjAAAXDbHZEJR9LHL2KQJ2Udr7lmab0uzonLdYsQB1AfLbEgKrvWe0f
 w9hTbu6TnmbhKZ5JN3Ed4gshtKJNCFATHI2BrSFQYw==
X-Google-Smtp-Source: APXvYqz4JBxBG/OiXETJkFUVfdRQQ7OWhbPgMvmI+61wlcpYPTCT8G1SiO63RS1BaQZM+RGsv7U11aIEwnTH3UzdEes=
X-Received: by 2002:a54:460c:: with SMTP id p12mr8105383oip.62.1571404983844; 
 Fri, 18 Oct 2019 06:23:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Fri, 18 Oct 2019 06:23:03
 -0700 (PDT)
In-Reply-To: <CAK4993h6p2ZHx7a_JZhP_GE21UjfDmBJoSoBSPSo0pDwRmyK=Q@mail.gmail.com>
References: <20191014161843.84845-1-mrolnik@gmail.com>
 <20191014161843.84845-5-mrolnik@gmail.com>
 <CAL1e-=g9ER4tuqEL2ubqb7oAbatcVR8x+A0LAydSwBJEnk9_ow@mail.gmail.com>
 <CAK4993gm=8tVXyprjHPMiNZuKZRkx0iDYnXh76cQfMwUayqcWQ@mail.gmail.com>
 <CAL1e-=hGJQqVnvAu=ZJRV-AdoAWpkSvdf5ex=b7EwkodUGKpUg@mail.gmail.com>
 <CAK4993jaqFrzcmAyz7neJoq5cQgnB_o35dZhdh9_uVyOfKGG-Q@mail.gmail.com>
 <CAL1e-=ixhb1z8h9f6DrNAuEn69pPaV2qvvd=BvVnFKCdW+XMwg@mail.gmail.com>
 <CAK4993h6p2ZHx7a_JZhP_GE21UjfDmBJoSoBSPSo0pDwRmyK=Q@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 18 Oct 2019 15:23:03 +0200
Message-ID: <CAL1e-=gjP5CJ5x-e9MCw5T2-y41KuWD=CiSVecCFB1StsP5nFw@mail.gmail.com>
Subject: Re: [PATCH v32 04/13] target/avr: Add instruction translation -
 Registers definition
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000dc439d05952f3bbc"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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

--000000000000dc439d05952f3bbc
Content-Type: text/plain; charset="UTF-8"

On Friday, October 18, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

>
>
> On Fri, Oct 18, 2019 at 11:52 AM Aleksandar Markovic <
> aleksandar.m.mail@gmail.com> wrote:
>
>>
>>
>> On Thursday, October 17, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:
>>
>>> On Thu, Oct 17, 2019 at 11:17 PM Aleksandar Markovic
>>> <aleksandar.m.mail@gmail.com> wrote:
>>> >>
>>> >>
>>> >> >> +static TCGv cpu_Cf;
>>> >> >> +static TCGv cpu_Zf;
>>> >> >> +static TCGv cpu_Nf;
>>> >> >> +static TCGv cpu_Vf;
>>> >> >> +static TCGv cpu_Sf;
>>> >> >> +static TCGv cpu_Hf;
>>> >> >> +static TCGv cpu_Tf;
>>> >> >> +static TCGv cpu_If;
>>> >> >> +
>>> >> >
>>> >> >
>>> >> > Hello, Michael,
>>> >> >
>>> >> > Is there any particular reason or motivation beyond modelling
>>> status register flags as TCGv variables?
>>> >>
>>> >>
>>> >>
>>> >> I think it's easier this way as I don't need to convert flag values to
>>> >> bits or bits to flag values.
>>> >
>>> >
>>> > Ok. But, how do you map 0/1 flag value to the value of a TCGv variable
>>> and vice versa? In other words, what value or values (out of 2^32 vales) of
>>> a TCGv variable mean the flag is 1? And the same question for 0.
>>> >
>>> > Is 0110000111000010100 one or zero?
>>> >
>>> > Besides, in such arrangement, how do you display the 8-bit status
>>> register in gdb, if at all?
>>>
>>> each flag register is either 0 or 1,....
>>
>>
>>>
>>>
>> Michael,
>>
>> If this is true, why is there a special handling of two flags in the
>> following code:
>>
>>
>> static inline uint8_t cpu_get_sreg(CPUAVRState *env)
>> {
>> uint8_t sreg;
>> sreg = (env->sregC & 0x01) << 0
>> | (env->sregZ == 0 ? 1 : 0) << 1
>> | (env->sregN) << 2
>> | (env->sregV) << 3
>> | (env->sregS) << 4
>> | (env->sregH) << 5
>> | (env->sregT) << 6
>> | (env->sregI) << 7;
>> return sreg;
>> }
>> static inline void cpu_set_sreg(CPUAVRState *env, uint8_t sreg)
>> {
>> env->sregC = (sreg >> 0) & 0x01;
>> env->sregZ = (sreg >> 1) & 0x01 ? 0 : 1;
>> env->sregN = (sreg >> 2) & 0x01;
>> env->sregV = (sreg >> 3) & 0x01;
>> env->sregS = (sreg >> 4) & 0x01;
>> env->sregH = (sreg >> 5) & 0x01;
>> env->sregT = (sreg >> 6) & 0x01;
>> env->sregI = (sreg >> 7) & 0x01;
>> }
>>  ?
>>
>> Aleksandar,
>
> If I understand your question correctly cpu_get_sreg assembles SREG value
> to be presented by GDB, and cpu_set_sreg sets flags values when GDB
> modifies SREG.
>
> Michael
>


Why is handling of sregC and sregZ flags different than handling of other
flags? This contradicts your previos statement that 1 (in TCGv) means 1
(flag), and 0 (in TCGv) means 0 (flag)?


Whatever is the explanation, ot should be included, in my opinion, in code
comments.

Please, Michael, let's first clarify the issue from the question above.

Thanks, Aleksandar





>> Thanks,
>> A.
>>
>>>
>>>  they are calculated here
>>> 1. https://github.com/michaelrolnik/qemu-avr/blob/
>>> avr-v32/target/avr/translate.c#L146-L148
>>> 2. https://github.com/michaelrolnik/qemu-avr/blob/
>>> avr-v32/target/avr/translate.c#L166
>>> 3. https://github.com/michaelrolnik/qemu-avr/blob/
>>> avr-v32/target/avr/translate.c#L185-L187
>>> 4. https://github.com/michaelrolnik/qemu-avr/blob/
>>> avr-v32/target/avr/translate.c#L205
>>> 5. https://github.com/michaelrolnik/qemu-avr/blob/
>>> avr-v32/target/avr/translate.c#L214-L215
>>> 6. https://github.com/michaelrolnik/qemu-avr/blob/
>>> avr-v32/target/avr/translate.c#L222-L223
>>> The COU itself never uses SREG at all, only the flags.
>>>
>>> As for the GDB it's get assembled/disassembled here
>>> 1. https://github.com/michaelrolnik/qemu-avr/blob/
>>> avr-v32/target/avr/cpu.h#L219-L243
>>> 2. https://github.com/michaelrolnik/qemu-avr/blob/
>>> avr-v32/target/avr/gdbstub.c#L35-L37
>>> 3. https://github.com/michaelrolnik/qemu-avr/blob/
>>> avr-v32/target/avr/gdbstub.c#L66-L68
>>>
>>> >
>>> > A.
>>> >
>>> >>
>>> >> >
>>> >> > A.
>>> >> >
>>> >> >
>>> >> >
>>> >> >>
>>> >> >> +static TCGv cpu_rampD;
>>> >> >> +static TCGv cpu_rampX;
>>> >> >> +static TCGv cpu_rampY;
>>> >> >> +static TCGv cpu_rampZ;
>>> >> >> +
>>> >> >> +static TCGv cpu_r[NO_CPU_REGISTERS];
>>> >> >> +static TCGv cpu_eind;
>>> >> >> +static TCGv cpu_sp;
>>> >> >> +
>>> >> >> +static TCGv cpu_skip;
>>> >> >> +
>>> >> >> +static const char reg_names[NO_CPU_REGISTERS][8] = {
>>> >> >> +    "r0",  "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
>>> >> >> +    "r8",  "r9",  "r10", "r11", "r12", "r13", "r14", "r15",
>>> >> >> +    "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
>>> >> >> +    "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
>>> >> >> +};
>>> >> >> +#define REG(x) (cpu_r[x])
>>> >> >> +
>>> >> >> +enum {
>>> >> >> +    DISAS_EXIT   = DISAS_TARGET_0,  /* We want return to the cpu
>>> main loop.  */
>>> >> >> +    DISAS_LOOKUP = DISAS_TARGET_1,  /* We have a variable
>>> condition exit.  */
>>> >> >> +    DISAS_CHAIN  = DISAS_TARGET_2,  /* We have a single condition
>>> exit.  */
>>> >> >> +};
>>> >> >> +
>>> >> >> +typedef struct DisasContext DisasContext;
>>> >> >> +
>>> >> >> +/* This is the state at translation time. */
>>> >> >> +struct DisasContext {
>>> >> >> +    TranslationBlock *tb;
>>> >> >> +
>>> >> >> +    CPUAVRState *env;
>>> >> >> +    CPUState *cs;
>>> >> >> +
>>> >> >> +    target_long npc;
>>> >> >> +    uint32_t opcode;
>>> >> >> +
>>> >> >> +    /* Routine used to access memory */
>>> >> >> +    int memidx;
>>> >> >> +    int bstate;
>>> >> >> +    int singlestep;
>>> >> >> +
>>> >> >> +    TCGv skip_var0;
>>> >> >> +    TCGv skip_var1;
>>> >> >> +    TCGCond skip_cond;
>>> >> >> +    bool free_skip_var0;
>>> >> >> +};
>>> >> >> +
>>> >> >> +static int to_A(DisasContext *ctx, int indx) { return 16 + (indx
>>> % 16); }
>>> >> >> +static int to_B(DisasContext *ctx, int indx) { return 16 + (indx
>>> % 8); }
>>> >> >> +static int to_C(DisasContext *ctx, int indx) { return 24 + (indx
>>> % 4) * 2; }
>>> >> >> +static int to_D(DisasContext *ctx, int indx) { return (indx % 16)
>>> * 2; }
>>> >> >> +
>>> >> >> +static uint16_t next_word(DisasContext *ctx)
>>> >> >> +{
>>> >> >> +    return cpu_lduw_code(ctx->env, ctx->npc++ * 2);
>>> >> >> +}
>>> >> >> +
>>> >> >> +static int append_16(DisasContext *ctx, int x)
>>> >> >> +{
>>> >> >> +    return x << 16 | next_word(ctx);
>>> >> >> +}
>>> >> >> +
>>> >> >> +
>>> >> >> +static bool avr_have_feature(DisasContext *ctx, int feature)
>>> >> >> +{
>>> >> >> +    if (!avr_feature(ctx->env, feature)) {
>>> >> >> +        gen_helper_unsupported(cpu_env);
>>> >> >> +        ctx->bstate = DISAS_NORETURN;
>>> >> >> +        return false;
>>> >> >> +    }
>>> >> >> +    return true;
>>> >> >> +}
>>> >> >> +
>>> >> >> +static bool decode_insn(DisasContext *ctx, uint16_t insn);
>>> >> >> +#include "decode_insn.inc.c"
>>> >> >> +
>>> >> >> --
>>> >> >> 2.17.2 (Apple Git-113)
>>> >> >>
>>> >>
>>> >>
>>> >> --
>>> >> Best Regards,
>>> >> Michael Rolnik
>>>
>>>
>>>
>>> --
>>> Best Regards,
>>> Michael Rolnik
>>>
>>
>
> --
> Best Regards,
> Michael Rolnik
>

--000000000000dc439d05952f3bbc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, October 18, 2019, Michael Rolnik &lt;<a href=3D"mailto:m=
rolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 18, 2019 at 11:=
52 AM Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com=
" target=3D"_blank">aleksandar.m.mail@gmail.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><br><br>On Thursday, October=
 17, 2019, Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" target=
=3D"_blank">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">On Thu, Oct 17, 2019 at 11:17 PM Aleksandar Markovic=
<br>
&lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com" target=3D"_blank">aleksa=
ndar.m.mail@gmail.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; &gt;&gt; +static TCGv cpu_Cf;<br>
&gt;&gt; &gt;&gt; +static TCGv cpu_Zf;<br>
&gt;&gt; &gt;&gt; +static TCGv cpu_Nf;<br>
&gt;&gt; &gt;&gt; +static TCGv cpu_Vf;<br>
&gt;&gt; &gt;&gt; +static TCGv cpu_Sf;<br>
&gt;&gt; &gt;&gt; +static TCGv cpu_Hf;<br>
&gt;&gt; &gt;&gt; +static TCGv cpu_Tf;<br>
&gt;&gt; &gt;&gt; +static TCGv cpu_If;<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Hello, Michael,<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Is there any particular reason or motivation beyond modelling=
 status register flags as TCGv variables?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; I think it&#39;s easier this way as I don&#39;t need to convert fl=
ag values to<br>
&gt;&gt; bits or bits to flag values.<br>
&gt;<br>
&gt;<br>
&gt; Ok. But, how do you map 0/1 flag value to the value of a TCGv variable=
 and vice versa? In other words, what value or values (out of 2^32 vales) o=
f a TCGv variable mean the flag is 1? And the same question for 0.<br>
&gt;<br>
&gt; Is 0110000111000010100 one or zero?<br>
&gt;<br>
&gt; Besides, in such arrangement, how do you display the 8-bit status regi=
ster in gdb, if at all?<br>
<br>
each flag register is either 0 or 1,....</blockquote><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex"><br></blockquote><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex"><br></blockquote><div><br></div><div>Michael,</div><div=
><br></div><div>If this is true, why is there a special handling of two fla=
gs in the following code:</div><div><br></div><div><br></div><div><table st=
yle=3D"border-spacing:0px;border-collapse:collapse;color:rgb(36,41,46);font=
-family:-apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Helvetica,Ari=
al,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;;font=
-size:14px;line-height:21px"><tbody><tr><td style=3D"padding:0px 10px;line-=
height:20px;vertical-align:top;overflow:visible;font-family:SFMono-Regular,=
Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;white-s=
pace:pre-wrap"><span style=3D"color:rgb(215,58,73)">static</span> <span sty=
le=3D"color:rgb(215,58,73)">inline</span> <span style=3D"color:rgb(0,92,197=
)">uint8_t</span> <span style=3D"color:rgb(111,66,193)">cpu_get_sreg</span>=
(CPUAVRState *env)</td></tr><tr><td style=3D"padding:0px 10px;width:50px;mi=
n-width:50px;font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot=
;,Menlo,monospace;font-size:12px;line-height:20px;color:rgba(27,31,35,0.298=
);text-align:right;white-space:nowrap;vertical-align:top"></td><td style=3D=
"padding:0px 10px;line-height:20px;vertical-align:top;overflow:visible;font=
-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace=
;font-size:12px;white-space:pre-wrap">{</td></tr><tr><td style=3D"padding:0=
px 10px;width:50px;min-width:50px;font-family:SFMono-Regular,Consolas,&quot=
;Liberation Mono&quot;,Menlo,monospace;font-size:12px;line-height:20px;colo=
r:rgba(27,31,35,0.298);text-align:right;white-space:nowrap;vertical-align:t=
op"></td><td style=3D"padding:0px 10px;line-height:20px;vertical-align:top;=
overflow:visible;font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&=
quot;,Menlo,monospace;font-size:12px;white-space:pre-wrap">    <span style=
=3D"color:rgb(0,92,197)">uint8_t</span> sreg;</td></tr><tr><td style=3D"pad=
ding:0px 10px;width:50px;min-width:50px;font-family:SFMono-Regular,Consolas=
,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;line-height:20p=
x;color:rgba(27,31,35,0.298);text-align:right;white-space:nowrap;vertical-a=
lign:top"></td><td style=3D"padding:0px 10px;line-height:20px;vertical-alig=
n:top;overflow:visible;font-family:SFMono-Regular,Consolas,&quot;Liberation=
 Mono&quot;,Menlo,monospace;font-size:12px;white-space:pre-wrap">    sreg =
=3D (env-&gt;<span>sregC</span> &amp; <span style=3D"color:rgb(0,92,197)">0=
x01</span>) &lt;&lt; <span style=3D"color:rgb(0,92,197)">0</span></td></tr>=
<tr><td style=3D"padding:0px 10px;width:50px;min-width:50px;font-family:SFM=
ono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:=
12px;line-height:20px;color:rgba(27,31,35,0.298);text-align:right;white-spa=
ce:nowrap;vertical-align:top"></td><td style=3D"padding:0px 10px;line-heigh=
t:20px;vertical-align:top;overflow:visible;font-family:SFMono-Regular,Conso=
las,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;white-space:=
pre-wrap">         | (env-&gt;<span>sregZ</span> =3D=3D <span style=3D"colo=
r:rgb(0,92,197)">0</span> ? <span style=3D"color:rgb(0,92,197)">1</span> : =
<span style=3D"color:rgb(0,92,197)">0</span>) &lt;&lt; <span style=3D"color=
:rgb(0,92,197)">1</span></td></tr><tr><td style=3D"padding:0px 10px;width:5=
0px;min-width:50px;font-family:SFMono-Regular,Consolas,&quot;Liberation Mon=
o&quot;,Menlo,monospace;font-size:12px;line-height:20px;color:rgba(27,31,35=
,0.298);text-align:right;white-space:nowrap;vertical-align:top"></td><td st=
yle=3D"padding:0px 10px;line-height:20px;vertical-align:top;overflow:visibl=
e;font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,mon=
ospace;font-size:12px;white-space:pre-wrap">         | (env-&gt;<span>sregN=
</span>) &lt;&lt; <span style=3D"color:rgb(0,92,197)">2</span></td></tr><tr=
><td style=3D"padding:0px 10px;width:50px;min-width:50px;font-family:SFMono=
-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12p=
x;line-height:20px;color:rgba(27,31,35,0.298);text-align:right;white-space:=
nowrap;vertical-align:top"></td><td style=3D"padding:0px 10px;line-height:2=
0px;vertical-align:top;overflow:visible;font-family:SFMono-Regular,Consolas=
,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;white-space:pre=
-wrap">         | (env-&gt;<span>sregV</span>) &lt;&lt; <span style=3D"colo=
r:rgb(0,92,197)">3</span></td></tr><tr><td style=3D"padding:0px 10px;width:=
50px;min-width:50px;font-family:SFMono-Regular,Consolas,&quot;Liberation Mo=
no&quot;,Menlo,monospace;font-size:12px;line-height:20px;color:rgba(27,31,3=
5,0.298);text-align:right;white-space:nowrap;vertical-align:top"></td><td s=
tyle=3D"padding:0px 10px;line-height:20px;vertical-align:top;overflow:visib=
le;font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,mo=
nospace;font-size:12px;white-space:pre-wrap">         | (env-&gt;<span>sreg=
S</span>) &lt;&lt; <span style=3D"color:rgb(0,92,197)">4</span></td></tr><t=
r><td style=3D"padding:0px 10px;width:50px;min-width:50px;font-family:SFMon=
o-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12=
px;line-height:20px;color:rgba(27,31,35,0.298);text-align:right;white-space=
:nowrap;vertical-align:top"></td><td style=3D"padding:0px 10px;line-height:=
20px;vertical-align:top;overflow:visible;font-family:SFMono-Regular,Consola=
s,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;white-space:pr=
e-wrap">         | (env-&gt;<span>sregH</span>) &lt;&lt; <span style=3D"col=
or:rgb(0,92,197)">5</span></td></tr><tr><td style=3D"padding:0px 10px;width=
:50px;min-width:50px;font-family:SFMono-Regular,Consolas,&quot;Liberation M=
ono&quot;,Menlo,monospace;font-size:12px;line-height:20px;color:rgba(27,31,=
35,0.298);text-align:right;white-space:nowrap;vertical-align:top"></td><td =
style=3D"padding:0px 10px;line-height:20px;vertical-align:top;overflow:visi=
ble;font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,m=
onospace;font-size:12px;white-space:pre-wrap">         | (env-&gt;<span>sre=
gT</span>) &lt;&lt; <span style=3D"color:rgb(0,92,197)">6</span></td></tr><=
tr><td style=3D"padding:0px 10px;width:50px;min-width:50px;font-family:SFMo=
no-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:1=
2px;line-height:20px;color:rgba(27,31,35,0.298);text-align:right;white-spac=
e:nowrap;vertical-align:top"></td><td style=3D"padding:0px 10px;line-height=
:20px;vertical-align:top;overflow:visible;font-family:SFMono-Regular,Consol=
as,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;white-space:p=
re-wrap">         | (env-&gt;<span>sregI</span>) &lt;&lt; <span style=3D"co=
lor:rgb(0,92,197)">7</span>;</td></tr><tr><td style=3D"padding:0px 10px;wid=
th:50px;min-width:50px;font-family:SFMono-Regular,Consolas,&quot;Liberation=
 Mono&quot;,Menlo,monospace;font-size:12px;line-height:20px;color:rgba(27,3=
1,35,0.298);text-align:right;white-space:nowrap;vertical-align:top"></td><t=
d style=3D"padding:0px 10px;line-height:20px;vertical-align:top;overflow:vi=
sible;font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo=
,monospace;font-size:12px;white-space:pre-wrap">    <span style=3D"color:rg=
b(215,58,73)">return</span> sreg;</td></tr><tr><td style=3D"padding:0px 10p=
x;width:50px;min-width:50px;font-family:SFMono-Regular,Consolas,&quot;Liber=
ation Mono&quot;,Menlo,monospace;font-size:12px;line-height:20px;color:rgba=
(27,31,35,0.298);text-align:right;white-space:nowrap;vertical-align:top"></=
td><td style=3D"padding:0px 10px;line-height:20px;vertical-align:top;overfl=
ow:visible;font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,=
Menlo,monospace;font-size:12px;white-space:pre-wrap">}</td></tr><tr><td sty=
le=3D"padding:0px 10px;width:50px;min-width:50px;font-family:SFMono-Regular=
,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;line-h=
eight:20px;color:rgba(27,31,35,0.298);text-align:right;white-space:nowrap;v=
ertical-align:top"></td><td style=3D"padding:0px 10px;line-height:20px;vert=
ical-align:top;overflow:visible;font-family:SFMono-Regular,Consolas,&quot;L=
iberation Mono&quot;,Menlo,monospace;font-size:12px;white-space:pre-wrap">
</td></tr><tr><td style=3D"padding:0px 10px;width:50px;min-width:50px;font-=
family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;=
font-size:12px;line-height:20px;color:rgba(27,31,35,0.298);text-align:right=
;white-space:nowrap;vertical-align:top"></td><td style=3D"padding:0px 10px;=
line-height:20px;vertical-align:top;overflow:visible;font-family:SFMono-Reg=
ular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;wh=
ite-space:pre-wrap"><span style=3D"color:rgb(215,58,73)">static</span> <spa=
n style=3D"color:rgb(215,58,73)">inline</span> <span style=3D"color:rgb(215=
,58,73)">void</span> <span style=3D"color:rgb(111,66,193)">cpu_set_sreg</sp=
an>(CPUAVRState *env, <span style=3D"color:rgb(0,92,197)">uint8_t</span> sr=
eg)</td></tr><tr><td style=3D"padding:0px 10px;width:50px;min-width:50px;fo=
nt-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospa=
ce;font-size:12px;line-height:20px;color:rgba(27,31,35,0.298);text-align:ri=
ght;white-space:nowrap;vertical-align:top"></td><td style=3D"padding:0px 10=
px;line-height:20px;vertical-align:top;overflow:visible;font-family:SFMono-=
Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px=
;white-space:pre-wrap">{</td></tr><tr><td style=3D"padding:0px 10px;width:5=
0px;min-width:50px;font-family:SFMono-Regular,Consolas,&quot;Liberation Mon=
o&quot;,Menlo,monospace;font-size:12px;line-height:20px;color:rgba(27,31,35=
,0.298);text-align:right;white-space:nowrap;vertical-align:top"></td><td st=
yle=3D"padding:0px 10px;line-height:20px;vertical-align:top;overflow:visibl=
e;font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,mon=
ospace;font-size:12px;white-space:pre-wrap">    env-&gt;<span>sregC</span> =
=3D (sreg &gt;&gt; <span style=3D"color:rgb(0,92,197)">0</span>) &amp; <spa=
n style=3D"color:rgb(0,92,197)">0x01</span>;</td></tr><tr><td style=3D"padd=
ing:0px 10px;width:50px;min-width:50px;font-family:SFMono-Regular,Consolas,=
&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;line-height:20px=
;color:rgba(27,31,35,0.298);text-align:right;white-space:nowrap;vertical-al=
ign:top"></td><td style=3D"padding:0px 10px;line-height:20px;vertical-align=
:top;overflow:visible;font-family:SFMono-Regular,Consolas,&quot;Liberation =
Mono&quot;,Menlo,monospace;font-size:12px;white-space:pre-wrap">    env-&gt=
;<span>sregZ</span> =3D (sreg &gt;&gt; <span style=3D"color:rgb(0,92,197)">=
1</span>) &amp; <span style=3D"color:rgb(0,92,197)">0x01</span> ? <span sty=
le=3D"color:rgb(0,92,197)">0</span> : <span style=3D"color:rgb(0,92,197)">1=
</span>;</td></tr><tr><td style=3D"padding:0px 10px;width:50px;min-width:50=
px;font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,mo=
nospace;font-size:12px;line-height:20px;color:rgba(27,31,35,0.298);text-ali=
gn:right;white-space:nowrap;vertical-align:top"></td><td style=3D"padding:0=
px 10px;line-height:20px;vertical-align:top;overflow:visible;font-family:SF=
Mono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size=
:12px;white-space:pre-wrap">    env-&gt;<span>sregN</span> =3D (sreg &gt;&g=
t; <span style=3D"color:rgb(0,92,197)">2</span>) &amp; <span style=3D"color=
:rgb(0,92,197)">0x01</span>;</td></tr><tr><td style=3D"padding:0px 10px;wid=
th:50px;min-width:50px;font-family:SFMono-Regular,Consolas,&quot;Liberation=
 Mono&quot;,Menlo,monospace;font-size:12px;line-height:20px;color:rgba(27,3=
1,35,0.298);text-align:right;white-space:nowrap;vertical-align:top"></td><t=
d style=3D"padding:0px 10px;line-height:20px;vertical-align:top;overflow:vi=
sible;font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo=
,monospace;font-size:12px;white-space:pre-wrap">    env-&gt;<span>sregV</sp=
an> =3D (sreg &gt;&gt; <span style=3D"color:rgb(0,92,197)">3</span>) &amp; =
<span style=3D"color:rgb(0,92,197)">0x01</span>;</td></tr><tr><td style=3D"=
padding:0px 10px;width:50px;min-width:50px;font-family:SFMono-Regular,Conso=
las,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;line-height:=
20px;color:rgba(27,31,35,0.298);text-align:right;white-space:nowrap;vertica=
l-align:top"></td><td style=3D"padding:0px 10px;line-height:20px;vertical-a=
lign:top;overflow:visible;font-family:SFMono-Regular,Consolas,&quot;Liberat=
ion Mono&quot;,Menlo,monospace;font-size:12px;white-space:pre-wrap">    env=
-&gt;<span>sregS</span> =3D (sreg &gt;&gt; <span style=3D"color:rgb(0,92,19=
7)">4</span>) &amp; <span style=3D"color:rgb(0,92,197)">0x01</span>;</td></=
tr><tr><td style=3D"padding:0px 10px;width:50px;min-width:50px;font-family:=
SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-si=
ze:12px;line-height:20px;color:rgba(27,31,35,0.298);text-align:right;white-=
space:nowrap;vertical-align:top"></td><td style=3D"padding:0px 10px;line-he=
ight:20px;vertical-align:top;overflow:visible;font-family:SFMono-Regular,Co=
nsolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;white-spa=
ce:pre-wrap">    env-&gt;<span>sregH</span> =3D (sreg &gt;&gt; <span style=
=3D"color:rgb(0,92,197)">5</span>) &amp; <span style=3D"color:rgb(0,92,197)=
">0x01</span>;</td></tr><tr><td style=3D"padding:0px 10px;width:50px;min-wi=
dth:50px;font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Me=
nlo,monospace;font-size:12px;line-height:20px;color:rgba(27,31,35,0.298);te=
xt-align:right;white-space:nowrap;vertical-align:top"></td><td style=3D"pad=
ding:0px 10px;line-height:20px;vertical-align:top;overflow:visible;font-fam=
ily:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;fon=
t-size:12px;white-space:pre-wrap">    env-&gt;<span>sregT</span> =3D (sreg =
&gt;&gt; <span style=3D"color:rgb(0,92,197)">6</span>) &amp; <span style=3D=
"color:rgb(0,92,197)">0x01</span>;</td></tr><tr><td style=3D"padding:0px 10=
px;width:50px;min-width:50px;font-family:SFMono-Regular,Consolas,&quot;Libe=
ration Mono&quot;,Menlo,monospace;font-size:12px;line-height:20px;color:rgb=
a(27,31,35,0.298);text-align:right;white-space:nowrap;vertical-align:top"><=
/td><td style=3D"padding:0px 10px;line-height:20px;vertical-align:top;overf=
low:visible;font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;=
,Menlo,monospace;font-size:12px;white-space:pre-wrap">    env-&gt;<span>sre=
gI</span> =3D (sreg &gt;&gt; <span style=3D"color:rgb(0,92,197)">7</span>) =
&amp; <span style=3D"color:rgb(0,92,197)">0x01</span>;</td></tr><tr><td sty=
le=3D"padding:0px 10px;width:50px;min-width:50px;font-family:SFMono-Regular=
,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;line-h=
eight:20px;color:rgba(27,31,35,0.298);text-align:right;white-space:nowrap;v=
ertical-align:top"></td><td style=3D"padding:0px 10px;line-height:20px;vert=
ical-align:top;overflow:visible;font-family:SFMono-Regular,Consolas,&quot;L=
iberation Mono&quot;,Menlo,monospace;font-size:12px;white-space:pre-wrap">}=
</td></tr></tbody></table></div><div>=C2=A0?</div><div><br></div></blockquo=
te><div>Aleksandar,</div><div><br></div><div>If I understand your question =
correctly=C2=A0cpu_get_sreg assembles SREG value to be presented by GDB, an=
d=C2=A0cpu_set_sreg sets flags values when GDB modifies SREG.</div><div><br=
></div><div>Michael</div></div></div></blockquote><div><br></div><div><br><=
/div><div>Why is handling of sregC and sregZ flags different than handling =
of other flags? This contradicts your previos statement that 1 (in TCGv) me=
ans 1 (flag), and 0 (in TCGv) means 0 (flag)?</div><div><br></div><div><br>=
</div><div>Whatever is the explanation, ot should be included, in my opinio=
n, in code comments.</div><div><br></div><div>Please, Michael, let&#39;s fi=
rst clarify the issue from the question above.</div><div><br></div><div>Tha=
nks, Aleksandar</div><div><br></div><div><br></div><div><br></div><div><br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_q=
uote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><div></div><div><br=
></div><div>Thanks,</div><div>A.</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex"><br></blockquote><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">=C2=A0they are calculated here<br>
1. <a href=3D"https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target=
/avr/translate.c#L146-L148" target=3D"_blank">https://github.com/<wbr>micha=
elrolnik/qemu-avr/blob/<wbr>avr-v32/target/avr/translate.<wbr>c#L146-L148</=
a><br>
2. <a href=3D"https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target=
/avr/translate.c#L166" target=3D"_blank">https://github.com/<wbr>michaelrol=
nik/qemu-avr/blob/<wbr>avr-v32/target/avr/translate.<wbr>c#L166</a><br>
3. <a href=3D"https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target=
/avr/translate.c#L185-L187" target=3D"_blank">https://github.com/<wbr>micha=
elrolnik/qemu-avr/blob/<wbr>avr-v32/target/avr/translate.<wbr>c#L185-L187</=
a><br>
4. <a href=3D"https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target=
/avr/translate.c#L205" target=3D"_blank">https://github.com/<wbr>michaelrol=
nik/qemu-avr/blob/<wbr>avr-v32/target/avr/translate.<wbr>c#L205</a><br>
5. <a href=3D"https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target=
/avr/translate.c#L214-L215" target=3D"_blank">https://github.com/<wbr>micha=
elrolnik/qemu-avr/blob/<wbr>avr-v32/target/avr/translate.<wbr>c#L214-L215</=
a><br>
6. <a href=3D"https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target=
/avr/translate.c#L222-L223" target=3D"_blank">https://github.com/<wbr>micha=
elrolnik/qemu-avr/blob/<wbr>avr-v32/target/avr/translate.<wbr>c#L222-L223</=
a><br>
The COU itself never uses SREG at all, only the flags.<br>
<br>
As for the GDB it&#39;s get assembled/disassembled here<br>
1. <a href=3D"https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target=
/avr/cpu.h#L219-L243" target=3D"_blank">https://github.com/<wbr>michaelroln=
ik/qemu-avr/blob/<wbr>avr-v32/target/avr/cpu.h#L219-<wbr>L243</a><br>
2. <a href=3D"https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target=
/avr/gdbstub.c#L35-L37" target=3D"_blank">https://github.com/<wbr>michaelro=
lnik/qemu-avr/blob/<wbr>avr-v32/target/avr/gdbstub.c#<wbr>L35-L37</a><br>
3. <a href=3D"https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target=
/avr/gdbstub.c#L66-L68" target=3D"_blank">https://github.com/<wbr>michaelro=
lnik/qemu-avr/blob/<wbr>avr-v32/target/avr/gdbstub.c#<wbr>L66-L68</a><br>
<br>
&gt;<br>
&gt; A.<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; A.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; +static TCGv cpu_rampD;<br>
&gt;&gt; &gt;&gt; +static TCGv cpu_rampX;<br>
&gt;&gt; &gt;&gt; +static TCGv cpu_rampY;<br>
&gt;&gt; &gt;&gt; +static TCGv cpu_rampZ;<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +static TCGv cpu_r[NO_CPU_REGISTERS];<br>
&gt;&gt; &gt;&gt; +static TCGv cpu_eind;<br>
&gt;&gt; &gt;&gt; +static TCGv cpu_sp;<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +static TCGv cpu_skip;<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +static const char reg_names[NO_CPU_REGISTERS][8] =3D {<b=
r>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 &quot;r0&quot;,=C2=A0 &quot;r1&quot;,=C2=
=A0 &quot;r2&quot;,=C2=A0 &quot;r3&quot;,=C2=A0 &quot;r4&quot;,=C2=A0 &quot=
;r5&quot;,=C2=A0 &quot;r6&quot;,=C2=A0 &quot;r7&quot;,<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 &quot;r8&quot;,=C2=A0 &quot;r9&quot;,=C2=
=A0 &quot;r10&quot;, &quot;r11&quot;, &quot;r12&quot;, &quot;r13&quot;, &qu=
ot;r14&quot;, &quot;r15&quot;,<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 &quot;r16&quot;, &quot;r17&quot;, &quot;r1=
8&quot;, &quot;r19&quot;, &quot;r20&quot;, &quot;r21&quot;, &quot;r22&quot;=
, &quot;r23&quot;,<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 &quot;r24&quot;, &quot;r25&quot;, &quot;r2=
6&quot;, &quot;r27&quot;, &quot;r28&quot;, &quot;r29&quot;, &quot;r30&quot;=
, &quot;r31&quot;,<br>
&gt;&gt; &gt;&gt; +};<br>
&gt;&gt; &gt;&gt; +#define REG(x) (cpu_r[x])<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +enum {<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 DISAS_EXIT=C2=A0 =C2=A0=3D DISAS_TARGET_0,=
=C2=A0 /* We want return to the cpu main loop.=C2=A0 */<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 DISAS_LOOKUP =3D DISAS_TARGET_1,=C2=A0 /* =
We have a variable condition exit.=C2=A0 */<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 DISAS_CHAIN=C2=A0 =3D DISAS_TARGET_2,=C2=
=A0 /* We have a single condition exit.=C2=A0 */<br>
&gt;&gt; &gt;&gt; +};<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +typedef struct DisasContext DisasContext;<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +/* This is the state at translation time. */<br>
&gt;&gt; &gt;&gt; +struct DisasContext {<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 TranslationBlock *tb;<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 CPUAVRState *env;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 CPUState *cs;<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 target_long npc;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 uint32_t opcode;<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 /* Routine used to access memory */<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 int memidx;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 int bstate;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 int singlestep;<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 TCGv skip_var0;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 TCGv skip_var1;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 TCGCond skip_cond;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 bool free_skip_var0;<br>
&gt;&gt; &gt;&gt; +};<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +static int to_A(DisasContext *ctx, int indx) { return 16=
 + (indx % 16); }<br>
&gt;&gt; &gt;&gt; +static int to_B(DisasContext *ctx, int indx) { return 16=
 + (indx % 8); }<br>
&gt;&gt; &gt;&gt; +static int to_C(DisasContext *ctx, int indx) { return 24=
 + (indx % 4) * 2; }<br>
&gt;&gt; &gt;&gt; +static int to_D(DisasContext *ctx, int indx) { return (i=
ndx % 16) * 2; }<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +static uint16_t next_word(DisasContext *ctx)<br>
&gt;&gt; &gt;&gt; +{<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 return cpu_lduw_code(ctx-&gt;env, ctx-&gt;=
npc++ * 2);<br>
&gt;&gt; &gt;&gt; +}<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +static int append_16(DisasContext *ctx, int x)<br>
&gt;&gt; &gt;&gt; +{<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 return x &lt;&lt; 16 | next_word(ctx);<br>
&gt;&gt; &gt;&gt; +}<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +static bool avr_have_feature(DisasContext *ctx, int feat=
ure)<br>
&gt;&gt; &gt;&gt; +{<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 if (!avr_feature(ctx-&gt;env, feature)) {<=
br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_unsupported(cpu_<=
wbr>env);<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;bstate =3D DISAS_NOR=
ETURN;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 return true;<br>
&gt;&gt; &gt;&gt; +}<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +static bool decode_insn(DisasContext *ctx, uint16_t insn=
);<br>
&gt;&gt; &gt;&gt; +#include &quot;decode_insn.inc.c&quot;<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; --<br>
&gt;&gt; &gt;&gt; 2.17.2 (Apple Git-113)<br>
&gt;&gt; &gt;&gt;<br>
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
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
>Best Regards,<br>Michael Rolnik</div></div>
</blockquote>

--000000000000dc439d05952f3bbc--

