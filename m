Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38626C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 22:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA95A2087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 22:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgkez1+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA95A2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz74x-0000qG-1y
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 17:53:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iz74G-0000JX-Tx
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 17:53:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iz74F-0006Je-Hi
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 17:53:16 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33045)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iz74F-0006IA-9S
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 17:53:15 -0500
Received: by mail-oi1-x242.google.com with SMTP id q81so19183oig.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 14:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=6/H/LxVC8ajIMWqQAM0T9zW2uM8nXVy7k7xQEkVKIQU=;
 b=jgkez1+eZzVe+cUo+h5lyUZSG+CRi9rISVB6aFwNhELQtRw2AM+gWBUy+JkMkEC98s
 rBu4TFiUx3TZy0MtQqs6vdvDbxichLIxKr4zgyRrhTrEBhjEw8yKVsCSRb177lmnvl/y
 4pk2PjsPSF2LKB0OC1VkrttE6+8x+wzP23nkhyMb513GHvf6KGAINKK8BztXzUGomxxE
 YLK492szSWbPY4C0XR3L7keemffeqkgTnOnVxP17vd7DxRvcg9A3JbyMAutaqlRzdLF+
 B9Bcyiuz2NR+zn/MOVBxYzSyQX9EOsStqTI8orv7qGfczvvF1rpraPyjETHfTJcpG/JH
 UN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=6/H/LxVC8ajIMWqQAM0T9zW2uM8nXVy7k7xQEkVKIQU=;
 b=W7Xfk0LEWNLsyDCEwIS0Hu4iQhvw8y9Z6RFKAoIHa4cSINpemqq+HGL/fHwPetkvAy
 JrK798ODnPIveOFJZTNm2IuF6dOGIHVyi8qG1QGiVWBY1mq9ZeuTCdhBRu3weA+W9gWe
 O6R7wzMy7y1nWZ61BDq/VkSPizg8Rnsw1VirhfEfESfUnO0QZp6rLBWs/sewvsJx0PRz
 kCKvxto51jH4REmuisQUaC0f1DYKYbs99Kyz7qg4EpVkKMSYp7BERiHV+e7Ni8txFuRg
 bOpMKfRfXp99wKzO48rVm69KRl0YJ1rUPozAsFscmjQGtyPKjQy3Q+D9gCBUVHoaq58K
 F+xQ==
X-Gm-Message-State: APjAAAV5RRHTHpe7TKAts4eBIt0qNgUn47P+cIYYfMx4Woi2MFdDk9yl
 LaU9lVInbuhAEOnT6mbeh/eP6YR3dVPO79PzaVg=
X-Google-Smtp-Source: APXvYqwCC1/sBApH0ZiTpKMM49xceX4c8bbSXeMfIQ5YAkTohwL3nYhCKlPvAm7MB01xs25RijrhFOsTwNEa9gNku4I=
X-Received: by 2002:a05:6808:3ba:: with SMTP id
 n26mr968633oie.62.1580856791702; 
 Tue, 04 Feb 2020 14:53:11 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Tue, 4 Feb 2020 14:53:11 -0800 (PST)
In-Reply-To: <96c7bed8-8292-bd35-ba79-717cf543fa47@vivier.eu>
References: <1578947683-21011-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1578947683-21011-6-git-send-email-aleksandar.markovic@rt-rk.com>
 <93e1c210-2f0d-2ab1-d933-2889939396db@vivier.eu>
 <CAL1e-=hMS0-E7c_gW-m9Mk6ZeCSzdDwmhmYnNUGhor2o_KEhBQ@mail.gmail.com>
 <96c7bed8-8292-bd35-ba79-717cf543fa47@vivier.eu>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 4 Feb 2020 23:53:11 +0100
Message-ID: <CAL1e-=iMQ9orkQBzb5kzJyiiP_QBOTUwVq2s92-2jq+M0qcbrA@mail.gmail.com>
Subject: Re: [PATCH v5 05/20] linux-user: mips: Update syscall numbers to
 kernel 5.5 rc3 level
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/alternative; boundary="000000000000829e17059dc7e78a"
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000829e17059dc7e78a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, February 4, 2020, Laurent Vivier <laurent@vivier.eu> wrote:

> Le 04/02/2020 =C3=A0 12:56, Aleksandar Markovic a =C3=A9crit :
> > On Tue, Jan 14, 2020 at 5:40 PM Laurent Vivier <laurent@vivier.eu>
> wrote:
> >>
> >> Le 13/01/2020 =C3=A0 21:34, Aleksandar Markovic a =C3=A9crit :
> >>> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> >>>
> >>> Update mips syscall numbers based on Linux kernel tag v5.5-rc3
> >>> (commit 46cf053e).
> >>>
> >>> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> >>> ---
> >>>  linux-user/mips/cpu_loop.c     | 78 ++++++++++++++++++++++++++++++
> +++++++++++-
> >>>  linux-user/mips/syscall_nr.h   | 45 ++++++++++++++++++++++++
> >>>  linux-user/mips64/syscall_nr.h | 13 +++++++
> >>>  3 files changed, 135 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
> >>> index 39915b3..b81479b 100644
> >>> --- a/linux-user/mips/cpu_loop.c
> >>> +++ b/linux-user/mips/cpu_loop.c
> >>> @@ -25,8 +25,9 @@
> >>>  #include "internal.h"
> >>>
> >>>  # ifdef TARGET_ABI_MIPSO32
> >>> +#  define MIPS_SYSCALL_NUMBER_UNUSED -1
> >>
> >> I'm not sure you need to introduce this change.
> >>
> >> The case already exists (stat, fstat, old_select, lstat, ...) and the
> >> entry that was used is:
> >>
> >>            MIPS_SYS(sys_ni_syscall , 0)
> >>
> >> perhaps you can do the same ?
> >>
> >
> > I like better the new way of dealing with this (like in this patch),
> since it is
> > more explicit. For now, I won't change this patch, if you agree, and
> later on
> > I will synchronize all such cases to be the same (but this is not
> critical for
> > the time being).
>
> So Perhaps you can do:
>
> #  define MIPS_SYSCALL_NUMBER_UNUSED 0
>
> And so the real availability of the syscall will be detected in
> do_syscall1() based on a "#ifdef TARGET_XXXX" (well, not sure
> syscall_nr.h differentiates O32 and N32)
>
> By the way, do we really need this table?
>
> It seems kernel is always copying 4 words from the stack.
> But kernel code is not really clear, perhaps I'm missing something...
>
>
Yes, Laurent, we actually don't need that table. We could have just a
series of preprocessor constants, like any other ABI, but it would have
required larger code reorganization. It started that way long time ago, and
nobody bothered to correct this, partially for sure because of fear of
regressions.

I am not in the mood for refactoring this area of code right now in any
substantial way, until the situation stabilizes with new syscalls. The
current solution in this patch is good enough for me, and it is not that
intrusive, which I like. Please accept it as is, and the time for
refactoring will hopefully come at some later point of time.

I prefer several incremental smaller refactoring to one large one. I'll
take into account all your suggestions and hints.

Thanks, Aleksandar


> In the end, as you are the MIPS maintainer, you can choose the solution
> you prefer.
>
> Thanks,
> Laurent
>

--000000000000829e17059dc7e78a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, February 4, 2020, Laurent Vivier &lt;<a href=3D"mailto:=
laurent@vivier.eu">laurent@vivier.eu</a>&gt; wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">Le 04/02/2020 =C3=A0 12:56, Aleksandar Markovic a =C3=A9crit=C2=
=A0:<br>
&gt; On Tue, Jan 14, 2020 at 5:40 PM Laurent Vivier &lt;<a href=3D"mailto:l=
aurent@vivier.eu">laurent@vivier.eu</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Le 13/01/2020 =C3=A0 21:34, Aleksandar Markovic a =C3=A9crit :<br>
&gt;&gt;&gt; From: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wave=
comp.com">amarkovic@wavecomp.com</a>&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Update mips syscall numbers based on Linux kernel tag v5.5-rc3=
<br>
&gt;&gt;&gt; (commit 46cf053e).<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Aleksandar Markovic &lt;<a href=3D"mailto:amark=
ovic@wavecomp.com">amarkovic@wavecomp.com</a>&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;=C2=A0 linux-user/mips/cpu_loop.c=C2=A0 =C2=A0 =C2=A0| 78 +++++=
+++++++++++++++++++++++++<wbr>+++++++++++-<br>
&gt;&gt;&gt;=C2=A0 linux-user/mips/syscall_nr.h=C2=A0 =C2=A0| 45 ++++++++++=
++++++++++++++<br>
&gt;&gt;&gt;=C2=A0 linux-user/mips64/syscall_nr.h | 13 +++++++<br>
&gt;&gt;&gt;=C2=A0 3 files changed, 135 insertions(+), 1 deletion(-)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_=
loop.c<br>
&gt;&gt;&gt; index 39915b3..b81479b 100644<br>
&gt;&gt;&gt; --- a/linux-user/mips/cpu_loop.c<br>
&gt;&gt;&gt; +++ b/linux-user/mips/cpu_loop.c<br>
&gt;&gt;&gt; @@ -25,8 +25,9 @@<br>
&gt;&gt;&gt;=C2=A0 #include &quot;internal.h&quot;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 # ifdef TARGET_ABI_MIPSO32<br>
&gt;&gt;&gt; +#=C2=A0 define MIPS_SYSCALL_NUMBER_UNUSED -1<br>
&gt;&gt;<br>
&gt;&gt; I&#39;m not sure you need to introduce this change.<br>
&gt;&gt;<br>
&gt;&gt; The case already exists (stat, fstat, old_select, lstat, ...) and =
the<br>
&gt;&gt; entry that was used is:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall ,=
 0)<br>
&gt;&gt;<br>
&gt;&gt; perhaps you can do the same ?<br>
&gt;&gt;<br>
&gt; <br>
&gt; I like better the new way of dealing with this (like in this patch), s=
ince it is<br>
&gt; more explicit. For now, I won&#39;t change this patch, if you agree, a=
nd later on<br>
&gt; I will synchronize all such cases to be the same (but this is not crit=
ical for<br>
&gt; the time being).<br>
<br>
So Perhaps you can do:<br>
<br>
#=C2=A0 define MIPS_SYSCALL_NUMBER_UNUSED 0<br>
<br>
And so the real availability of the syscall will be detected in<br>
do_syscall1() based on a &quot;#ifdef TARGET_XXXX&quot; (well, not sure<br>
syscall_nr.h differentiates O32 and N32)<br>
<br>
By the way, do we really need this table?<br>
<br>
It seems kernel is always copying 4 words from the stack.<br>
But kernel code is not really clear, perhaps I&#39;m missing something...<b=
r>
<br></blockquote><div><br></div><div>Yes, Laurent, we actually don&#39;t ne=
ed that table. We could have just a series of preprocessor constants, like =
any other ABI, but it would have required larger code reorganization. It st=
arted that way long time ago, and nobody bothered to correct this, partiall=
y for sure because of fear of regressions.</div><div><br></div><div>I am no=
t in the mood for refactoring this area of code right now in any substantia=
l way, until the situation stabilizes with new syscalls. The current soluti=
on in this patch is good enough for me, and it is not that intrusive, which=
 I like. Please accept it as is, and the time for refactoring will hopefull=
y come at some later point of time.</div><div><br></div><div>I prefer sever=
al incremental smaller refactoring to one large one. I&#39;ll take into acc=
ount all your suggestions and hints.</div><div><br></div><div>Thanks, Aleks=
andar</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
In the end, as you are the MIPS maintainer, you can choose the solution<br>
you prefer.<br>
<br>
Thanks,<br>
Laurent<br>
</blockquote>

--000000000000829e17059dc7e78a--

