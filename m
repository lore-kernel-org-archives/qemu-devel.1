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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9516ECA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 08:53:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F87021897
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 08:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtvHCMSb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F87021897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLO0Y-0006Ye-Dl
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 04:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLNzp-00066r-6l
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 04:52:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLNzn-0002O0-5y
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 04:52:29 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36466)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iLNzm-0002NS-U9
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 04:52:27 -0400
Received: by mail-ot1-x344.google.com with SMTP id 67so4341180oto.3
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 01:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=+fYUObq6wAlNk8APRgbI1FgkBeROtJfEjCHGT4wdvew=;
 b=VtvHCMSbs7QyoPjbMHcbuDTf547TdCCNe+LKGNP/cQbh21vr6NgAs1JsZ4bam/Ua0v
 4EeugM0MXOnoBJZIL44VrvSTuWPrIYSVkeYQMH2Qo1Xy8gXB/c0biLzou+uQl6f0UrT8
 wi0YjAkDC3pWOAV+GusAkP7NK/voFhq/biwpc8+hezmfXl77qCxfGI/AuxKaE1OqZJ9Q
 byn7yiBVX55/MRGL21kX1iXejAYzIY3B10F2U5hPhqIfqugFPp7HGPsiW0IRrhJQ1VPw
 dayFos0RuBA9orq49XBo5534CyAfvm502QennXhjiRo6xTMJ6prYC1Wo8IfXKZ9lvOdw
 qyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=+fYUObq6wAlNk8APRgbI1FgkBeROtJfEjCHGT4wdvew=;
 b=YCWbMcNEitsg+CmfrdTi4jibPSx1GGr4Z9gjpc0iwp8YOGCkAQ5w3mNwdp11tm3d6x
 SvI/Y+xyXNkbT3ZkiE7eGX5ENVI2fQxWtmHanl6lxd5+MrRvAxAXBxMLVFGaYTNY4I/t
 iOt3V93ETXEjH+4rCa+GNWfK0d8552XsQaPVjrCgO2ACXFiN4eYUMMbyilUBDWxLF0g8
 aodmN3BKgG/dqVd/UYDBwjN3TYNBB1N7SnI6zE0JCuoRKmZr1mFS/IpcYoD66k3N+O+q
 rNbbKJZtb2LwnDmxbR0N3PuTrKFRHwZHZAv44l0aXNjcWp3Dz0RNNH/M0UqhVRzkeSD8
 klpw==
X-Gm-Message-State: APjAAAVz73Wy4E4Wa8j7zI5dAC0UWPZPW6+BisVSc/vGrEfu3Nw3njuS
 B+nqWiRtoEWIoKP45P7PxdzcVUknyzMKBaNb6EI=
X-Google-Smtp-Source: APXvYqwstgavfEX0i6mX+xPgfo2GTwXCnl+rtTMuDyiNfXrz0CwLTzAEi55v9GhoebLHGwM13V5RzZqjvxEbG96r9rk=
X-Received: by 2002:a9d:4f0f:: with SMTP id d15mr6353575otl.64.1571388745817; 
 Fri, 18 Oct 2019 01:52:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Fri, 18 Oct 2019 01:52:25
 -0700 (PDT)
In-Reply-To: <CAK4993jaqFrzcmAyz7neJoq5cQgnB_o35dZhdh9_uVyOfKGG-Q@mail.gmail.com>
References: <20191014161843.84845-1-mrolnik@gmail.com>
 <20191014161843.84845-5-mrolnik@gmail.com>
 <CAL1e-=g9ER4tuqEL2ubqb7oAbatcVR8x+A0LAydSwBJEnk9_ow@mail.gmail.com>
 <CAK4993gm=8tVXyprjHPMiNZuKZRkx0iDYnXh76cQfMwUayqcWQ@mail.gmail.com>
 <CAL1e-=hGJQqVnvAu=ZJRV-AdoAWpkSvdf5ex=b7EwkodUGKpUg@mail.gmail.com>
 <CAK4993jaqFrzcmAyz7neJoq5cQgnB_o35dZhdh9_uVyOfKGG-Q@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 18 Oct 2019 10:52:25 +0200
Message-ID: <CAL1e-=ixhb1z8h9f6DrNAuEn69pPaV2qvvd=BvVnFKCdW+XMwg@mail.gmail.com>
Subject: Re: [PATCH v32 04/13] target/avr: Add instruction translation -
 Registers definition
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000ffa3cc05952b73c6"
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

--000000000000ffa3cc05952b73c6
Content-Type: text/plain; charset="UTF-8"

On Thursday, October 17, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

> On Thu, Oct 17, 2019 at 11:17 PM Aleksandar Markovic
> <aleksandar.m.mail@gmail.com> wrote:
> >>
> >>
> >> >> +static TCGv cpu_Cf;
> >> >> +static TCGv cpu_Zf;
> >> >> +static TCGv cpu_Nf;
> >> >> +static TCGv cpu_Vf;
> >> >> +static TCGv cpu_Sf;
> >> >> +static TCGv cpu_Hf;
> >> >> +static TCGv cpu_Tf;
> >> >> +static TCGv cpu_If;
> >> >> +
> >> >
> >> >
> >> > Hello, Michael,
> >> >
> >> > Is there any particular reason or motivation beyond modelling status
> register flags as TCGv variables?
> >>
> >>
> >>
> >> I think it's easier this way as I don't need to convert flag values to
> >> bits or bits to flag values.
> >
> >
> > Ok. But, how do you map 0/1 flag value to the value of a TCGv variable
> and vice versa? In other words, what value or values (out of 2^32 vales) of
> a TCGv variable mean the flag is 1? And the same question for 0.
> >
> > Is 0110000111000010100 one or zero?
> >
> > Besides, in such arrangement, how do you display the 8-bit status
> register in gdb, if at all?
>
> each flag register is either 0 or 1,....


>
>
Michael,

If this is true, why is there a special handling of two flags in the
following code:


static inline uint8_t cpu_get_sreg(CPUAVRState *env)
{
uint8_t sreg;
sreg = (env->sregC & 0x01) << 0
| (env->sregZ == 0 ? 1 : 0) << 1
| (env->sregN) << 2
| (env->sregV) << 3
| (env->sregS) << 4
| (env->sregH) << 5
| (env->sregT) << 6
| (env->sregI) << 7;
return sreg;
}
static inline void cpu_set_sreg(CPUAVRState *env, uint8_t sreg)
{
env->sregC = (sreg >> 0) & 0x01;
env->sregZ = (sreg >> 1) & 0x01 ? 0 : 1;
env->sregN = (sreg >> 2) & 0x01;
env->sregV = (sreg >> 3) & 0x01;
env->sregS = (sreg >> 4) & 0x01;
env->sregH = (sreg >> 5) & 0x01;
env->sregT = (sreg >> 6) & 0x01;
env->sregI = (sreg >> 7) & 0x01;
}
 ?


Thanks,
A.

>
>  they are calculated here
> 1. https://github.com/michaelrolnik/qemu-avr/blob/
> avr-v32/target/avr/translate.c#L146-L148
> 2. https://github.com/michaelrolnik/qemu-avr/blob/
> avr-v32/target/avr/translate.c#L166
> 3. https://github.com/michaelrolnik/qemu-avr/blob/
> avr-v32/target/avr/translate.c#L185-L187
> 4. https://github.com/michaelrolnik/qemu-avr/blob/
> avr-v32/target/avr/translate.c#L205
> 5. https://github.com/michaelrolnik/qemu-avr/blob/
> avr-v32/target/avr/translate.c#L214-L215
> 6. https://github.com/michaelrolnik/qemu-avr/blob/
> avr-v32/target/avr/translate.c#L222-L223
> The COU itself never uses SREG at all, only the flags.
>
> As for the GDB it's get assembled/disassembled here
> 1. https://github.com/michaelrolnik/qemu-avr/blob/
> avr-v32/target/avr/cpu.h#L219-L243
> 2. https://github.com/michaelrolnik/qemu-avr/blob/
> avr-v32/target/avr/gdbstub.c#L35-L37
> 3. https://github.com/michaelrolnik/qemu-avr/blob/
> avr-v32/target/avr/gdbstub.c#L66-L68
>
> >
> > A.
> >
> >>
> >> >
> >> > A.
> >> >
> >> >
> >> >
> >> >>
> >> >> +static TCGv cpu_rampD;
> >> >> +static TCGv cpu_rampX;
> >> >> +static TCGv cpu_rampY;
> >> >> +static TCGv cpu_rampZ;
> >> >> +
> >> >> +static TCGv cpu_r[NO_CPU_REGISTERS];
> >> >> +static TCGv cpu_eind;
> >> >> +static TCGv cpu_sp;
> >> >> +
> >> >> +static TCGv cpu_skip;
> >> >> +
> >> >> +static const char reg_names[NO_CPU_REGISTERS][8] = {
> >> >> +    "r0",  "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
> >> >> +    "r8",  "r9",  "r10", "r11", "r12", "r13", "r14", "r15",
> >> >> +    "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
> >> >> +    "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
> >> >> +};
> >> >> +#define REG(x) (cpu_r[x])
> >> >> +
> >> >> +enum {
> >> >> +    DISAS_EXIT   = DISAS_TARGET_0,  /* We want return to the cpu
> main loop.  */
> >> >> +    DISAS_LOOKUP = DISAS_TARGET_1,  /* We have a variable condition
> exit.  */
> >> >> +    DISAS_CHAIN  = DISAS_TARGET_2,  /* We have a single condition
> exit.  */
> >> >> +};
> >> >> +
> >> >> +typedef struct DisasContext DisasContext;
> >> >> +
> >> >> +/* This is the state at translation time. */
> >> >> +struct DisasContext {
> >> >> +    TranslationBlock *tb;
> >> >> +
> >> >> +    CPUAVRState *env;
> >> >> +    CPUState *cs;
> >> >> +
> >> >> +    target_long npc;
> >> >> +    uint32_t opcode;
> >> >> +
> >> >> +    /* Routine used to access memory */
> >> >> +    int memidx;
> >> >> +    int bstate;
> >> >> +    int singlestep;
> >> >> +
> >> >> +    TCGv skip_var0;
> >> >> +    TCGv skip_var1;
> >> >> +    TCGCond skip_cond;
> >> >> +    bool free_skip_var0;
> >> >> +};
> >> >> +
> >> >> +static int to_A(DisasContext *ctx, int indx) { return 16 + (indx %
> 16); }
> >> >> +static int to_B(DisasContext *ctx, int indx) { return 16 + (indx %
> 8); }
> >> >> +static int to_C(DisasContext *ctx, int indx) { return 24 + (indx %
> 4) * 2; }
> >> >> +static int to_D(DisasContext *ctx, int indx) { return (indx % 16) *
> 2; }
> >> >> +
> >> >> +static uint16_t next_word(DisasContext *ctx)
> >> >> +{
> >> >> +    return cpu_lduw_code(ctx->env, ctx->npc++ * 2);
> >> >> +}
> >> >> +
> >> >> +static int append_16(DisasContext *ctx, int x)
> >> >> +{
> >> >> +    return x << 16 | next_word(ctx);
> >> >> +}
> >> >> +
> >> >> +
> >> >> +static bool avr_have_feature(DisasContext *ctx, int feature)
> >> >> +{
> >> >> +    if (!avr_feature(ctx->env, feature)) {
> >> >> +        gen_helper_unsupported(cpu_env);
> >> >> +        ctx->bstate = DISAS_NORETURN;
> >> >> +        return false;
> >> >> +    }
> >> >> +    return true;
> >> >> +}
> >> >> +
> >> >> +static bool decode_insn(DisasContext *ctx, uint16_t insn);
> >> >> +#include "decode_insn.inc.c"
> >> >> +
> >> >> --
> >> >> 2.17.2 (Apple Git-113)
> >> >>
> >>
> >>
> >> --
> >> Best Regards,
> >> Michael Rolnik
>
>
>
> --
> Best Regards,
> Michael Rolnik
>

--000000000000ffa3cc05952b73c6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, October 17, 2019, Michael Rolnik &lt;<a href=3D"mailto=
:mrolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">On Thu, Oct 17, 2019 at 11:17 PM Aleksandar Markovic<br>
&lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com">aleksandar.m.mail@gmail.=
com</a>&gt; wrote:<br>
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
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br></blockquote><=
div><br></div><div>Michael,</div><div><br></div><div>If this is true, why i=
s there a special handling of two flags in the following code:</div><div><b=
r></div><div><br></div><div><table class=3D"highlight tab-size js-file-line=
-container" style=3D"box-sizing:border-box;border-spacing:0px;border-collap=
se:collapse;color:rgb(36,41,46);font-family:-apple-system,BlinkMacSystemFon=
t,&#39;Segoe UI&#39;,Helvetica,Arial,sans-serif,&#39;Apple Color Emoji&#39;=
,&#39;Segoe UI Emoji&#39;;font-size:14px;line-height:21px"><tbody style=3D"=
box-sizing:border-box"><tr style=3D"box-sizing:border-box"><td id=3D"LC219"=
 class=3D"blob-code blob-code-inner js-file-line" style=3D"box-sizing:borde=
r-box;padding:0px 10px;line-height:20px;vertical-align:top;overflow:visible=
;font-family:SFMono-Regular,Consolas,&#39;Liberation Mono&#39;,Menlo,monosp=
ace;font-size:12px;word-wrap:normal;white-space:pre"><span class=3D"pl-k" s=
tyle=3D"box-sizing:border-box;color:rgb(215,58,73)">static</span> <span cla=
ss=3D"pl-k" style=3D"box-sizing:border-box;color:rgb(215,58,73)">inline</sp=
an> <span class=3D"pl-c1" style=3D"box-sizing:border-box;color:rgb(0,92,197=
)">uint8_t</span> <span class=3D"pl-en" style=3D"box-sizing:border-box;colo=
r:rgb(111,66,193)">cpu_get_sreg</span>(CPUAVRState *env)</td></tr><tr style=
=3D"box-sizing:border-box"><td id=3D"L220" class=3D"blob-num js-line-number=
" style=3D"box-sizing:border-box;padding:0px 10px;width:50px;min-width:50px=
;font-family:SFMono-Regular,Consolas,&#39;Liberation Mono&#39;,Menlo,monosp=
ace;font-size:12px;line-height:20px;color:rgba(27,31,35,0.298039);text-alig=
n:right;white-space:nowrap;vertical-align:top"></td><td id=3D"LC220" class=
=3D"blob-code blob-code-inner js-file-line" style=3D"box-sizing:border-box;=
padding:0px 10px;line-height:20px;vertical-align:top;overflow:visible;font-=
family:SFMono-Regular,Consolas,&#39;Liberation Mono&#39;,Menlo,monospace;fo=
nt-size:12px;word-wrap:normal;white-space:pre">{</td></tr><tr style=3D"box-=
sizing:border-box"><td id=3D"L221" class=3D"blob-num js-line-number" style=
=3D"box-sizing:border-box;padding:0px 10px;width:50px;min-width:50px;font-f=
amily:SFMono-Regular,Consolas,&#39;Liberation Mono&#39;,Menlo,monospace;fon=
t-size:12px;line-height:20px;color:rgba(27,31,35,0.298039);text-align:right=
;white-space:nowrap;vertical-align:top"></td><td id=3D"LC221" class=3D"blob=
-code blob-code-inner js-file-line" style=3D"box-sizing:border-box;padding:=
0px 10px;line-height:20px;vertical-align:top;overflow:visible;font-family:S=
FMono-Regular,Consolas,&#39;Liberation Mono&#39;,Menlo,monospace;font-size:=
12px;word-wrap:normal;white-space:pre">    <span class=3D"pl-c1" style=3D"b=
ox-sizing:border-box;color:rgb(0,92,197)">uint8_t</span> sreg;</td></tr><tr=
 style=3D"box-sizing:border-box"><td id=3D"L222" class=3D"blob-num js-line-=
number" style=3D"box-sizing:border-box;padding:0px 10px;width:50px;min-widt=
h:50px;font-family:SFMono-Regular,Consolas,&#39;Liberation Mono&#39;,Menlo,=
monospace;font-size:12px;line-height:20px;color:rgba(27,31,35,0.298039);tex=
t-align:right;white-space:nowrap;vertical-align:top"></td><td id=3D"LC222" =
class=3D"blob-code blob-code-inner js-file-line" style=3D"box-sizing:border=
-box;padding:0px 10px;line-height:20px;vertical-align:top;overflow:visible;=
font-family:SFMono-Regular,Consolas,&#39;Liberation Mono&#39;,Menlo,monospa=
ce;font-size:12px;word-wrap:normal;white-space:pre">    sreg =3D (env-&gt;<=
span class=3D"pl-smi" style=3D"box-sizing:border-box">sregC</span> &amp; <s=
pan class=3D"pl-c1" style=3D"box-sizing:border-box;color:rgb(0,92,197)">0x0=
1</span>) &lt;&lt; <span class=3D"pl-c1" style=3D"box-sizing:border-box;col=
or:rgb(0,92,197)">0</span></td></tr><tr style=3D"box-sizing:border-box"><td=
 id=3D"L223" class=3D"blob-num js-line-number" style=3D"box-sizing:border-b=
ox;padding:0px 10px;width:50px;min-width:50px;font-family:SFMono-Regular,Co=
nsolas,&#39;Liberation Mono&#39;,Menlo,monospace;font-size:12px;line-height=
:20px;color:rgba(27,31,35,0.298039);text-align:right;white-space:nowrap;ver=
tical-align:top"></td><td id=3D"LC223" class=3D"blob-code blob-code-inner j=
s-file-line" style=3D"box-sizing:border-box;padding:0px 10px;line-height:20=
px;vertical-align:top;overflow:visible;font-family:SFMono-Regular,Consolas,=
&#39;Liberation Mono&#39;,Menlo,monospace;font-size:12px;word-wrap:normal;w=
hite-space:pre">         | (env-&gt;<span class=3D"pl-smi" style=3D"box-siz=
ing:border-box">sregZ</span> =3D=3D <span class=3D"pl-c1" style=3D"box-sizi=
ng:border-box;color:rgb(0,92,197)">0</span> ? <span class=3D"pl-c1" style=
=3D"box-sizing:border-box;color:rgb(0,92,197)">1</span> : <span class=3D"pl=
-c1" style=3D"box-sizing:border-box;color:rgb(0,92,197)">0</span>) &lt;&lt;=
 <span class=3D"pl-c1" style=3D"box-sizing:border-box;color:rgb(0,92,197)">=
1</span></td></tr><tr style=3D"box-sizing:border-box"><td id=3D"L224" class=
=3D"blob-num js-line-number" style=3D"box-sizing:border-box;padding:0px 10p=
x;width:50px;min-width:50px;font-family:SFMono-Regular,Consolas,&#39;Libera=
tion Mono&#39;,Menlo,monospace;font-size:12px;line-height:20px;color:rgba(2=
7,31,35,0.298039);text-align:right;white-space:nowrap;vertical-align:top"><=
/td><td id=3D"LC224" class=3D"blob-code blob-code-inner js-file-line" style=
=3D"box-sizing:border-box;padding:0px 10px;line-height:20px;vertical-align:=
top;overflow:visible;font-family:SFMono-Regular,Consolas,&#39;Liberation Mo=
no&#39;,Menlo,monospace;font-size:12px;word-wrap:normal;white-space:pre">  =
       | (env-&gt;<span class=3D"pl-smi" style=3D"box-sizing:border-box">sr=
egN</span>) &lt;&lt; <span class=3D"pl-c1" style=3D"box-sizing:border-box;c=
olor:rgb(0,92,197)">2</span></td></tr><tr style=3D"box-sizing:border-box"><=
td id=3D"L225" class=3D"blob-num js-line-number" style=3D"box-sizing:border=
-box;padding:0px 10px;width:50px;min-width:50px;font-family:SFMono-Regular,=
Consolas,&#39;Liberation Mono&#39;,Menlo,monospace;font-size:12px;line-heig=
ht:20px;color:rgba(27,31,35,0.298039);text-align:right;white-space:nowrap;v=
ertical-align:top"></td><td id=3D"LC225" class=3D"blob-code blob-code-inner=
 js-file-line" style=3D"box-sizing:border-box;padding:0px 10px;line-height:=
20px;vertical-align:top;overflow:visible;font-family:SFMono-Regular,Consola=
s,&#39;Liberation Mono&#39;,Menlo,monospace;font-size:12px;word-wrap:normal=
;white-space:pre">         | (env-&gt;<span class=3D"pl-smi" style=3D"box-s=
izing:border-box">sregV</span>) &lt;&lt; <span class=3D"pl-c1" style=3D"box=
-sizing:border-box;color:rgb(0,92,197)">3</span></td></tr><tr style=3D"box-=
sizing:border-box"><td id=3D"L226" class=3D"blob-num js-line-number" style=
=3D"box-sizing:border-box;padding:0px 10px;width:50px;min-width:50px;font-f=
amily:SFMono-Regular,Consolas,&#39;Liberation Mono&#39;,Menlo,monospace;fon=
t-size:12px;line-height:20px;color:rgba(27,31,35,0.298039);text-align:right=
;white-space:nowrap;vertical-align:top"></td><td id=3D"LC226" class=3D"blob=
-code blob-code-inner js-file-line" style=3D"box-sizing:border-box;padding:=
0px 10px;line-height:20px;vertical-align:top;overflow:visible;font-family:S=
FMono-Regular,Consolas,&#39;Liberation Mono&#39;,Menlo,monospace;font-size:=
12px;word-wrap:normal;white-space:pre">         | (env-&gt;<span class=3D"p=
l-smi" style=3D"box-sizing:border-box">sregS</span>) &lt;&lt; <span class=
=3D"pl-c1" style=3D"box-sizing:border-box;color:rgb(0,92,197)">4</span></td=
></tr><tr style=3D"box-sizing:border-box"><td id=3D"L227" class=3D"blob-num=
 js-line-number" style=3D"box-sizing:border-box;padding:0px 10px;width:50px=
;min-width:50px;font-family:SFMono-Regular,Consolas,&#39;Liberation Mono&#3=
9;,Menlo,monospace;font-size:12px;line-height:20px;color:rgba(27,31,35,0.29=
8039);text-align:right;white-space:nowrap;vertical-align:top"></td><td id=
=3D"LC227" class=3D"blob-code blob-code-inner js-file-line" style=3D"box-si=
zing:border-box;padding:0px 10px;line-height:20px;vertical-align:top;overfl=
ow:visible;font-family:SFMono-Regular,Consolas,&#39;Liberation Mono&#39;,Me=
nlo,monospace;font-size:12px;word-wrap:normal;white-space:pre">         | (=
env-&gt;<span class=3D"pl-smi" style=3D"box-sizing:border-box">sregH</span>=
) &lt;&lt; <span class=3D"pl-c1" style=3D"box-sizing:border-box;color:rgb(0=
,92,197)">5</span></td></tr><tr style=3D"box-sizing:border-box"><td id=3D"L=
228" class=3D"blob-num js-line-number" style=3D"box-sizing:border-box;paddi=
ng:0px 10px;width:50px;min-width:50px;font-family:SFMono-Regular,Consolas,&=
#39;Liberation Mono&#39;,Menlo,monospace;font-size:12px;line-height:20px;co=
lor:rgba(27,31,35,0.298039);text-align:right;white-space:nowrap;vertical-al=
ign:top"></td><td id=3D"LC228" class=3D"blob-code blob-code-inner js-file-l=
ine" style=3D"box-sizing:border-box;padding:0px 10px;line-height:20px;verti=
cal-align:top;overflow:visible;font-family:SFMono-Regular,Consolas,&#39;Lib=
eration Mono&#39;,Menlo,monospace;font-size:12px;word-wrap:normal;white-spa=
ce:pre">         | (env-&gt;<span class=3D"pl-smi" style=3D"box-sizing:bord=
er-box">sregT</span>) &lt;&lt; <span class=3D"pl-c1" style=3D"box-sizing:bo=
rder-box;color:rgb(0,92,197)">6</span></td></tr><tr style=3D"box-sizing:bor=
der-box"><td id=3D"L229" class=3D"blob-num js-line-number" style=3D"box-siz=
ing:border-box;padding:0px 10px;width:50px;min-width:50px;font-family:SFMon=
o-Regular,Consolas,&#39;Liberation Mono&#39;,Menlo,monospace;font-size:12px=
;line-height:20px;color:rgba(27,31,35,0.298039);text-align:right;white-spac=
e:nowrap;vertical-align:top"></td><td id=3D"LC229" class=3D"blob-code blob-=
code-inner js-file-line" style=3D"box-sizing:border-box;padding:0px 10px;li=
ne-height:20px;vertical-align:top;overflow:visible;font-family:SFMono-Regul=
ar,Consolas,&#39;Liberation Mono&#39;,Menlo,monospace;font-size:12px;word-w=
rap:normal;white-space:pre">         | (env-&gt;<span class=3D"pl-smi" styl=
e=3D"box-sizing:border-box">sregI</span>) &lt;&lt; <span class=3D"pl-c1" st=
yle=3D"box-sizing:border-box;color:rgb(0,92,197)">7</span>;</td></tr><tr st=
yle=3D"box-sizing:border-box"><td id=3D"L230" class=3D"blob-num js-line-num=
ber" style=3D"box-sizing:border-box;padding:0px 10px;width:50px;min-width:5=
0px;font-family:SFMono-Regular,Consolas,&#39;Liberation Mono&#39;,Menlo,mon=
ospace;font-size:12px;line-height:20px;color:rgba(27,31,35,0.298039);text-a=
lign:right;white-space:nowrap;vertical-align:top"></td><td id=3D"LC230" cla=
ss=3D"blob-code blob-code-inner js-file-line" style=3D"box-sizing:border-bo=
x;padding:0px 10px;line-height:20px;vertical-align:top;overflow:visible;fon=
t-family:SFMono-Regular,Consolas,&#39;Liberation Mono&#39;,Menlo,monospace;=
font-size:12px;word-wrap:normal;white-space:pre">    <span class=3D"pl-k" s=
tyle=3D"box-sizing:border-box;color:rgb(215,58,73)">return</span> sreg;</td=
></tr><tr style=3D"box-sizing:border-box"><td id=3D"L231" class=3D"blob-num=
 js-line-number" style=3D"box-sizing:border-box;padding:0px 10px;width:50px=
;min-width:50px;font-family:SFMono-Regular,Consolas,&#39;Liberation Mono&#3=
9;,Menlo,monospace;font-size:12px;line-height:20px;color:rgba(27,31,35,0.29=
8039);text-align:right;white-space:nowrap;vertical-align:top"></td><td id=
=3D"LC231" class=3D"blob-code blob-code-inner js-file-line" style=3D"box-si=
zing:border-box;padding:0px 10px;line-height:20px;vertical-align:top;overfl=
ow:visible;font-family:SFMono-Regular,Consolas,&#39;Liberation Mono&#39;,Me=
nlo,monospace;font-size:12px;word-wrap:normal;white-space:pre">}</td></tr><=
tr style=3D"box-sizing:border-box"><td id=3D"L232" class=3D"blob-num js-lin=
e-number" style=3D"box-sizing:border-box;padding:0px 10px;width:50px;min-wi=
dth:50px;font-family:SFMono-Regular,Consolas,&#39;Liberation Mono&#39;,Menl=
o,monospace;font-size:12px;line-height:20px;color:rgba(27,31,35,0.298039);t=
ext-align:right;white-space:nowrap;vertical-align:top"></td><td id=3D"LC232=
" class=3D"blob-code blob-code-inner js-file-line" style=3D"box-sizing:bord=
er-box;padding:0px 10px;line-height:20px;vertical-align:top;overflow:visibl=
e;font-family:SFMono-Regular,Consolas,&#39;Liberation Mono&#39;,Menlo,monos=
pace;font-size:12px;word-wrap:normal;white-space:pre">
</td></tr><tr style=3D"box-sizing:border-box"><td id=3D"L233" class=3D"blob=
-num js-line-number" style=3D"box-sizing:border-box;padding:0px 10px;width:=
50px;min-width:50px;font-family:SFMono-Regular,Consolas,&#39;Liberation Mon=
o&#39;,Menlo,monospace;font-size:12px;line-height:20px;color:rgba(27,31,35,=
0.298039);text-align:right;white-space:nowrap;vertical-align:top"></td><td =
id=3D"LC233" class=3D"blob-code blob-code-inner js-file-line" style=3D"box-=
sizing:border-box;padding:0px 10px;line-height:20px;vertical-align:top;over=
flow:visible;font-family:SFMono-Regular,Consolas,&#39;Liberation Mono&#39;,=
Menlo,monospace;font-size:12px;word-wrap:normal;white-space:pre"><span clas=
s=3D"pl-k" style=3D"box-sizing:border-box;color:rgb(215,58,73)">static</spa=
n> <span class=3D"pl-k" style=3D"box-sizing:border-box;color:rgb(215,58,73)=
">inline</span> <span class=3D"pl-k" style=3D"box-sizing:border-box;color:r=
gb(215,58,73)">void</span> <span class=3D"pl-en" style=3D"box-sizing:border=
-box;color:rgb(111,66,193)">cpu_set_sreg</span>(CPUAVRState *env, <span cla=
ss=3D"pl-c1" style=3D"box-sizing:border-box;color:rgb(0,92,197)">uint8_t</s=
pan> sreg)</td></tr><tr style=3D"box-sizing:border-box"><td id=3D"L234" cla=
ss=3D"blob-num js-line-number" style=3D"box-sizing:border-box;padding:0px 1=
0px;width:50px;min-width:50px;font-family:SFMono-Regular,Consolas,&#39;Libe=
ration Mono&#39;,Menlo,monospace;font-size:12px;line-height:20px;color:rgba=
(27,31,35,0.298039);text-align:right;white-space:nowrap;vertical-align:top"=
></td><td id=3D"LC234" class=3D"blob-code blob-code-inner js-file-line" sty=
le=3D"box-sizing:border-box;padding:0px 10px;line-height:20px;vertical-alig=
n:top;overflow:visible;font-family:SFMono-Regular,Consolas,&#39;Liberation =
Mono&#39;,Menlo,monospace;font-size:12px;word-wrap:normal;white-space:pre">=
{</td></tr><tr style=3D"box-sizing:border-box"><td id=3D"L235" class=3D"blo=
b-num js-line-number" style=3D"box-sizing:border-box;padding:0px 10px;width=
:50px;min-width:50px;font-family:SFMono-Regular,Consolas,&#39;Liberation Mo=
no&#39;,Menlo,monospace;font-size:12px;line-height:20px;color:rgba(27,31,35=
,0.298039);text-align:right;white-space:nowrap;vertical-align:top"></td><td=
 id=3D"LC235" class=3D"blob-code blob-code-inner js-file-line" style=3D"box=
-sizing:border-box;padding:0px 10px;line-height:20px;vertical-align:top;ove=
rflow:visible;font-family:SFMono-Regular,Consolas,&#39;Liberation Mono&#39;=
,Menlo,monospace;font-size:12px;word-wrap:normal;white-space:pre">    env-&=
gt;<span class=3D"pl-smi" style=3D"box-sizing:border-box">sregC</span> =3D =
(sreg &gt;&gt; <span class=3D"pl-c1" style=3D"box-sizing:border-box;color:r=
gb(0,92,197)">0</span>) &amp; <span class=3D"pl-c1" style=3D"box-sizing:bor=
der-box;color:rgb(0,92,197)">0x01</span>;</td></tr><tr style=3D"box-sizing:=
border-box"><td id=3D"L236" class=3D"blob-num js-line-number" style=3D"box-=
sizing:border-box;padding:0px 10px;width:50px;min-width:50px;font-family:SF=
Mono-Regular,Consolas,&#39;Liberation Mono&#39;,Menlo,monospace;font-size:1=
2px;line-height:20px;color:rgba(27,31,35,0.298039);text-align:right;white-s=
pace:nowrap;vertical-align:top"></td><td id=3D"LC236" class=3D"blob-code bl=
ob-code-inner js-file-line" style=3D"box-sizing:border-box;padding:0px 10px=
;line-height:20px;vertical-align:top;overflow:visible;font-family:SFMono-Re=
gular,Consolas,&#39;Liberation Mono&#39;,Menlo,monospace;font-size:12px;wor=
d-wrap:normal;white-space:pre">    env-&gt;<span class=3D"pl-smi" style=3D"=
box-sizing:border-box">sregZ</span> =3D (sreg &gt;&gt; <span class=3D"pl-c1=
" style=3D"box-sizing:border-box;color:rgb(0,92,197)">1</span>) &amp; <span=
 class=3D"pl-c1" style=3D"box-sizing:border-box;color:rgb(0,92,197)">0x01</=
span> ? <span class=3D"pl-c1" style=3D"box-sizing:border-box;color:rgb(0,92=
,197)">0</span> : <span class=3D"pl-c1" style=3D"box-sizing:border-box;colo=
r:rgb(0,92,197)">1</span>;</td></tr><tr style=3D"box-sizing:border-box"><td=
 id=3D"L237" class=3D"blob-num js-line-number" style=3D"box-sizing:border-b=
ox;padding:0px 10px;width:50px;min-width:50px;font-family:SFMono-Regular,Co=
nsolas,&#39;Liberation Mono&#39;,Menlo,monospace;font-size:12px;line-height=
:20px;color:rgba(27,31,35,0.298039);text-align:right;white-space:nowrap;ver=
tical-align:top"></td><td id=3D"LC237" class=3D"blob-code blob-code-inner j=
s-file-line" style=3D"box-sizing:border-box;padding:0px 10px;line-height:20=
px;vertical-align:top;overflow:visible;font-family:SFMono-Regular,Consolas,=
&#39;Liberation Mono&#39;,Menlo,monospace;font-size:12px;word-wrap:normal;w=
hite-space:pre">    env-&gt;<span class=3D"pl-smi" style=3D"box-sizing:bord=
er-box">sregN</span> =3D (sreg &gt;&gt; <span class=3D"pl-c1" style=3D"box-=
sizing:border-box;color:rgb(0,92,197)">2</span>) &amp; <span class=3D"pl-c1=
" style=3D"box-sizing:border-box;color:rgb(0,92,197)">0x01</span>;</td></tr=
><tr style=3D"box-sizing:border-box"><td id=3D"L238" class=3D"blob-num js-l=
ine-number" style=3D"box-sizing:border-box;padding:0px 10px;width:50px;min-=
width:50px;font-family:SFMono-Regular,Consolas,&#39;Liberation Mono&#39;,Me=
nlo,monospace;font-size:12px;line-height:20px;color:rgba(27,31,35,0.298039)=
;text-align:right;white-space:nowrap;vertical-align:top"></td><td id=3D"LC2=
38" class=3D"blob-code blob-code-inner js-file-line" style=3D"box-sizing:bo=
rder-box;padding:0px 10px;line-height:20px;vertical-align:top;overflow:visi=
ble;font-family:SFMono-Regular,Consolas,&#39;Liberation Mono&#39;,Menlo,mon=
ospace;font-size:12px;word-wrap:normal;white-space:pre">    env-&gt;<span c=
lass=3D"pl-smi" style=3D"box-sizing:border-box">sregV</span> =3D (sreg &gt;=
&gt; <span class=3D"pl-c1" style=3D"box-sizing:border-box;color:rgb(0,92,19=
7)">3</span>) &amp; <span class=3D"pl-c1" style=3D"box-sizing:border-box;co=
lor:rgb(0,92,197)">0x01</span>;</td></tr><tr style=3D"box-sizing:border-box=
"><td id=3D"L239" class=3D"blob-num js-line-number" style=3D"box-sizing:bor=
der-box;padding:0px 10px;width:50px;min-width:50px;font-family:SFMono-Regul=
ar,Consolas,&#39;Liberation Mono&#39;,Menlo,monospace;font-size:12px;line-h=
eight:20px;color:rgba(27,31,35,0.298039);text-align:right;white-space:nowra=
p;vertical-align:top"></td><td id=3D"LC239" class=3D"blob-code blob-code-in=
ner js-file-line" style=3D"box-sizing:border-box;padding:0px 10px;line-heig=
ht:20px;vertical-align:top;overflow:visible;font-family:SFMono-Regular,Cons=
olas,&#39;Liberation Mono&#39;,Menlo,monospace;font-size:12px;word-wrap:nor=
mal;white-space:pre">    env-&gt;<span class=3D"pl-smi" style=3D"box-sizing=
:border-box">sregS</span> =3D (sreg &gt;&gt; <span class=3D"pl-c1" style=3D=
"box-sizing:border-box;color:rgb(0,92,197)">4</span>) &amp; <span class=3D"=
pl-c1" style=3D"box-sizing:border-box;color:rgb(0,92,197)">0x01</span>;</td=
></tr><tr style=3D"box-sizing:border-box"><td id=3D"L240" class=3D"blob-num=
 js-line-number" style=3D"box-sizing:border-box;padding:0px 10px;width:50px=
;min-width:50px;font-family:SFMono-Regular,Consolas,&#39;Liberation Mono&#3=
9;,Menlo,monospace;font-size:12px;line-height:20px;color:rgba(27,31,35,0.29=
8039);text-align:right;white-space:nowrap;vertical-align:top"></td><td id=
=3D"LC240" class=3D"blob-code blob-code-inner js-file-line" style=3D"box-si=
zing:border-box;padding:0px 10px;line-height:20px;vertical-align:top;overfl=
ow:visible;font-family:SFMono-Regular,Consolas,&#39;Liberation Mono&#39;,Me=
nlo,monospace;font-size:12px;word-wrap:normal;white-space:pre">    env-&gt;=
<span class=3D"pl-smi" style=3D"box-sizing:border-box">sregH</span> =3D (sr=
eg &gt;&gt; <span class=3D"pl-c1" style=3D"box-sizing:border-box;color:rgb(=
0,92,197)">5</span>) &amp; <span class=3D"pl-c1" style=3D"box-sizing:border=
-box;color:rgb(0,92,197)">0x01</span>;</td></tr><tr style=3D"box-sizing:bor=
der-box"><td id=3D"L241" class=3D"blob-num js-line-number" style=3D"box-siz=
ing:border-box;padding:0px 10px;width:50px;min-width:50px;font-family:SFMon=
o-Regular,Consolas,&#39;Liberation Mono&#39;,Menlo,monospace;font-size:12px=
;line-height:20px;color:rgba(27,31,35,0.298039);text-align:right;white-spac=
e:nowrap;vertical-align:top"></td><td id=3D"LC241" class=3D"blob-code blob-=
code-inner js-file-line" style=3D"box-sizing:border-box;padding:0px 10px;li=
ne-height:20px;vertical-align:top;overflow:visible;font-family:SFMono-Regul=
ar,Consolas,&#39;Liberation Mono&#39;,Menlo,monospace;font-size:12px;word-w=
rap:normal;white-space:pre">    env-&gt;<span class=3D"pl-smi" style=3D"box=
-sizing:border-box">sregT</span> =3D (sreg &gt;&gt; <span class=3D"pl-c1" s=
tyle=3D"box-sizing:border-box;color:rgb(0,92,197)">6</span>) &amp; <span cl=
ass=3D"pl-c1" style=3D"box-sizing:border-box;color:rgb(0,92,197)">0x01</spa=
n>;</td></tr><tr style=3D"box-sizing:border-box"><td id=3D"L242" class=3D"b=
lob-num js-line-number" style=3D"box-sizing:border-box;padding:0px 10px;wid=
th:50px;min-width:50px;font-family:SFMono-Regular,Consolas,&#39;Liberation =
Mono&#39;,Menlo,monospace;font-size:12px;line-height:20px;color:rgba(27,31,=
35,0.298039);text-align:right;white-space:nowrap;vertical-align:top"></td><=
td id=3D"LC242" class=3D"blob-code blob-code-inner js-file-line" style=3D"b=
ox-sizing:border-box;padding:0px 10px;line-height:20px;vertical-align:top;o=
verflow:visible;font-family:SFMono-Regular,Consolas,&#39;Liberation Mono&#3=
9;,Menlo,monospace;font-size:12px;word-wrap:normal;white-space:pre">    env=
-&gt;<span class=3D"pl-smi" style=3D"box-sizing:border-box">sregI</span> =
=3D (sreg &gt;&gt; <span class=3D"pl-c1" style=3D"box-sizing:border-box;col=
or:rgb(0,92,197)">7</span>) &amp; <span class=3D"pl-c1" style=3D"box-sizing=
:border-box;color:rgb(0,92,197)">0x01</span>;</td></tr><tr style=3D"box-siz=
ing:border-box"><td id=3D"L243" class=3D"blob-num js-line-number" style=3D"=
box-sizing:border-box;padding:0px 10px;width:50px;min-width:50px;font-famil=
y:SFMono-Regular,Consolas,&#39;Liberation Mono&#39;,Menlo,monospace;font-si=
ze:12px;line-height:20px;color:rgba(27,31,35,0.298039);text-align:right;whi=
te-space:nowrap;vertical-align:top"></td><td id=3D"LC243" class=3D"blob-cod=
e blob-code-inner js-file-line" style=3D"box-sizing:border-box;padding:0px =
10px;line-height:20px;vertical-align:top;overflow:visible;font-family:SFMon=
o-Regular,Consolas,&#39;Liberation Mono&#39;,Menlo,monospace;font-size:12px=
;word-wrap:normal;white-space:pre">}</td></tr></tbody></table></div><div>=
=C2=A0?</div><div><br></div><div><br></div><div>Thanks,</div><div>A.</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex"><br></blockquote><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">=C2=A0they are calculated here<br>
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

--000000000000ffa3cc05952b73c6--

