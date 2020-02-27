Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F31DC11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 19:08:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E492424692
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 19:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnCBUaR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E492424692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7OWI-0004gR-6R
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 14:08:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j7OVa-00048S-Ut
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 14:07:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j7OVY-0001TR-Vh
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 14:07:42 -0500
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:42964)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1j7OVU-0001M5-Nw; Thu, 27 Feb 2020 14:07:36 -0500
Received: by mail-io1-xd42.google.com with SMTP id z1so635337iom.9;
 Thu, 27 Feb 2020 11:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xIaAzOO7CiQeAH4qsbtZ0X6RjIuzPqsDnaVRY+vJMyg=;
 b=NnCBUaR+zBYH8eIiTe9Si9RoGFPIRzyCL6SYG0xdClQwmeJgfCgWApXTpjHYs3Xrk/
 p8FnOSG76FfmQVWoOO2yrxuyS/tiDmCwkhumbTIcpnqN+jcgtEmzK9bzfBmb5qcT/AwX
 KIDDuwKVHhV7DFqTsAA01LmE3gWKFM0qbsVy+WDMrn5MLx2zCa3tTCefUqWbR5kMKABN
 W+qsGgyemJNBa3pE+jFnbyjO28Vhd/hW58A5L+kIR5whD74jODaD9ucWoNSJSzp/8rTE
 21PzfBUXv1EblBl6ISlywPLhaJj0zZP2BGm3fd7yYY9pAQPRHOWffVM433IjFdb5oatS
 HOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xIaAzOO7CiQeAH4qsbtZ0X6RjIuzPqsDnaVRY+vJMyg=;
 b=USpYrFdL9JVWq3enUncIbJx3emBSbkpsD9ZGRI1ASkPaD0ewR0K60FmNOjXJylXKji
 o/zxjSqjr6ySE4cqmBjByuK8YFppIvDi5bsfqoUy9+xdcLSvEH9PTYNuJxNhEjHQ23SB
 vzY+zH+cnxz9CO3x6J8ZeSnUP6bI5NQojjBxd8l+kRNp895Xn6fjtP5ZTzTReOaZhjQo
 TPtgZuQbZkmdkA2ZsqeA5c5xpZ0mWnopueqtPZbZr/PXLa4H9Uz8DGcdV2to0Lpmnekx
 LmWsJIlOW1uiX2Hv+IyvlJNoS5CZoX8rUy82ZOCQsS5MS7l8iKQ27cpV2qRzvehvLYmC
 5/4Q==
X-Gm-Message-State: APjAAAXT3DZpYmIpYkwZPE5szYBHEOoZunTkhh3hkrsBVKi3z/SL8ChM
 zauafB0sKyG/vBACTuhGsnY7G9ZHjALodBNHDEI=
X-Google-Smtp-Source: APXvYqwMmSKe6zMqgVBTvSvaC0BkVyDodskrCdOT/NZO07wSJA6kB0s0wipVEGOz9FzW8fxqBxFjepP4OIMwBcMxAG4=
X-Received: by 2002:a05:6602:158e:: with SMTP id
 e14mr584466iow.217.1582830455947; 
 Thu, 27 Feb 2020 11:07:35 -0800 (PST)
MIME-Version: 1.0
References: <20200226181020.19592-1-alex.bennee@linaro.org>
 <20200226181020.19592-5-alex.bennee@linaro.org>
 <2ca7b55b-5674-370d-5c4d-dc8b7782ca64@linaro.org>
 <87pne0w6rt.fsf@linaro.org> <56f5e355-9357-e212-e92b-9db1d8424dea@linaro.org>
In-Reply-To: <56f5e355-9357-e212-e92b-9db1d8424dea@linaro.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Thu, 27 Feb 2020 20:07:24 +0100
Message-ID: <CAPan3WrSRm986EfwJdXV2MduNLE5BS+QmCv0Bo5-BD+QfT-=dg@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] accel/tcg: increase default code gen buffer size
 for 64 bit
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000011092f059f936f1b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000011092f059f936f1b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On Thu, Feb 27, 2020 at 1:57 PM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 2/27/20 4:31 AM, Alex Benn=C3=A9e wrote:
> >> It does not make sense for a linux-user chroot, running make -jN, on
> just about
> >> any host.  For linux-user, I could be happy with a modest increase, bu=
t
> not all
> >> the way out to 2GiB.
> >>
> >> Discuss.
> >
> > Does it matter that much? Surely for small programs the kernel just
> > never pages in the used portions of the mmap?
>
> That's why I used the example of a build under the chroot, because the
> compiler
> is not a small program.
>
> Consider when the memory *is* used, and N * 2GB implies lots of paging,
> where
> the previous N * 32MB did not.
>
> I agree that a lower default value probably is safer until we have more
proof that a larger value does not give any issues.


> I'm saying that we should consider a setting more like 128MB or so, since
> the
> value cannot be changed from the command-line, or through the environment=
.
>

Proposal: can we then introduce a new command line parameter for this?
Maybe in a new patch?
Since the size of the code generation buffer appears to have an impact on
performance,
in my opinion it would make sense to make it configurable by the user.

Regards,
Niek


>
>
> r~
>
>

--=20
Niek Linnenbank

--00000000000011092f059f936f1b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Richard,<br></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 27, 2020 at 1:57 PM Richar=
d Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.hen=
derson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On 2/27/20 4:31 AM, Alex Benn=C3=A9e wrote:<br>
&gt;&gt; It does not make sense for a linux-user chroot, running make -jN, =
on just about<br>
&gt;&gt; any host.=C2=A0 For linux-user, I could be happy with a modest inc=
rease, but not all<br>
&gt;&gt; the way out to 2GiB.<br>
&gt;&gt;<br>
&gt;&gt; Discuss.<br>
&gt; <br>
&gt; Does it matter that much? Surely for small programs the kernel just<br=
>
&gt; never pages in the used portions of the mmap?<br>
<br>
That&#39;s why I used the example of a build under the chroot, because the =
compiler<br>
is not a small program.<br>
<br>
Consider when the memory *is* used, and N * 2GB implies lots of paging, whe=
re<br>
the previous N * 32MB did not.<br>
<br></blockquote><div><div>I agree that a lower default value probably is s=
afer until we have more proof that a larger value does not give any issues.=
</div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
I&#39;m saying that we should consider a setting more like 128MB or so, sin=
ce the<br>
value cannot be changed from the command-line, or through the environment.<=
br></blockquote><div><br></div><div>Proposal: can we then introduce a new c=
ommand line parameter for this? Maybe in a new patch?</div><div>Since the s=
ize of the code generation buffer appears to have an impact on performance,=
</div><div>in my opinion it would make sense to make it configurable by the=
 user.<br></div><div><br></div><div>Regards,</div><div>Niek<br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
r~<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--00000000000011092f059f936f1b--

