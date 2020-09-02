Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E11C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:36:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C6120773
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKQemhz3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C6120773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDYYx-000790-Ju
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 15:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDYYF-0006T6-8Z
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:36:11 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232]:35411)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDYYD-000339-4t
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:36:10 -0400
Received: by mail-lj1-x232.google.com with SMTP id a15so602170ljk.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 12:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=a8wJuPdo+yEwcxbXlCgHoqooCQgqtpIyp9ItDTCp9bE=;
 b=MKQemhz3l0t0YBb5Ye6nBP1kIYNbHnNIwy7rvcG/M5s1awzMkIUp8uLxnh6gtVbgfY
 R8Tv2vtuT11zKYn5gJXs3bHS2j6uMAP1Ye5WGwTS6iM3qUb1ZRi387y9EPzOsUKxMfuk
 7NEdqTPTbdyl9p/5tL/SCCCsi8HVBKcOAckHLghk7fRCyWIuwtSkfL7IbL6bHT+EMAHw
 i5OYajE9v+fE5KxNL9yulVBR7N1G1kzTI/KcUc15LJLed1AuXAAbM9jXusfNTY1Vh/Rw
 WI7avy/ket8P/NotqzOFiUsYDPV34LC6PyIekPBb0S28+YvTrl9r0VWdk0DLKzZ5vk55
 Zl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=a8wJuPdo+yEwcxbXlCgHoqooCQgqtpIyp9ItDTCp9bE=;
 b=ZDCeT4tFTu5/h79H2sLyLvbzx4beDZw/+WO0XKOQNQk2+5iC142qUmW77vZ2RRPqUe
 Jszibi5HESk+AHmjRg7JZ1B/4x87qBE2xzIhoB1wHE8vwl0Yzk8FTYWASymaIln26xmu
 eJKtJvp5uS2veVs2bSaizcHUYA9eYaMdgm3NCysOsKOhpicEZ+AMsKSmiztNwy4LhXvJ
 bVbiEHLqUcpdXrDygySX96nozhfKLs41n6s8a1Kr2FIrJr6Dwkq9KzLiKuu85pBPGa1S
 zQjtjBF3D9vZQC7r7Maa8G0XuetCp8wPxclX4T/ZroXdSSO/pPOkdGpW8nh8AIwGHaFv
 WWgA==
X-Gm-Message-State: AOAM531ZtRPlXVAK2/MiM96Rt238yTH2Y3LjCSEKWfaHHQydW7G8D7Co
 igRKYOTaMpUA1046OIL48zNexsxAV41ltwo7sxr98/dAhvIyjcRa
X-Google-Smtp-Source: ABdhPJzp5rCVD9erR0+mjMAzxDTd/KhOl3YwK3k/bUp2/mXCdWh7wDU8V+eYAgkK+yZecqiWG7V64g9yk61ueAN/W7U=
X-Received: by 2002:a2e:2a83:: with SMTP id q125mr4188104ljq.242.1599075366983; 
 Wed, 02 Sep 2020 12:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE8VqiSFAuRL--VZtj-wOsGcGPn0FO3SOLeVfXwrP12_ig@mail.gmail.com>
 <20727adf-8d8c-ada2-c95b-a4f8d7653c91@redhat.com>
In-Reply-To: <20727adf-8d8c-ada2-c95b-a4f8d7653c91@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 3 Sep 2020 03:35:55 +0800
Message-ID: <CAE2XoE90HDXjQDOFyR_Ar2jxABLgZHhjZ+fFkwngTPzt7aSjyQ@mail.gmail.com>
Subject: Re: new msys2 testing failure,
 does this fixe? undefined reference to `qemu_lock_fd_test'
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000037db5105ae59bf5d"
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x232.google.com
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
Cc: qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000037db5105ae59bf5d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2020 at 3:33 AM Thomas Huth <thuth@redhat.com> wrote:

> On 02/09/2020 21.13, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> >
> >
> C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../..=
/../x86_64-w64-mingw32/bin/ld.exe:
> > tests/test-image-locking.o: in function `check_locked_bytes':
> > 5564D:/a/qemu/qemu/tests/test-image-locking.c:69: undefined reference t=
o
> > `qemu_lock_fd_test'
> >
> 5565C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../.=
./../../x86_64-w64-mingw32/bin/ld.exe:
> > D:/a/qemu/qemu/tests/test-image-locking.c:71: undefined reference to
> > `qemu_lock_fd_test'
> >
> 5566C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../.=
./../../x86_64-w64-mingw32/bin/ld.exe:
> > D:/a/qemu/qemu/tests/test-image-locking.c:62: undefined reference to
> > `qemu_lock_fd_test'
> >
> 5567C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../.=
./../../x86_64-w64-mingw32/bin/ld.exe:
> > tests/test-image-locking.o: in function `main':
> > 5568D:/a/qemu/qemu/tests/test-image-locking.c:152: undefined reference
> > to `qemu_has_ofd_lock'
> > 5569collect2.exe: error: ld returned 1 exit status
> > 5570make: *** [D:/a/qemu/qemu/rules.mak:88:
> > tests/test-image-locking.exe] Error 1
> > 5571make: *** Waiting for unfinished jobs....
>
> You need this patch here:
>
> https://lore.kernel.org/qemu-devel/20200823111757.72002-4-thuth@redhat.co=
m/
>
> and also:
>
> https://lore.kernel.org/qemu-devel/20200823111757.72002-5-thuth@redhat.co=
m/
>
>   Well, about test-replication, I've already fixes the test code
directly, so enable it on win32 is a better option


> ... or wait for Paolo's next meson pull request which will convert
> tests/Makefile to meson.
>
>  Thomas
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000037db5105ae59bf5d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><span style=3D"color:rgb(0,0,0);font=
-size:13px;white-space:pre-wrap"><br></span></div></div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 3, 2020 at 3:=
33 AM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">O=
n 02/09/2020 21.13, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:<br>
&gt; <br>
&gt; C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../..=
/../../x86_64-w64-mingw32/bin/ld.exe:<br>
&gt; tests/test-image-locking.o: in function `check_locked_bytes&#39;:<br>
&gt; 5564D:/a/qemu/qemu/tests/test-image-locking.c:69: undefined reference =
to<br>
&gt; `qemu_lock_fd_test&#39;<br>
&gt; 5565C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/.=
./../../../x86_64-w64-mingw32/bin/ld.exe:<br>
&gt; D:/a/qemu/qemu/tests/test-image-locking.c:71: undefined reference to<b=
r>
&gt; `qemu_lock_fd_test&#39;<br>
&gt; 5566C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/.=
./../../../x86_64-w64-mingw32/bin/ld.exe:<br>
&gt; D:/a/qemu/qemu/tests/test-image-locking.c:62: undefined reference to<b=
r>
&gt; `qemu_lock_fd_test&#39;<br>
&gt; 5567C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/.=
./../../../x86_64-w64-mingw32/bin/ld.exe:<br>
&gt; tests/test-image-locking.o: in function `main&#39;:<br>
&gt; 5568D:/a/qemu/qemu/tests/test-image-locking.c:152: undefined reference=
<br>
&gt; to `qemu_has_ofd_lock&#39;<br>
&gt; 5569collect2.exe: error: ld returned 1 exit status<br>
&gt; 5570make: *** [D:/a/qemu/qemu/rules.mak:88:<br>
&gt; tests/test-image-locking.exe] Error 1<br>
&gt; 5571make: *** Waiting for unfinished jobs....<br>
<br>
You need this patch here:<br>
<br>
<a href=3D"https://lore.kernel.org/qemu-devel/20200823111757.72002-4-thuth@=
redhat.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.org/q=
emu-devel/20200823111757.72002-4-thuth@redhat.com/</a><br>
<br>
and also:<br>
<br>
<a href=3D"https://lore.kernel.org/qemu-devel/20200823111757.72002-5-thuth@=
redhat.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.org/q=
emu-devel/20200823111757.72002-5-thuth@redhat.com/</a><br>
<br></blockquote>=C2=A0 Well, about=C2=A0<span style=3D"color:rgb(0,0,0);fo=
nt-size:13px;white-space:pre-wrap">test-replication, I&#39;ve already fixes=
 the test code directly, so enable it on win32 is a better option</span><di=
v></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
... or wait for Paolo&#39;s next meson pull request which will convert<br>
tests/Makefile to meson.<br>
<br>
=C2=A0Thomas<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--00000000000037db5105ae59bf5d--

