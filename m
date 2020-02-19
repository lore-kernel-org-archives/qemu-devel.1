Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BD4C34056
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 20:03:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D05D207FD
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 20:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBKnP0/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D05D207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4VZC-0008Sd-3j
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 15:03:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j4VXy-0007UD-D4
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 15:02:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j4VXx-0008Sp-5r
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 15:02:14 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44898)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j4VXv-0008Rm-W3; Wed, 19 Feb 2020 15:02:13 -0500
Received: by mail-ot1-x342.google.com with SMTP id h9so1353308otj.11;
 Wed, 19 Feb 2020 12:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=nIKXe7L9BpeECIXTtRvzeDcTbInJVPXvnkFxhLCPuBA=;
 b=OBKnP0/wCT9R6cnLmMQ5fjzdJ0a/xs9p7PChW8kjZ4UR/24VNsGOoMk/5EaG0ezJ5c
 vl8qcUDh3h7csBKZqzGcmcq+P4J8hVVEQMvAf4jmabR49ebM3BsocOfiAY+DAFaFmS+x
 xMKNLojhFaQfm/WKWbo1AIMLJcYxkCdlAPQpm9ZxNcwtlKoogbHf52q+dFA4SXvw0/Od
 M7JyK5mfQ291tfDmESnQFBpGrPrdvAgLepnIYztHUKH8wa6QHJGIYwk93OrjHoMiyoAl
 PPtS7PhPpMbzajmq45ZIFb9BKLbKs2MHN6jALpD7nSDQHYR42rkE+SHtO3iNntX2yyHd
 bcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=nIKXe7L9BpeECIXTtRvzeDcTbInJVPXvnkFxhLCPuBA=;
 b=hbJ6/gjScY4whId0G0fk2dey6N8QPmH0whO1GoijGiflQ6eYNWDTHLlBQLmR/LQAq3
 JIhniiMKzELSZUsdl010L9gOBL3rYwAyZA5a/JLsirhC7VjYLNxbmmXaZcM9Pbg2bOSQ
 rINcCULX64eT9OWch69T+/rVr8rbNYBkLHqCATxXktr4fClLPM6bJ/Hp32/jAoW4+gfV
 CtM1hu4ICrMUHZEDANXuojojsB4TBex8Dms+WxzQ+hp8dtPXf7s/nv5x9sm4O9WQvUMK
 qAa1GuynUUSlGuMBs5O1HaJwOANlbrNS9Qp29Z8PHptWdMpLYBKy8pnVi+3eB6XKFgrg
 KfJA==
X-Gm-Message-State: APjAAAWP+dveITw2P598rVAIUFXpquK2r3zcjsT3iAXIwkZGcy+GzV2T
 Z0ZwgGJt0pWHRCqbmCUffV8O3HOMDpVqso0czro=
X-Google-Smtp-Source: APXvYqx4eTSNsfgO4xwl8AqJf5t9emIVosPShGmbop8i1Jqwzvf3PWi/W99gvQ+f9882fKMS4SeamJXG0NA+HyjEIMA=
X-Received: by 2002:a05:6830:1042:: with SMTP id
 b2mr20523360otp.306.1582142531202; 
 Wed, 19 Feb 2020 12:02:11 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Wed, 19 Feb 2020 12:02:10 -0800 (PST)
In-Reply-To: <9f0e6f56-1a0e-9dc5-8608-e9928ff27cba@vivier.eu>
References: <20200217223558.863199-1-laurent@vivier.eu>
 <20200217223558.863199-22-laurent@vivier.eu>
 <CAL1e-=hxuExGBLhy=mYvM3ZfXeZA2KpA6z-5=X6xta5WcM+p5A@mail.gmail.com>
 <CAL1e-=j1R1Sd-Y8Wc56SHKZf1QLjhNq5KpY2RHD3wkQf0QKeaQ@mail.gmail.com>
 <9f0e6f56-1a0e-9dc5-8608-e9928ff27cba@vivier.eu>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 19 Feb 2020 21:02:10 +0100
Message-ID: <CAL1e-=jVvH4UHQrxguB_p1Hc8Ma7-5=-Dk2G4oEX0GugbQRdUQ@mail.gmail.com>
Subject: Re: [PATCH 21/22] linux-user,mips: move content of mips_syscall_args
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/alternative; boundary="0000000000008e711c059ef343cd"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008e711c059ef343cd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday, February 19, 2020, Laurent Vivier <laurent@vivier.eu> wrote:

> Le 19/02/2020 =C3=A0 19:58, Aleksandar Markovic a =C3=A9crit :
> >
> >
> > On Tuesday, February 18, 2020, Aleksandar Markovic
> > <aleksandar.m.mail@gmail.com <mailto:aleksandar.m.mail@gmail.com>>
> wrote:
> >
> >
> >
> >     On Monday, February 17, 2020, Laurent Vivier <laurent@vivier.eu
> >     <mailto:laurent@vivier.eu>> wrote:
> >
> >         Move content of mips_syscall_args to mips-syscall-args-o32.c.in=
c
> to
> >         ease automatic update. No functionnal change
> >
> >         Signed-off-by: Laurent Vivier <laurent@vivier.eu
> >         <mailto:laurent@vivier.eu>>
> >         ---
> >
> >
> >
> > Laurent,
> >
> > Many thanks for implementing this series, and a special thank you for
> > mips parts! I conceptually agree with the whole content (but I looked i=
n
> > details only mips-related stuff), however I will take a closer look at
> > the entire series in next few days.
>
> I plan to send a v2 to remove the syscall32_nr.h and syscall64_nr and
> use everywhere syscall_nr.h (because it is generated by target). files
> because they are not needed. Wait the v2 to take a closer look, except
> if you see any obvious issue.
>
>
Sure, in that case, I am going to wait for v2.

Best regards,
Aleksandar

Thanks,
> Laurent
>
>

--0000000000008e711c059ef343cd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, February 19, 2020, Laurent Vivier &lt;<a href=3D"mail=
to:laurent@vivier.eu">laurent@vivier.eu</a>&gt; wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Le 19/02/2020 =C3=A0 19:58, Aleksandar Markovic a =C3=A9crit=
=C2=A0:<br>
&gt; <br>
&gt; <br>
&gt; On Tuesday, February 18, 2020, Aleksandar Markovic<br>
&gt; &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com">aleksandar.m.mail@g=
mail.com</a> &lt;mailto:<a href=3D"mailto:aleksandar.m.mail@gmail.com">alek=
sandar.m.mail@<wbr>gmail.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Monday, February 17, 2020, Laurent Vivier &lt;<a=
 href=3D"mailto:laurent@vivier.eu">laurent@vivier.eu</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:laurent@vivier.eu">lau=
rent@vivier.eu</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Move content of mips_syscall_args to =
mips-syscall-args-o32.c.inc to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ease automatic update. No functionnal=
 change<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Signed-off-by: Laurent Vivier &lt;<a =
href=3D"mailto:laurent@vivier.eu">laurent@vivier.eu</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:laurent@=
vivier.eu">laurent@vivier.eu</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0---<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; Laurent,<br>
&gt; <br>
&gt; Many thanks for implementing this series, and a special thank you for<=
br>
&gt; mips parts! I conceptually agree with the whole content (but I looked =
in<br>
&gt; details only mips-related stuff), however I will take a closer look at=
<br>
&gt; the entire series in next few days.<br>
<br>
I plan to send a v2 to remove the syscall32_nr.h and syscall64_nr and<br>
use everywhere syscall_nr.h (because it is generated by target). files<br>
because they are not needed. Wait the v2 to take a closer look, except<br>
if you see any obvious issue.<br>
<br></blockquote><div><br></div><div>Sure, in that case, I am going to wait=
 for v2.</div><div><br></div><div>Best regards,</div><div>Aleksandar</div><=
div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">
Thanks,<br>
Laurent<br>
<br>
</blockquote>

--0000000000008e711c059ef343cd--

