Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5E8C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:55:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C9B920678
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+/8WWSw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C9B920678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDxC8-0005P3-7K
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDweQ-0000Za-Qp
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 17:20:10 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:35497)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDweO-0001gC-Pv
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 17:20:10 -0400
Received: by mail-lj1-x241.google.com with SMTP id a15so5532676ljk.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 14:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=8mY81QGa2T4jYxigyi2JYuEs3lpmLNHGtUPnudy1ur8=;
 b=n+/8WWSwMD0SPqrAmyv5I64RXHnD86gRrjrs/71F8kIit9PnkYoMLLaQlUx9M1q3NU
 ydHj+7zthyWXFly9FZmm94ZQZWZwLXHI/7kW74RJ43T3Su9GYO1FaxA4pPoCX8qr36MW
 UXxmK/bCbZzGeg+5u/cqyJk/ZRKmNOlh4VXEN42uyXgTN10NVZVhW/3zG0ywSAzxETp+
 CZnsBp2xKsSVXig6F1ECkvXmgA+HNCi80XMdL89Uw+3bRKvqNfl+7xJ0v+IuFjKei9Y/
 Ae9jraYh+22d8RA+6k741QE00O2i0mh2RKseCxmkIw62Ce/Z3R+MEEPsSQDI+ioUIcEk
 fNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=8mY81QGa2T4jYxigyi2JYuEs3lpmLNHGtUPnudy1ur8=;
 b=t58Z512saJRoE7ik7PaT2fHRRgQUpPNJWxAIsoI59G6BCgBG48eLOxgLXIe3Cr5nC4
 gE6dJBrYL1d2dyr9UGrFPBmWJIFqySlL1MqBONDeq1AjtrQZzMU0UcGURkB95RENYadq
 AaeiHrNQxqfPDnqZfGHCfVyl7r6SBv0346Ps8iY98Z5foxadgfyjAUVJV89uqYxddA4P
 TSfKKcdTRrwQDWUR6BUzd1JKBpMp+UfV6XThuDK2bgGlo1EFOxS4UX2Vr04kPR8iBziP
 Dg6btdP5qQTDOjOYmSDeCJn84XZQnBviu7nQUCZEe4YngQr2zT3nbBuA53mhwnUoo1Bk
 GViw==
X-Gm-Message-State: AOAM5313VfIBu44J1A3BPXe7wu4DUu9ZQ7HfgujQM5Osm6JW7BMUEUpX
 VMtd9XeE0Vi6l2c9/vFKiyOG8Ln1icxJkGnUYpo=
X-Google-Smtp-Source: ABdhPJzy6rTYBio4eKpn+BFIkh8hQBXyfwANP48zIHtXgYOyDqzK8N8VV71nnHGJABNszEjNlwD7DQVfTQOBqn8Tl4o=
X-Received: by 2002:a2e:854c:: with SMTP id u12mr2231867ljj.120.1599168005992; 
 Thu, 03 Sep 2020 14:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200903083147.707-1-luoyonggang@gmail.com>
 <20200903083147.707-4-luoyonggang@gmail.com>
 <8c5dd495-abaf-7abc-2ba0-82f13bbd3d02@linaro.org>
In-Reply-To: <8c5dd495-abaf-7abc-2ba0-82f13bbd3d02@linaro.org>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 4 Sep 2020 05:19:56 +0800
Message-ID: <CAE2XoE8w_H+_N9AMgssSheWsTWwvoiOTgYdgCZG9g5cyHLbdpw@mail.gmail.com>
Subject: Re: [PATCH v4 03/12] tcg: Fixes dup_const link error
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000eefa4205ae6f5059"
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x241.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000eefa4205ae6f5059
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2020 at 1:20 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 9/3/20 1:31 AM, Yonggang Luo wrote:
> > Rename function dup_const to dup_const_eval for avoid confliction with
> macro dup_const
> >
> > The link error on msys2
> >
> > Linking target qemu-system-alpha.exe
> >
> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../..=
/../../x86_64-w64-mingw32/bin/ld.exe:
> libqemu-alpha-softmmu.fa.p/tcg_optimize.c.obj: in function `tcg_optimize'=
:
> > E:\CI-Cor-Ready\xemu\qemu-build/../qemu.org/tcg/optimize.c:1106:
> undefined reference to `dup_const'
> >
> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../..=
/../../x86_64-w64-mingw32/bin/ld.exe:
> libqemu-alpha-softmmu.fa.p/tcg_tcg-op-vec.c.obj: in function
> `tcg_gen_dupi_vec':
> > E:\CI-Cor-Ready\xemu\qemu-build/../qemu.org/tcg/tcg-op-vec.c:283:
> undefined reference to `dup_const'
> > collect2.exe: error: ld returned 1 exit status
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  include/tcg/tcg.h | 6 +++---
> >  tcg/tcg-op-gvec.c | 2 +-
> >  2 files changed, 4 insertions(+), 4 deletions(-)
>
> No, really, as I asked before: what symbol is present in tcg-op-gvec.c.ob=
j
> without this patch?
>
The   tcg-op-gvec.c.obj are missing now, maybe skip this patch first?
Anyway have same name with function and macro is not that good

>
> That you need this, to me says that you've got a broken compiler.  This i=
s
> bog-standard C.  There is nothing windows-specific about it.
>
>
> r~
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000eefa4205ae6f5059
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 4, 2020 at 1:20 AM Richar=
d Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.hen=
derson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On 9/3/20 1:31 AM, Yonggang Luo wrote:<br>
&gt; Rename function dup_const to dup_const_eval for avoid confliction with=
 macro dup_const<br>
&gt; <br>
&gt; The link error on msys2<br>
&gt; <br>
&gt; Linking target qemu-system-alpha.exe<br>
&gt; C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/..=
/../../../x86_64-w64-mingw32/bin/ld.exe: libqemu-alpha-softmmu.fa.p/tcg_opt=
imize.c.obj: in function `tcg_optimize&#39;:<br>
&gt; E:\CI-Cor-Ready\xemu\qemu-build/../<a href=3D"http://qemu.org/tcg/opti=
mize.c:1106" rel=3D"noreferrer" target=3D"_blank">qemu.org/tcg/optimize.c:1=
106</a>: undefined reference to `dup_const&#39;<br>
&gt; C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/..=
/../../../x86_64-w64-mingw32/bin/ld.exe: libqemu-alpha-softmmu.fa.p/tcg_tcg=
-op-vec.c.obj: in function `tcg_gen_dupi_vec&#39;:<br>
&gt; E:\CI-Cor-Ready\xemu\qemu-build/../<a href=3D"http://qemu.org/tcg/tcg-=
op-vec.c:283" rel=3D"noreferrer" target=3D"_blank">qemu.org/tcg/tcg-op-vec.=
c:283</a>: undefined reference to `dup_const&#39;<br>
&gt; collect2.exe: error: ld returned 1 exit status<br>
&gt; <br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 include/tcg/tcg.h | 6 +++---<br>
&gt;=C2=A0 tcg/tcg-op-gvec.c | 2 +-<br>
&gt;=C2=A0 2 files changed, 4 insertions(+), 4 deletions(-)<br>
<br>
No, really, as I asked before: what symbol is present in tcg-op-gvec.c.obj<=
br>
without this patch?<br></blockquote><div>The=C2=A0=C2=A0

tcg-op-gvec.c.obj are missing now, maybe skip this patch first?</div><div>A=
nyway have same name with function and macro is not that good</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
<br>
That you need this, to me says that you&#39;ve got a broken compiler.=C2=A0=
 This is<br>
bog-standard C.=C2=A0 There is nothing windows-specific about it.<br>
<br>
<br>
r~<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000eefa4205ae6f5059--

