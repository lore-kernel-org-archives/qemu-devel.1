Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14E5C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 10:57:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C18C20658
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 10:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0PpgLfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C18C20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36747 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJxWy-0003qL-P3
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 06:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1jJxWG-0003Hg-Si
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 06:56:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1jJxWF-0007eJ-B8
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 06:56:20 -0400
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e]:42798)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>)
 id 1jJxWF-0007dn-2Z; Thu, 02 Apr 2020 06:56:19 -0400
Received: by mail-io1-xd2e.google.com with SMTP id y17so995828iow.9;
 Thu, 02 Apr 2020 03:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z9pkTaW3SC6n9aMuNkhlJ0igs5jeTaZjHxoCh8YFsig=;
 b=h0PpgLfiSXf785IlxCM+KragVQjADjr2uvURKlRv/zdhMKaoE3fwmRiet9tgQS0GVs
 l/QvDahzbW9c8TBcvrwS1zVQHgwAtHxch5R//SUVwXk8rjrsWkL39jpQZrKnCBIREOAh
 l1pzE0DB0NBf0UWX4PAZbZlTAwEsr0qpwgsYpza20yfnvK0iqhrenEhRErNv0G6ozKtW
 vJM1o5iBkxG8tsg/WpyrjCXotTePl4vyS5DOjYANI2X+CSNb+F1CiTg+/cmwLvH21KXy
 9Um/2hmxA8idF1Jxu8/lTfCBTUnD5Aj7QkbByXoxr9gTlEh3Vt42qTgF7y24Yde3Clzy
 OASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z9pkTaW3SC6n9aMuNkhlJ0igs5jeTaZjHxoCh8YFsig=;
 b=blZAUBAA0CkvIAJ9JjWp/SzLFknNwYqLb5ZTXHRLE+ZPbcvGQgtxebVcIWvtzd6yhp
 /6I+e0Dnl1DNG0hy2UQEs3T0eOemLbuGIFZdKCmyD4NaIkxJr6kzkSuGRdRyYR56oOab
 fs0IWAfMz3zy3ccW4NFu35v1mgrRrS1n/o2Gxm2chgyL3Fi9pQ/RD8qAMH8WAAPlA7vF
 Sc6DB3x7uzl2evn8PMm34ZqzJ83KZZLbkCr77Npw/IeyVcSR4E3yImVKc4lA7vFa6fyp
 S2xpJHbJV/S2gsqOf+SYY6LAlkcOFeHBMZuNuTUYz9A+sBK9KhdW9lLq9JSDrkRpM76S
 iusg==
X-Gm-Message-State: AGi0PuZ9/tp0uw+Q/tXG/QM8NntfiDzYeACfI5n8V2w6vHLxeoZQjjVJ
 OUnGWVImlTtOTqw2vMiVZmdwgYhgYqu/GFpfmsw=
X-Google-Smtp-Source: APiQypIOP/eJMQiV+14RiSlXgegdB5WAmkD1Gnnr8f9wQqqjIiywHVExGSwr6iUVV9y2cyXPkwdylZykEx8/pUBEQcQ=
X-Received: by 2002:a5e:da0c:: with SMTP id x12mr2165473ioj.69.1585824976996; 
 Thu, 02 Apr 2020 03:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <CABLmASEaKJKzDdvKGv+iWfp=0vdr9bupM76zvLZZ6sZFAPkuRg@mail.gmail.com>
 <6ad7d2d1-658c-04db-4ce0-77c498efbba4@redhat.com>
In-Reply-To: <6ad7d2d1-658c-04db-4ce0-77c498efbba4@redhat.com>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Thu, 2 Apr 2020 12:56:05 +0200
Message-ID: <CABLmASEBUzdzu8wt-2YbcntOAfNbsVm7W=W-Uk85ieu1757pMA@mail.gmail.com>
Subject: Re: qemu-system-ppc 5.0 rc1 crashing on Windows
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006e0bd405a24ca614"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d2e
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
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, qemu-devel qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006e0bd405a24ca614
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2020 at 12:47 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> Cc'ing the persons referenced in the commit you referred,
> who happened to be chatting about this issue few hours ago on IRC.
>
>
Thanks, adding --disable-pie to configure solves this issue, but I guess
the default detection should work ;-)

Best,
Howard



> On 4/2/20 11:28 AM, Howard Spoelstra wrote:
> > Hi,
> >
> > I just compiled qemu-system-ppc for Windows, using native msys2 on
> > Windows 10 64 bit and the 64 bit mingw cross compiler on Fedora 31. Bot=
h
> > create executables that crash:
> >
> > qemu-system-ppc.exe -L pc-bios -boot c -m 512 -M mac99,via=3Dpmu -h
> > da C:\Mac-disks\9.2.img
> > Exception code=3D0xc0000005 flags=3D0x0 at 0x00007FFB2A602078. Access
> > violation - attempting to write data at address 0x00000000034C76EC
> >
> > I bisected this down to:
> >
> > d2cd29e30736afd4a1e8cac3cf4da360bbc65978 is the first bad commit
> > commit d2cd29e30736afd4a1e8cac3cf4da360bbc65978
> > Author: Richard Henderson <richard.henderson@linaro.org
> > <mailto:richard.henderson@linaro.org>>
> > Date:   Tue Dec 17 13:47:37 2019 -1000
> >
> >      configure: Do not force pie=3Dno for non-x86
> >
> >      PIE is supported on many other hosts besides x86.
> >
> >      The default for non-x86 is now the same as x86: pie is used
> >      if supported, and may be forced via --enable/--disable-pie.
> >
> >      The original commit (40d6444e91c) said:
> >
> >        "Non-x86 are not changed, as they require TCG changes"
> >
> >      but I think that's wrong -- there's nothing about PIE that
> >      affects TCG one way or another.
> >
> >      Tested on aarch64 (bionic) and ppc64le (centos 7) hosts.
> >
> >      Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org
> > <mailto:alex.bennee@linaro.org>>
> >      Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org
> > <mailto:alex.bennee@linaro.org>>
> >      Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
> > <mailto:philmd@redhat.com>>
> >      Signed-off-by: Richard Henderson <richard.henderson@linaro.org
> > <mailto:richard.henderson@linaro.org>>
> >
> > Please note that I tried again after applying patch
> > https://patchwork.ozlabs.org/patch/1265368/ However, this has not
> solved
> > my issue.
> >
> > Best,
> > Howard
> >
> >
>
>

--0000000000006e0bd405a24ca614
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 2, 2020 at 12:47 PM Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Cc&#39;ing the persons referenced in the commit you referred,<br>
who happened to be chatting about this issue few hours ago on IRC.<br>
<br></blockquote><div><br></div><div>Thanks, adding --disable-pie to config=
ure solves this issue, but I guess the default detection should work ;-)</d=
iv><div><br></div><div>Best,</div><div>Howard<br></div><div><br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
On 4/2/20 11:28 AM, Howard Spoelstra wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; I just compiled qemu-system-ppc for Windows, using native msys2 on <br=
>
&gt; Windows 10 64 bit and the 64 bit mingw cross compiler on Fedora 31. Bo=
th <br>
&gt; create executables that crash:<br>
&gt; <br>
&gt; qemu-system-ppc.exe -L pc-bios -boot c -m 512 -M mac99,via=3Dpmu -h<br=
>
&gt; da C:\Mac-disks\9.2.img<br>
&gt; Exception code=3D0xc0000005 flags=3D0x0 at 0x00007FFB2A602078. Access =
<br>
&gt; violation - attempting to write data at address 0x00000000034C76EC<br>
&gt; <br>
&gt; I bisected this down to:<br>
&gt; <br>
&gt; d2cd29e30736afd4a1e8cac3cf4da360bbc65978 is the first bad commit<br>
&gt; commit d2cd29e30736afd4a1e8cac3cf4da360bbc65978<br>
&gt; Author: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:richard.henderson@linaro.org" target=3D"_=
blank">richard.henderson@linaro.org</a>&gt;&gt;<br>
&gt; Date: =C2=A0 Tue Dec 17 13:47:37 2019 -1000<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 configure: Do not force pie=3Dno for non-x86<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 PIE is supported on many other hosts besides x86.<=
br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 The default for non-x86 is now the same as x86: pi=
e is used<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if supported, and may be forced via --enable/--dis=
able-pie.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 The original commit (40d6444e91c) said:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Non-x86 are not changed, as they requ=
ire TCG changes&quot;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 but I think that&#39;s wrong -- there&#39;s nothin=
g about PIE that<br>
&gt;=C2=A0 =C2=A0 =C2=A0 affects TCG one way or another.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 Tested on aarch64 (bionic) and ppc64le (centos 7) =
hosts.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 Tested-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:=
alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:alex.bennee@linaro.org" target=3D"_blank"=
>alex.bennee@linaro.org</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Reviewed-by: Alex Benn=C3=A9e &lt;<a href=3D"mailt=
o:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:alex.bennee@linaro.org" target=3D"_blank"=
>alex.bennee@linaro.org</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redhat.com</a> <br=
>
&gt; &lt;mailto:<a href=3D"mailto:philmd@redhat.com" target=3D"_blank">phil=
md@redhat.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Signed-off-by: Richard Henderson &lt;<a href=3D"ma=
ilto:richard.henderson@linaro.org" target=3D"_blank">richard.henderson@lina=
ro.org</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:richard.henderson@linaro.org" target=3D"_=
blank">richard.henderson@linaro.org</a>&gt;&gt;<br>
&gt; <br>
&gt; Please note that I tried again after applying patch <br>
&gt; <a href=3D"https://patchwork.ozlabs.org/patch/1265368/" rel=3D"norefer=
rer" target=3D"_blank">https://patchwork.ozlabs.org/patch/1265368/</a> Howe=
ver, this has not solved <br>
&gt; my issue.<br>
&gt; <br>
&gt; Best,<br>
&gt; Howard<br>
&gt; <br>
&gt; <br>
<br>
</blockquote></div></div>

--0000000000006e0bd405a24ca614--

