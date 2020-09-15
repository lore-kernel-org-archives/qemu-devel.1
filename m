Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED36CC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:39:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87BAD206E6
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLZ9f6PZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87BAD206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIEvd-0001z7-GX
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEX0-0000CD-JI
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:14:14 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e]:35211)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEQV-00029N-24
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:07:32 -0400
Received: by mail-lj1-x22e.google.com with SMTP id a15so3514494ljk.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 10:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=YZHg3+1xVHc8t3r2YlvFbE/q98tePh778/s41ccjXjw=;
 b=oLZ9f6PZPEbAOO/tXVASKUYUiMS4DtfreY30oh5f6rJLK3HTa1UkgpqQROz8UQ/KFz
 eCjjCLcWgQk6iUBHmJaGPYZwcKSBW/af5XIMETBiCogCxcPATNj/+pa38EhmQA+ADpk8
 WEanL8QT9IaBCDgOLpiAKilJsrMIaqLeOc3MXNcVHeWq7L0dR6DEiTm8lfbvmre60Jod
 23k+q5FJs0goRNE/uZ593P/vpCSG1TnXf12hPwRBznGB+cKW/ehicND3B8fu5Ux8jzmO
 fvbEpASfJHIEFXTkOEX2c/J3IkQgAJ3b8X0yV5qQ2fcXhCJwbk2H1A0aV3iPJk2LKWe8
 muLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=YZHg3+1xVHc8t3r2YlvFbE/q98tePh778/s41ccjXjw=;
 b=p/wojtBY05Q5bns0Dlr5h65i1fMQUEo7ZlQtfCjFnu/qRjZBmAQGR+RTP+SK8j5AGV
 v5SEMS3FOfQtXNMIGfFvu77JbK96SLh6QZyYirWbsnZRa1GqqCExZvT42PLmDPzSwokd
 FfXur8E0lq6GYtOwUq7qzB7ZZhMyfmu+2eytjSMfdj5bEw7ZsLVvrWewlRZJK7IAaxzo
 9J23+kNlNYZMvUUoDu0RI9m8FEdknKt0+Hu5n5OIkui+Gyp5Vrk4tF9ifkKQYf8zr+pZ
 ttdbe0T7FvTe+KEmmWouIjmBBy68ANvDMUjvswr8R7YCKxfDstLLTtAavDIYE7KVDnHJ
 WYgw==
X-Gm-Message-State: AOAM531+oXGf9J/r7yF88y+sFhRc6LIpq53PcgXG9O9LlvEN213D0kp1
 k87VCMhrfVyTkZqnfnLWx7EMMVraxkGZmlp36Jw=
X-Google-Smtp-Source: ABdhPJxvusoV1yZm9Yhn8QDqBrM/UC0SHnfaJOGvzwXJwVNq7qKsOXF3lvCSegZo0aI87zdmxX8j+vo20n/0S+SN+94=
X-Received: by 2002:a05:651c:151:: with SMTP id
 c17mr7594425ljd.467.1600189649275; 
 Tue, 15 Sep 2020 10:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200914230210.2185860-1-richard.henderson@linaro.org>
 <20200914230210.2185860-2-richard.henderson@linaro.org>
 <eced490f-0250-3516-5d75-c6c3ff6e97be@linaro.org>
 <CABgObfbWzf7DLgx23+yMqYqnMUaiJ=0WKaW4zvzkA4u5T9fQXQ@mail.gmail.com>
 <4813770a-34a4-72ce-17f7-7ea451a7af99@linaro.org>
 <CAE2XoE_he2L85WgAg5NBWKLT+FFy6RJDULsL-QWBH0jbhxZTpw@mail.gmail.com>
 <2444b9f2-3668-8ca8-2e9e-3215d55b1472@redhat.com>
In-Reply-To: <2444b9f2-3668-8ca8-2e9e-3215d55b1472@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 16 Sep 2020 01:07:16 +0800
Message-ID: <CAE2XoE_9K7UwdOYTxPggGhA4x17qRAMGC7x0y5Lgc_2ta=m2sw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] capstone: Convert Makefile bits to meson bits
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009e51c005af5d2f4b"
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x22e.google.com
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009e51c005af5d2f4b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2020 at 1:00 AM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 15/09/20 18:12, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> >
> > I suggest remove the capstone=3Dsystem option cause the system library
> > may not satisfy the requirements of qemu and create in-consistence
> > expereince when bug or error happens about capstone. We either have
> > git submodule capstone or nothing at all
>
> Linux distributions generally do not want to have bundled libraries, so
>
Yes, bundled libraries is a bad idea, but static linked library is another
case, that won't affect
the Linux distributions.

> the fallback to the system library is the default.  We single out
> capstone, libfdt and slirp because they are slightly less common
>
Ineed, I would like suggest these three libraries always to be static
linked or not use it at all.

> dependencies and are missing on some distros; however, in general we
> strive to _only_ use system libraries and not package any of QEMU's
> dependencies.
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

--0000000000009e51c005af5d2f4b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 16, 2020 at 1:00 AM Paolo=
 Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 1=
5/09/20 18:12, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:<br>
&gt; <br>
&gt; I suggest remove the capstone=3Dsystem option cause the system library=
<br>
&gt; may not satisfy the requirements of qemu and create in-consistence<br>
&gt; expereince when bug or error happens about capstone. We either have<br=
>
&gt; git submodule capstone or nothing at all<br>
<br>
Linux distributions generally do not want to have bundled libraries, so<br>=
</blockquote><div>Yes, bundled=20

libraries is a bad idea, but static linked library is another case, that wo=
n&#39;t affect</div><div>the=20

Linux distributions.=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
the fallback to the system library is the default.=C2=A0 We single out<br>
capstone, libfdt and slirp because they are slightly less common<br></block=
quote><div>Ineed, I would like suggest these three libraries always to be s=
tatic linked or not use it at all.</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
dependencies and are missing on some distros; however, in general we<br>
strive to _only_ use system libraries and not package any of QEMU&#39;s<br>
dependencies.<br>
<br>
Paolo<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--0000000000009e51c005af5d2f4b--

