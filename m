Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53EFC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 17:16:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AABC020757
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 17:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qh6j/Lkl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AABC020757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK3Ro-0007Cj-SO
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 13:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1jK3R6-0006al-Tn
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:15:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1jK3R5-0004LL-7Y
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:15:24 -0400
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e]:34273)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>)
 id 1jK3R5-0004Kr-1v; Thu, 02 Apr 2020 13:15:23 -0400
Received: by mail-io1-xd2e.google.com with SMTP id h131so4462089iof.1;
 Thu, 02 Apr 2020 10:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vIPcFUdM/d4Zh/tkui82ZgxlVT7Tab6yeG3s7D5C7Rw=;
 b=qh6j/Lkl3IEw1Mz1sMGFaxKx6GsxgsMhPTdMLD0F7sJVN1TOYkvfuww1box+OdMl6l
 +liXRoskvTiiE277q9mcEK8e8UkKG24OO/LFyYrpUBVWzGLEUYI6Xz/dclvyek95b93Q
 7ZAy9xC+3iNVw1yk1CGPiTWmMjRAAJ5iEAJw/HYE1oM6A0izEj6EJdmnLyoAclomm4SB
 4im5vb7sRMdOj2LPWPUtio2icDf3QEkJ+IBi3Sr/rFkBm3XYc2F0a7mdqcSy8rxGCzhs
 4FTxYgm+KqQnVW3Bk6NBuT7o4iDXBuSBeDKLeoCRcpLTVuklvBHUZloEXGJID3tiTu2W
 f/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vIPcFUdM/d4Zh/tkui82ZgxlVT7Tab6yeG3s7D5C7Rw=;
 b=Z7LoYlaVkqlltMfwJsTzFP2tZLVk91giak3LoET9tFhRKfv1CmmLCTd0kdE3rR5iy7
 /2k+jijjSD1MheKA/zzefN2OYCKlvfumYPJjiAe64R3OTSDaz4fAZZ/WXgAqnAr0/LhT
 ZdLLzcZoC9J8Z7ShhBmSmSnZtWSQclAMWFOpinyt3jbhjPmr7A+TpxkzFUEOFj0yUzpk
 ZLsQvrIawFIo//M6GchOak7RgJVUVNG9ZyrnmVqp9R5aAkbezjibBhRL8OlJqelZWZEd
 OzSd2LgfMGdb3DX9kBOz2EM5wyO0ys/zb+sY7IpGvPsVYs7WzQeOIW5vsvqtcIhc2sem
 dyLQ==
X-Gm-Message-State: AGi0PuYvzKjdhfgIykVm8neQN8tYoQlkYWeKdUgcf5+oNV86g7wLaqfi
 bCZX3yyce9sFizhl+HuGdBvTD8b3Aw/ejI/JbVk=
X-Google-Smtp-Source: APiQypJ+A1cMB+7LHt1U18VES1lmV1K7bOrXQautAZmovB6FAOhinsBn7HpEDU6RjnnKVFtfsTgiYK1FozgkPXpwOl4=
X-Received: by 2002:a02:b690:: with SMTP id i16mr4419754jam.69.1585847722085; 
 Thu, 02 Apr 2020 10:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <CABLmASEaKJKzDdvKGv+iWfp=0vdr9bupM76zvLZZ6sZFAPkuRg@mail.gmail.com>
 <6ad7d2d1-658c-04db-4ce0-77c498efbba4@redhat.com>
 <CABLmASEBUzdzu8wt-2YbcntOAfNbsVm7W=W-Uk85ieu1757pMA@mail.gmail.com>
 <87h7y2dnwy.fsf@linaro.org>
 <CABLmASHEhe2gWpXY6zFxdWTJYASst6vCoEabXCRw34aYsO-qwQ@mail.gmail.com>
 <87eet6djev.fsf@linaro.org>
In-Reply-To: <87eet6djev.fsf@linaro.org>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Thu, 2 Apr 2020 19:15:10 +0200
Message-ID: <CABLmASFAXvLQbPrVMs9q=BB2Zjj9Z3cqXC+WH6puQrztQ+Swcg@mail.gmail.com>
Subject: Re: qemu-system-ppc 5.0 rc1 crashing on Windows
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000024968b05a251f200"
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000024968b05a251f200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2020 at 4:58 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:

>
> Howard Spoelstra <hsp.cat7@gmail.com> writes:
>
> > On Thu, Apr 2, 2020 at 3:20 PM Alex Benn=C3=A9e <alex.bennee@linaro.org=
>
> wrote:
> >
> >>
> >> Howard Spoelstra <hsp.cat7@gmail.com> writes:
> >>
> >> > On Thu, Apr 2, 2020 at 12:47 PM Philippe Mathieu-Daud=C3=A9 <
> >> philmd@redhat.com>
> >> > wrote:
> >> >
> >> >> Cc'ing the persons referenced in the commit you referred,
> >> >> who happened to be chatting about this issue few hours ago on IRC.
> >> >>
> >> >>
> >> > Thanks, adding --disable-pie to configure solves this issue, but I
> guess
> >> > the default detection should work ;-)
> >>
> >> Could you try the following patch:
> >>
> >>   Subject: [PATCH for-5.0] configure: Add -Werror to PIE probe
> >>   Date: Wed,  1 Apr 2020 14:47:56 -0700
> >>   Message-Id: <20200401214756.6559-1-richard.henderson@linaro.org>
> >>
> >> which fixed the win mxe cross compile failures.
> >>
> >>
> > Hi,
> >
> > Thanks for your reply. However, I already did that. Please see the end =
of
> > my original message repeated below.
> > I never experienced compilation errors, just a crash when running.
> >
> >>> > Please note that I tried again after applying patch
> >>> > https://patchwork.ozlabs.org/patch/1265368/ However, this has not
> >>> solved
> >>> > my issue.
>
> Ahh sorry missed that. Is there anyway you get can a back trace?
>
> --
> Alex Benn=C3=A9e
>

Hi,

I might need a bit of help here.
I compiled qemu with:
./configure --cross-prefix=3Dx86_64-w64-mingw32- --target-list=3Dppc-softmm=
u
--enable-gtk --enable-sdl --enable-debug

Then run gdb for Windows:

C:\qemu-debugging>gdb --args c:\qemu-master-msys2\qemu-system-ppc.exe -L
c:\qemu-master-msys2\pc-bios -boot c -m 256 -M mac99,via=3Dpmu -hda
c:\Mac-disks\9.2.img
GNU gdb (GDB) 7.7.50.20140303-cvs
Copyright (C) 2014 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.htm=
l
>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-w64-mingw32".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
<http://www.gnu.org/software/gdb/documentation/>.
For help, type "help".
Type "apropos word" to search for commands related to "word".

This binary was built by Equation Solution <http://www.Equation.com>...
Reading symbols from c:\qemu-master-msys2\qemu-system-ppc.exe...done.
(gdb) run
Starting program: c:\qemu-master-msys2\qemu-system-ppc.exe -L
c:\qemu-master-msys2\pc-bios -boot c -m 256 -M "mac99,via=3Dpmu" -hda
c:\Mac-disks\9.2.img
[New Thread 3076.0x1384]
[New Thread 3076.0x9a0]
[New Thread 3076.0x3074]
[New Thread 3076.0x3014]
[Thread 3076.0x9a0 exited with code 0]
[Thread 3076.0x3014 exited with code 0]
[Thread 3076.0x3074 exited with code 0]
[Inferior 1 (process 3076) exited with code 035610000]
(gdb) thread apply all bt full

I get no output.

(gdb) bt
No stack.

Best,
Howard

--00000000000024968b05a251f200
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 2, 2020 at 4:58 PM Alex B=
enn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro=
.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex"><br>
Howard Spoelstra &lt;<a href=3D"mailto:hsp.cat7@gmail.com" target=3D"_blank=
">hsp.cat7@gmail.com</a>&gt; writes:<br>
<br>
&gt; On Thu, Apr 2, 2020 at 3:20 PM Alex Benn=C3=A9e &lt;<a href=3D"mailto:=
alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt; wr=
ote:<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; Howard Spoelstra &lt;<a href=3D"mailto:hsp.cat7@gmail.com" target=
=3D"_blank">hsp.cat7@gmail.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; On Thu, Apr 2, 2020 at 12:47 PM Philippe Mathieu-Daud=C3=A9 &=
lt;<br>
&gt;&gt; <a href=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redh=
at.com</a>&gt;<br>
&gt;&gt; &gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; Cc&#39;ing the persons referenced in the commit you refer=
red,<br>
&gt;&gt; &gt;&gt; who happened to be chatting about this issue few hours ag=
o on IRC.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt; Thanks, adding --disable-pie to configure solves this issue, =
but I guess<br>
&gt;&gt; &gt; the default detection should work ;-)<br>
&gt;&gt;<br>
&gt;&gt; Could you try the following patch:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0Subject: [PATCH for-5.0] configure: Add -Werror to PIE=
 probe<br>
&gt;&gt;=C2=A0 =C2=A0Date: Wed,=C2=A0 1 Apr 2020 14:47:56 -0700<br>
&gt;&gt;=C2=A0 =C2=A0Message-Id: &lt;<a href=3D"mailto:20200401214756.6559-=
1-richard.henderson@linaro.org" target=3D"_blank">20200401214756.6559-1-ric=
hard.henderson@linaro.org</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; which fixed the win mxe cross compile failures.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; Thanks for your reply. However, I already did that. Please see the end=
 of<br>
&gt; my original message repeated below.<br>
&gt; I never experienced compilation errors, just a crash when running.<br>
&gt;<br>
&gt;&gt;&gt; &gt; Please note that I tried again after applying patch<br>
&gt;&gt;&gt; &gt; <a href=3D"https://patchwork.ozlabs.org/patch/1265368/" r=
el=3D"noreferrer" target=3D"_blank">https://patchwork.ozlabs.org/patch/1265=
368/</a> However, this has not<br>
&gt;&gt;&gt; solved<br>
&gt;&gt;&gt; &gt; my issue.<br>
<br>
Ahh sorry missed that. Is there anyway you get can a back trace?<br>
<br>
-- <br>
Alex Benn=C3=A9e<br></blockquote><div><br></div><div>Hi,</div><div><br></di=
v><div>I might need a bit of help here.</div><div>I compiled qemu with:</di=
v><div> ./configure --cross-prefix=3Dx86_64-w64-mingw32- --target-list=3Dpp=
c-softmmu --enable-gtk --enable-sdl --enable-debug</div><div><br></div><div=
>Then run gdb for Windows: <br></div><div><br></div><div>C:\qemu-debugging&=
gt;gdb --args c:\qemu-master-msys2\qemu-system-ppc.exe -L c:\qemu-master-ms=
ys2\pc-bios -boot c -m 256 -M mac99,via=3Dpmu -hda c:\Mac-disks\9.2.img<br>=
GNU gdb (GDB) 7.7.50.20140303-cvs<br>Copyright (C) 2014 Free Software Found=
ation, Inc.<br>License GPLv3+: GNU GPL version 3 or later &lt;<a href=3D"ht=
tp://gnu.org/licenses/gpl.html">http://gnu.org/licenses/gpl.html</a>&gt;<br=
>This is free software: you are free to change and redistribute it.<br>Ther=
e is NO WARRANTY, to the extent permitted by law.=C2=A0 Type &quot;show cop=
ying&quot;<br>and &quot;show warranty&quot; for details.<br>This GDB was co=
nfigured as &quot;x86_64-w64-mingw32&quot;.<br>Type &quot;show configuratio=
n&quot; for configuration details.<br>For bug reporting instructions, pleas=
e see:<br>&lt;<a href=3D"http://www.gnu.org/software/gdb/bugs/">http://www.=
gnu.org/software/gdb/bugs/</a>&gt;.<br>Find the GDB manual and other docume=
ntation resources online at:<br>&lt;<a href=3D"http://www.gnu.org/software/=
gdb/documentation/">http://www.gnu.org/software/gdb/documentation/</a>&gt;.=
<br>For help, type &quot;help&quot;.<br>Type &quot;apropos word&quot; to se=
arch for commands related to &quot;word&quot;.<br><br>This binary was built=
 by Equation Solution &lt;<a href=3D"http://www.Equation.com">http://www.Eq=
uation.com</a>&gt;...<br>Reading symbols from c:\qemu-master-msys2\qemu-sys=
tem-ppc.exe...done.<br>(gdb) run<br>Starting program: c:\qemu-master-msys2\=
qemu-system-ppc.exe -L c:\qemu-master-msys2\pc-bios -boot c -m 256 -M &quot=
;mac99,via=3Dpmu&quot; -hda c:\Mac-disks\9.2.img<br>[New Thread 3076.0x1384=
]<br>[New Thread 3076.0x9a0]<br>[New Thread 3076.0x3074]<br>[New Thread 307=
6.0x3014]<br>[Thread 3076.0x9a0 exited with code 0]<br>[Thread 3076.0x3014 =
exited with code 0]<br>[Thread 3076.0x3074 exited with code 0]<br>[Inferior=
 1 (process 3076) exited with code 035610000]<br>(gdb) thread apply all bt =
full<br></div><div><br></div><div>I get no output.<br></div><div><br></div>=
<div>(gdb) bt<br>No stack.</div><br><div>Best,<br></div><div>Howard<br></di=
v><div>=C2=A0</div></div></div>

--00000000000024968b05a251f200--

