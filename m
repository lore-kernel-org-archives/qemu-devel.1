Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71A5C41604
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 09:33:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74019206CD
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 09:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UF7uZjHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74019206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOdvR-0003lC-LF
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 05:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kOduI-0002gs-3M
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 05:32:46 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:36894)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kOduE-0000FX-Ss
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 05:32:45 -0400
Received: by mail-lf1-x142.google.com with SMTP id z19so4874484lfr.4
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 02:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=145fYW/DlLrIp3vKcTYEsrhkVlJCngyTG0ntr/8URY4=;
 b=UF7uZjHOCn94wvnfIhvzCWwqfmkRfToLIFooDhBdNyBbZMPMtQFHjtJIsDJTzikshp
 7twWhp+z9zUB52t5hhdLaCjlx4CamiEhOT9alWv+81vG7+sLmlT9ukB2v001IEHioedm
 zS72fznSQG0V6uFtFphDjO7OoH1XW8YpgwiapsqOf4ED7PlIQUjxk5Y3nXQSNZM1kxNz
 Dz/JGmW8rJFidjMXcpCmUGO9jgEpzB79gmxU8kuvC4tRIb6lD5EwRAP7Tztmx7EhVvlm
 3kHJ0uywqcPkj1BNo29yrS1Z1cIjYbgNsIdAThc/itny4w0fCNr8rfmG6jHtdJDAVKq4
 xu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=145fYW/DlLrIp3vKcTYEsrhkVlJCngyTG0ntr/8URY4=;
 b=ah1nB+Pbt4bo/UuAQvu1nlVf8gJn4F9UNpyTj+oGehqFSuXqmLbLL1NsEc/Fr7g6CZ
 nBcsW97mBqnkyEWj4osXC+jwAwEvl8idO99oz+uYrCXe4ogrZYw4mHT94LVPqSNHEAdD
 KgACPc6wsZm0uioqoflq6xLI0MTkeQvIy2QldzkXdUtozkiw4+/8WIx/zSR2INHeH04l
 uQuSezO3U3ZfD7Cx3TxQFjQgXyx6UncVHKc5PCVX/tn2vBDcp93ah14NY9+q6zQ7adgl
 AUza+XPTSWbgmkGiPMkj3snxfBAleGvOESf2TCJVW89ihr/VM6zMoOU7Py+0yag5QXv/
 D7Pw==
X-Gm-Message-State: AOAM530bgQzTeKvOBZh7wzgftZTA/QDVCXOnouAv9n0ahmbiy9yT2Lj9
 n0KWWoJOBMctEqITbAd4EADpdNn92NgAEpU3Za8=
X-Google-Smtp-Source: ABdhPJzEGrJHke7Pi2vVQOua/Z/2CRT4Y68Ju84C7gDu/CO2hTYm8K+H8UuZN070X3Ahw17QgxYycSPnrw7imdsIRnw=
X-Received: by 2002:a19:674f:: with SMTP id e15mr2054007lfj.50.1601717560686; 
 Sat, 03 Oct 2020 02:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201002105239.2444-1-peter.maydell@linaro.org>
 <b1a6000a-c9a1-43fb-7646-b6ea87797b2e@redhat.com>
 <CAFEAcA9PbBByROzJ3+pfxycAoP-C5JnmfxQEt5jm6+3A3n2fbw@mail.gmail.com>
 <df5bd19c-da9d-d3b0-71a9-4deed67450bf@redhat.com>
 <CAFEAcA9M_BP9mnZHCLM93aYvMxrRHYFELQZ3FvsyH3hNvXtHDA@mail.gmail.com>
 <CAE2XoE-RnJ2j732JfxDA2A9O0Bp4KJ2rGG0LTjrDMKvRox-VBg@mail.gmail.com>
 <d6417044-324c-0bec-a05c-1142dcdc6003@redhat.com>
 <CAE2XoE_4S6NpA7+TOuzwQ=TFjw5=rOe-_mrSkuJ4OEzUWK1X2A@mail.gmail.com>
 <8bd109cd-e78b-6857-d704-4519d8150ef9@redhat.com>
In-Reply-To: <8bd109cd-e78b-6857-d704-4519d8150ef9@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sat, 3 Oct 2020 17:32:30 +0800
Message-ID: <CAE2XoE9VBgCmj4j-mGY7X7JB5s0AYkweCFySYk3P3UkYkkkMAQ@mail.gmail.com>
Subject: Re: [PATCH] meson.build: Don't look for libudev for static builds
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000003c3da405b0c0eebd"
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x142.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003c3da405b0c0eebd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2020 at 4:43 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 03/10/20 10:29, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> > For some meson script like this:
> > curses =3D not_found
> > if iconv.found() and not get_option('curses').disabled()
> >   curses_libname_list =3D ['ncursesw', 'ncurses', 'cursesw', 'pdcurses'=
]
> >   curses_test =3D '''
> >     #include <locale.h>
> >     #include <curses.h>
> >     #include <wchar.h>
> >     int main(void) {
> >       wchar_t wch =3D L'w';
> >       setlocale(LC_ALL, "");
> >       resize_term(0, 0);
> >       addwstr(L"wide chars\n");
> >       addnwstr(&wch, 1);
> >       add_wch(WACS_DEGREE);
> >       return 0;
> >     }'''
> >   foreach curses_libname : curses_libname_list
> >       libcurses =3D dependency(curses_libname,
> >                              required: false,
> >                              method: 'pkg-config',
> >                              static: enable_static)
> >
> >       if not libcurses.found()
> >         dirs =3D ['/usr/include/ncursesw']
> >         if targetos =3D=3D 'windows'
> >           dirs =3D []
> >         endif
> >         libcurses =3D cc.find_library(curses_libname,
> >                                     required: false,
> >                                     dirs: dirs,
> >                                     static: enable_static)
> >       endif
> >       if libcurses.found()
> >         if cc.links(curses_test, dependencies: [libcurses])
> >           curses =3D declare_dependency(compile_args:
> > '-DNCURSES_WIDECHAR', dependencies: [libcurses])
> >           break
> >         endif
> >       endif
> >   endforeach
> > endif
> >
> > We also need to define extra  compile_args  '-DNCURSES_WIDECHAR' as the
> > part of dependencies.
>
> You can do that with #define before including <curses.h>.
Yeap, but the  -DNCURSES_WIDECHAR not only used for testing compile of
#include<curses.h> but also
as a dependencies of qemu.
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

--0000000000003c3da405b0c0eebd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Sat, Oct 3, 2020 at 4:43 PM Paolo Bonzini &lt;<=
a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<br=
>&gt;<br>&gt; On 03/10/20 10:29, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) =
wrote:<br>&gt; &gt; For some meson script like this:<br>&gt; &gt; curses =
=3D not_found<br>&gt; &gt; if iconv.found() and not get_option(&#39;curses&=
#39;).disabled()<br>&gt; &gt; =C2=A0 curses_libname_list =3D [&#39;ncursesw=
&#39;, &#39;ncurses&#39;, &#39;cursesw&#39;, &#39;pdcurses&#39;]<br>&gt; &g=
t; =C2=A0 curses_test =3D &#39;&#39;&#39;<br>&gt; &gt; =C2=A0 =C2=A0 #inclu=
de &lt;locale.h&gt;<br>&gt; &gt; =C2=A0 =C2=A0 #include &lt;curses.h&gt;<br=
>&gt; &gt; =C2=A0 =C2=A0 #include &lt;wchar.h&gt;<br>&gt; &gt; =C2=A0 =C2=
=A0 int main(void) {<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 wchar_t wch =3D L&#3=
9;w&#39;;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 setlocale(LC_ALL, &quot;&quot;)=
;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 resize_term(0, 0);<br>&gt; &gt; =C2=A0 =
=C2=A0 =C2=A0 addwstr(L&quot;wide chars\n&quot;);<br>&gt; &gt; =C2=A0 =C2=
=A0 =C2=A0 addnwstr(&amp;wch, 1);<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 add_wch=
(WACS_DEGREE);<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 return 0;<br>&gt; &gt; =C2=
=A0 =C2=A0 }&#39;&#39;&#39;<br>&gt; &gt; =C2=A0 foreach curses_libname : cu=
rses_libname_list<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 libcurses =3D dependenc=
y(curses_libname,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0required: fal=
se,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0method: &#39;pkg-config&#39=
;,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0static: enable_static)<br>&gt;=
 &gt;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 if not libcurses.found()<br>&gt; &g=
t; =C2=A0 =C2=A0 =C2=A0 =C2=A0 dirs =3D [&#39;/usr/include/ncursesw&#39;]<b=
r>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if targetos =3D=3D &#39;windows&#39=
;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dirs =3D []<br>&gt; &gt; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 endif<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
libcurses =3D cc.find_library(curses_libname,<br>&gt; &gt; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 required: false,<br>&gt; &gt; =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dirs: dirs,<br>&gt; &gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 static: enable_static)<br>=
&gt; &gt; =C2=A0 =C2=A0 =C2=A0 endif<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 if l=
ibcurses.found()<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if cc.links(curse=
s_test, dependencies: [libcurses])<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 curses =3D declare_dependency(compile_args:<br>&gt; &gt; &#39;-DNCU=
RSES_WIDECHAR&#39;, dependencies: [libcurses])<br>&gt; &gt; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 break<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 endif<b=
r>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 endif<br>&gt; &gt; =C2=A0 endforeach<br>&g=
t; &gt; endif<br>&gt; &gt;<br>&gt; &gt; We also need to define extra =C2=A0=
compile_args =C2=A0&#39;-DNCURSES_WIDECHAR&#39; as the<br>&gt; &gt; part of=
 dependencies.<br>&gt;<br>&gt; You can do that with #define before includin=
g &lt;curses.h&gt;.<div>Yeap, but the=C2=A0

-DNCURSES_WIDECHAR not only used for testing compile of #include&lt;curses.=
h&gt; but also</div><div>as a dependencies of qemu.<br>&gt;<br>&gt; Paolo<b=
r>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=
=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 s=
incerely,<br>Yonggang Luo</div></div>

--0000000000003c3da405b0c0eebd--

