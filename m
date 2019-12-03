Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3ECC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 14:43:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C988D20661
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 14:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPY1ZLig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C988D20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic9OR-0008UM-RN
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 09:43:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59245)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ic97M-00021l-Ov
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 09:25:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ic97J-0006nK-7o
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 09:25:31 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832]:43654)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ic97B-0006ij-SI
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 09:25:24 -0500
Received: by mail-qt1-x832.google.com with SMTP id q8so3883761qtr.10
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 06:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gO0lQ3MIHFoxx1g92zJOdDn3wB4wzbGejnY3NcyNDyk=;
 b=XPY1ZLig6OT3QJn8/bnIdzms81GFp4QQaKb0geH6NClp6Gl6/HSIL0JFTj9RAYJLYq
 6PWbflhLO3DABxyio7qrAJOAUi3TkW4GlqSj4UO8lHCuiRi+nW8x9MStrGCYYFxcJqBt
 LLhknnNuYDPEdIgdXR7r39wWKsDRmkbMJvwvHqqADE4KRd8DXiisiE5G7krWgMXsRQa9
 qO0MMxbXAz0JvRwSS8tAh+uEWIgpBMGni0ETmqFvLy72+g02GGIC1p8dddICJm7XCJfl
 KWGZmlTHMsV0RpSyN3BwlKjn77xGIvDBqHqsklDysHSBQJgqTtoOW4N+BFtUrwzyovW/
 UMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gO0lQ3MIHFoxx1g92zJOdDn3wB4wzbGejnY3NcyNDyk=;
 b=YpJnfaRAHZtbP7Q+LS0hMG9S6osJAPVXkSQcnrSh/mw+8/pGHCfwmlqoCRX/dlym2b
 iUyX+p5gw7uXfilt1Iam/qc1iboQsDSknsztakIo6sv3heGaMyx9/ZL71nCHeDH/Pxs4
 jVIWtWIgXEyot/HJaFv8hpChoL4RT/mgPZgCfoEACEIhWH2CaCBHkoCmyNfd3QIJ6tFk
 D6MrOKwhlz88kNSVlPLnIC5OA+IdY/E6h3lKznW4Xx6DdayOo7O5K7SisnGL6+Ae/gO1
 NW6aMmMGANcz3eLUMrR4rV7XTZDO0KXQJBcspKHZGcrTba+DPDljwIgRNP/lq9nn2F6f
 YzCA==
X-Gm-Message-State: APjAAAXwM6NHTat0yUYfWXLHZNtB8iyZ2ppe/t27yiTkiQk9F7ZG2oeN
 zAAVnsBnhdsHCkhzh8aK75QxfKXzLhs2ISEmKX8=
X-Google-Smtp-Source: APXvYqxOeiGa8lJ/cgV7srMCPJVf5ma2BQuasw60Et7U+WNX5ub4Reu1hHMpLb5l9QXcWLE4t5j8FSqfwG7kJ9X890Q=
X-Received: by 2002:ac8:74b:: with SMTP id k11mr4293349qth.160.1575383119155; 
 Tue, 03 Dec 2019 06:25:19 -0800 (PST)
MIME-Version: 1.0
References: <20191127175257.23480-1-mrolnik@gmail.com>
 <20191127175257.23480-11-mrolnik@gmail.com>
 <CAL1e-=gBNhUExfrvNcsGby6HOUmLsoQ9h68oFoOqms3ExWGBbQ@mail.gmail.com>
 <CAK4993g9sAkBSHiHz5RzMCXJdr-vHU=qGaBMq52GEBku3y=oNw@mail.gmail.com>
 <b24d01f6-7112-8074-f0bf-623024ae4176@redhat.com>
In-Reply-To: <b24d01f6-7112-8074-f0bf-623024ae4176@redhat.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Tue, 3 Dec 2019 16:24:42 +0200
Message-ID: <CAK4993hmEbtf40p1fsRGEmTJHMdE8x61hxzrxdCMiR8v+BC2XA@mail.gmail.com>
Subject: Re: [PATCH v37 10/17] target/avr: Add instruction disassembly function
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000033dbc20598cd7755"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::832
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
 "me@xcancerberox.com.ar" <me@xcancerberox.com.ar>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000033dbc20598cd7755
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe.

I copied Richard's file and modified it's content, that's why Richard is
there.

Regards,
Michael Rolnik

On Tue, Dec 3, 2019 at 1:18 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om>
wrote:

> On 12/2/19 8:04 AM, Michael Rolnik wrote:
> > Aleksandar.
> >
> > If this code is going to be merge in 2019 I should modify al the
> > copyrights, right. or should I put 2020 in?
>
> Usually the copyright date is when you first contributed your code to
> the world (here, the list). If a patch was on the list in 2018, even if
> you made modifications and repost it, (c) is 2018.
>
> IOW, If your series gets merged in 2020, it will be merged as (c) 2019.
>
> I'm not sure why Richard's (c) appears here, is target/avr/disas.c based
> on target/openrisc/disas.c? Then it looks correct to me, but IANAL.
>
> > On Mon, Dec 2, 2019 at 2:28 AM Aleksandar Markovic
> > <aleksandar.m.mail@gmail.com <mailto:aleksandar.m.mail@gmail.com>>
> wrote:
> >
> >
> >
> >     On Wednesday, November 27, 2019, Michael Rolnik <mrolnik@gmail.com
> >     <mailto:mrolnik@gmail.com>> wrote:
> >
> >         Provide function disassembles executed instruction when `-d
> >         in_asm` is
> >         provided
> >
> >         Example:
> >         `./avr-softmmu/qemu-system-avr -bios
> >         free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf -d in_asm` will
> >         produce something like the following
> >
> >         ```
> >              ...
> >              IN:
> >              0x0000014a:  CALL      0x3808
> >
> >              IN: main
> >              0x00003808:  CALL      0x4b4
> >
> >              IN: vParTestInitialise
> >              0x000004b4:  LDI       r24, 255
> >              0x000004b6:  STS       r24, 0
> >              0x000004b8:  MULS      r16, r20
> >              0x000004ba:  OUT       $1, r24
> >              0x000004bc:  LDS       r24, 0
> >              0x000004be:  MULS      r16, r20
> >              0x000004c0:  OUT       $2, r24
> >              0x000004c2:  RET
> >              ...
> >         ```
> >
> >         Signed-off-by: Michael Rolnik <mrolnik@gmail.com
> >         <mailto:mrolnik@gmail.com>>
> >         Suggested-by: Richard Henderson <richard.henderson@linaro.org
> >         <mailto:richard.henderson@linaro.org>>
> >         Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
> >         <mailto:philmd@redhat.com>>
> >         Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com
> >         <mailto:aleksandar.m.mail@gmail.com>>
> >         Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
> >         <mailto:philmd@redhat.com>>
> >         Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
> >         <mailto:philmd@redhat.com>>
> >         ---
> >           target/avr/cpu.h       |   1 +
> >           target/avr/cpu.c       |   2 +-
> >           target/avr/disas.c     | 228
> >         +++++++++++++++++++++++++++++++++++++++++
> >           target/avr/translate.c |  11 ++
> >           4 files changed, 241 insertions(+), 1 deletion(-)
> >           create mode 100644 target/avr/disas.c
> >
> >         diff --git a/target/avr/cpu.h b/target/avr/cpu.h
> >         index 9ea5260165..a3e615a1eb 100644
> >         --- a/target/avr/cpu.h
> >         +++ b/target/avr/cpu.h
> >         @@ -157,6 +157,7 @@ bool avr_cpu_exec_interrupt(CPUState *cpu,
> >         int int_req);
> >           hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr)=
;
> >           int avr_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, in=
t
> >         reg);
> >           int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf,
> >         int reg);
> >         +int avr_print_insn(bfd_vma addr, disassemble_info *info);
> >
> >           static inline int avr_feature(CPUAVRState *env, int feature)
> >           {
> >         diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> >         index dae56d7845..52ec21dd16 100644
> >         --- a/target/avr/cpu.c
> >         +++ b/target/avr/cpu.c
> >         @@ -83,7 +83,7 @@ static void avr_cpu_reset(CPUState *cs)
> >           static void avr_cpu_disas_set_info(CPUState *cpu,
> >         disassemble_info *info)
> >           {
> >               info->mach =3D bfd_arch_avr;
> >         -    info->print_insn =3D NULL;
> >         +    info->print_insn =3D avr_print_insn;
> >           }
> >
> >           static void avr_cpu_realizefn(DeviceState *dev, Error **errp)
> >         diff --git a/target/avr/disas.c b/target/avr/disas.c
> >         new file mode 100644
> >         index 0000000000..a51ade7c2a
> >         --- /dev/null
> >         +++ b/target/avr/disas.c
> >         @@ -0,0 +1,228 @@
> >         +/*
> >         + * AVR disassembler
> >         + *
> >         + * Copyright (c) 2018 Richard Henderson <rth@twiddle.net
> >         <mailto:rth@twiddle.net>>
> >
> >
> >     Just a detail: since this file is created in 2019, the copyright
> >     year should be 2019 too.
> >
> >         + * Copyright (c) 2019 Michael Rolnik <mrolnik@gmail.com
> >         <mailto:mrolnik@gmail.com>>
> >         + *
> >         + * This program is free software: you can redistribute it
> >         and/or modify
> >         + * it under the terms of the GNU General Public License as
> >         published by
> >         + * the Free Software Foundation, either version 2 of the
> >         License, or
> >         + * (at your option) any later version.
> >         + *
> >         + * This program is distributed in the hope that it will be
> useful,
> >         + * but WITHOUT ANY WARRANTY; without even the implied warranty
> of
> >         + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See t=
he
> >         + * GNU General Public License for more details.
> >         + *
> >         + * You should have received a copy of the GNU General Public
> >         License
> >         + * along with this program.  If not, see
> >         <http://www.gnu.org/licenses/>.
> >         + */
> [...]
>
>

--=20
Best Regards,
Michael Rolnik

--00000000000033dbc20598cd7755
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Philippe.<div><br></div><div>I copied Richard&#39;s fil=
e and modified it&#39;s content, that&#39;s why Richard is there.</div><div=
><br></div><div>Regards,</div><div>Michael Rolnik</div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 3, 2019 =
at 1:18 PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.=
com">philmd@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On 12/2/19 8:04 AM, Michael Rolnik wrote:<br>
&gt; Aleksandar.<br>
&gt; <br>
&gt; If this code is going to be merge in 2019 I should modify al the <br>
&gt; copyrights, right. or should I put 2020 in?<br>
<br>
Usually the copyright date is when you first contributed your code to <br>
the world (here, the list). If a patch was on the list in 2018, even if <br=
>
you made modifications and repost it, (c) is 2018.<br>
<br>
IOW, If your series gets merged in 2020, it will be merged as (c) 2019.<br>
<br>
I&#39;m not sure why Richard&#39;s (c) appears here, is target/avr/disas.c =
based <br>
on target/openrisc/disas.c? Then it looks correct to me, but IANAL.<br>
<br>
&gt; On Mon, Dec 2, 2019 at 2:28 AM Aleksandar Markovic <br>
&gt; &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com" target=3D"_blank">a=
leksandar.m.mail@gmail.com</a> &lt;mailto:<a href=3D"mailto:aleksandar.m.ma=
il@gmail.com" target=3D"_blank">aleksandar.m.mail@gmail.com</a>&gt;&gt; wro=
te:<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Wednesday, November 27, 2019, Michael Rolnik &lt=
;<a href=3D"mailto:mrolnik@gmail.com" target=3D"_blank">mrolnik@gmail.com</=
a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:mrolnik@gmail.com" tar=
get=3D"_blank">mrolnik@gmail.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Provide function disassembles execute=
d instruction when `-d<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in_asm` is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0provided<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Example:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0`./avr-softmmu/qemu-system-avr -bios<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free-rtos/Demo/AVR_ATMega2560_GCC/dem=
o.elf -d in_asm` will<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0produce something like the following<=
br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0```<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IN:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0000014a:=C2=A0 CALL=
=C2=A0 =C2=A0 =C2=A0 0x3808<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IN: main<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00003808:=C2=A0 CALL=
=C2=A0 =C2=A0 =C2=A0 0x4b4<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IN: vParTestInitialise=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x000004b4:=C2=A0 LDI=
=C2=A0 =C2=A0 =C2=A0 =C2=A0r24, 255<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x000004b6:=C2=A0 STS=
=C2=A0 =C2=A0 =C2=A0 =C2=A0r24, 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x000004b8:=C2=A0 MULS=
=C2=A0 =C2=A0 =C2=A0 r16, r20<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x000004ba:=C2=A0 OUT=
=C2=A0 =C2=A0 =C2=A0 =C2=A0$1, r24<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x000004bc:=C2=A0 LDS=
=C2=A0 =C2=A0 =C2=A0 =C2=A0r24, 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x000004be:=C2=A0 MULS=
=C2=A0 =C2=A0 =C2=A0 r16, r20<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x000004c0:=C2=A0 OUT=
=C2=A0 =C2=A0 =C2=A0 =C2=A0$2, r24<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x000004c2:=C2=A0 RET<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0```<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Signed-off-by: Michael Rolnik &lt;<a =
href=3D"mailto:mrolnik@gmail.com" target=3D"_blank">mrolnik@gmail.com</a><b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:mrolnik@=
gmail.com" target=3D"_blank">mrolnik@gmail.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Suggested-by: Richard Henderson &lt;<=
a href=3D"mailto:richard.henderson@linaro.org" target=3D"_blank">richard.he=
nderson@linaro.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:richard.=
henderson@linaro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt=
;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Suggested-by: Philippe Mathieu-Daud=
=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@re=
dhat.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:philmd@r=
edhat.com" target=3D"_blank">philmd@redhat.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Suggested-by: Aleksandar Markovic &lt=
;<a href=3D"mailto:aleksandar.m.mail@gmail.com" target=3D"_blank">aleksanda=
r.m.mail@gmail.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:aleksand=
ar.m.mail@gmail.com" target=3D"_blank">aleksandar.m.mail@gmail.com</a>&gt;&=
gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Reviewed-by: Philippe Mathieu-Daud=C3=
=A9 &lt;<a href=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redha=
t.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:philmd@r=
edhat.com" target=3D"_blank">philmd@redhat.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Tested-by: Philippe Mathieu-Daud=C3=
=A9 &lt;<a href=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redha=
t.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:philmd@r=
edhat.com" target=3D"_blank">philmd@redhat.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target/avr/cpu.h=C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target/avr/cpu.c=C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target/avr/disas.c=C2=A0 =C2=
=A0 =C2=A0| 228<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+++++++++++++++++++++++++++++++++++++=
++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target/avr/translate.c |=C2=A0=
 11 ++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04 files changed, 241 insertion=
s(+), 1 deletion(-)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 target/avr/=
disas.c<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0diff --git a/target/avr/cpu.h b/targe=
t/avr/cpu.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0index 9ea5260165..a3e615a1eb 100644<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--- a/target/avr/cpu.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+++ b/target/avr/cpu.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0@@ -157,6 +157,7 @@ bool avr_cpu_exec=
_interrupt(CPUState *cpu,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int int_req);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hwaddr avr_cpu_get_phys_page_d=
ebug(CPUState *cpu, vaddr addr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int avr_cpu_gdb_read_register(=
CPUState *cpu, uint8_t *buf, int<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int avr_cpu_gdb_write_register=
(CPUState *cpu, uint8_t *buf,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int reg);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+int avr_print_insn(bfd_vma addr, dis=
assemble_info *info);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0static inline int avr_feature(=
CPUAVRState *env, int feature)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0diff --git a/target/avr/cpu.c b/targe=
t/avr/cpu.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0index dae56d7845..52ec21dd16 100644<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--- a/target/avr/cpu.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+++ b/target/avr/cpu.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0@@ -83,7 +83,7 @@ static void avr_cpu=
_reset(CPUState *cs)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0static void avr_cpu_disas_set_=
info(CPUState *cpu,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0disassemble_info *info)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0info-&gt;mach =
=3D bfd_arch_avr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 info-&gt;print_insn =
=3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 info-&gt;print_insn =
=3D avr_print_insn;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0static void avr_cpu_realizefn(=
DeviceState *dev, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0diff --git a/target/avr/disas.c b/tar=
get/avr/disas.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0new file mode 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0index 0000000000..a51ade7c2a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--- /dev/null<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+++ b/target/avr/disas.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0@@ -0,0 +1,228 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ * AVR disassembler<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ * Copyright (c) 2018 Richard Hender=
son &lt;<a href=3D"mailto:rth@twiddle.net" target=3D"_blank">rth@twiddle.ne=
t</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:rth@twid=
dle.net" target=3D"_blank">rth@twiddle.net</a>&gt;&gt;<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Just a detail: since this file is created in 2019, =
the copyright<br>
&gt;=C2=A0 =C2=A0 =C2=A0year should be 2019 too.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ * Copyright (c) 2019 Michael Rolnik=
 &lt;<a href=3D"mailto:mrolnik@gmail.com" target=3D"_blank">mrolnik@gmail.c=
om</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:mrolnik@=
gmail.com" target=3D"_blank">mrolnik@gmail.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ * This program is free software: yo=
u can redistribute it<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0and/or modify<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ * it under the terms of the GNU Gen=
eral Public License as<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0published by<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ * the Free Software Foundation, eit=
her version 2 of the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0License, or<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ * (at your option) any later versio=
n.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ * This program is distributed in th=
e hope that it will be useful,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ * but WITHOUT ANY WARRANTY; without=
 even the implied warranty of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ * MERCHANTABILITY or FITNESS FOR A =
PARTICULAR PURPOSE.=C2=A0 See the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ * GNU General Public License for mo=
re details.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ * You should have received a copy o=
f the GNU General Public<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0License<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ * along with this program.=C2=A0 If=
 not, see<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"http://www.gnu.org/lic=
enses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.org/licenses/</=
a>&gt;.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ */<br>
[...]<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--00000000000033dbc20598cd7755--

