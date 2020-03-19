Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2682C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 14:32:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E2CC20782
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 14:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ts+mJJV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E2CC20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEwDt-0008Aj-OA
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 10:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mansourweb@gmail.com>) id 1jEwD3-0007Q9-Ej
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:31:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mansourweb@gmail.com>) id 1jEwD2-00052N-71
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:31:45 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133]:38840)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mansourweb@gmail.com>)
 id 1jEwD0-00051a-W4
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:31:43 -0400
Received: by mail-lf1-x133.google.com with SMTP id n13so1810186lfh.5
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 07:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=/ayF9jYzWyGPL6mGDUl2C1/kywBa1U0xypOD6/4ahXA=;
 b=Ts+mJJV8+o0PHVgM3W9fZ0zkHeKo6bJLe4o8mi4NCgZV9ciWj7XfBW9zAAAVEWjMMt
 DbcWHo7KTQKre0r47vXWNJwqPh5X3aNfa1MWvWCKfmyAQsmLtxsMxloQRIUYWF5rvU+r
 x7H4LF1fjWhwlKSuxj4Tyj3N6bOnMJnslfsN1svOzyWOLkzOWyElzUgTEDUv6u+AHDwq
 5mFNUcg5KGK+3wEnH378FBMOEe8qSR2NfzQMEvXJ6bt0SYUQUxmnbu2867vHPJqAYfHE
 WPB0xG3xikqEN4IFmHPHX50RF5QckieZsiDyez7Tt6Eh9ymzvsdNK2ojjGLbrR07gYdh
 54qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=/ayF9jYzWyGPL6mGDUl2C1/kywBa1U0xypOD6/4ahXA=;
 b=MVmZo17MUN8Bz/6Vx0gTsZlOerho8GJ/pFqgzQzsJZEmaArUGRPkEFFQxHnqMmhSeM
 lXgxD0aTfisMlVMFLzOyVRPz5zDJfFTY5G9901rldoLNue9KXLSDRsjKB++rfoOjqkD2
 i63nwV7oUHmpwbeQf3ydNgZQ9pR3mUn3iKZlRgRbWTeje95qOJz/d4X8KZIueyoLRz7y
 57dvbtkKjwhkZdBlP3wGX6t72PUdDqN6tfG2Sbg+LjsSTuWHcDpu7hIsFyb28pTydsc8
 YwZpOLEzmhzxXka9kSbhRmj902L6vTklcsfv/HYD36harItVKlSt4HzXWO02pA0AVYGP
 O5cA==
X-Gm-Message-State: ANhLgQ1+juUxRnl4Xtu7S244Uvi08rWQ2uBII8G9wHPWQQhwfjwQ1dM1
 v6rV+ASpZqdS98QeYcjDnT95XhL6KIo6cuTqbsOAK5RKPRY=
X-Google-Smtp-Source: ADFU+vtfPQk5MBD1+PEyxfr9cnzn5i6vDwusMZ+A2VUoMnh9dfqULmjwNBQ2unSFW6gYzay30wj73WSiWBZrLL5Agwg=
X-Received: by 2002:a19:6445:: with SMTP id b5mr2233635lfj.187.1584628301149; 
 Thu, 19 Mar 2020 07:31:41 -0700 (PDT)
MIME-Version: 1.0
From: Mansour Ahmadi <ManSoSec@gmail.com>
Date: Thu, 19 Mar 2020 10:31:30 -0400
Message-ID: <CAGT9xrAiELsA0jt9tsn+jQ+mmeNK+Ya+5mBKBnLOEYVYKwKYoQ@mail.gmail.com>
Subject: Missing Frame initialization
To: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/alternative; boundary="000000000000fdb9d305a136064e"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::133
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fdb9d305a136064e
Content-Type: text/plain; charset="UTF-8"

I originally reported this:

In the case of badframe, user struct is not unlocked here and may lead to
deadlock:

https://github.com/qemu/qemu
/blob/d4f7d56759f7c75270c13d5f3f5f736a9558929c/linux-user/m68k/signal.c#L380

In similar case, it in unlocked correctly:
https://github.com/qemu/qemu
/blob/d4f7d56759f7c75270c13d5f3f5f736a9558929c/linux-user/sh4/signal.c#L303

Laurant replied that frame needs to be initialized with NULL in the second
case indeed:

In fact, this case is a little bit different and wrong but to fix that
the solution is to set frame to NULL when it is declared:

linux-user/qemu.h:
* Unlock an area of guest memory.  The first LEN bytes must be
   flushed back to guest memory. host_ptr = NULL is explicitly
   allowed and does nothing. */
static inline void unlock_user(void *host_ptr, abi_ulong guest_addr,
                               long len)
like for linux-user/aarch64/signal.c:
long do_rt_sigreturn(CPUARMState *env)
{
    struct target_rt_sigframe *frame = NULL;
...
We have several targets with the same problem.

Thanks,
Mansour

--000000000000fdb9d305a136064e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:garamond=
,serif;font-size:large">I originally reported this:</div><div class=3D"gmai=
l_default" style=3D"font-family:garamond,serif;font-size:large"><br></div><=
div class=3D"gmail_default" style=3D"font-family:garamond,serif;font-size:l=
arge"><div class=3D"gmail_default">In the case of badframe, user struct is =
not unlocked here and may lead to deadlock:</div><div class=3D"gmail_defaul=
t"><br></div><div class=3D"gmail_default"><a href=3D"https://github.com/qem=
u/qemu/blob/d4f7d56759f7c75270c13d5f3f5f736a9558929c/linux-user/m68k/signal=
.c#L380" target=3D"_blank">https://github.com/<span class=3D"gmail-il">qemu=
</span>/<span class=3D"gmail-il">qemu</span>/blob/d4f7d56759f7c75270c13d5f3=
f5f736a9558929c/linux-user/m68k/signal.c#L380</a><br></div><div class=3D"gm=
ail_default"><br></div><div class=3D"gmail_default">In similar case, it in =
unlocked correctly:</div><div class=3D"gmail_default"><a href=3D"https://gi=
thub.com/qemu/qemu/blob/d4f7d56759f7c75270c13d5f3f5f736a9558929c/linux-user=
/sh4/signal.c#L303" target=3D"_blank">https://github.com/<span class=3D"gma=
il-il">qemu</span>/<span class=3D"gmail-il">qemu</span>/blob/d4f7d56759f7c7=
5270c13d5f3f5f736a9558929c/linux-user/sh4/signal.c#L303</a><br></div><div c=
lass=3D"gmail_default"><br></div><div class=3D"gmail_default">Laurant repli=
ed that frame needs to be initialized with NULL in the second case indeed:<=
/div><div class=3D"gmail_default"><br></div><div class=3D"gmail_default"><s=
pan style=3D"font-family:Arial,Helvetica,sans-serif;font-size:small">In fac=
t, this case is a little bit different and wrong but to fix that</span><br =
style=3D"font-family:Arial,Helvetica,sans-serif;font-size:small"><span styl=
e=3D"font-family:Arial,Helvetica,sans-serif;font-size:small">the solution i=
s to set frame to NULL when it is declared:</span><br style=3D"font-family:=
Arial,Helvetica,sans-serif;font-size:small"><br style=3D"font-family:Arial,=
Helvetica,sans-serif;font-size:small"><span style=3D"font-family:Arial,Helv=
etica,sans-serif;font-size:small">linux-user/</span><span class=3D"gmail-il=
" style=3D"font-family:Arial,Helvetica,sans-serif;font-size:small">qemu</sp=
an><span style=3D"font-family:Arial,Helvetica,sans-serif;font-size:small">.=
h:</span><br style=3D"font-family:Arial,Helvetica,sans-serif;font-size:smal=
l"><span style=3D"font-family:Arial,Helvetica,sans-serif;font-size:small">*=
 Unlock an area of guest memory.=C2=A0 The first LEN bytes must be</span><b=
r style=3D"font-family:Arial,Helvetica,sans-serif;font-size:small"><span st=
yle=3D"font-family:Arial,Helvetica,sans-serif;font-size:small">=C2=A0 =C2=
=A0flushed back to guest memory. host_ptr =3D NULL is explicitly</span><br =
style=3D"font-family:Arial,Helvetica,sans-serif;font-size:small"><span styl=
e=3D"font-family:Arial,Helvetica,sans-serif;font-size:small">=C2=A0 =C2=A0a=
llowed and does nothing. */</span><br style=3D"font-family:Arial,Helvetica,=
sans-serif;font-size:small"><span style=3D"font-family:Arial,Helvetica,sans=
-serif;font-size:small">static inline void unlock_user(void *host_ptr, abi_=
ulong guest_addr,</span><br style=3D"font-family:Arial,Helvetica,sans-serif=
;font-size:small"><span style=3D"font-family:Arial,Helvetica,sans-serif;fon=
t-size:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0long len)</span><br sty=
le=3D"font-family:Arial,Helvetica,sans-serif;font-size:small"><span style=
=3D"font-family:Arial,Helvetica,sans-serif;font-size:small">like for linux-=
user/aarch64/signal.c:</span><br style=3D"font-family:Arial,Helvetica,sans-=
serif;font-size:small"><span style=3D"font-family:Arial,Helvetica,sans-seri=
f;font-size:small">long do_rt_sigreturn(CPUARMState *env)</span><br style=
=3D"font-family:Arial,Helvetica,sans-serif;font-size:small"><span style=3D"=
font-family:Arial,Helvetica,sans-serif;font-size:small">{</span><br style=
=3D"font-family:Arial,Helvetica,sans-serif;font-size:small"><span style=3D"=
font-family:Arial,Helvetica,sans-serif;font-size:small">=C2=A0 =C2=A0 struc=
t target_rt_sigframe *frame =3D NULL;</span><br style=3D"font-family:Arial,=
Helvetica,sans-serif;font-size:small"><span style=3D"font-family:Arial,Helv=
etica,sans-serif;font-size:small">...</span><br style=3D"font-family:Arial,=
Helvetica,sans-serif;font-size:small"><span style=3D"font-family:Arial,Helv=
etica,sans-serif;font-size:small">We have several targets with the same pro=
blem.</span></div></div><div class=3D"gmail_default" style=3D"font-family:g=
aramond,serif;font-size:large"><br></div><div class=3D"gmail_default" style=
=3D"font-family:garamond,serif;font-size:large">Thanks,</div><div class=3D"=
gmail_default" style=3D"font-family:garamond,serif;font-size:large">Mansour=
</div><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gma=
il_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr">=
<div dir=3D"ltr"><span style=3D"border-collapse:collapse;white-space:pre-wr=
ap"><span style=3D"border-collapse:separate;white-space:normal"><font color=
=3D"#000000" size=3D"2"><div style=3D"font-family:Calibri"><div style=3D"fo=
nt-family:arial,sans-serif"></div></div></font></span></span></div></div></=
div></div></div></div></div></div></div>

--000000000000fdb9d305a136064e--

