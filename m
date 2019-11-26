Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91CDC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 20:43:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CFA520862
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 20:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOpabZbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CFA520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZhgP-0007fr-GR
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 15:43:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iZheb-0006nX-Ve
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 15:41:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iZheZ-0007mE-ND
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 15:41:45 -0500
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:33958)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iZheZ-0007lG-HD
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 15:41:43 -0500
Received: by mail-qt1-x842.google.com with SMTP id i17so22943089qtq.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 12:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gBAMQHPt91TGMLvQK37duKjPHEWnakH+78TgrySypUM=;
 b=dOpabZbf/DVqNswwGM0ALIaxvXm77fl0RJk4tqB7kqXMLkyF9nSs+dX+7l0bEe0M/K
 4+O1OIfaMy6CpKOI+UC3rBUXWfYZ6sVkXB3AB+ea49ILXNcsc7Z7vgaeOK0oHIFc0gET
 fvmQSwypEZFgTmz8253Sx1Ho9M/gmnYTZbunPlb36j45cDi4R0SSBbcZF540QJuhuUQp
 lGewjY9UqSUoEUaGjgW8CGwBDyTRRZP/SrjEa3gSnbbtNYLVg94lug2/1FcmBaJpVzcx
 m3wEPtjJcQS7DHo1KeBnucunmF0u6bqWHZCEBJuaXXCqj+qOAJCE0upXSWtMHEt00VPt
 U2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gBAMQHPt91TGMLvQK37duKjPHEWnakH+78TgrySypUM=;
 b=WyIOJ0mcyXjlflyrVGZrDE3jtX07kjRrlx+vuC1Q68AW04uJckp+P4Aflcny/9zb3N
 s60HnC5XulzqjBp0De4Z+CfSI9L2YQNTI0ri9zBKgz1XI38Ok+S7G2k6Ahn6BpS1YDBe
 ZC4if8v6vhjT869955/i3AVA6nyY2dfWFRSUWWPtUM08yUUAp6Xt2vlRiN+qUya2i2Og
 otSNfk17RNV1D+JVSdFqCjFwIvPhHV5A24KHRIrynl4itLPEuJnjwWLXciDpzViPFlBm
 mzA0T53iv4iPzwXoxIfDgebChi1R8w6m/ibmMcBprRGi2Ji4ZvxoErN6So8R5BNJYhEN
 6nIQ==
X-Gm-Message-State: APjAAAW4cDfVNyP4sRte2Vagq+g1Jt/HWBod6gQFCDSayV93BwUCgcAv
 qsCcFefNLlAtPqZ+VW+ZVOODfTnrKfjEHW9pU2k=
X-Google-Smtp-Source: APXvYqz06BwmF/tJxRMtL11fW4rvm/mTic0J9W74vjTaVRg9+mtUmr1xyMKgwVbULP+WgLashFJW0BBN73ka+c4C/Yk=
X-Received: by 2002:ac8:5516:: with SMTP id j22mr3513332qtq.160.1574800902508; 
 Tue, 26 Nov 2019 12:41:42 -0800 (PST)
MIME-Version: 1.0
References: <20191124050225.30351-1-mrolnik@gmail.com>
 <20191124050225.30351-5-mrolnik@gmail.com>
 <CAL1e-=gvZsJQVZJDpzw2J9XTmafrwWmZwcnXd4B0oAJzde7NwQ@mail.gmail.com>
In-Reply-To: <CAL1e-=gvZsJQVZJDpzw2J9XTmafrwWmZwcnXd4B0oAJzde7NwQ@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Tue, 26 Nov 2019 22:40:35 +0200
Message-ID: <CAK4993h03JLkmbGn9_hd4XEWpzrEo4nj7DqLZUBWyA-iZOC=tw@mail.gmail.com>
Subject: Re: [PATCH v36 04/17] target/avr: Add instruction translation -
 Registers definition
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000062d6ef059845e89f"
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
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000062d6ef059845e89f
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 26, 2019 at 9:48 PM Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

> On Sun, Nov 24, 2019 at 6:03 AM Michael Rolnik <mrolnik@gmail.com> wrote:
> >
> > Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> > ---
> >  target/avr/translate.c | 132 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 132 insertions(+)
> >  create mode 100644 target/avr/translate.c
> >
> > diff --git a/target/avr/translate.c b/target/avr/translate.c
> > new file mode 100644
> > index 0000000000..53c9892a60
> > --- /dev/null
> > +++ b/target/avr/translate.c
> > @@ -0,0 +1,132 @@
> > +/*
> > + * QEMU AVR CPU
> > + *
> > + * Copyright (c) 2019 Michael Rolnik
> > + *
> > + * This library is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU Lesser General Public
> > + * License as published by the Free Software Foundation; either
> > + * version 2.1 of the License, or (at your option) any later version.
> > + *
> > + * This library is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * Lesser General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU Lesser General Public
> > + * License along with this library; if not, see
> > + * <http://www.gnu.org/licenses/lgpl-2.1.html>
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/qemu-print.h"
> > +#include "tcg/tcg.h"
> > +#include "cpu.h"
> > +#include "exec/exec-all.h"
> > +#include "disas/disas.h"
> > +#include "tcg-op.h"
> > +#include "exec/cpu_ldst.h"
> > +#include "exec/helper-proto.h"
> > +#include "exec/helper-gen.h"
> > +#include "exec/log.h"
> > +#include "exec/gdbstub.h"
> > +#include "exec/translator.h"
> > +#include "exec/gen-icount.h"
> > +
> > +/*
> > + *  Define if you want a BREAK instruction translated to a breakpoint
> > + *  Active debugging connection is assumed
> > + *  This is for
> > + *
> https://github.com/seharris/qemu-avr-tests/tree/master/instruction-tests
> > + *  tests
> > + */
> > +#undef BREAKPOINT_ON_BREAK
> > +
> > +static TCGv cpu_pc;
> > +
> > +static TCGv cpu_Cf;
> > +static TCGv cpu_Zf;
> > +static TCGv cpu_Nf;
> > +static TCGv cpu_Vf;
> > +static TCGv cpu_Sf;
> > +static TCGv cpu_Hf;
> > +static TCGv cpu_Tf;
> > +static TCGv cpu_If;
> > +
> > +static TCGv cpu_rampD;
> > +static TCGv cpu_rampX;
> > +static TCGv cpu_rampY;
> > +static TCGv cpu_rampZ;
> > +
> > +static TCGv cpu_r[NO_CPU_REGISTERS];
> > +static TCGv cpu_eind;
> > +static TCGv cpu_sp;
> > +
> > +static TCGv cpu_skip;
> > +
> > +static const char reg_names[NO_CPU_REGISTERS][8] = {
> > +    "r0",  "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
> > +    "r8",  "r9",  "r10", "r11", "r12", "r13", "r14", "r15",
> > +    "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
> > +    "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
> > +};
> > +#define REG(x) (cpu_r[x])
> > +
> > +enum {
> > +    DISAS_EXIT   = DISAS_TARGET_0,  /* We want return to the cpu main
> loop.  */
> > +    DISAS_LOOKUP = DISAS_TARGET_1,  /* We have a variable condition
> exit.  */
> > +    DISAS_CHAIN  = DISAS_TARGET_2,  /* We have a single condition
> exit.  */
> > +};
> > +
> > +typedef struct DisasContext DisasContext;
> > +
> > +/* This is the state at translation time. */
> > +struct DisasContext {
> > +    TranslationBlock *tb;
> > +
> > +    CPUAVRState *env;
> > +    CPUState *cs;
> > +
> > +    target_long npc;
> > +    uint32_t opcode;
> > +
> > +    /* Routine used to access memory */
> > +    int memidx;
> > +    int bstate;
> > +    int singlestep;
> > +
> > +    TCGv skip_var0;
> > +    TCGv skip_var1;
> > +    TCGCond skip_cond;
> > +    bool free_skip_var0;
>
> This set of four lines are by far the hardest to connect to the
> documentation.
>
> Please add before them a sizable comment with explanations for:
>
> - the reson these variables are introduced
> - why are they here (part of DisasContext)
> - what they affect
> - summary of the way they work
>
> Perhaps add comments to other places where "skip"-related data fields
> are introduced.
>
> (I believe the implementation is correct, but it is extremely hard to the
> reader
> to reverse-engineer the intentions)
>
> Yours,
> Aleksandar
>

Aleksandar,

My original implementation was different. This piece of code belongs to
Richard (he also listed as a co developer). so, if Richard has time, I
prefer him to answer otherwise I will try to explain myself.

Regards,
Michael

>
> > +};
> > +
> > +static int to_A(DisasContext *ctx, int indx) { return 16 + (indx % 16);
> }
> > +static int to_B(DisasContext *ctx, int indx) { return 16 + (indx % 8); }
> > +static int to_C(DisasContext *ctx, int indx) { return 24 + (indx % 4) *
> 2; }
> > +static int to_D(DisasContext *ctx, int indx) { return (indx % 16) * 2; }
> > +
> > +static uint16_t next_word(DisasContext *ctx)
> > +{
> > +    return cpu_lduw_code(ctx->env, ctx->npc++ * 2);
> > +}
> > +
> > +static int append_16(DisasContext *ctx, int x)
> > +{
> > +    return x << 16 | next_word(ctx);
> > +}
> > +
> > +
> > +static bool avr_have_feature(DisasContext *ctx, int feature)
> > +{
> > +    if (!avr_feature(ctx->env, feature)) {
> > +        gen_helper_unsupported(cpu_env);
> > +        ctx->bstate = DISAS_NORETURN;
> > +        return false;
> > +    }
> > +    return true;
> > +}
> > +
> > +static bool decode_insn(DisasContext *ctx, uint16_t insn);
> > +#include "decode_insn.inc.c"
> > +
> > --
> > 2.17.2 (Apple Git-113)
> >
>


-- 
Best Regards,
Michael Rolnik

--00000000000062d6ef059845e89f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 26, 2019 at 9:48 PM Aleks=
andar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com">aleksanda=
r.m.mail@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">On Sun, Nov 24, 2019 at 6:03 AM Michael Rolnik &lt;<a hre=
f=3D"mailto:mrolnik@gmail.com" target=3D"_blank">mrolnik@gmail.com</a>&gt; =
wrote:<br>
&gt;<br>
&gt; Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com"=
 target=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/avr/translate.c | 132 +++++++++++++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 1 file changed, 132 insertions(+)<br>
&gt;=C2=A0 create mode 100644 target/avr/translate.c<br>
&gt;<br>
&gt; diff --git a/target/avr/translate.c b/target/avr/translate.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..53c9892a60<br>
&gt; --- /dev/null<br>
&gt; +++ b/target/avr/translate.c<br>
&gt; @@ -0,0 +1,132 @@<br>
&gt; +/*<br>
&gt; + * QEMU AVR CPU<br>
&gt; + *<br>
&gt; + * Copyright (c) 2019 Michael Rolnik<br>
&gt; + *<br>
&gt; + * This library is free software; you can redistribute it and/or<br>
&gt; + * modify it under the terms of the GNU Lesser General Public<br>
&gt; + * License as published by the Free Software Foundation; either<br>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt; + *<br>
&gt; + * This library is distributed in the hope that it will be useful,<br=
>
&gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
 GNU<br>
&gt; + * Lesser General Public License for more details.<br>
&gt; + *<br>
&gt; + * You should have received a copy of the GNU Lesser General Public<b=
r>
&gt; + * License along with this library; if not, see<br>
&gt; + * &lt;<a href=3D"http://www.gnu.org/licenses/lgpl-2.1.html" rel=3D"n=
oreferrer" target=3D"_blank">http://www.gnu.org/licenses/lgpl-2.1.html</a>&=
gt;<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;qemu/qemu-print.h&quot;<br>
&gt; +#include &quot;tcg/tcg.h&quot;<br>
&gt; +#include &quot;cpu.h&quot;<br>
&gt; +#include &quot;exec/exec-all.h&quot;<br>
&gt; +#include &quot;disas/disas.h&quot;<br>
&gt; +#include &quot;tcg-op.h&quot;<br>
&gt; +#include &quot;exec/cpu_ldst.h&quot;<br>
&gt; +#include &quot;exec/helper-proto.h&quot;<br>
&gt; +#include &quot;exec/helper-gen.h&quot;<br>
&gt; +#include &quot;exec/log.h&quot;<br>
&gt; +#include &quot;exec/gdbstub.h&quot;<br>
&gt; +#include &quot;exec/translator.h&quot;<br>
&gt; +#include &quot;exec/gen-icount.h&quot;<br>
&gt; +<br>
&gt; +/*<br>
&gt; + *=C2=A0 Define if you want a BREAK instruction translated to a break=
point<br>
&gt; + *=C2=A0 Active debugging connection is assumed<br>
&gt; + *=C2=A0 This is for<br>
&gt; + *=C2=A0 <a href=3D"https://github.com/seharris/qemu-avr-tests/tree/m=
aster/instruction-tests" rel=3D"noreferrer" target=3D"_blank">https://githu=
b.com/seharris/qemu-avr-tests/tree/master/instruction-tests</a><br>
&gt; + *=C2=A0 tests<br>
&gt; + */<br>
&gt; +#undef BREAKPOINT_ON_BREAK<br>
&gt; +<br>
&gt; +static TCGv cpu_pc;<br>
&gt; +<br>
&gt; +static TCGv cpu_Cf;<br>
&gt; +static TCGv cpu_Zf;<br>
&gt; +static TCGv cpu_Nf;<br>
&gt; +static TCGv cpu_Vf;<br>
&gt; +static TCGv cpu_Sf;<br>
&gt; +static TCGv cpu_Hf;<br>
&gt; +static TCGv cpu_Tf;<br>
&gt; +static TCGv cpu_If;<br>
&gt; +<br>
&gt; +static TCGv cpu_rampD;<br>
&gt; +static TCGv cpu_rampX;<br>
&gt; +static TCGv cpu_rampY;<br>
&gt; +static TCGv cpu_rampZ;<br>
&gt; +<br>
&gt; +static TCGv cpu_r[NO_CPU_REGISTERS];<br>
&gt; +static TCGv cpu_eind;<br>
&gt; +static TCGv cpu_sp;<br>
&gt; +<br>
&gt; +static TCGv cpu_skip;<br>
&gt; +<br>
&gt; +static const char reg_names[NO_CPU_REGISTERS][8] =3D {<br>
&gt; +=C2=A0 =C2=A0 &quot;r0&quot;,=C2=A0 &quot;r1&quot;,=C2=A0 &quot;r2&qu=
ot;,=C2=A0 &quot;r3&quot;,=C2=A0 &quot;r4&quot;,=C2=A0 &quot;r5&quot;,=C2=
=A0 &quot;r6&quot;,=C2=A0 &quot;r7&quot;,<br>
&gt; +=C2=A0 =C2=A0 &quot;r8&quot;,=C2=A0 &quot;r9&quot;,=C2=A0 &quot;r10&q=
uot;, &quot;r11&quot;, &quot;r12&quot;, &quot;r13&quot;, &quot;r14&quot;, &=
quot;r15&quot;,<br>
&gt; +=C2=A0 =C2=A0 &quot;r16&quot;, &quot;r17&quot;, &quot;r18&quot;, &quo=
t;r19&quot;, &quot;r20&quot;, &quot;r21&quot;, &quot;r22&quot;, &quot;r23&q=
uot;,<br>
&gt; +=C2=A0 =C2=A0 &quot;r24&quot;, &quot;r25&quot;, &quot;r26&quot;, &quo=
t;r27&quot;, &quot;r28&quot;, &quot;r29&quot;, &quot;r30&quot;, &quot;r31&q=
uot;,<br>
&gt; +};<br>
&gt; +#define REG(x) (cpu_r[x])<br>
&gt; +<br>
&gt; +enum {<br>
&gt; +=C2=A0 =C2=A0 DISAS_EXIT=C2=A0 =C2=A0=3D DISAS_TARGET_0,=C2=A0 /* We =
want return to the cpu main loop.=C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 DISAS_LOOKUP =3D DISAS_TARGET_1,=C2=A0 /* We have a var=
iable condition exit.=C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 DISAS_CHAIN=C2=A0 =3D DISAS_TARGET_2,=C2=A0 /* We have =
a single condition exit.=C2=A0 */<br>
&gt; +};<br>
&gt; +<br>
&gt; +typedef struct DisasContext DisasContext;<br>
&gt; +<br>
&gt; +/* This is the state at translation time. */<br>
&gt; +struct DisasContext {<br>
&gt; +=C2=A0 =C2=A0 TranslationBlock *tb;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env;<br>
&gt; +=C2=A0 =C2=A0 CPUState *cs;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 target_long npc;<br>
&gt; +=C2=A0 =C2=A0 uint32_t opcode;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Routine used to access memory */<br>
&gt; +=C2=A0 =C2=A0 int memidx;<br>
&gt; +=C2=A0 =C2=A0 int bstate;<br>
&gt; +=C2=A0 =C2=A0 int singlestep;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 TCGv skip_var0;<br>
&gt; +=C2=A0 =C2=A0 TCGv skip_var1;<br>
&gt; +=C2=A0 =C2=A0 TCGCond skip_cond;<br>
&gt; +=C2=A0 =C2=A0 bool free_skip_var0;<br>
<br>
This set of four lines are by far the hardest to connect to the documentati=
on.<br>
<br>
Please add before them a sizable comment with explanations for:<br>
<br>
- the reson these variables are introduced<br>
- why are they here (part of DisasContext)<br>
- what they affect<br>
- summary of the way they work<br>
<br>
Perhaps add comments to other places where &quot;skip&quot;-related data fi=
elds<br>
are introduced.<br>
<br>
(I believe the implementation is correct, but it is extremely hard to the r=
eader<br>
to reverse-engineer the intentions)<br>
<br>
Yours,<br>
Aleksandar<br></blockquote><div><br></div><div>Aleksandar,</div><div><br></=
div><div>My original implementation was different. This piece of code belon=
gs to Richard (he also listed as a co developer). so, if Richard has time, =
I prefer him to answer otherwise I will try to explain myself.</div><div><b=
r></div><div>Regards,</div><div>Michael=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
<br>
&gt; +};<br>
&gt; +<br>
&gt; +static int to_A(DisasContext *ctx, int indx) { return 16 + (indx % 16=
); }<br>
&gt; +static int to_B(DisasContext *ctx, int indx) { return 16 + (indx % 8)=
; }<br>
&gt; +static int to_C(DisasContext *ctx, int indx) { return 24 + (indx % 4)=
 * 2; }<br>
&gt; +static int to_D(DisasContext *ctx, int indx) { return (indx % 16) * 2=
; }<br>
&gt; +<br>
&gt; +static uint16_t next_word(DisasContext *ctx)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return cpu_lduw_code(ctx-&gt;env, ctx-&gt;npc++ * 2);<b=
r>
&gt; +}<br>
&gt; +<br>
&gt; +static int append_16(DisasContext *ctx, int x)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return x &lt;&lt; 16 | next_word(ctx);<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +static bool avr_have_feature(DisasContext *ctx, int feature)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (!avr_feature(ctx-&gt;env, feature)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_unsupported(cpu_env);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;bstate =3D DISAS_NORETURN;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool decode_insn(DisasContext *ctx, uint16_t insn);<br>
&gt; +#include &quot;decode_insn.inc.c&quot;<br>
&gt; +<br>
&gt; --<br>
&gt; 2.17.2 (Apple Git-113)<br>
&gt;<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div></div>

--00000000000062d6ef059845e89f--

