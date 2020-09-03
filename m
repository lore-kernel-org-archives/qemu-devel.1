Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FECBC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:52:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D609C206A5
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JP7mxNgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D609C206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDmqw-0007NA-0j
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 06:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDmqL-0006jr-LN
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:51:49 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a]:43332)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDmqK-0003hz-0V
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:51:49 -0400
Received: by mail-lj1-x22a.google.com with SMTP id u4so2214325ljd.10
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 03:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=K4AerSzGdKrVguZIk9IHyzH9pirXXiwunhkC5OV7U7w=;
 b=JP7mxNgW97xmlBwz+MJpKYceBRmHzRGNzbqhEPxq9lve3iYn+7fZmXOFrvpgFNcW3U
 3WktcnMaUu/nkC7omCieSMzxcOAC/r3l8OYydL3r4hZ3zyeNXb04urzBuC9J42Gu+j0E
 1SJLSpwelH8M+A0HP0BY9gyA2nhjnTOtUXcduXq3C+A+P9gKnUXQHirehYJ5l/EOEpFw
 DtYZuDJZoIJCEc7m/qFsDYDUtRFcaeoBUfbdpzzLmXRznUPV+X2ZKWC0TM+4t7YjlXw+
 qquJ0DGc1kpoZqJ42RfuCZea+Llko6yIQQUrmg2e64qnnGGRq6VWWIgcsMLzPBXJIdMC
 5y+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=K4AerSzGdKrVguZIk9IHyzH9pirXXiwunhkC5OV7U7w=;
 b=lgbpcdbQXWHXgYV2hZXtP/aaZ/W4xv+lxh0oDeVBImYjDItUpLi8Ff/jS/A7LS75dv
 6dO/yOWJ+VgcgVFR4+cEjE8wOAqG5XqG6x33ncAO2QfMBIFuPU3tq+JguZWa0koFAstv
 QjNPyGeWsfVb5Q4xm9rg0NC9my7jSsslk6VwGh6BDG+aYy2+yON0O/VMzHeDNu4UqON6
 wgTFp5H6+uNUukznAmJdB6IDo5x0jxbQp2fuQv3bVxkrjVWDz2ar/c326hMzqTKmAsCI
 3HYZqClJ/Ic9VQ7cWsMe/BYkqjTSxVvsgnNtYGwAswjJER6Jwynjv0TRgONCconu75RQ
 s58g==
X-Gm-Message-State: AOAM53052J7npQfVBYKRCT9z3NjnbpnGfKYBzbtj8NQ3rig69yC/5aQd
 Q1p6r38mMCvfPzaDNa4P7vap7/OjbaogP7qt2+M=
X-Google-Smtp-Source: ABdhPJxsSPGUJvVSsITTLManMem0hpLUDmI65yQKvpkeVgMY8FD/kiMtMI8leeY1+lZvZSOXAuOGrkVu9dFDo29r3Ig=
X-Received: by 2002:a2e:2a83:: with SMTP id q125mr1025545ljq.242.1599130305766; 
 Thu, 03 Sep 2020 03:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE-Rwe8-k8p5zC6YzxFX-=bj+JY+RCJN4A1ZQudSZ8DQKQ@mail.gmail.com>
 <7e34696d-6c4f-7b5a-96a7-14d21adcd4b1@redhat.com>
In-Reply-To: <7e34696d-6c4f-7b5a-96a7-14d21adcd4b1@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 3 Sep 2020 18:51:34 +0800
Message-ID: <CAE2XoE9MHCzrR16yG_4Rhb4sYwQPBG5z=a+gm6qoaOSWFLvYuQ@mail.gmail.com>
Subject: Re: Thouhgs about cross-platform signals and process
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000d32d0a05ae6689a0"
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x22a.google.com
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
Cc: Stefan Weil <sw@weilnetz.de>, "Daniel P. Berrange" <berrange@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d32d0a05ae6689a0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2020 at 6:42 PM Thomas Huth <thuth@redhat.com> wrote:

> On 03/09/2020 00.15, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> > Seems signal handling are common and process fork are common in qemu,
> > I suggest wrapping those in utils library for easily and consistence
> > access across different platforms(Win32/POSIX)
>
> For fork()-related things, I guess we could use the functions from glib
> most of the time.
> Concerning signal handling, I have to say that I was surprised to see in
> your patches that signal() is available with msys at all... is that
>
signal is already provide by MSVC runtime,  just not as much functional as
posix.

> always working as expected? There must be a reason why we did not use it
> in the QEMU code for things like the in the past...?
>
This need someone know that to answer, or maybe just because Win32 are
poorly maintained.

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

--000000000000d32d0a05ae6689a0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 3, 2020 at 6:42 PM Thomas=
 Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 03/09/2020=
 00.15, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:<br>
&gt; Seems signal handling are common and process fork are common in qemu,<=
br>
&gt; I suggest wrapping those in utils library for easily and consistence<b=
r>
&gt; access across different platforms(Win32/POSIX)<br>
<br>
For fork()-related things, I guess we could use the functions from glib<br>
most of the time.<br>
Concerning signal handling, I have to say that I was surprised to see in<br=
>
your patches that signal() is available with msys at all... is that<br></bl=
ockquote><div>signal is already provide by MSVC runtime,=C2=A0 just not as =
much functional as posix.</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
always working as expected? There must be a reason why we did not use it<br=
>
in the QEMU code for things like the in the past...?<br></blockquote><div>T=
his need someone know that to answer, or maybe just because Win32 are poorl=
y maintained.=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0Thomas<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000d32d0a05ae6689a0--

