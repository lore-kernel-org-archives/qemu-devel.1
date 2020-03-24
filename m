Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60853C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 23:08:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F1192078A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 23:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiFjJ1Lz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1192078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGseg-0002j3-9M
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 19:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mansourweb@gmail.com>) id 1jGqKa-0000Wn-QX
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 16:39:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mansourweb@gmail.com>) id 1jGqKY-0002KZ-W6
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 16:39:24 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c]:38026)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mansourweb@gmail.com>)
 id 1jGqKY-0002JP-J5
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 16:39:22 -0400
Received: by mail-lj1-x22c.google.com with SMTP id w1so137250ljh.5
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 13:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zRpt9OILYe9v3aZz0hE0OTtDbRaHfdC7G5dm/VbNy7o=;
 b=OiFjJ1LzAX1Fox50CQO6TfXVhu21GtscWzViES2aJLS49i1MusKFCKOCk/iWudCVKF
 X0BZySNzRXqdEXiaIEjo94sZdyIZYMMqd0IXMXOkD3rKllj6cETB3ku+IpoqAzOXstJQ
 Rw66h4s4e8TVHyawcCQT2PWcGdbdEAw6A2rOANRs7pfyFRKDoVS+GL8uugndaG9cDV9w
 IRoIFIEmIsOt+8jtEIgHA8QDfbcdgV1sgl+P6avigkUe578WGyIXWv8OnbpBFExsjoTu
 VFSsMKrSjSd+f0zyfh+47j/1deLby0VHcDqDr1VXfVMaqbJ1yUfXfOiNne0vUicrbzO0
 nM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zRpt9OILYe9v3aZz0hE0OTtDbRaHfdC7G5dm/VbNy7o=;
 b=EbLinNSi5i40IQ/se0xF7NF2zIiM2fMut2cOKfleC4/aTmRgv4OdO8Kap5PBvmGqoI
 vnN73K/xwnKimbbh0ovkDQ2EbUSZp+IuLxYAnlO+DsdTZuLaJCIcqzudTAL0ofGjUi1D
 CefujQsuXAth6ScLSffsAfwRqDxaUV7S0EurOtnU+UhHA2yIGwklPsyPJL/5nkmk8Pa9
 7Vg1fcQRY9/d+zvLSCpbqXkp9wfCLqMgUdB38VDb4OpVmMirjgdv6sSS/vmQws1YVJg8
 HlTj9lvDR/vgRIRkrLr06rSt4fVQXxpF/xOmUQYzZUF1if/LmISBTV28B2k3+DlzRgm2
 z33w==
X-Gm-Message-State: ANhLgQ2OQqKLQKnWcSNUkBaOYPCif+jqscGuOqWfbMHuOEuLDHd4YAPW
 2NwPlu8vl6vZVe/fNOqEwk/QpUYnZcbg7p3iNxo=
X-Google-Smtp-Source: ADFU+vsYXT6OlGuw+133fSjytnU0y/tMz9cKNraLbJw4ilU3ty6oFn8gm4HQ+ryutdBwtN4EgftJcIdveH/oSpd6RJU=
X-Received: by 2002:a2e:94c8:: with SMTP id r8mr18463194ljh.28.1585082359602; 
 Tue, 24 Mar 2020 13:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAGT9xrDKJQW6HV6OWDDck=H0bGzk=7ZTVn6tTfNnv=tH0sr1nA@mail.gmail.com>
 <CAFEAcA-sY_H5s6j4ZEZ+SMvQgyENF+w+v5ajiJOhHDrn_zfjrA@mail.gmail.com>
In-Reply-To: <CAFEAcA-sY_H5s6j4ZEZ+SMvQgyENF+w+v5ajiJOhHDrn_zfjrA@mail.gmail.com>
From: Mansour Ahmadi <mansourweb@gmail.com>
Date: Tue, 24 Mar 2020 16:39:08 -0400
Message-ID: <CAGT9xrBS_Hp5VHjZeSP4q5CMEbzu33B3Jza+nxGybK-n4QLQGA@mail.gmail.com>
Subject: Re: Potential missing checks
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000fbe1e005a19fbe50"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::22c
X-Mailman-Approved-At: Tue, 24 Mar 2020 19:07:06 -0400
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fbe1e005a19fbe50
Content-Type: text/plain; charset="UTF-8"

Thank you for looking into this, Peter. I agree that static analysis has
false positives; that's why I called them potential. Basically, they are
found based on code similarity so I might be wrong and I need a second
opinion from QEMU developers. I appreciate your effort.

For the first case, I noticed a check on offset (if (offset)) before
negating it and passing to stream function here.
https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df76/disas/arm.c#L1748

Similar scenario happened here WITHOUT the check:
https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df76/disas/arm.c#L2731-L2733

So I wonder whether a check on offset is really missed.

Thank you!
Mansour



On Tue, Mar 24, 2020 at 5:24 AM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Mon, 23 Mar 2020 at 22:04, Mansour Ahmadi <ManSoSec@gmail.com> wrote:
> >
> > Hi QEMU developers,
> >
> > I noticed the following two potential missing checks by static analysis
> and detecting inconsistencies on the source code of QEMU. here is the
> result:
>
> Hi. Can you provide more details of your analysis, please? "Maybe
> there's an issue
> at this line" is not terribly helpful, especially if one has to follow
> a bunch of URLs
> to even find out which code is being discussed. All static analysers are
> prone
> to false positives, and so the value is in analysing the possible issues,
> not
> in simply dumping raw output with no details onto the mailing list.
>
> > 1)
> > Missing check on offset:
> >
> https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df76/disas/arm.c#L2728-L2733
> >
> > While it is checked here:
> >
> https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df76/disas/arm.c#L1748-L1752
>
> What in particular do you think should be being checked that is not?
>
> > 2)
> > Missing check on bmds->dirty_bitmap:
> >
> https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df76/migration/block.c#L377-L378
> >
> > While it is checked here:
> >
> https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df76/migration/block.c#L363-L365
>
> This one looks correct to me -- the second case is the error handling
> path for "failure halfway through creating the list of dirty bitmaps",
> and so it must handle "this one wasn't created yet". The first
> case will only run on data structures where set_dirty_tracking()
> succeeded, and so we know that there can't be any NULL pointers.
> Why do you think it is incorrect?
>
> thanks
> -- PMM
>

--000000000000fbe1e005a19fbe50
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:garamond=
,serif;font-size:large">Thank you for looking into this, Peter. I agree tha=
t static analysis has false positives; that&#39;s why I called them potenti=
al. Basically, they are found based on code similarity so I might be wrong =
and I need a second opinion from QEMU developers. I appreciate your effort.=
</div><div class=3D"gmail_default" style=3D"font-family:garamond,serif;font=
-size:large"><br></div><div class=3D"gmail_default" style=3D"font-family:ga=
ramond,serif;font-size:large">For the first case, I noticed a check on offs=
et (<span class=3D"gmail-pl-k" style=3D"box-sizing:border-box;color:rgb(215=
,58,73);font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Men=
lo,monospace;font-size:12px;white-space:pre">if</span><span style=3D"color:=
rgb(36,41,46);font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quo=
t;,Menlo,monospace;font-size:12px;white-space:pre;background-color:rgb(255,=
251,221)"> (offset)</span>) before negating it and passing to stream functi=
on here.=C2=A0</div><div class=3D"gmail_default" style=3D"font-family:garam=
ond,serif;font-size:large"><a href=3D"https://github.com/qemu/qemu/blob/c53=
2b954d96f96d361ca31308f75f1b95bd4df76/disas/arm.c#L1748">https://github.com=
/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df76/disas/arm.c#L1748<=
/a><br></div><div class=3D"gmail_default" style=3D"font-family:garamond,ser=
if;font-size:large"><br></div><div class=3D"gmail_default" style=3D"font-fa=
mily:garamond,serif;font-size:large">Similar scenario happened here WITHOUT=
 the check:</div><div class=3D"gmail_default" style=3D"font-family:garamond=
,serif;font-size:large"><a href=3D"https://github.com/qemu/qemu/blob/c532b9=
54d96f96d361ca31308f75f1b95bd4df76/disas/arm.c#L2731-L2733">https://github.=
com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df76/disas/arm.c#L27=
31-L2733</a><br></div><div class=3D"gmail_default" style=3D"font-family:gar=
amond,serif;font-size:large"><br></div><div class=3D"gmail_default" style=
=3D"font-family:garamond,serif;font-size:large">So I wonder whether a check=
 on offset is really missed.</div><div class=3D"gmail_default" style=3D"fon=
t-family:garamond,serif;font-size:large"><br></div><div class=3D"gmail_defa=
ult" style=3D"font-family:garamond,serif;font-size:large">Thank you!</div><=
div class=3D"gmail_default" style=3D"font-family:garamond,serif;font-size:l=
arge">Mansour</div><div><div dir=3D"ltr" class=3D"gmail_signature" data-sma=
rtmail=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"lt=
r"><div dir=3D"ltr"><span style=3D"border-collapse:collapse;white-space:pre=
-wrap"><span style=3D"border-collapse:separate;white-space:normal"><font co=
lor=3D"#000000" size=3D"2"><div style=3D"font-family:Calibri"><div style=3D=
"font-family:arial,sans-serif"><div><br></div></div></div></font></span></s=
pan></div></div></div></div></div></div><br></div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 24, 2020 at 5:24 AM=
 Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydel=
l@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">On Mon, 23 Mar 2020 at 22:04, Mansour Ahmadi &lt;<a href=3D"mai=
lto:ManSoSec@gmail.com" target=3D"_blank">ManSoSec@gmail.com</a>&gt; wrote:=
<br>
&gt;<br>
&gt; Hi QEMU developers,<br>
&gt;<br>
&gt; I noticed the following two potential missing checks by static analysi=
s and detecting inconsistencies on the source code of QEMU. here is the res=
ult:<br>
<br>
Hi. Can you provide more details of your analysis, please? &quot;Maybe<br>
there&#39;s an issue<br>
at this line&quot; is not terribly helpful, especially if one has to follow=
<br>
a bunch of URLs<br>
to even find out which code is being discussed. All static analysers are pr=
one<br>
to false positives, and so the value is in analysing the possible issues, n=
ot<br>
in simply dumping raw output with no details onto the mailing list.<br>
<br>
&gt; 1)<br>
&gt; Missing check on offset:<br>
&gt; <a href=3D"https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308=
f75f1b95bd4df76/disas/arm.c#L2728-L2733" rel=3D"noreferrer" target=3D"_blan=
k">https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df=
76/disas/arm.c#L2728-L2733</a><br>
&gt;<br>
&gt; While it is checked here:<br>
&gt; <a href=3D"https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308=
f75f1b95bd4df76/disas/arm.c#L1748-L1752" rel=3D"noreferrer" target=3D"_blan=
k">https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df=
76/disas/arm.c#L1748-L1752</a><br>
<br>
What in particular do you think should be being checked that is not?<br>
<br>
&gt; 2)<br>
&gt; Missing check on bmds-&gt;dirty_bitmap:<br>
&gt; <a href=3D"https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308=
f75f1b95bd4df76/migration/block.c#L377-L378" rel=3D"noreferrer" target=3D"_=
blank">https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95b=
d4df76/migration/block.c#L377-L378</a><br>
&gt;<br>
&gt; While it is checked here:<br>
&gt; <a href=3D"https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308=
f75f1b95bd4df76/migration/block.c#L363-L365" rel=3D"noreferrer" target=3D"_=
blank">https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95b=
d4df76/migration/block.c#L363-L365</a><br>
<br>
This one looks correct to me -- the second case is the error handling<br>
path for &quot;failure halfway through creating the list of dirty bitmaps&q=
uot;,<br>
and so it must handle &quot;this one wasn&#39;t created yet&quot;. The firs=
t<br>
case will only run on data structures where set_dirty_tracking()<br>
succeeded, and so we know that there can&#39;t be any NULL pointers.<br>
Why do you think it is incorrect?<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--000000000000fbe1e005a19fbe50--

