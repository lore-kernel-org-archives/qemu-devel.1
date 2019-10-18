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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A73CCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 11:29:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F2421925
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 11:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W32eWzVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F2421925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLQRe-0001h5-Rf
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 07:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iLQQU-0001Fg-Nj
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 07:28:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iLQQS-0003iz-Dc
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 07:28:10 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:43913)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iLQQS-0003id-4d
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 07:28:08 -0400
Received: by mail-qk1-x741.google.com with SMTP id a194so816676qkg.10
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 04:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Lqg9851nHMR6g0HNW2liNzxVLiL4MAlvtqs/o/m9tXo=;
 b=W32eWzVBtH0+akV210cQHCzRhWAiupGHcUCqhOvtifLLzhAN7sTgs3WPTiWo03VjG4
 a6RacfsUGJ6hDGPBSes/rDYCcAAW5PUhRRjSiNy6pTDu+VwE6P+mwdl1y/vHQMexttyr
 b538fInrOyrLFubqTTlfYE0SI4zead84KohbCKgweQj8BKoq6rMmO2nRM4VwbLfNvnIk
 xyjSf354X6mcAM5hxqxS+cGfJoQ5MnWiJkPNgJPmJbt1sQsYruH186ngn1e7Hc2xzU9/
 i0pVFLJpJPZcxS6Rii9pRXZ4UOxlVDGF52GZ8TkvXTrIVanTIsG7qeGiTwk5z//rn1Xh
 KQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Lqg9851nHMR6g0HNW2liNzxVLiL4MAlvtqs/o/m9tXo=;
 b=OWBigE3UEz9ksF1g4dDl1TFABNicZhHOboBaUtkKE7FVv/iRZt6igCA2LeYzs6cR2F
 +lBdkZ+badTm1npppz4eqB3RL94hLcjATrDlF6Mt9BtLjioqvY+VooWgnt197N5QOmDa
 tnAAyi/15xnG4r3VRJG7vi1bHUScQobTGRqeA5+o2I9rRrxDzcSbm2a2Syez975Q7JoD
 SQYaXByE8pFvA5cT7QHf3u08wE4J/vooY1mVEvvmiigl2ypdlvAZK4D6IbtoEQlcPjPH
 uTz7ASutpK+2Yq1NNag9J2W7DZua62MoI5us+PIrZriSHm82sD3ftdjv+3YTT8/Nq897
 cRYg==
X-Gm-Message-State: APjAAAWGD7QHokVbzht0OcbQGMdKBk/KrzknA0DDt5ifqKnaWeP72vgv
 RrBFOWNJ4ecFDUkqXiAGSwXF8A4nPPlzfapz9j8=
X-Google-Smtp-Source: APXvYqyTGJS2R1hfwWjCThfU2X0b8w01UgmOASyiPk/KbxVw5Qwg71ka9OOR+GKZJd/PgTqZqIiAFpgF0p8mnf+kbfQ=
X-Received: by 2002:a37:a646:: with SMTP id p67mr7685168qke.489.1571398087018; 
 Fri, 18 Oct 2019 04:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191014161843.84845-1-mrolnik@gmail.com>
 <20191014161843.84845-5-mrolnik@gmail.com>
 <CAL1e-=g9ER4tuqEL2ubqb7oAbatcVR8x+A0LAydSwBJEnk9_ow@mail.gmail.com>
 <CAK4993gm=8tVXyprjHPMiNZuKZRkx0iDYnXh76cQfMwUayqcWQ@mail.gmail.com>
 <CAL1e-=hGJQqVnvAu=ZJRV-AdoAWpkSvdf5ex=b7EwkodUGKpUg@mail.gmail.com>
 <CAK4993jaqFrzcmAyz7neJoq5cQgnB_o35dZhdh9_uVyOfKGG-Q@mail.gmail.com>
 <CAL1e-=ixhb1z8h9f6DrNAuEn69pPaV2qvvd=BvVnFKCdW+XMwg@mail.gmail.com>
In-Reply-To: <CAL1e-=ixhb1z8h9f6DrNAuEn69pPaV2qvvd=BvVnFKCdW+XMwg@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Fri, 18 Oct 2019 14:27:12 +0300
Message-ID: <CAK4993h6p2ZHx7a_JZhP_GE21UjfDmBJoSoBSPSo0pDwRmyK=Q@mail.gmail.com>
Subject: Re: [PATCH v32 04/13] target/avr: Add instruction translation -
 Registers definition
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000c7109f05952da0a2"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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

--000000000000c7109f05952da0a2
Content-Type: text/plain; charset="UTF-8"

On Fri, Oct 18, 2019 at 11:52 AM Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

>
>
> On Thursday, October 17, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:
>
>> On Thu, Oct 17, 2019 at 11:17 PM Aleksandar Markovic
>> <aleksandar.m.mail@gmail.com> wrote:
>> >>
>> >>
>> >> >> +static TCGv cpu_Cf;
>> >> >> +static TCGv cpu_Zf;
>> >> >> +static TCGv cpu_Nf;
>> >> >> +static TCGv cpu_Vf;
>> >> >> +static TCGv cpu_Sf;
>> >> >> +static TCGv cpu_Hf;
>> >> >> +static TCGv cpu_Tf;
>> >> >> +static TCGv cpu_If;
>> >> >> +
>> >> >
>> >> >
>> >> > Hello, Michael,
>> >> >
>> >> > Is there any particular reason or motivation beyond modelling status
>> register flags as TCGv variables?
>> >>
>> >>
>> >>
>> >> I think it's easier this way as I don't need to convert flag values to
>> >> bits or bits to flag values.
>> >
>> >
>> > Ok. But, how do you map 0/1 flag value to the value of a TCGv variable
>> and vice versa? In other words, what value or values (out of 2^32 vales) of
>> a TCGv variable mean the flag is 1? And the same question for 0.
>> >
>> > Is 0110000111000010100 one or zero?
>> >
>> > Besides, in such arrangement, how do you display the 8-bit status
>> register in gdb, if at all?
>>
>> each flag register is either 0 or 1,....
>
>
>>
>>
> Michael,
>
> If this is true, why is there a special handling of two flags in the
> following code:
>
>
> static inline uint8_t cpu_get_sreg(CPUAVRState *env)
> {
> uint8_t sreg;
> sreg = (env->sregC & 0x01) << 0
> | (env->sregZ == 0 ? 1 : 0) << 1
> | (env->sregN) << 2
> | (env->sregV) << 3
> | (env->sregS) << 4
> | (env->sregH) << 5
> | (env->sregT) << 6
> | (env->sregI) << 7;
> return sreg;
> }
> static inline void cpu_set_sreg(CPUAVRState *env, uint8_t sreg)
> {
> env->sregC = (sreg >> 0) & 0x01;
> env->sregZ = (sreg >> 1) & 0x01 ? 0 : 1;
> env->sregN = (sreg >> 2) & 0x01;
> env->sregV = (sreg >> 3) & 0x01;
> env->sregS = (sreg >> 4) & 0x01;
> env->sregH = (sreg >> 5) & 0x01;
> env->sregT = (sreg >> 6) & 0x01;
> env->sregI = (sreg >> 7) & 0x01;
> }
>  ?
>
> Aleksandar,

If I understand your question correctly cpu_get_sreg assembles SREG value
to be presented by GDB, and cpu_set_sreg sets flags values when GDB
modifies SREG.

Michael


>
> Thanks,
> A.
>
>>
>>  they are calculated here
>> 1.
>> https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/avr/translate.c#L146-L148
>> 2.
>> https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/avr/translate.c#L166
>> 3.
>> https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/avr/translate.c#L185-L187
>> 4.
>> https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/avr/translate.c#L205
>> 5.
>> https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/avr/translate.c#L214-L215
>> 6.
>> https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/avr/translate.c#L222-L223
>> The COU itself never uses SREG at all, only the flags.
>>
>> As for the GDB it's get assembled/disassembled here
>> 1.
>> https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/avr/cpu.h#L219-L243
>> 2.
>> https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/avr/gdbstub.c#L35-L37
>> 3.
>> https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/avr/gdbstub.c#L66-L68
>>
>> >
>> > A.
>> >
>> >>
>> >> >
>> >> > A.
>> >> >
>> >> >
>> >> >
>> >> >>
>> >> >> +static TCGv cpu_rampD;
>> >> >> +static TCGv cpu_rampX;
>> >> >> +static TCGv cpu_rampY;
>> >> >> +static TCGv cpu_rampZ;
>> >> >> +
>> >> >> +static TCGv cpu_r[NO_CPU_REGISTERS];
>> >> >> +static TCGv cpu_eind;
>> >> >> +static TCGv cpu_sp;
>> >> >> +
>> >> >> +static TCGv cpu_skip;
>> >> >> +
>> >> >> +static const char reg_names[NO_CPU_REGISTERS][8] = {
>> >> >> +    "r0",  "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
>> >> >> +    "r8",  "r9",  "r10", "r11", "r12", "r13", "r14", "r15",
>> >> >> +    "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
>> >> >> +    "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
>> >> >> +};
>> >> >> +#define REG(x) (cpu_r[x])
>> >> >> +
>> >> >> +enum {
>> >> >> +    DISAS_EXIT   = DISAS_TARGET_0,  /* We want return to the cpu
>> main loop.  */
>> >> >> +    DISAS_LOOKUP = DISAS_TARGET_1,  /* We have a variable
>> condition exit.  */
>> >> >> +    DISAS_CHAIN  = DISAS_TARGET_2,  /* We have a single condition
>> exit.  */
>> >> >> +};
>> >> >> +
>> >> >> +typedef struct DisasContext DisasContext;
>> >> >> +
>> >> >> +/* This is the state at translation time. */
>> >> >> +struct DisasContext {
>> >> >> +    TranslationBlock *tb;
>> >> >> +
>> >> >> +    CPUAVRState *env;
>> >> >> +    CPUState *cs;
>> >> >> +
>> >> >> +    target_long npc;
>> >> >> +    uint32_t opcode;
>> >> >> +
>> >> >> +    /* Routine used to access memory */
>> >> >> +    int memidx;
>> >> >> +    int bstate;
>> >> >> +    int singlestep;
>> >> >> +
>> >> >> +    TCGv skip_var0;
>> >> >> +    TCGv skip_var1;
>> >> >> +    TCGCond skip_cond;
>> >> >> +    bool free_skip_var0;
>> >> >> +};
>> >> >> +
>> >> >> +static int to_A(DisasContext *ctx, int indx) { return 16 + (indx %
>> 16); }
>> >> >> +static int to_B(DisasContext *ctx, int indx) { return 16 + (indx %
>> 8); }
>> >> >> +static int to_C(DisasContext *ctx, int indx) { return 24 + (indx %
>> 4) * 2; }
>> >> >> +static int to_D(DisasContext *ctx, int indx) { return (indx % 16)
>> * 2; }
>> >> >> +
>> >> >> +static uint16_t next_word(DisasContext *ctx)
>> >> >> +{
>> >> >> +    return cpu_lduw_code(ctx->env, ctx->npc++ * 2);
>> >> >> +}
>> >> >> +
>> >> >> +static int append_16(DisasContext *ctx, int x)
>> >> >> +{
>> >> >> +    return x << 16 | next_word(ctx);
>> >> >> +}
>> >> >> +
>> >> >> +
>> >> >> +static bool avr_have_feature(DisasContext *ctx, int feature)
>> >> >> +{
>> >> >> +    if (!avr_feature(ctx->env, feature)) {
>> >> >> +        gen_helper_unsupported(cpu_env);
>> >> >> +        ctx->bstate = DISAS_NORETURN;
>> >> >> +        return false;
>> >> >> +    }
>> >> >> +    return true;
>> >> >> +}
>> >> >> +
>> >> >> +static bool decode_insn(DisasContext *ctx, uint16_t insn);
>> >> >> +#include "decode_insn.inc.c"
>> >> >> +
>> >> >> --
>> >> >> 2.17.2 (Apple Git-113)
>> >> >>
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

-- 
Best Regards,
Michael Rolnik

--000000000000c7109f05952da0a2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 18, 2019 at 11:52 AM Alek=
sandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com">aleksand=
ar.m.mail@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><br><br>On Thursday, October 17, 2019, Michael Rolnik &l=
t;<a href=3D"mailto:mrolnik@gmail.com" target=3D"_blank">mrolnik@gmail.com<=
/a>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu,=
 Oct 17, 2019 at 11:17 PM Aleksandar Markovic<br>
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
yle=3D"box-sizing:border-box;border-spacing:0px;border-collapse:collapse;co=
lor:rgb(36,41,46);font-family:-apple-system,BlinkMacSystemFont,&quot;Segoe =
UI&quot;,Helvetica,Arial,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Seg=
oe UI Emoji&quot;;font-size:14px;line-height:21px"><tbody style=3D"box-sizi=
ng:border-box"><tr style=3D"box-sizing:border-box"><td id=3D"gmail-m_-52075=
5766449201707LC219" style=3D"box-sizing:border-box;padding:0px 10px;line-he=
ight:20px;vertical-align:top;overflow:visible;font-family:SFMono-Regular,Co=
nsolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;white-spa=
ce:pre-wrap"><span style=3D"box-sizing:border-box;color:rgb(215,58,73)">sta=
tic</span> <span style=3D"box-sizing:border-box;color:rgb(215,58,73)">inlin=
e</span> <span style=3D"box-sizing:border-box;color:rgb(0,92,197)">uint8_t<=
/span> <span style=3D"box-sizing:border-box;color:rgb(111,66,193)">cpu_get_=
sreg</span>(CPUAVRState *env)</td></tr><tr style=3D"box-sizing:border-box">=
<td id=3D"gmail-m_-520755766449201707L220" style=3D"box-sizing:border-box;p=
adding:0px 10px;width:50px;min-width:50px;font-family:SFMono-Regular,Consol=
as,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;line-height:2=
0px;color:rgba(27,31,35,0.298);text-align:right;white-space:nowrap;vertical=
-align:top"></td><td id=3D"gmail-m_-520755766449201707LC220" style=3D"box-s=
izing:border-box;padding:0px 10px;line-height:20px;vertical-align:top;overf=
low:visible;font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;=
,Menlo,monospace;font-size:12px;white-space:pre-wrap">{</td></tr><tr style=
=3D"box-sizing:border-box"><td id=3D"gmail-m_-520755766449201707L221" style=
=3D"box-sizing:border-box;padding:0px 10px;width:50px;min-width:50px;font-f=
amily:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;f=
ont-size:12px;line-height:20px;color:rgba(27,31,35,0.298);text-align:right;=
white-space:nowrap;vertical-align:top"></td><td id=3D"gmail-m_-520755766449=
201707LC221" style=3D"box-sizing:border-box;padding:0px 10px;line-height:20=
px;vertical-align:top;overflow:visible;font-family:SFMono-Regular,Consolas,=
&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;white-space:pre-=
wrap">    <span style=3D"box-sizing:border-box;color:rgb(0,92,197)">uint8_t=
</span> sreg;</td></tr><tr style=3D"box-sizing:border-box"><td id=3D"gmail-=
m_-520755766449201707L222" style=3D"box-sizing:border-box;padding:0px 10px;=
width:50px;min-width:50px;font-family:SFMono-Regular,Consolas,&quot;Liberat=
ion Mono&quot;,Menlo,monospace;font-size:12px;line-height:20px;color:rgba(2=
7,31,35,0.298);text-align:right;white-space:nowrap;vertical-align:top"></td=
><td id=3D"gmail-m_-520755766449201707LC222" style=3D"box-sizing:border-box=
;padding:0px 10px;line-height:20px;vertical-align:top;overflow:visible;font=
-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace=
;font-size:12px;white-space:pre-wrap">    sreg =3D (env-&gt;<span style=3D"=
box-sizing:border-box">sregC</span> &amp; <span style=3D"box-sizing:border-=
box;color:rgb(0,92,197)">0x01</span>) &lt;&lt; <span style=3D"box-sizing:bo=
rder-box;color:rgb(0,92,197)">0</span></td></tr><tr style=3D"box-sizing:bor=
der-box"><td id=3D"gmail-m_-520755766449201707L223" style=3D"box-sizing:bor=
der-box;padding:0px 10px;width:50px;min-width:50px;font-family:SFMono-Regul=
ar,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;line=
-height:20px;color:rgba(27,31,35,0.298);text-align:right;white-space:nowrap=
;vertical-align:top"></td><td id=3D"gmail-m_-520755766449201707LC223" style=
=3D"box-sizing:border-box;padding:0px 10px;line-height:20px;vertical-align:=
top;overflow:visible;font-family:SFMono-Regular,Consolas,&quot;Liberation M=
ono&quot;,Menlo,monospace;font-size:12px;white-space:pre-wrap">         | (=
env-&gt;<span style=3D"box-sizing:border-box">sregZ</span> =3D=3D <span sty=
le=3D"box-sizing:border-box;color:rgb(0,92,197)">0</span> ? <span style=3D"=
box-sizing:border-box;color:rgb(0,92,197)">1</span> : <span style=3D"box-si=
zing:border-box;color:rgb(0,92,197)">0</span>) &lt;&lt; <span style=3D"box-=
sizing:border-box;color:rgb(0,92,197)">1</span></td></tr><tr style=3D"box-s=
izing:border-box"><td id=3D"gmail-m_-520755766449201707L224" style=3D"box-s=
izing:border-box;padding:0px 10px;width:50px;min-width:50px;font-family:SFM=
ono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:=
12px;line-height:20px;color:rgba(27,31,35,0.298);text-align:right;white-spa=
ce:nowrap;vertical-align:top"></td><td id=3D"gmail-m_-520755766449201707LC2=
24" style=3D"box-sizing:border-box;padding:0px 10px;line-height:20px;vertic=
al-align:top;overflow:visible;font-family:SFMono-Regular,Consolas,&quot;Lib=
eration Mono&quot;,Menlo,monospace;font-size:12px;white-space:pre-wrap">   =
      | (env-&gt;<span style=3D"box-sizing:border-box">sregN</span>) &lt;&l=
t; <span style=3D"box-sizing:border-box;color:rgb(0,92,197)">2</span></td><=
/tr><tr style=3D"box-sizing:border-box"><td id=3D"gmail-m_-5207557664492017=
07L225" style=3D"box-sizing:border-box;padding:0px 10px;width:50px;min-widt=
h:50px;font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menl=
o,monospace;font-size:12px;line-height:20px;color:rgba(27,31,35,0.298);text=
-align:right;white-space:nowrap;vertical-align:top"></td><td id=3D"gmail-m_=
-520755766449201707LC225" style=3D"box-sizing:border-box;padding:0px 10px;l=
ine-height:20px;vertical-align:top;overflow:visible;font-family:SFMono-Regu=
lar,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;whi=
te-space:pre-wrap">         | (env-&gt;<span style=3D"box-sizing:border-box=
">sregV</span>) &lt;&lt; <span style=3D"box-sizing:border-box;color:rgb(0,9=
2,197)">3</span></td></tr><tr style=3D"box-sizing:border-box"><td id=3D"gma=
il-m_-520755766449201707L226" style=3D"box-sizing:border-box;padding:0px 10=
px;width:50px;min-width:50px;font-family:SFMono-Regular,Consolas,&quot;Libe=
ration Mono&quot;,Menlo,monospace;font-size:12px;line-height:20px;color:rgb=
a(27,31,35,0.298);text-align:right;white-space:nowrap;vertical-align:top"><=
/td><td id=3D"gmail-m_-520755766449201707LC226" style=3D"box-sizing:border-=
box;padding:0px 10px;line-height:20px;vertical-align:top;overflow:visible;f=
ont-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monosp=
ace;font-size:12px;white-space:pre-wrap">         | (env-&gt;<span style=3D=
"box-sizing:border-box">sregS</span>) &lt;&lt; <span style=3D"box-sizing:bo=
rder-box;color:rgb(0,92,197)">4</span></td></tr><tr style=3D"box-sizing:bor=
der-box"><td id=3D"gmail-m_-520755766449201707L227" style=3D"box-sizing:bor=
der-box;padding:0px 10px;width:50px;min-width:50px;font-family:SFMono-Regul=
ar,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;line=
-height:20px;color:rgba(27,31,35,0.298);text-align:right;white-space:nowrap=
;vertical-align:top"></td><td id=3D"gmail-m_-520755766449201707LC227" style=
=3D"box-sizing:border-box;padding:0px 10px;line-height:20px;vertical-align:=
top;overflow:visible;font-family:SFMono-Regular,Consolas,&quot;Liberation M=
ono&quot;,Menlo,monospace;font-size:12px;white-space:pre-wrap">         | (=
env-&gt;<span style=3D"box-sizing:border-box">sregH</span>) &lt;&lt; <span =
style=3D"box-sizing:border-box;color:rgb(0,92,197)">5</span></td></tr><tr s=
tyle=3D"box-sizing:border-box"><td id=3D"gmail-m_-520755766449201707L228" s=
tyle=3D"box-sizing:border-box;padding:0px 10px;width:50px;min-width:50px;fo=
nt-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospa=
ce;font-size:12px;line-height:20px;color:rgba(27,31,35,0.298);text-align:ri=
ght;white-space:nowrap;vertical-align:top"></td><td id=3D"gmail-m_-52075576=
6449201707LC228" style=3D"box-sizing:border-box;padding:0px 10px;line-heigh=
t:20px;vertical-align:top;overflow:visible;font-family:SFMono-Regular,Conso=
las,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;white-space:=
pre-wrap">         | (env-&gt;<span style=3D"box-sizing:border-box">sregT</=
span>) &lt;&lt; <span style=3D"box-sizing:border-box;color:rgb(0,92,197)">6=
</span></td></tr><tr style=3D"box-sizing:border-box"><td id=3D"gmail-m_-520=
755766449201707L229" style=3D"box-sizing:border-box;padding:0px 10px;width:=
50px;min-width:50px;font-family:SFMono-Regular,Consolas,&quot;Liberation Mo=
no&quot;,Menlo,monospace;font-size:12px;line-height:20px;color:rgba(27,31,3=
5,0.298);text-align:right;white-space:nowrap;vertical-align:top"></td><td i=
d=3D"gmail-m_-520755766449201707LC229" style=3D"box-sizing:border-box;paddi=
ng:0px 10px;line-height:20px;vertical-align:top;overflow:visible;font-famil=
y:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-=
size:12px;white-space:pre-wrap">         | (env-&gt;<span style=3D"box-sizi=
ng:border-box">sregI</span>) &lt;&lt; <span style=3D"box-sizing:border-box;=
color:rgb(0,92,197)">7</span>;</td></tr><tr style=3D"box-sizing:border-box"=
><td id=3D"gmail-m_-520755766449201707L230" style=3D"box-sizing:border-box;=
padding:0px 10px;width:50px;min-width:50px;font-family:SFMono-Regular,Conso=
las,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;line-height:=
20px;color:rgba(27,31,35,0.298);text-align:right;white-space:nowrap;vertica=
l-align:top"></td><td id=3D"gmail-m_-520755766449201707LC230" style=3D"box-=
sizing:border-box;padding:0px 10px;line-height:20px;vertical-align:top;over=
flow:visible;font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot=
;,Menlo,monospace;font-size:12px;white-space:pre-wrap">    <span style=3D"b=
ox-sizing:border-box;color:rgb(215,58,73)">return</span> sreg;</td></tr><tr=
 style=3D"box-sizing:border-box"><td id=3D"gmail-m_-520755766449201707L231"=
 style=3D"box-sizing:border-box;padding:0px 10px;width:50px;min-width:50px;=
font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monos=
pace;font-size:12px;line-height:20px;color:rgba(27,31,35,0.298);text-align:=
right;white-space:nowrap;vertical-align:top"></td><td id=3D"gmail-m_-520755=
766449201707LC231" style=3D"box-sizing:border-box;padding:0px 10px;line-hei=
ght:20px;vertical-align:top;overflow:visible;font-family:SFMono-Regular,Con=
solas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;white-spac=
e:pre-wrap">}</td></tr><tr style=3D"box-sizing:border-box"><td id=3D"gmail-=
m_-520755766449201707L232" style=3D"box-sizing:border-box;padding:0px 10px;=
width:50px;min-width:50px;font-family:SFMono-Regular,Consolas,&quot;Liberat=
ion Mono&quot;,Menlo,monospace;font-size:12px;line-height:20px;color:rgba(2=
7,31,35,0.298);text-align:right;white-space:nowrap;vertical-align:top"></td=
><td id=3D"gmail-m_-520755766449201707LC232" style=3D"box-sizing:border-box=
;padding:0px 10px;line-height:20px;vertical-align:top;overflow:visible;font=
-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace=
;font-size:12px;white-space:pre-wrap">
</td></tr><tr style=3D"box-sizing:border-box"><td id=3D"gmail-m_-5207557664=
49201707L233" style=3D"box-sizing:border-box;padding:0px 10px;width:50px;mi=
n-width:50px;font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot=
;,Menlo,monospace;font-size:12px;line-height:20px;color:rgba(27,31,35,0.298=
);text-align:right;white-space:nowrap;vertical-align:top"></td><td id=3D"gm=
ail-m_-520755766449201707LC233" style=3D"box-sizing:border-box;padding:0px =
10px;line-height:20px;vertical-align:top;overflow:visible;font-family:SFMon=
o-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12=
px;white-space:pre-wrap"><span style=3D"box-sizing:border-box;color:rgb(215=
,58,73)">static</span> <span style=3D"box-sizing:border-box;color:rgb(215,5=
8,73)">inline</span> <span style=3D"box-sizing:border-box;color:rgb(215,58,=
73)">void</span> <span style=3D"box-sizing:border-box;color:rgb(111,66,193)=
">cpu_set_sreg</span>(CPUAVRState *env, <span style=3D"box-sizing:border-bo=
x;color:rgb(0,92,197)">uint8_t</span> sreg)</td></tr><tr style=3D"box-sizin=
g:border-box"><td id=3D"gmail-m_-520755766449201707L234" style=3D"box-sizin=
g:border-box;padding:0px 10px;width:50px;min-width:50px;font-family:SFMono-=
Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px=
;line-height:20px;color:rgba(27,31,35,0.298);text-align:right;white-space:n=
owrap;vertical-align:top"></td><td id=3D"gmail-m_-520755766449201707LC234" =
style=3D"box-sizing:border-box;padding:0px 10px;line-height:20px;vertical-a=
lign:top;overflow:visible;font-family:SFMono-Regular,Consolas,&quot;Liberat=
ion Mono&quot;,Menlo,monospace;font-size:12px;white-space:pre-wrap">{</td><=
/tr><tr style=3D"box-sizing:border-box"><td id=3D"gmail-m_-5207557664492017=
07L235" style=3D"box-sizing:border-box;padding:0px 10px;width:50px;min-widt=
h:50px;font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menl=
o,monospace;font-size:12px;line-height:20px;color:rgba(27,31,35,0.298);text=
-align:right;white-space:nowrap;vertical-align:top"></td><td id=3D"gmail-m_=
-520755766449201707LC235" style=3D"box-sizing:border-box;padding:0px 10px;l=
ine-height:20px;vertical-align:top;overflow:visible;font-family:SFMono-Regu=
lar,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;whi=
te-space:pre-wrap">    env-&gt;<span style=3D"box-sizing:border-box">sregC<=
/span> =3D (sreg &gt;&gt; <span style=3D"box-sizing:border-box;color:rgb(0,=
92,197)">0</span>) &amp; <span style=3D"box-sizing:border-box;color:rgb(0,9=
2,197)">0x01</span>;</td></tr><tr style=3D"box-sizing:border-box"><td id=3D=
"gmail-m_-520755766449201707L236" style=3D"box-sizing:border-box;padding:0p=
x 10px;width:50px;min-width:50px;font-family:SFMono-Regular,Consolas,&quot;=
Liberation Mono&quot;,Menlo,monospace;font-size:12px;line-height:20px;color=
:rgba(27,31,35,0.298);text-align:right;white-space:nowrap;vertical-align:to=
p"></td><td id=3D"gmail-m_-520755766449201707LC236" style=3D"box-sizing:bor=
der-box;padding:0px 10px;line-height:20px;vertical-align:top;overflow:visib=
le;font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,mo=
nospace;font-size:12px;white-space:pre-wrap">    env-&gt;<span style=3D"box=
-sizing:border-box">sregZ</span> =3D (sreg &gt;&gt; <span style=3D"box-sizi=
ng:border-box;color:rgb(0,92,197)">1</span>) &amp; <span style=3D"box-sizin=
g:border-box;color:rgb(0,92,197)">0x01</span> ? <span style=3D"box-sizing:b=
order-box;color:rgb(0,92,197)">0</span> : <span style=3D"box-sizing:border-=
box;color:rgb(0,92,197)">1</span>;</td></tr><tr style=3D"box-sizing:border-=
box"><td id=3D"gmail-m_-520755766449201707L237" style=3D"box-sizing:border-=
box;padding:0px 10px;width:50px;min-width:50px;font-family:SFMono-Regular,C=
onsolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;line-hei=
ght:20px;color:rgba(27,31,35,0.298);text-align:right;white-space:nowrap;ver=
tical-align:top"></td><td id=3D"gmail-m_-520755766449201707LC237" style=3D"=
box-sizing:border-box;padding:0px 10px;line-height:20px;vertical-align:top;=
overflow:visible;font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&=
quot;,Menlo,monospace;font-size:12px;white-space:pre-wrap">    env-&gt;<spa=
n style=3D"box-sizing:border-box">sregN</span> =3D (sreg &gt;&gt; <span sty=
le=3D"box-sizing:border-box;color:rgb(0,92,197)">2</span>) &amp; <span styl=
e=3D"box-sizing:border-box;color:rgb(0,92,197)">0x01</span>;</td></tr><tr s=
tyle=3D"box-sizing:border-box"><td id=3D"gmail-m_-520755766449201707L238" s=
tyle=3D"box-sizing:border-box;padding:0px 10px;width:50px;min-width:50px;fo=
nt-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospa=
ce;font-size:12px;line-height:20px;color:rgba(27,31,35,0.298);text-align:ri=
ght;white-space:nowrap;vertical-align:top"></td><td id=3D"gmail-m_-52075576=
6449201707LC238" style=3D"box-sizing:border-box;padding:0px 10px;line-heigh=
t:20px;vertical-align:top;overflow:visible;font-family:SFMono-Regular,Conso=
las,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;white-space:=
pre-wrap">    env-&gt;<span style=3D"box-sizing:border-box">sregV</span> =
=3D (sreg &gt;&gt; <span style=3D"box-sizing:border-box;color:rgb(0,92,197)=
">3</span>) &amp; <span style=3D"box-sizing:border-box;color:rgb(0,92,197)"=
>0x01</span>;</td></tr><tr style=3D"box-sizing:border-box"><td id=3D"gmail-=
m_-520755766449201707L239" style=3D"box-sizing:border-box;padding:0px 10px;=
width:50px;min-width:50px;font-family:SFMono-Regular,Consolas,&quot;Liberat=
ion Mono&quot;,Menlo,monospace;font-size:12px;line-height:20px;color:rgba(2=
7,31,35,0.298);text-align:right;white-space:nowrap;vertical-align:top"></td=
><td id=3D"gmail-m_-520755766449201707LC239" style=3D"box-sizing:border-box=
;padding:0px 10px;line-height:20px;vertical-align:top;overflow:visible;font=
-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace=
;font-size:12px;white-space:pre-wrap">    env-&gt;<span style=3D"box-sizing=
:border-box">sregS</span> =3D (sreg &gt;&gt; <span style=3D"box-sizing:bord=
er-box;color:rgb(0,92,197)">4</span>) &amp; <span style=3D"box-sizing:borde=
r-box;color:rgb(0,92,197)">0x01</span>;</td></tr><tr style=3D"box-sizing:bo=
rder-box"><td id=3D"gmail-m_-520755766449201707L240" style=3D"box-sizing:bo=
rder-box;padding:0px 10px;width:50px;min-width:50px;font-family:SFMono-Regu=
lar,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;lin=
e-height:20px;color:rgba(27,31,35,0.298);text-align:right;white-space:nowra=
p;vertical-align:top"></td><td id=3D"gmail-m_-520755766449201707LC240" styl=
e=3D"box-sizing:border-box;padding:0px 10px;line-height:20px;vertical-align=
:top;overflow:visible;font-family:SFMono-Regular,Consolas,&quot;Liberation =
Mono&quot;,Menlo,monospace;font-size:12px;white-space:pre-wrap">    env-&gt=
;<span style=3D"box-sizing:border-box">sregH</span> =3D (sreg &gt;&gt; <spa=
n style=3D"box-sizing:border-box;color:rgb(0,92,197)">5</span>) &amp; <span=
 style=3D"box-sizing:border-box;color:rgb(0,92,197)">0x01</span>;</td></tr>=
<tr style=3D"box-sizing:border-box"><td id=3D"gmail-m_-520755766449201707L2=
41" style=3D"box-sizing:border-box;padding:0px 10px;width:50px;min-width:50=
px;font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,mo=
nospace;font-size:12px;line-height:20px;color:rgba(27,31,35,0.298);text-ali=
gn:right;white-space:nowrap;vertical-align:top"></td><td id=3D"gmail-m_-520=
755766449201707LC241" style=3D"box-sizing:border-box;padding:0px 10px;line-=
height:20px;vertical-align:top;overflow:visible;font-family:SFMono-Regular,=
Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;white-s=
pace:pre-wrap">    env-&gt;<span style=3D"box-sizing:border-box">sregT</spa=
n> =3D (sreg &gt;&gt; <span style=3D"box-sizing:border-box;color:rgb(0,92,1=
97)">6</span>) &amp; <span style=3D"box-sizing:border-box;color:rgb(0,92,19=
7)">0x01</span>;</td></tr><tr style=3D"box-sizing:border-box"><td id=3D"gma=
il-m_-520755766449201707L242" style=3D"box-sizing:border-box;padding:0px 10=
px;width:50px;min-width:50px;font-family:SFMono-Regular,Consolas,&quot;Libe=
ration Mono&quot;,Menlo,monospace;font-size:12px;line-height:20px;color:rgb=
a(27,31,35,0.298);text-align:right;white-space:nowrap;vertical-align:top"><=
/td><td id=3D"gmail-m_-520755766449201707LC242" style=3D"box-sizing:border-=
box;padding:0px 10px;line-height:20px;vertical-align:top;overflow:visible;f=
ont-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monosp=
ace;font-size:12px;white-space:pre-wrap">    env-&gt;<span style=3D"box-siz=
ing:border-box">sregI</span> =3D (sreg &gt;&gt; <span style=3D"box-sizing:b=
order-box;color:rgb(0,92,197)">7</span>) &amp; <span style=3D"box-sizing:bo=
rder-box;color:rgb(0,92,197)">0x01</span>;</td></tr><tr style=3D"box-sizing=
:border-box"><td id=3D"gmail-m_-520755766449201707L243" style=3D"box-sizing=
:border-box;padding:0px 10px;width:50px;min-width:50px;font-family:SFMono-R=
egular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;=
line-height:20px;color:rgba(27,31,35,0.298);text-align:right;white-space:no=
wrap;vertical-align:top"></td><td id=3D"gmail-m_-520755766449201707LC243" s=
tyle=3D"box-sizing:border-box;padding:0px 10px;line-height:20px;vertical-al=
ign:top;overflow:visible;font-family:SFMono-Regular,Consolas,&quot;Liberati=
on Mono&quot;,Menlo,monospace;font-size:12px;white-space:pre-wrap">}</td></=
tr></tbody></table></div><div>=C2=A0?</div><div><br></div></blockquote><div=
>Aleksandar,</div><div><br></div><div>If I understand your question correct=
ly=C2=A0cpu_get_sreg assembles SREG value to be presented by GDB, and=C2=A0=
cpu_set_sreg sets flags values when GDB modifies SREG.</div><div><br></div>=
<div>Michael</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div></div><div><br></div><div>Thanks,</div><div>A.</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex"><br></blockquote><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">=C2=A0they are calculated here<br>
1. <a href=3D"https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target=
/avr/translate.c#L146-L148" target=3D"_blank">https://github.com/michaelrol=
nik/qemu-avr/blob/avr-v32/target/avr/translate.c#L146-L148</a><br>
2. <a href=3D"https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target=
/avr/translate.c#L166" target=3D"_blank">https://github.com/michaelrolnik/q=
emu-avr/blob/avr-v32/target/avr/translate.c#L166</a><br>
3. <a href=3D"https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target=
/avr/translate.c#L185-L187" target=3D"_blank">https://github.com/michaelrol=
nik/qemu-avr/blob/avr-v32/target/avr/translate.c#L185-L187</a><br>
4. <a href=3D"https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target=
/avr/translate.c#L205" target=3D"_blank">https://github.com/michaelrolnik/q=
emu-avr/blob/avr-v32/target/avr/translate.c#L205</a><br>
5. <a href=3D"https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target=
/avr/translate.c#L214-L215" target=3D"_blank">https://github.com/michaelrol=
nik/qemu-avr/blob/avr-v32/target/avr/translate.c#L214-L215</a><br>
6. <a href=3D"https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target=
/avr/translate.c#L222-L223" target=3D"_blank">https://github.com/michaelrol=
nik/qemu-avr/blob/avr-v32/target/avr/translate.c#L222-L223</a><br>
The COU itself never uses SREG at all, only the flags.<br>
<br>
As for the GDB it&#39;s get assembled/disassembled here<br>
1. <a href=3D"https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target=
/avr/cpu.h#L219-L243" target=3D"_blank">https://github.com/michaelrolnik/qe=
mu-avr/blob/avr-v32/target/avr/cpu.h#L219-L243</a><br>
2. <a href=3D"https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target=
/avr/gdbstub.c#L35-L37" target=3D"_blank">https://github.com/michaelrolnik/=
qemu-avr/blob/avr-v32/target/avr/gdbstub.c#L35-L37</a><br>
3. <a href=3D"https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target=
/avr/gdbstub.c#L66-L68" target=3D"_blank">https://github.com/michaelrolnik/=
qemu-avr/blob/avr-v32/target/avr/gdbstub.c#L66-L68</a><br>
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
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_unsupported(cpu_e=
nv);<br>
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
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div></div>

--000000000000c7109f05952da0a2--

