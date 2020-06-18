Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EFBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:10:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 638CE20656
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyTmc21d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 638CE20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlwBM-0003bV-MZ
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 11:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jlw8D-0008LG-Hn
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:07:10 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:40217)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jlw8B-0000vF-2Q
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:07:08 -0400
Received: by mail-wr1-x433.google.com with SMTP id h5so6447271wrc.7
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 08:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=VE45IjbDxvu3358vkYjshA4lYZnR9j7ohge4rzRsW/s=;
 b=GyTmc21djPYpLkp9ExME4oGKbFnSLUwCdu2tRFICDDOiCQYC+kboiwjUxB7QiAa+87
 4xvbyREFYE/DqMB+/glCB2549mB88pua43lGR9GLjceAzfyH1cwJkqqijP1tvSe6zwSr
 o15z3EmhjcCIHKn7gHTcyqdU46L8d3akh13cnfwC742kH7CHPsLwZ2D1U954VHkCTszs
 h/3EJe14SbeadftLsXJq0YS4B0DW4Enrq5oE6u/qwTNkQDKHhUUrFkWS/iBhkcb0ASbu
 xfY0GdKhJunh1Lipy6+Cr2GXWbjLZ/IT55eNbweI+XSMm37wvABck15HUyeGuYAZtMbm
 UOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=VE45IjbDxvu3358vkYjshA4lYZnR9j7ohge4rzRsW/s=;
 b=ODVvRY5i7wUsm8NKvPDidhRjLFl2OV8xgCpEDYPM5ysHKHfNkO0zGhy6A9WShnELT7
 4UjOlBhBtXWT8nZQjTb11mzTKNNNcZ9OiVNddoAgGSTaDLxXySicdL5o/BtIZhjyP44n
 IqbNXKIKBaAutl/6nDeTR3c3e5VIY4v8XThxAXg6EoEblfj3YfxverJdgvDaM6jK2DRk
 +62dEAj/S2LBHfL6NHdUQ0s+aWtWd6Pw8W29XTPKDFwwjRHFIjBr1LpWSYU5D246jpfB
 2yoW4i+dvc7BlLJerkIOqCJxQD0JziOX9D2ktN04oCWmSRq1oJoydG8QNe9N9X829T8f
 S3LA==
X-Gm-Message-State: AOAM5331KzQucSkFK0TnzGmF46vg6R/qhm0ShTyVM8yZaTcsBbCMke5Z
 f3P9Xsnqf4K8J5f1SCuv2ISOgVZjbm/NTfr7bUI=
X-Google-Smtp-Source: ABdhPJxXQbOZp7x81ZYKLvergILhxcQwqtFgLZXUIm1At8BlE0lob9YUdg0lWOUjWO3U+5DRfBypUqsU/Arj1EvZymQ=
X-Received: by 2002:adf:a283:: with SMTP id s3mr4761852wra.147.1592492825145; 
 Thu, 18 Jun 2020 08:07:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:451:0:0:0:0:0 with HTTP;
 Thu, 18 Jun 2020 08:07:04 -0700 (PDT)
In-Reply-To: <CALTWKrXmYVtxeAjMjD0UYKzYeuBUXxNeMYVVNLfbL-iKknAN4Q@mail.gmail.com>
References: <20200616231204.8850-1-ahmedkhaledkaraman@gmail.com>
 <20200616231204.8850-4-ahmedkhaledkaraman@gmail.com>
 <871rmdyjbh.fsf@linaro.org>
 <CALTWKrVovkoQvNFxYac2eOV7Cf+K_RA+1-Gn=3AnL8dJLemTyQ@mail.gmail.com>
 <877dw5wq7r.fsf@linaro.org>
 <CALTWKrXmYVtxeAjMjD0UYKzYeuBUXxNeMYVVNLfbL-iKknAN4Q@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 18 Jun 2020 17:07:04 +0200
Message-ID: <CAHiYmc6Cg+FQrJZJ4nzoDs9sgoxrbOZ2hL3k9rAAb9T23PVxrw@mail.gmail.com>
Subject: Re: [PATCH 3/3] scripts/performance: Add perf_top_25.py script
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000026732305a85d21e7"
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x433.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, "crosa@redhat.com" <crosa@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000026732305a85d21e7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80=D0=B5=D0=B4=D0=B0, 17. =D1=98=D1=83=D0=BD 2020., Ahmed Karaman=
 <ahmedkhaledkaraman@gmail.com> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:

> On Wed, Jun 17, 2020 at 7:35 PM Alex Benn=C3=A9e <alex.bennee@linaro.org>
> wrote:
> >
> > Right - which I do as a developer. It would be rude to sudo things if
> > you don't need to because then you end up running your potentially
> > un-trusted application with root privileges.
> >
> > Could we either probe for the requirement or require an explicit sudo
> > flag which we can prompt for if it fails?
> >
> To make sure I got it right. You mean I should specify in the script
> comment on the top that the user should modify the
> kernel.perf_event_paranoid setting in order to run the script, otherwise,
> they should add a --sudo flag when running the Python script to invoke
> perf as sudo?
>
>
I think Alex meant that everything related to super user access should be
examined by the script. You could:

A. Establish if the user that execute the script is already super user. If
yes, you can proceed with command lines containing "perf. (see hints how to
do this here:
https://stackoverflow.com/questions/2806897/what-is-the-best-way-for-checki=
ng-if-the-user-of-a-script-has-root-like-privileg
)

B. Establish if "perf" can be executed successfully with current user
privelages. If yes, you can also proceed with command lines containing
"perf" (a primitive but simple way for establishing this is to run "perf
stat ls /" and see what happens, success or error)

C. If neither A nor B are satisfied, you cold emit error message
instructing the user what he needs to/could do.

Just my 2 c. Not sure if this is compatible with Alex' thoughts.

Aleksandar


> > >
> > >> Also redirecting just stderr? why?
> > >
> > > Perf, as well as Valgrind, print their output on stderr not stdout.
> >
> > Right so I think a bit of splitting apart and use of subprocess can mak=
e
> > this cleaner and not involve quite so much being done with shell
> > redirection in one invocation.
> >
>
> Noted!
>

--00000000000026732305a85d21e7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D1=81=D1=80=D0=B5=D0=B4=D0=B0, 17. =D1=98=D1=83=D0=BD 2020., Ahmed=
 Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail.com">ahmedkhaledkar=
aman@gmail.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BE/=D0=BB=D0=B0:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Wed, Jun 17, 2020 at=
 7:35 PM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">ale=
x.bennee@linaro.org</a>&gt; wrote:<br>
&gt;<br>
&gt; Right - which I do as a developer. It would be rude to sudo things if<=
br>
&gt; you don&#39;t need to because then you end up running your potentially=
<br>
&gt; un-trusted application with root privileges.<br>
&gt;<br>
&gt; Could we either probe for the requirement or require an explicit sudo<=
br>
&gt; flag which we can prompt for if it fails?<br>
&gt;<br>
To make sure I got it right. You mean I should specify in the script<br>
comment on the top that the user should modify the<br>
kernel.perf_event_paranoid setting in order to run the script, otherwise,<b=
r>
they should add a --sudo flag when running the Python script to invoke<br>
perf as sudo?<br>
<br></blockquote><div><br></div><div>I think Alex meant that everything rel=
ated to super user access should be examined by the script. You could:</div=
><div><br></div><div>A. Establish if the user that execute the script is al=
ready super user. If yes, you can proceed with command lines containing &qu=
ot;perf. (see hints how to do this here: <a href=3D"https://stackoverflow.c=
om/questions/2806897/what-is-the-best-way-for-checking-if-the-user-of-a-scr=
ipt-has-root-like-privileg">https://stackoverflow.com/questions/2806897/wha=
t-is-the-best-way-for-checking-if-the-user-of-a-script-has-root-like-privil=
eg</a> )</div><div><br></div><div>B. Establish if &quot;perf&quot; can be e=
xecuted successfully with current user privelages. If yes,=C2=A0you can als=
o proceed with command lines containing &quot;perf&quot;=C2=A0(a primitive =
but simple way for establishing this is to run &quot;perf stat ls /&quot; a=
nd see what happens, success or error)</div><div><br></div><div>C. If neith=
er A nor B are satisfied, you cold emit error message instructing the user =
what he needs to/could do.</div><div><br></div><div>Just my 2 c. Not sure i=
f this is compatible with Alex&#39; thoughts.</div><div><br></div><div>Alek=
sandar</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
&gt; &gt;<br>
&gt; &gt;&gt; Also redirecting just stderr? why?<br>
&gt; &gt;<br>
&gt; &gt; Perf, as well as Valgrind, print their output on stderr not stdou=
t.<br>
&gt;<br>
&gt; Right so I think a bit of splitting apart and use of subprocess can ma=
ke<br>
&gt; this cleaner and not involve quite so much being done with shell<br>
&gt; redirection in one invocation.<br>
&gt;<br>
<br>
Noted!<br>
</blockquote>

--00000000000026732305a85d21e7--

