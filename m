Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83D2C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:03:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82D292080C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+bkPM54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D292080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK0Rb-0005oU-Ns
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 10:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1jK0Qk-0005In-QO
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1jK0Qi-0006Dw-8u
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:02:50 -0400
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136]:46520)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>)
 id 1jK0Qi-0006Cq-34; Thu, 02 Apr 2020 10:02:48 -0400
Received: by mail-il1-x136.google.com with SMTP id i75so3627733ild.13;
 Thu, 02 Apr 2020 07:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nx78UPPqFQxQZOuRPvNxPsoJ24UlrKsksUM4I/Sj+hA=;
 b=U+bkPM543pxtifQTCX4EvCWpgTTBcXlbhcr0j+4sd7Q0fiwybpWjQO+xWEGhjIbgGq
 z+iFrnTBGKRi1YcTAh2jUeAAtSaIu35rNwHuClKoHYK0Eb7EqiSfPA+DAorgmDZW0ILf
 taWyLShCo4jrJsAJw/p748Qdkv9krzhq13zWtASMpt3mkaPXLWgJ0am6Ap2HW9xHyfJf
 MjBZsdHByi2gWEs5RmNJv0+61U00GrunWredkxU3fvCoHAdSP8gejtnmaindVD6PS0UT
 NxdMYhu3wc1pMuCfYCIGxCKNRvPIqOmUHUTA1eCvJY4tToW21nL5qSbK/HkvsNsm/aLL
 bLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nx78UPPqFQxQZOuRPvNxPsoJ24UlrKsksUM4I/Sj+hA=;
 b=hVim1HCV7JGdZcubeEE6r/TRCtUliD352Et5XYlwyFTPEuWL9Xl5QL+9Jv2GLy5aZz
 b0kvObRFhhzCVSyw9GJDdVFAt8YlgduT3th0xq2GrLOKsD9hHaYcIO0vsSJU7bZFRphg
 DHsII6AnuhqIxYv0JKSlI4qetFomoPPqLAhX1ZBsZ+nZCvUJ92GSc38WtV1lDWogsLe3
 NVMODeRmVD2WsPOTv0fEaCTdg7yQLqewhrtxd4qwoJYKal4U/T4t4PpVZHEleKxfFIwZ
 1j6npHSKL+pGfLx7DqhsZBoEhUORxBVMce7a1JrNuLrD+VJ+L6u9VnabbKytRvR8Zrqa
 pDDA==
X-Gm-Message-State: AGi0PuZkcRNPY55bBioPYgfk/gP5npg4rGRpAT/HnccJLstjMMpa+a4S
 MeAf3GLE6XcmOKuQ++Ml2g5t1h43rjzkLYWY+58=
X-Google-Smtp-Source: APiQypIV3D3drg5tKvyfWiQpjpNiKRZhvDmyi0OUmGTQ4sQcyVgbLBQbvBv19NHUBcuxeadmFH5FwAR4+x3B5eY+zuE=
X-Received: by 2002:a92:894b:: with SMTP id n72mr3622976ild.138.1585836167251; 
 Thu, 02 Apr 2020 07:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <CABLmASEaKJKzDdvKGv+iWfp=0vdr9bupM76zvLZZ6sZFAPkuRg@mail.gmail.com>
 <6ad7d2d1-658c-04db-4ce0-77c498efbba4@redhat.com>
 <CABLmASEBUzdzu8wt-2YbcntOAfNbsVm7W=W-Uk85ieu1757pMA@mail.gmail.com>
 <87h7y2dnwy.fsf@linaro.org>
In-Reply-To: <87h7y2dnwy.fsf@linaro.org>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Thu, 2 Apr 2020 16:02:35 +0200
Message-ID: <CABLmASHEhe2gWpXY6zFxdWTJYASst6vCoEabXCRw34aYsO-qwQ@mail.gmail.com>
Subject: Re: qemu-system-ppc 5.0 rc1 crashing on Windows
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000006bd13f05a24f41b1"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::136
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006bd13f05a24f41b1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2020 at 3:20 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:

>
> Howard Spoelstra <hsp.cat7@gmail.com> writes:
>
> > On Thu, Apr 2, 2020 at 12:47 PM Philippe Mathieu-Daud=C3=A9 <
> philmd@redhat.com>
> > wrote:
> >
> >> Cc'ing the persons referenced in the commit you referred,
> >> who happened to be chatting about this issue few hours ago on IRC.
> >>
> >>
> > Thanks, adding --disable-pie to configure solves this issue, but I gues=
s
> > the default detection should work ;-)
>
> Could you try the following patch:
>
>   Subject: [PATCH for-5.0] configure: Add -Werror to PIE probe
>   Date: Wed,  1 Apr 2020 14:47:56 -0700
>   Message-Id: <20200401214756.6559-1-richard.henderson@linaro.org>
>
> which fixed the win mxe cross compile failures.
>
>
Hi,

Thanks for your reply. However, I already did that. Please see the end of
my original message repeated below.
I never experienced compilation errors, just a crash when running.

>> > Please note that I tried again after applying patch
>> > https://patchwork.ozlabs.org/patch/1265368/ However, this has not
>> solved
>> > my issue.
>> >

Best,
Howard


> >
> > Best,
> > Howard
> >
> >
> >
> >> On 4/2/20 11:28 AM, Howard Spoelstra wrote:
> >> > Hi,
> >> >
> >> > I just compiled qemu-system-ppc for Windows, using native msys2 on
> >> > Windows 10 64 bit and the 64 bit mingw cross compiler on Fedora 31.
> Both
> >> > create executables that crash:
> >> >
> >> > qemu-system-ppc.exe -L pc-bios -boot c -m 512 -M mac99,via=3Dpmu -h
> >> > da C:\Mac-disks\9.2.img
> >> > Exception code=3D0xc0000005 flags=3D0x0 at 0x00007FFB2A602078. Acces=
s
> >> > violation - attempting to write data at address 0x00000000034C76EC
> >> >
> >> > I bisected this down to:
> >> >
> >> > d2cd29e30736afd4a1e8cac3cf4da360bbc65978 is the first bad commit
> >> > commit d2cd29e30736afd4a1e8cac3cf4da360bbc65978
> >> > Author: Richard Henderson <richard.henderson@linaro.org
> >> > <mailto:richard.henderson@linaro.org>>
> >> > Date:   Tue Dec 17 13:47:37 2019 -1000
> >> >
> >> >      configure: Do not force pie=3Dno for non-x86
> >> >
> >> >      PIE is supported on many other hosts besides x86.
> >> >
> >> >      The default for non-x86 is now the same as x86: pie is used
> >> >      if supported, and may be forced via --enable/--disable-pie.
> >> >
> >> >      The original commit (40d6444e91c) said:
> >> >
> >> >        "Non-x86 are not changed, as they require TCG changes"
> >> >
> >> >      but I think that's wrong -- there's nothing about PIE that
> >> >      affects TCG one way or another.
> >> >
> >> >      Tested on aarch64 (bionic) and ppc64le (centos 7) hosts.
> >> >
> >> >      Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org
> >> > <mailto:alex.bennee@linaro.org>>
> >> >      Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org
> >> > <mailto:alex.bennee@linaro.org>>
> >> >      Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
> >> > <mailto:philmd@redhat.com>>
> >> >      Signed-off-by: Richard Henderson <richard.henderson@linaro.org
> >> > <mailto:richard.henderson@linaro.org>>
> >> >
> >> > Please note that I tried again after applying patch
> >> > https://patchwork.ozlabs.org/patch/1265368/ However, this has not
> >> solved
> >> > my issue.
> >> >
> >> > Best,
> >> > Howard
> >> >
> >> >
> >>
> >>
>
>
> --
> Alex Benn=C3=A9e
>

--0000000000006bd13f05a24f41b1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 2, 2020 at 3:20 PM Alex B=
enn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro=
.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex"><br>
Howard Spoelstra &lt;<a href=3D"mailto:hsp.cat7@gmail.com" target=3D"_blank=
">hsp.cat7@gmail.com</a>&gt; writes:<br>
<br>
&gt; On Thu, Apr 2, 2020 at 12:47 PM Philippe Mathieu-Daud=C3=A9 &lt;<a hre=
f=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<=
br>
&gt; wrote:<br>
&gt;<br>
&gt;&gt; Cc&#39;ing the persons referenced in the commit you referred,<br>
&gt;&gt; who happened to be chatting about this issue few hours ago on IRC.=
<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; Thanks, adding --disable-pie to configure solves this issue, but I gue=
ss<br>
&gt; the default detection should work ;-)<br>
<br>
Could you try the following patch:<br>
<br>
=C2=A0 Subject: [PATCH for-5.0] configure: Add -Werror to PIE probe<br>
=C2=A0 Date: Wed,=C2=A0 1 Apr 2020 14:47:56 -0700<br>
=C2=A0 Message-Id: &lt;<a href=3D"mailto:20200401214756.6559-1-richard.hend=
erson@linaro.org" target=3D"_blank">20200401214756.6559-1-richard.henderson=
@linaro.org</a>&gt;<br>
<br>
which fixed the win mxe cross compile failures.<br>
<br></blockquote><div><br></div><div>Hi, <br></div><div><br></div><div>Than=
ks for your reply. However, I already did that. Please see the end of my or=
iginal message repeated below.<br></div><div>I never experienced compilatio=
n errors, just a crash when running.<br></div><div><br></div><div>
&gt;&gt; &gt; Please note that I tried again after applying patch<br>
&gt;&gt; &gt; <a href=3D"https://patchwork.ozlabs.org/patch/1265368/" rel=
=3D"noreferrer" target=3D"_blank">https://patchwork.ozlabs.org/patch/126536=
8/</a> However, this has not<br>
&gt;&gt; solved<br>
&gt;&gt; &gt; my issue.<br>
&gt;&gt; &gt;

</div><div><br></div><div>Best,</div><div>Howard<br></div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;<br>
&gt; Best,<br>
&gt; Howard<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;&gt; On 4/2/20 11:28 AM, Howard Spoelstra wrote:<br>
&gt;&gt; &gt; Hi,<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I just compiled qemu-system-ppc for Windows, using native msy=
s2 on<br>
&gt;&gt; &gt; Windows 10 64 bit and the 64 bit mingw cross compiler on Fedo=
ra 31. Both<br>
&gt;&gt; &gt; create executables that crash:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; qemu-system-ppc.exe -L pc-bios -boot c -m 512 -M mac99,via=3D=
pmu -h<br>
&gt;&gt; &gt; da C:\Mac-disks\9.2.img<br>
&gt;&gt; &gt; Exception code=3D0xc0000005 flags=3D0x0 at 0x00007FFB2A602078=
. Access<br>
&gt;&gt; &gt; violation - attempting to write data at address 0x00000000034=
C76EC<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I bisected this down to:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; d2cd29e30736afd4a1e8cac3cf4da360bbc65978 is the first bad com=
mit<br>
&gt;&gt; &gt; commit d2cd29e30736afd4a1e8cac3cf4da360bbc65978<br>
&gt;&gt; &gt; Author: Richard Henderson &lt;<a href=3D"mailto:richard.hende=
rson@linaro.org" target=3D"_blank">richard.henderson@linaro.org</a><br>
&gt;&gt; &gt; &lt;mailto:<a href=3D"mailto:richard.henderson@linaro.org" ta=
rget=3D"_blank">richard.henderson@linaro.org</a>&gt;&gt;<br>
&gt;&gt; &gt; Date:=C2=A0 =C2=A0Tue Dec 17 13:47:37 2019 -1000<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 configure: Do not force pie=3Dno for non-=
x86<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 PIE is supported on many other hosts besi=
des x86.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 The default for non-x86 is now the same a=
s x86: pie is used<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if supported, and may be forced via --ena=
ble/--disable-pie.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 The original commit (40d6444e91c) said:<b=
r>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Non-x86 are not changed, as =
they require TCG changes&quot;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 but I think that&#39;s wrong -- there&#39=
;s nothing about PIE that<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 affects TCG one way or another.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 Tested on aarch64 (bionic) and ppc64le (c=
entos 7) hosts.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 Tested-by: Alex Benn=C3=A9e &lt;<a href=
=3D"mailto:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org=
</a><br>
&gt;&gt; &gt; &lt;mailto:<a href=3D"mailto:alex.bennee@linaro.org" target=
=3D"_blank">alex.bennee@linaro.org</a>&gt;&gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 Reviewed-by: Alex Benn=C3=A9e &lt;<a href=
=3D"mailto:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org=
</a><br>
&gt;&gt; &gt; &lt;mailto:<a href=3D"mailto:alex.bennee@linaro.org" target=
=3D"_blank">alex.bennee@linaro.org</a>&gt;&gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 Reviewed-by: Philippe Mathieu-Daud=C3=A9 =
&lt;<a href=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redhat.co=
m</a><br>
&gt;&gt; &gt; &lt;mailto:<a href=3D"mailto:philmd@redhat.com" target=3D"_bl=
ank">philmd@redhat.com</a>&gt;&gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 Signed-off-by: Richard Henderson &lt;<a h=
ref=3D"mailto:richard.henderson@linaro.org" target=3D"_blank">richard.hende=
rson@linaro.org</a><br>
&gt;&gt; &gt; &lt;mailto:<a href=3D"mailto:richard.henderson@linaro.org" ta=
rget=3D"_blank">richard.henderson@linaro.org</a>&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Please note that I tried again after applying patch<br>
&gt;&gt; &gt; <a href=3D"https://patchwork.ozlabs.org/patch/1265368/" rel=
=3D"noreferrer" target=3D"_blank">https://patchwork.ozlabs.org/patch/126536=
8/</a> However, this has not<br>
&gt;&gt; solved<br>
&gt;&gt; &gt; my issue.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Best,<br>
&gt;&gt; &gt; Howard<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
</blockquote></div></div>

--0000000000006bd13f05a24f41b1--

