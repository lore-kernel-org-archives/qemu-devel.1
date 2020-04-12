Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953A2C2D0EC
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 20:56:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 579F7206A1
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 20:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RW6HujZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 579F7206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNjew-0001Wi-JA
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 16:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <adultjiuice@gmail.com>) id 1jNjeD-0000zj-38
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 16:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <adultjiuice@gmail.com>) id 1jNjeB-0007OK-UW
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 16:56:09 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:38984)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <adultjiuice@gmail.com>)
 id 1jNjeB-0007O2-Pw
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 16:56:07 -0400
Received: by mail-ot1-x329.google.com with SMTP id x11so7327684otp.6
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2020 13:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PiurOeC+lPKo6LugEjHrK2AUgA8SRN3a1qqSmunLqR4=;
 b=RW6HujZbRj4b3l/QlfPcAvlzVOhVpAY1CuQZXg5EAtvS9AvsmrwcPcikIX0PHiSO74
 kO/BJUFoXHleFnhEuXvTk1bavIQT1LfCNxGeIsDx0ignt7Q0r1ulj8H4+45tT/FYJaVF
 MH/bd6nsyax8sqVQmwHuWssaAmX69BD+WHWSJKezi/wcapqXafX43KmwT3Vt5vplSWhh
 aO0gYA8H3As0l7QN1l8Q0ji/CS5/UXY9oMrJk9egFginNK9FxQ8bVBCiHMO0Nt/COsJL
 +6I+HUQg2sqRbycpDaiK/cHfxDTfjEqiAovhVn4R08qrzNQV9Ekui0JnXgZqpQ8yQGvP
 LgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PiurOeC+lPKo6LugEjHrK2AUgA8SRN3a1qqSmunLqR4=;
 b=ULqFwXHlELJ/aGSh8d+0mq0kz1YeWWM/JtG0jziHDWss+6C1nkCku7PhwHO8NXsjVW
 NQ/1LtD5B96l9otc3cYmjTu7/C5RZTd5KxRSQPwNWinRN4NM35okVhvc/uyVz44cb4D5
 Sjhy19qD/XCuE46985hAYTOvk43Htb0NSh9Cjtn7zoojniQoIgu7PHKTpkMeXguc5q+l
 Qoq3W3R8mZaqmbo7kO6DfodrICkM42fxWkzmqCbRsJJsCKD2k4AeN6NFffL+lJ4wI7XJ
 pmi+1myWpyp4sNntD1Zm6yWRowZtLbiElOSa9IzykYtQA1O+i2X9Q6t7UzxwT3shqi72
 sF6w==
X-Gm-Message-State: AGi0PuZlRr26ArFJymmrsY6O8m8wrxzKXI21WSSCxOekQVXthDNHgoZv
 5V69vgaNhed7RoyfFMzXmsSb7/u5w2IOFUZ6McQgN0Uj11Y=
X-Google-Smtp-Source: APiQypJw/OrXkOBjbWuQ3z1IiEfJgt4o0py/3A49onpai7SIJ2eOljMkQ8ZP1lxnW2i+F1JDjJCfRH28WVT3btBcdZo=
X-Received: by 2002:a9d:629a:: with SMTP id x26mr11144869otk.201.1586724966771; 
 Sun, 12 Apr 2020 13:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAJAyOaarDVp_Qaqn45ML+KqfidyCH=wQG36VZn=f1wh1+nBumw@mail.gmail.com>
 <CAFEAcA8Y50+c5Hub7Y=XHbdrFVv+rhaN_7mkEW9YB63LgS0=TQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8Y50+c5Hub7Y=XHbdrFVv+rhaN_7mkEW9YB63LgS0=TQ@mail.gmail.com>
From: Oliver Christopher <adultjiuice@gmail.com>
Date: Sun, 12 Apr 2020 16:55:56 -0400
Message-ID: <CAJAyOaa5dX3d+awg+7ZRqDYPKAsQnj9jBZ8KH-384=7ewqo6Ow@mail.gmail.com>
Subject: Re: Clarification of above code
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000000321f05a31e3239"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000000321f05a31e3239
Content-Type: text/plain; charset="UTF-8"

Thank you for the clarification.

On Sun, Apr 12, 2020 at 4:54 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Sun, 12 Apr 2020 at 21:46, Oliver Christopher <adultjiuice@gmail.com>
> wrote:
> >
> > /*
> >  * We default to false if we know other options have been enabled
> >  * which are currently incompatible with MTTCG. Otherwise when each
> >  * guest (target) has been updated to support:
> >  *   - atomic instructions
> >  *   - memory ordering primitives (barriers)
> >  * they can set the appropriate CONFIG flags in ${target}-softmmu.mak
> >  *
> >  * Once a guest architecture has been converted to the new primitives
> >  * there are two remaining limitations to check.
> >  *
> >  * - The guest can't be oversized (e.g. 64 bit guest on 32 bit host)
> >  * - The host must have a stronger memory order than the guest
> >  *
> >  * It may be possible in future to support strong guests on weak hosts
> >  * but that will require tagging all load/stores in a guest with their
> >  * implicit memory order requirements which would likely slow things
> >  * down a lot.
> >  */
>
> > I am asking for clarification because the above code will default
> > x86 on ARM64 to disable MTTCG.
>
> What clarification are you after? The comment says we won't
> enable MTTCG if the host has a weaker memory model than
> the guest; arm64 has a weaker memory model than x86,
> and so we don't enable MTTCG for x86 guest on arm64 host.
> The 'it may be possible' paragraph explains why MTTCG
> on this combination would be tricky.
>
> (Strictly the comment should say "host must have at least as
> strong a memory order as the guest", but that makes no difference
> in the case you're asking about.)
>
> thanks
> -- PMM
>

--00000000000000321f05a31e3239
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div>Thank you for the clarification.</div><div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Apr 12, 2020 at 4:54 PM P=
eter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@=
linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Sun, =
12 Apr 2020 at 21:46, Oliver Christopher &lt;<a href=3D"mailto:adultjiuice@=
gmail.com" target=3D"_blank">adultjiuice@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; /*<br>
&gt;=C2=A0 * We default to false if we know other options have been enabled=
<br>
&gt;=C2=A0 * which are currently incompatible with MTTCG. Otherwise when ea=
ch<br>
&gt;=C2=A0 * guest (target) has been updated to support:<br>
&gt;=C2=A0 *=C2=A0 =C2=A0- atomic instructions<br>
&gt;=C2=A0 *=C2=A0 =C2=A0- memory ordering primitives (barriers)<br>
&gt;=C2=A0 * they can set the appropriate CONFIG flags in ${target}-softmmu=
.mak<br>
&gt;=C2=A0 *<br>
&gt;=C2=A0 * Once a guest architecture has been converted to the new primit=
ives<br>
&gt;=C2=A0 * there are two remaining limitations to check.<br>
&gt;=C2=A0 *<br>
&gt;=C2=A0 * - The guest can&#39;t be oversized (e.g. 64 bit guest on 32 bi=
t host)<br>
&gt;=C2=A0 * - The host must have a stronger memory order than the guest<br=
>
&gt;=C2=A0 *<br>
&gt;=C2=A0 * It may be possible in future to support strong guests on weak =
hosts<br>
&gt;=C2=A0 * but that will require tagging all load/stores in a guest with =
their<br>
&gt;=C2=A0 * implicit memory order requirements which would likely slow thi=
ngs<br>
&gt;=C2=A0 * down a lot.<br>
&gt;=C2=A0 */<br>
<br>
&gt; I am asking for clarification because the above code will default<br>
&gt; x86 on ARM64 to disable MTTCG.<br>
<br>
What clarification are you after? The comment says we won&#39;t<br>
enable MTTCG if the host has a weaker memory model than<br>
the guest; arm64 has a weaker memory model than x86,<br>
and so we don&#39;t enable MTTCG for x86 guest on arm64 host.<br>
The &#39;it may be possible&#39; paragraph explains why MTTCG<br>
on this combination would be tricky.<br>
<br>
(Strictly the comment should say &quot;host must have at least as<br>
strong a memory order as the guest&quot;, but that makes no difference<br>
in the case you&#39;re asking about.)<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div></div>

--00000000000000321f05a31e3239--

