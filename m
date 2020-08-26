Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AA9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:47:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AEE220738
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxV7SfQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AEE220738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAxdh-0004Au-A9
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 11:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAxcA-0003KM-Ao
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:45:30 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b]:33997)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAxc8-0000cV-L6
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:45:30 -0400
Received: by mail-lj1-x22b.google.com with SMTP id y2so2929283ljc.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 08:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=Z3ItVnUN0o3zPQC0gEzQxIUcgK28YU1PFrCOdWWkMEw=;
 b=mxV7SfQDejvWqa4FFkFdTJ8bcVdvZFf9Ui4q0ZWs43UoXq7/Xq8G+ao4MK7uvzn+W1
 YSR2FfTrTNMdsjyllND5f0T5hiX71sg/S9ASOC5NX3b/W5VGMcgAC14XF0Jvkduqmbpa
 eu1YLy0A9VyMgWZ6KD+6BHo5KQykvBThj5rf20Ez7wUuYW58DVgKPKq9fisqX8ZD9tto
 OSo5qrX/4lyr480coIpr1fd+UwiyGxCmlTHOuXEEZYMaHpgMZexyHaWZgzkpNn2Rg7eh
 kUFCTiV/UCblzOJBVwLMpkTPCzbXzdKF/M5ym2Nm+jhWgwEWcbekff/wvuBt1D7pU6Z2
 cEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=Z3ItVnUN0o3zPQC0gEzQxIUcgK28YU1PFrCOdWWkMEw=;
 b=GIdnbOIXBoWTUyqs4LhGHksTilbY3zeN2Uzzp96Eqx2MrD0nKEo6aKDI0QexY53ah8
 CQ1Rh3+etwQFZYJdNGczBJ2C1TtKtg28I6axofk/6NCJL3SN1lUyiNrOpgUj/R2L8xMU
 QFGZe38LmuSX36JnjU3v5OUP6tQX7e7POZtSTd3IPwMfwiUo484b7UvMqh6kNJ+fX7Ve
 6SCPyd45KNYQzBg0kmOMv59QWsA2ixQgurn1jAB0gH5ayFlgiuWNk4zfaLvOL4ut4zDn
 tIm9A9oN0/I3Yq5ADb/O0CLKiTMiQ5oprGZsyjbn7bxldi2D2gKPE/ZGL8f5vT2BwOeO
 g9kw==
X-Gm-Message-State: AOAM533zKrZym+W3sU1+E2OWyunFdbqHBsuMBHl2xnSpKKTLN0E1Z77g
 oLyKLYW7nkgc6WQayeOnPnmK84jM9d+Y2aWFEbI=
X-Google-Smtp-Source: ABdhPJymKx5pJJEa+yt4b7yHVa9kQY+ECRUq5ewO1FsAWEgQsxol9f6Fib0mAJGVKRM2Q/34uq5cv+pWgEvvggmWg10=
X-Received: by 2002:a2e:8642:: with SMTP id i2mr8030403ljj.368.1598456726729; 
 Wed, 26 Aug 2020 08:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200826151006.80-1-luoyonggang@gmail.com>
 <CABgObfYdjLouNp8ZvqHmB-xsOJdUgxv3zJL4A1GKuWggh7fnbA@mail.gmail.com>
 <CAE2XoE-JKpqQj7H3wMt0+WNTBR1JS6ZyiLOhqOYkaVj5Zzgp5A@mail.gmail.com>
 <CABgObfYk8zG3TBB3UZhvmZLGqLO+bZF+AmL6hSQkCgiCKKW4ug@mail.gmail.com>
 <CAE2XoE-U6Ls9gMSSDB4Qajn-m0vrBBP-+C0K4tncvzzr3Nwq9w@mail.gmail.com>
 <CABgObfaByaW9jqRZkV3BGONmqFaYwnQDREemYit8s+qYTAeP4g@mail.gmail.com>
In-Reply-To: <CABgObfaByaW9jqRZkV3BGONmqFaYwnQDREemYit8s+qYTAeP4g@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 26 Aug 2020 23:45:10 +0800
Message-ID: <CAE2XoE9s=0J4KBHwtCJtS8rGD4nt9rUesOvPr2YPe3gfjXrEXA@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] meson: Fixes the ninjatool issue that E$$: are
 generated in Makefile.ninja
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000062b79705adc9b5d7"
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x22b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000062b79705adc9b5d7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2020 at 11:41 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On Wed, Aug 26, 2020 at 5:39 PM =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo)=
 <luoyonggang@gmail.com>
> wrote:
> >> Ok, that's useful. But can you just send the whole file (it's huge but
> >> you can gzip it or something similar)?
> >>
> >> Paolo
> >
> > I am OK with that, but where should I post
>
> Just pbonzini@redhat.com.
>
> Regarding the version.rc_version.o target in build.ninja, I see it
> translated to
>
> version.rc_version.o: private .var.command :=3D
> "C:/CI-Tools/msys64/mingw64/bin/x86_64-w64-mingw32-windres.EXE"
> "-I./." "-I../qemu.org/." "../qemu.org/version.rc"
> "version.rc_version.o" "--preprocessor-arg=3D-MD"
> "--preprocessor-arg=3D-MQversion.rc_version.o"
> "--preprocessor-arg=3D-MFversion.rc_version.o.d"
> version.rc_version.o: private .var.description :=3D Generating Windows
> resource for file 'version.rc' with a custom command
> version.rc_version.o: private .var.out :=3D version.rc_version.o
>


> Is this wrong?
>
This is fine

>

>
> Paolo
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000062b79705adc9b5d7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 26, 2020 at 11:41 PM Paol=
o Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
Wed, Aug 26, 2020 at 5:39 PM =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) &lt;=
<a href=3D"mailto:luoyonggang@gmail.com" target=3D"_blank">luoyonggang@gmai=
l.com</a>&gt; wrote:<br>
&gt;&gt; Ok, that&#39;s useful. But can you just send the whole file (it&#3=
9;s huge but<br>
&gt;&gt; you can gzip it or something similar)?<br>
&gt;&gt;<br>
&gt;&gt; Paolo<br>
&gt;<br>
&gt; I am OK with that, but where should I post<br>
<br>
Just <a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank">pbonzini@redh=
at.com</a>.<br>
<br>
Regarding the version.rc_version.o target in build.ninja, I see it translat=
ed to<br>
<br>
version.rc_version.o: private .var.command :=3D<br>
&quot;C:/CI-Tools/msys64/mingw64/bin/x86_64-w64-mingw32-windres.EXE&quot;<b=
r>
&quot;-I./.&quot; &quot;-I../<a href=3D"http://qemu.org/" rel=3D"noreferrer=
" target=3D"_blank">qemu.org/</a>.&quot; &quot;../<a href=3D"http://qemu.or=
g/version.rc" rel=3D"noreferrer" target=3D"_blank">qemu.org/version.rc</a>&=
quot;<br>
&quot;version.rc_version.o&quot; &quot;--preprocessor-arg=3D-MD&quot;<br>
&quot;--preprocessor-arg=3D-MQversion.rc_version.o&quot;<br>
&quot;--preprocessor-arg=3D-MFversion.rc_version.o.d&quot;<br>
version.rc_version.o: private .var.description :=3D Generating Windows<br>
resource for file &#39;version.rc&#39; with a custom command<br>
version.rc_version.o: private .var.out :=3D version.rc_version.o<br></block=
quote><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Is this wrong?<br></blockquote><div>This is fine=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"></blockquote><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
<br>
Paolo<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--00000000000062b79705adc9b5d7--

