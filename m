Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA34AC34037
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 11:52:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A78672173E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 11:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYEUoeoC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78672173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j41QC-00082A-U2
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 06:52:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j41Pb-0007cK-0s
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 06:51:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j41PZ-0008Hz-SP
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 06:51:34 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33707)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j41PZ-0008HG-Mt; Tue, 18 Feb 2020 06:51:33 -0500
Received: by mail-ot1-x341.google.com with SMTP id w6so10026365otk.0;
 Tue, 18 Feb 2020 03:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=faH1l7e6F46GSGj8UTvXe7PWy5Jigp4+RG1ZOaad7Ic=;
 b=IYEUoeoC9EcOrEPji711CFi0jfWVw99MI/Tw5UJGmwOfOnFrPjmoqWmFwpmSsWB3nA
 ofIQcYVqXTWWCI/4NZckCB+31YsbQKgcNHp6/fSVa0EZY365pDUThSKXMN/tKWrMvpP3
 gVGO+RvZ/weXQdaZpDsSGDO7SIS3pW7kLurFzzPsfVTIRQwgyj9Tm6befbk9mPgod1gk
 RkmceaHEgPuTcPQt28/O1A9Rwrl8KprpivJzv0dNSTlCRIj8HQeswUq5QwOSQeZrKDzO
 4GjTN4+TwbqfObwWpuXgAThkaCe8U00KS5J2Z8HOX5I8sFihK5uOJcyxDiaj+WwZQuYd
 piEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=faH1l7e6F46GSGj8UTvXe7PWy5Jigp4+RG1ZOaad7Ic=;
 b=O8b0YNidSPb3g+X/SrUF1q4rY7c8hflTwG04QwgGrwD27wbbMfT/8sto1kTz2Iy6U3
 mF8NWqDE4vD/7BZngqxe6dFI4b7eo2h95dWbVI+ZqBZqet+bn+fG8Wq6Dgi7URU5BJOv
 MWBlbFE3FuHTsZSQxpg1X5NwPc1NZDe96p9rst0q1EpYd1Wf8ttbNZRk7UwwPTWYMI0Y
 +pJgm6JQkfbs1GIQ3VsFHhakfLXwzX3aJ8EWNeHKgoqdLje1Kv6gwj5tqVUjK5wl5oos
 mXiGWL6yMSYsLj+/KRmqm6kw/KwwChWW6RqoOoZ6omyLH/bwuswSVO8ag1ex0qGASoRb
 Gh/w==
X-Gm-Message-State: APjAAAUOHSDsrFlGj9c5EiVDbZBgXo5HR5n4ZrUo8eKKWQzjVWvHN4nf
 xP3aqARBoJrtirTELKA77Q04PHK+zunV26UDFZk=
X-Google-Smtp-Source: APXvYqz+qT9Hln9fxCUaYD+yz8Ica51RXpySGAwkAeRJge/vdg1s6iZc07c/uGB8ZmEoHb0KxQ7KBZNnrWF3mBUpzuI=
X-Received: by 2002:a05:6830:1042:: with SMTP id
 b2mr15265226otp.306.1582026692806; 
 Tue, 18 Feb 2020 03:51:32 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Tue, 18 Feb 2020 03:51:32 -0800 (PST)
In-Reply-To: <d2d57fb3-7b9f-71e7-57be-ae6b37cd47a1@vivier.eu>
References: <20200217223558.863199-1-laurent@vivier.eu>
 <80c66cb5-3f04-5066-8be4-a53ece4f500f@redhat.com>
 <d2d57fb3-7b9f-71e7-57be-ae6b37cd47a1@vivier.eu>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 18 Feb 2020 12:51:32 +0100
Message-ID: <CAL1e-=hwcTXcAOapivTYD8HFONRnhdHnSGWPwT6530SkCuYCbg@mail.gmail.com>
Subject: Re: [PATCH 00/22] linux-user: generate syscall_nr.sh
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/alternative; boundary="0000000000000ccc2e059ed84b8f"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000ccc2e059ed84b8f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, February 18, 2020, Laurent Vivier <laurent@vivier.eu> wrote:

> Le 18/02/2020 =C3=A0 07:13, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit :
> > On 2/17/20 11:35 PM, Laurent Vivier wrote:
> >> This series copies the files syscall.tbl from linux v5.5 and generates
> >> the file syscall_nr.h from them.
> >>
> > [...]
> >> Laurent Vivier (22):
> >>    linux-user: introduce parameters to generate syscall_nr.h
> >>    linux-user,alpha: add syscall table generation support
> >>    linux-user,hppa: add syscall table generation support
> >>    linux-user,m68k: add syscall table generation support
> >>    linux-user,xtensa: add syscall table generation support
> >>    linux-user,sh4: add syscall table generation support
> >>    linux-user,microblaze: add syscall table generation support
> >>    linux-user,arm: add syscall table generation support
> >>    linux-user,ppc: split syscall_nr.h
> >>    linux-user,ppc: add syscall table generation support
> >>    linux-user,s390x: remove syscall definitions for !TARGET_S390X
> >>    linux-user,s390x: add syscall table generation support
> >>    linux-user,sparc,sparc64: add syscall table generation support
> >>    linux-user,i386: add syscall table generation support
> >>    linux-user,x86_64: add syscall table generation support
> >>    linux-user,mips: add syscall table generation support
> >>    linux-user,mips64: split syscall_nr.h
> >>    linux-user,mips64: add syscall table generation support
> >>    linux-user,scripts: add a script to update syscall.tbl
> >>    linux-user: update syscall.tbl from linux 0bf999f9c5e7
> >>    linux-user,mips: move content of mips_syscall_args
> >>    linux-user,mips: update syscall-args-o32.c.inc
> >
> > I suppose the patch subject was generated and you meant to use
> > "linux-user/" instead of "linux-user,". Is that right?
> >
>
> No, the idea is they touch "linux-user" subsystem and "ARCH" subsystem,
> not especially the "linux-user/ARCH" directory
>
>
I think Laurent's marks are appropriate, in fact, very useful for these
areas of code. Elsewhere,,for example, one could use "softfoat,mips" for
changes in softfloat affecting mips only.

Regards,
Aleksandar



> Thanks,
> Laurent
>
>

--0000000000000ccc2e059ed84b8f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, February 18, 2020, Laurent Vivier &lt;<a href=3D"mailto=
:laurent@vivier.eu">laurent@vivier.eu</a>&gt; wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Le 18/02/2020 =C3=A0 07:13, Philippe Mathieu-Daud=C3=A9 a =C3=
=A9crit=C2=A0:<br>
&gt; On 2/17/20 11:35 PM, Laurent Vivier wrote:<br>
&gt;&gt; This series copies the files syscall.tbl from linux v5.5 and gener=
ates<br>
&gt;&gt; the file syscall_nr.h from them.<br>
&gt;&gt;<br>
&gt; [...]<br>
&gt;&gt; Laurent Vivier (22):<br>
&gt;&gt; =C2=A0=C2=A0 linux-user: introduce parameters to generate syscall_=
nr.h<br>
&gt;&gt; =C2=A0=C2=A0 linux-user,alpha: add syscall table generation suppor=
t<br>
&gt;&gt; =C2=A0=C2=A0 linux-user,hppa: add syscall table generation support=
<br>
&gt;&gt; =C2=A0=C2=A0 linux-user,m68k: add syscall table generation support=
<br>
&gt;&gt; =C2=A0=C2=A0 linux-user,xtensa: add syscall table generation suppo=
rt<br>
&gt;&gt; =C2=A0=C2=A0 linux-user,sh4: add syscall table generation support<=
br>
&gt;&gt; =C2=A0=C2=A0 linux-user,microblaze: add syscall table generation s=
upport<br>
&gt;&gt; =C2=A0=C2=A0 linux-user,arm: add syscall table generation support<=
br>
&gt;&gt; =C2=A0=C2=A0 linux-user,ppc: split syscall_nr.h<br>
&gt;&gt; =C2=A0=C2=A0 linux-user,ppc: add syscall table generation support<=
br>
&gt;&gt; =C2=A0=C2=A0 linux-user,s390x: remove syscall definitions for !TAR=
GET_S390X<br>
&gt;&gt; =C2=A0=C2=A0 linux-user,s390x: add syscall table generation suppor=
t<br>
&gt;&gt; =C2=A0=C2=A0 linux-user,sparc,sparc64: add syscall table generatio=
n support<br>
&gt;&gt; =C2=A0=C2=A0 linux-user,i386: add syscall table generation support=
<br>
&gt;&gt; =C2=A0=C2=A0 linux-user,x86_64: add syscall table generation suppo=
rt<br>
&gt;&gt; =C2=A0=C2=A0 linux-user,mips: add syscall table generation support=
<br>
&gt;&gt; =C2=A0=C2=A0 linux-user,mips64: split syscall_nr.h<br>
&gt;&gt; =C2=A0=C2=A0 linux-user,mips64: add syscall table generation suppo=
rt<br>
&gt;&gt; =C2=A0=C2=A0 linux-user,scripts: add a script to update syscall.tb=
l<br>
&gt;&gt; =C2=A0=C2=A0 linux-user: update syscall.tbl from linux 0bf999f9c5e=
7<br>
&gt;&gt; =C2=A0=C2=A0 linux-user,mips: move content of mips_syscall_args<br=
>
&gt;&gt; =C2=A0=C2=A0 linux-user,mips: update syscall-args-o32.c.inc<br>
&gt; <br>
&gt; I suppose the patch subject was generated and you meant to use<br>
&gt; &quot;linux-user/&quot; instead of &quot;linux-user,&quot;. Is that ri=
ght?<br>
&gt; <br>
<br>
No, the idea is they touch &quot;linux-user&quot; subsystem and &quot;ARCH&=
quot; subsystem,<br>
not especially the &quot;linux-user/ARCH&quot; directory<br>
<br></blockquote><div><br></div><div>I think Laurent&#39;s marks are approp=
riate, in fact, very useful for these areas of code. Elsewhere,,for example=
, one could use &quot;softfoat,mips&quot; for changes in softfloat affectin=
g mips only.</div><div><br></div><div>Regards,</div><div>Aleksandar</div><d=
iv><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Thanks,<br>
Laurent<br>
<br>
</blockquote>

--0000000000000ccc2e059ed84b8f--

