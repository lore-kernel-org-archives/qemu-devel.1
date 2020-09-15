Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCFDC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:39:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 303B420678
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uMuor8Tr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 303B420678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIEv8-0000eD-4R
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEdG-0006PV-PH
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:20:42 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:43965)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEdE-0003kj-Q4
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:20:42 -0400
Received: by mail-lj1-x243.google.com with SMTP id u4so3491038ljd.10
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 10:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=gVSrt0YDsw9a1vxdtjU8o8LlcqH+RY9KvGa6DQG58yQ=;
 b=uMuor8TrGHksLhARDX3pYH1A4KLgUTdP81V+0C8Hq6MdfnmV5eBuftXvqJmsQWsV/w
 LDOIzAK96z+Ut4tMJjUmrmS90vTbQZuwH1xLgmAwP0Qu6JyZF1DaaVZlvjTd3UyfxF/+
 SvC8VGkWr0gAb9UDcyfh7IW+t931svL3aPCP/TMXEJQiVd7MeYLQJArIUgmW3woOS6Sh
 S+XkhDR2cU+qygbkmyIa5rPGHG7ujW36E4c3ZQcZtXBTJilLHePUM1sPYSurEx6YgWxH
 9uK9LMijx/Ghq7aGSr3IdAQH+pxVd68PMYo2sou3YzV5Tgr/AVTv50Ce6z4btXA6jSqw
 30KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=gVSrt0YDsw9a1vxdtjU8o8LlcqH+RY9KvGa6DQG58yQ=;
 b=X3txrzkykjeZk/0xRDR5x5dsYp0ui+mm6ZDVxIIpd89ewO1ofzoEZ22jfkAW3VJuYS
 MmjVrzduIY45e/+xXMTv5FgUyiCLY1+YxmKJTuDBxTToj6hga8vONTYpUVaeCGZZwfkO
 MXcDNPPvSQidLruUEJqF0nxB8/AiNkj7IOWC2k5v0jbLN3RKFiEHVfFX/Ao8yDTkjodW
 B6+V5GoZbsDtmyMmplRnbEnZUSriWi5q+mUbnS389gWy7tL3g0CYenoYbEjfvy1eBWbh
 XRK4E73BQa+LtA3Xpd/RMAY3avYauw3+3wup+SEcGqxco3UFgLpToqh5s27Ii5kr6y/3
 imOA==
X-Gm-Message-State: AOAM5318hzHIxKQfV3PSDSN1zhKr58qSojjxW+d0Q2Zy+dbR98Pwmv3Y
 3P0c9J2L5Ny/6vbVRYrUasJWmDQ9aIvcMp/6KNA=
X-Google-Smtp-Source: ABdhPJzR8FvN1+64Kq4qXikEFmgGDwfQ5prdD/6juN90eWvwi8ctnTjRjyt/RpKQ9u3fiAunG7HjJQmdfvyx1DSyAeA=
X-Received: by 2002:a05:651c:151:: with SMTP id
 c17mr7612144ljd.467.1600190438874; 
 Tue, 15 Sep 2020 10:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200914230210.2185860-1-richard.henderson@linaro.org>
 <20200914230210.2185860-2-richard.henderson@linaro.org>
 <eced490f-0250-3516-5d75-c6c3ff6e97be@linaro.org>
 <CABgObfbWzf7DLgx23+yMqYqnMUaiJ=0WKaW4zvzkA4u5T9fQXQ@mail.gmail.com>
 <4813770a-34a4-72ce-17f7-7ea451a7af99@linaro.org>
 <CAE2XoE_he2L85WgAg5NBWKLT+FFy6RJDULsL-QWBH0jbhxZTpw@mail.gmail.com>
 <2444b9f2-3668-8ca8-2e9e-3215d55b1472@redhat.com>
 <CAE2XoE_9K7UwdOYTxPggGhA4x17qRAMGC7x0y5Lgc_2ta=m2sw@mail.gmail.com>
 <29b0e531-b6e0-ebec-4415-37af1b849b1f@redhat.com>
In-Reply-To: <29b0e531-b6e0-ebec-4415-37af1b849b1f@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 16 Sep 2020 01:20:26 +0800
Message-ID: <CAE2XoE_UVTuwWCu580deUK5eyurXGirkGfBWT__rcsbpVQx75w@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] capstone: Convert Makefile bits to meson bits
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000aea2ff05af5d5ea4"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x243.google.com
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

--000000000000aea2ff05af5d5ea4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2020 at 1:14 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 15/09/20 19:07, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> >
> >     Linux distributions generally do not want to have bundled
libraries, so
> >
> > Yes, bundled libraries is a bad idea, but static linked library is
> > another case, that won't affect
> > the Linux distributions.
>
> As far as Linux distributions are concerned, static linking is a case of
> bundling.  Bundling means that, for example, any security issue will
> require rebuilding the package that does the bundling (this applies
> especially to slirp among the three that QEMU we bundles).

Oh, see that, so capstone and  libfdt doesn't have the security concern?
>
>
> Paolo
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000aea2ff05af5d5ea4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Wed, Sep 16, 2020 at 1:14 AM Paolo Bonzini &lt;=
<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<b=
r>&gt;<br>&gt; On 15/09/20 19:07, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo)=
 wrote:<br>&gt; &gt;<br>&gt; &gt; =C2=A0 =C2=A0 Linux distributions general=
ly do not want to have bundled libraries, so<br>&gt; &gt;<br>&gt; &gt; Yes,=
 bundled libraries is a bad idea, but static linked library is<br>&gt; &gt;=
 another case, that won&#39;t affect<br>&gt; &gt; the Linux distributions. =
<br>&gt;<br>&gt; As far as Linux distributions are concerned, static linkin=
g is a case of<br>&gt; bundling.=C2=A0 Bundling means that, for example, an=
y security issue will<br>&gt; require rebuilding the package that does the =
bundling (this applies<br>&gt; especially to slirp among the three that QEM=
U we bundles).<br><br>Oh, see that, so capstone and =C2=A0libfdt doesn&#39;=
t have the security concern?<br>&gt;<br>&gt;<br>&gt; Paolo<br>&gt;<br><br><=
br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<=
br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yong=
gang Luo</div>

--000000000000aea2ff05af5d5ea4--

