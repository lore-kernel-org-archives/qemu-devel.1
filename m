Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E683C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 17:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D834D20719
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 17:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtLNIyWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D834D20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGQW8-0001mA-Uw
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 13:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1jGQV0-0000wH-Oz
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1jGQUy-0001Xf-M5
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:04:26 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:42425)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1jGQUy-0001Wl-Dq
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:04:24 -0400
Received: by mail-qt1-x843.google.com with SMTP id t9so8350863qto.9
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 10:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Cq39Hb+6G5m/3KpbWktIqbX4bvL9AUW+y/o4/Hq3vy8=;
 b=JtLNIyWEN8K6xffgVkKsZ0kgNz7W8qm7XOT/HfkJ1La8WsZRUIXngzmfoXUpxec7TT
 eQ8UwEa2MzTJvBPlRSUFzbN/GroAjuzcQMEYJqKNSsFZ8glcouebKz3SyxxKeQMFkV5S
 qxF2VlivkDAuR4uK5avmzdv0bqfkiXl5/brPI9GQv6vbwaOZGzXnNVY8u18ZDlRLAwSh
 AJJMvvLos1L9OuI0XA4mVse3NiTGE3yQoj75oaEBWEQk0qWsN+WS0kjQGx6FN/qqnCuY
 WsZKUjCHM9nTuEPQMFyciSzlxXWsWU0urdJNcLcQqnT7ie0betiBqtfaz9G6vFIGWbxH
 nxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Cq39Hb+6G5m/3KpbWktIqbX4bvL9AUW+y/o4/Hq3vy8=;
 b=VKu00R9cT8gzYzyjSrK9u6awUjS0C9jf6rtu/XCLzOmYaRGF+g63HZRuIXJ5Pp3rt8
 20sRHhetd7dQY1TcUyGgp9uHjhpnqDrMJMoEcehbYfRocbYZ/Y7Xb69b0ZS1sudpA5rm
 1656KNme54htutww/O6BvoNSiXBnhyMWMs5zEk3jDyXx5/CI1i75piPyDj8QFMJkiQGX
 IWaL25CdyM4lPmIYePtcoqBD6E+JnqAKbncu0l9sbc74sgX4KBKADQyLnhSb4e0MUkJ7
 05JmePLKAEbxUYSjJTHXoe1zmCSca9868jdPDLKB/aYuUfgrSAXzBCg1MyPnuCpNMdsd
 8xVA==
X-Gm-Message-State: ANhLgQ1zDDfZNhrxJR4D4hrx6x2zHlxMbTe3ST6ddlckvPgf7jvvRwdy
 T5bRL7vVPp4LHhJ2QIqDOVXYHKJfFEB8AC8csJQ=
X-Google-Smtp-Source: ADFU+vuRuekayS/O+S5Ox1zIQH1Rj0gLrHJqBLPxTxuqCoLXJFcQ3r3jJtbViEXfdK2A5xtvlREcW1Jr5kIAFcbJoAQ=
X-Received: by 2002:ac8:4f03:: with SMTP id b3mr16355560qte.282.1584983063261; 
 Mon, 23 Mar 2020 10:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200118191416.19934-1-mrolnik@gmail.com>
 <20200118191416.19934-2-mrolnik@gmail.com>
 <80141c57-7fb7-6e95-4070-54f7cc23e166@redhat.com>
In-Reply-To: <80141c57-7fb7-6e95-4070-54f7cc23e166@redhat.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Mon, 23 Mar 2020 19:03:39 +0200
Message-ID: <CAK4993ie33Awp=sqUOcubqCLFqTd5mTPAkWQfhh3zvorMwnSig@mail.gmail.com>
Subject: Re: [PATCH v41 01/21] target/avr: Add outward facing interfaces and
 core CPU logic
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000075feb505a188a07b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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
Cc: Thomas Huth <thuth@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000075feb505a188a07b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe.

It's been a while. let me think about it and get back to you. what is your
concern ?

Regards,
Michael Rolnik

On Mon, Mar 23, 2020 at 5:55 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> Hi Michael,
>
> On 1/18/20 8:13 PM, Michael Rolnik wrote:
> > This includes:
> > - CPU data structures
> > - object model classes and functions
> > - migration functions
> > - GDB hooks
> >
> > Co-developed-by: Michael Rolnik <mrolnik@gmail.com>
> > Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> > Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> > Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> > Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> > Acked-by: Igor Mammedov <imammedo@redhat.com>
> > Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
> >   target/avr/cpu-param.h |  37 ++
> >   target/avr/cpu-qom.h   |  54 +++
> >   target/avr/cpu.h       | 258 +++++++++++++
> >   target/avr/cpu.c       | 826 ++++++++++++++++++++++++++++++++++++++++=
+
> >   target/avr/gdbstub.c   |  84 +++++
> >   target/avr/machine.c   | 121 ++++++
> >   gdb-xml/avr-cpu.xml    |  49 +++
> >   7 files changed, 1429 insertions(+)
> >   create mode 100644 target/avr/cpu-param.h
> >   create mode 100644 target/avr/cpu-qom.h
> >   create mode 100644 target/avr/cpu.h
> >   create mode 100644 target/avr/cpu.c
> >   create mode 100644 target/avr/gdbstub.c
> >   create mode 100644 target/avr/machine.c
> >   create mode 100644 gdb-xml/avr-cpu.xml
> >
> [...]> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> > new file mode 100644
> > index 0000000000..c74c5106fe
> > --- /dev/null
> > +++ b/target/avr/cpu.c
> > @@ -0,0 +1,826 @@
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
> > +#include "qapi/error.h"
> > +#include "qemu/qemu-print.h"
> > +#include "exec/exec-all.h"
> > +#include "cpu.h"
> > +#include "disas/dis-asm.h"
> > +
> > +static void avr_cpu_set_pc(CPUState *cs, vaddr value)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(cs);
> > +
> > +    cpu->env.pc_w =3D value / 2; /* internally PC points to words */
> > +}
> > +
> > +static bool avr_cpu_has_work(CPUState *cs)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(cs);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    return (cs->interrupt_request & (CPU_INTERRUPT_HARD |
> CPU_INTERRUPT_RESET))
> > +            && cpu_interrupts_enabled(env);
> > +}
> > +
> > +static void avr_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock
> *tb)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(cs);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    env->pc_w =3D tb->pc / 2; /* internally PC points to words */
> > +}
> > +
> > +static void avr_cpu_reset(CPUState *cs)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(cs);
> > +    AVRCPUClass *mcc =3D AVR_CPU_GET_CLASS(cpu);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    mcc->parent_reset(cs);
> > +
> > +    env->pc_w =3D 0;
> > +    env->sregI =3D 1;
> > +    env->sregC =3D 0;
> > +    env->sregZ =3D 0;
> > +    env->sregN =3D 0;
> > +    env->sregV =3D 0;
> > +    env->sregS =3D 0;
> > +    env->sregH =3D 0;
> > +    env->sregT =3D 0;
> > +
> > +    env->rampD =3D 0;
> > +    env->rampX =3D 0;
> > +    env->rampY =3D 0;
> > +    env->rampZ =3D 0;
> > +    env->eind =3D 0;
> > +    env->sp =3D 0;
> > +
> > +    env->skip =3D 0;
> > +
> > +    memset(env->r, 0, sizeof(env->r));
> > +
> > +    tlb_flush(cs);
>
> Why are you calling tlb_flush() here?
>
> > +}
>
>

--=20
Best Regards,
Michael Rolnik

--00000000000075feb505a188a07b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Philippe.<div><br></div><div>It&#39;s been a while. let=
 me think about it=C2=A0and get back to you. what is your concern ?=C2=A0</=
div><div><br></div><div>Regards,</div><div>Michael Rolnik</div></div><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar =
23, 2020 at 5:55 PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philm=
d@redhat.com">philmd@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Hi Michael,<br>
<br>
On 1/18/20 8:13 PM, Michael Rolnik wrote:<br>
&gt; This includes:<br>
&gt; - CPU data structures<br>
&gt; - object model classes and functions<br>
&gt; - migration functions<br>
&gt; - GDB hooks<br>
&gt; <br>
&gt; Co-developed-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.co=
m" target=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
&gt; Co-developed-by: Sarah Harris &lt;<a href=3D"mailto:S.E.Harris@kent.ac=
.uk" target=3D"_blank">S.E.Harris@kent.ac.uk</a>&gt;<br>
&gt; Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com"=
 target=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Sarah Harris &lt;<a href=3D"mailto:S.E.Harris@kent.ac.u=
k" target=3D"_blank">S.E.Harris@kent.ac.uk</a>&gt;<br>
&gt; Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com"=
 target=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
&gt; Acked-by: Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com" tar=
get=3D"_blank">imammedo@redhat.com</a>&gt;<br>
&gt; Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@re=
dhat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/avr/cpu-param.h |=C2=A0 37 ++<br>
&gt;=C2=A0 =C2=A0target/avr/cpu-qom.h=C2=A0 =C2=A0|=C2=A0 54 +++<br>
&gt;=C2=A0 =C2=A0target/avr/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 258 +++++++++=
++++<br>
&gt;=C2=A0 =C2=A0target/avr/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 826 +++++++++=
++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0target/avr/gdbstub.c=C2=A0 =C2=A0|=C2=A0 84 +++++<br>
&gt;=C2=A0 =C2=A0target/avr/machine.c=C2=A0 =C2=A0| 121 ++++++<br>
&gt;=C2=A0 =C2=A0gdb-xml/avr-cpu.xml=C2=A0 =C2=A0 |=C2=A0 49 +++<br>
&gt;=C2=A0 =C2=A07 files changed, 1429 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 target/avr/cpu-param.h<br>
&gt;=C2=A0 =C2=A0create mode 100644 target/avr/cpu-qom.h<br>
&gt;=C2=A0 =C2=A0create mode 100644 target/avr/cpu.h<br>
&gt;=C2=A0 =C2=A0create mode 100644 target/avr/cpu.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 target/avr/gdbstub.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 target/avr/machine.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 gdb-xml/avr-cpu.xml<br>
&gt; <br>
[...]&gt; diff --git a/target/avr/cpu.c b/target/avr/cpu.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..c74c5106fe<br>
&gt; --- /dev/null<br>
&gt; +++ b/target/avr/cpu.c<br>
&gt; @@ -0,0 +1,826 @@<br>
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
&gt; +#include &quot;qapi/error.h&quot;<br>
&gt; +#include &quot;qemu/qemu-print.h&quot;<br>
&gt; +#include &quot;exec/exec-all.h&quot;<br>
&gt; +#include &quot;cpu.h&quot;<br>
&gt; +#include &quot;disas/dis-asm.h&quot;<br>
&gt; +<br>
&gt; +static void avr_cpu_set_pc(CPUState *cs, vaddr value)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(cs);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 cpu-&gt;env.pc_w =3D value / 2; /* internally PC points=
 to words */<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool avr_cpu_has_work(CPUState *cs)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(cs);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return (cs-&gt;interrupt_request &amp; (CPU_INTERRUPT_H=
ARD | CPU_INTERRUPT_RESET))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; cpu_interrupts_e=
nabled(env);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void avr_cpu_synchronize_from_tb(CPUState *cs, TranslationBloc=
k *tb)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(cs);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 env-&gt;pc_w =3D tb-&gt;pc / 2; /* internally PC points=
 to words */<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void avr_cpu_reset(CPUState *cs)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(cs);<br>
&gt; +=C2=A0 =C2=A0 AVRCPUClass *mcc =3D AVR_CPU_GET_CLASS(cpu);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 mcc-&gt;parent_reset(cs);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 env-&gt;pc_w =3D 0;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sregI =3D 1;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sregC =3D 0;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sregZ =3D 0;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sregN =3D 0;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sregV =3D 0;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sregS =3D 0;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sregH =3D 0;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sregT =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 env-&gt;rampD =3D 0;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;rampX =3D 0;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;rampY =3D 0;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;rampZ =3D 0;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;eind =3D 0;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;sp =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 env-&gt;skip =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memset(env-&gt;r, 0, sizeof(env-&gt;r));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 tlb_flush(cs);<br>
<br>
Why are you calling tlb_flush() here?<br>
<br>
&gt; +}<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--00000000000075feb505a188a07b--

