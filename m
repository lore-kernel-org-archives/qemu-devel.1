Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F72C4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 08:31:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6316206CA
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 08:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gxhkawki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6316206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOcwr-00038I-SU
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 04:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kOcvi-0002bu-A7
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 04:30:11 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:46415)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kOcvf-0001nt-6H
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 04:30:10 -0400
Received: by mail-lf1-x144.google.com with SMTP id b22so4709820lfs.13
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 01:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=mpbq4+1BiPHRAqlukHo0ieFtAtZZh97DqXDDYN5cG/Y=;
 b=GxhkawkiO1/tK/ftfxbPaKUuPIp8TtKdEKWkzsu4FR7TiHSbUjTWfO7YIeNG+c9/sI
 pUv3qz4ANhIBRGkayLSQVd1WhH0a6gvprUcrxhg2SyXhmMrIvbsBDlPiW0dTN7Prbcor
 cYmsvHGOSCANiv3L+tp2UKkE9Pd0IVXKF/yv76M6CZI1vz9utIQ8CogiL3oRydT0CsKz
 39REsbpWh/w8j1j5OhrsaqFHzo3Hzg3vBvlRCzLMMBDuSSxF5F9TqPZH3R/aPlzZRdMZ
 sp5ChVj8cziKUkIqQEXvHbrU/f+p3U5ndpQgBgcPnXGYKDPqMvs1rBgvy3liHbe23VO8
 OnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=mpbq4+1BiPHRAqlukHo0ieFtAtZZh97DqXDDYN5cG/Y=;
 b=Tchd8zLfIm2k2+2t5EEMNQUUcnJEkbjYGMhxr4/N8IwaAXULFkYgtUn31D/KKRzCGn
 goFGZJv5SXcyTUTkd5oFisBWV+2yMU0yhvbyQjlD3GwUSwIuMrpXPlUqNcldyv+N14JC
 aXA1yEv+DDAHjvDMQyRFYRd4AAcyPpbfvi6Up7Y/ifBFMbg8Ep/j7MdUs0ECNRKSEHYA
 haUGGqmfjiliHRox7mKe+1IuTQtO58K9tNWOhSKWnnVUyn5tDICWgqLfBb+htp2jpjTl
 pgEu+G918TRiD0uoer31AuYvblP2QM2JLpW6iu8XmqD+TTh6vah6Zdnur1bbI7q6HaKj
 GnfQ==
X-Gm-Message-State: AOAM530A+OZPg3NjofqBwxuDSPI/C6uA2bksnLuOlCuFcKUKFtBiERKn
 NPTMiAYO/ilaR+o/B07ZQGqoUlGZQjJcrf0OwyI=
X-Google-Smtp-Source: ABdhPJzts7vWuN9E9xsdAcQLIXxzFY1f3zlhWDJ8eHmf9O2hsHxu8iZrLclcaLCATZkbxXfTPsJoO33e1rhk6InG5W8=
X-Received: by 2002:a19:674f:: with SMTP id e15mr1994639lfj.50.1601713804605; 
 Sat, 03 Oct 2020 01:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201002105239.2444-1-peter.maydell@linaro.org>
 <b1a6000a-c9a1-43fb-7646-b6ea87797b2e@redhat.com>
 <CAFEAcA9PbBByROzJ3+pfxycAoP-C5JnmfxQEt5jm6+3A3n2fbw@mail.gmail.com>
 <df5bd19c-da9d-d3b0-71a9-4deed67450bf@redhat.com>
 <CAFEAcA9M_BP9mnZHCLM93aYvMxrRHYFELQZ3FvsyH3hNvXtHDA@mail.gmail.com>
 <CAE2XoE-RnJ2j732JfxDA2A9O0Bp4KJ2rGG0LTjrDMKvRox-VBg@mail.gmail.com>
 <d6417044-324c-0bec-a05c-1142dcdc6003@redhat.com>
In-Reply-To: <d6417044-324c-0bec-a05c-1142dcdc6003@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sat, 3 Oct 2020 16:29:54 +0800
Message-ID: <CAE2XoE_4S6NpA7+TOuzwQ=TFjw5=rOe-_mrSkuJ4OEzUWK1X2A@mail.gmail.com>
Subject: Re: [PATCH] meson.build: Don't look for libudev for static builds
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005afc8a05b0c00e54"
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x144.google.com
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

--0000000000005afc8a05b0c00e54
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2020 at 3:50 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 03/10/20 09:24, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> >
> >
> > On Fri, Oct 2, 2020 at 9:11 PM Peter Maydell <peter.maydell@linaro.org
> > <mailto:peter.maydell@linaro.org>> wrote:
> >>
> >> On Fri, 2 Oct 2020 at 14:05, Paolo Bonzini <pbonzini@redhat.com
> > <mailto:pbonzini@redhat.com>> wrote:
> >> >
> >> > On 02/10/20 14:35, Peter Maydell wrote:
> >> > >
> >> > > It would be better to do the "see if a static library is present"
> >> > > test. This isn't too hard to do in configure (compare that
> >> > > six line fix to the detection of libgio). Hopefully it is
> >> > > not too hard to do in meson ?
> >> >
> >> > Yes, something like:
> >> >
> >> > if enable_static
> >> >   skeleton =3D 'int main(void) { return 0; }'
> >> >   if not cc.links(skeleton, dependencies: libudev)
> >> >     if get_option('mpath').enabled()
> >> >         error('Cannot link with libudev')
> >> >       else
> >> >         warning('Cannot link with libudev, disabling')
> >> >         libudev =3D not_found
> >> >       endif
> >> >     endif
> >> >   endif
> >> > endif
> >>
> >> This duplicates the information that the thing that depends
> >> on libudev is mpath. Can we put this in a wrapper around
> >> dependency() so that we could just say something like
> >>   libudev =3D compile_checked_dependency('libudev',
> >>                        required: get_option('mpath').enabled(),
> >>                        static: enable_static)
> >>
> > Hi Bonzini,
> > This looks like a frequently used function, can we upstrem to meson?
>
> Yes, I think adding a "links" argument to dependency (similar to
> find_library's has_headers argument) makes sense.  That would be written
>
>     dependency('libudev',
>                required: get_option('mpath').enabled(),
>                static: enable_static,
>                links: skeleton)
>
For some meson script like this:
curses =3D not_found
if iconv.found() and not get_option('curses').disabled()
  curses_libname_list =3D ['ncursesw', 'ncurses', 'cursesw', 'pdcurses']
  curses_test =3D '''
    #include <locale.h>
    #include <curses.h>
    #include <wchar.h>
    int main(void) {
      wchar_t wch =3D L'w';
      setlocale(LC_ALL, "");
      resize_term(0, 0);
      addwstr(L"wide chars\n");
      addnwstr(&wch, 1);
      add_wch(WACS_DEGREE);
      return 0;
    }'''
  foreach curses_libname : curses_libname_list
      libcurses =3D dependency(curses_libname,
                             required: false,
                             method: 'pkg-config',
                             static: enable_static)

      if not libcurses.found()
        dirs =3D ['/usr/include/ncursesw']
        if targetos =3D=3D 'windows'
          dirs =3D []
        endif
        libcurses =3D cc.find_library(curses_libname,
                                    required: false,
                                    dirs: dirs,
                                    static: enable_static)
      endif
      if libcurses.found()
        if cc.links(curses_test, dependencies: [libcurses])
          curses =3D declare_dependency(compile_args: '-DNCURSES_WIDECHAR',
dependencies: [libcurses])
          break
        endif
      endif
  endforeach
endif

We also need to define extra  compile_args  '-DNCURSES_WIDECHAR' as the
part of dependencies.

> But anyway that shouldn't be a blocker for more improvements to qemu's
> meson.build.  Now that we have 5-10 dependencies converted we have a
> clearer idea of how to abstract the tests.
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

--0000000000005afc8a05b0c00e54
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Sat, Oct 3, 2020 at 3:50 PM Paolo Bonzini &lt;<=
a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<br=
>&gt;<br>&gt; On 03/10/20 09:24, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) =
wrote:<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; On Fri, Oct 2, 2020 at 9:11 P=
M Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.mayde=
ll@linaro.org</a><br>&gt; &gt; &lt;mailto:<a href=3D"mailto:peter.maydell@l=
inaro.org">peter.maydell@linaro.org</a>&gt;&gt; wrote:<br>&gt; &gt;&gt;<br>=
&gt; &gt;&gt; On Fri, 2 Oct 2020 at 14:05, Paolo Bonzini &lt;<a href=3D"mai=
lto:pbonzini@redhat.com">pbonzini@redhat.com</a><br>&gt; &gt; &lt;mailto:<a=
 href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt;&gt; wrote:=
<br>&gt; &gt;&gt; &gt;<br>&gt; &gt;&gt; &gt; On 02/10/20 14:35, Peter Mayde=
ll wrote:<br>&gt; &gt;&gt; &gt; &gt;<br>&gt; &gt;&gt; &gt; &gt; It would be=
 better to do the &quot;see if a static library is present&quot;<br>&gt; &g=
t;&gt; &gt; &gt; test. This isn&#39;t too hard to do in configure (compare =
that<br>&gt; &gt;&gt; &gt; &gt; six line fix to the detection of libgio). H=
opefully it is<br>&gt; &gt;&gt; &gt; &gt; not too hard to do in meson ?<br>=
&gt; &gt;&gt; &gt;<br>&gt; &gt;&gt; &gt; Yes, something like:<br>&gt; &gt;&=
gt; &gt;<br>&gt; &gt;&gt; &gt; if enable_static<br>&gt; &gt;&gt; &gt; =C2=
=A0 skeleton =3D &#39;int main(void) { return 0; }&#39;<br>&gt; &gt;&gt; &g=
t; =C2=A0 if not cc.links(skeleton, dependencies: libudev)<br>&gt; &gt;&gt;=
 &gt; =C2=A0 =C2=A0 if get_option(&#39;mpath&#39;).enabled()<br>&gt; &gt;&g=
t; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 error(&#39;Cannot link with libudev&#39=
;)<br>&gt; &gt;&gt; &gt; =C2=A0 =C2=A0 =C2=A0 else<br>&gt; &gt;&gt; &gt; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 warning(&#39;Cannot link with libudev, disablin=
g&#39;)<br>&gt; &gt;&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 libudev =3D not_f=
ound<br>&gt; &gt;&gt; &gt; =C2=A0 =C2=A0 =C2=A0 endif<br>&gt; &gt;&gt; &gt;=
 =C2=A0 =C2=A0 endif<br>&gt; &gt;&gt; &gt; =C2=A0 endif<br>&gt; &gt;&gt; &g=
t; endif<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; This duplicates the information =
that the thing that depends<br>&gt; &gt;&gt; on libudev is mpath. Can we pu=
t this in a wrapper around<br>&gt; &gt;&gt; dependency() so that we could j=
ust say something like<br>&gt; &gt;&gt; =C2=A0 libudev =3D compile_checked_=
dependency(&#39;libudev&#39;,<br>&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0required: get_option=
(&#39;mpath&#39;).enabled(),<br>&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0static: enable_stati=
c)<br>&gt; &gt;&gt;<br>&gt; &gt; Hi Bonzini,<br>&gt; &gt; This looks like a=
 frequently used function, can we upstrem to meson?<br>&gt;<br>&gt; Yes, I =
think adding a &quot;links&quot; argument to dependency (similar to<br>&gt;=
 find_library&#39;s has_headers argument) makes sense.=C2=A0 That would be =
written<br>&gt;<br>&gt; =C2=A0 =C2=A0 dependency(&#39;libudev&#39;,<br>&gt;=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0required: get_optio=
n(&#39;mpath&#39;).enabled(),<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0static: enable_static,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0links: skeleton)<br>&gt;<div>For some meson =
script like this:</div><div>curses =3D not_found<br>if iconv.found() and no=
t get_option(&#39;curses&#39;).disabled()<br>=C2=A0 curses_libname_list =3D=
 [&#39;ncursesw&#39;, &#39;ncurses&#39;, &#39;cursesw&#39;, &#39;pdcurses&#=
39;]<br>=C2=A0 curses_test =3D &#39;&#39;&#39;<br>=C2=A0 =C2=A0 #include &l=
t;locale.h&gt;<br>=C2=A0 =C2=A0 #include &lt;curses.h&gt;<br>=C2=A0 =C2=A0 =
#include &lt;wchar.h&gt;<br>=C2=A0 =C2=A0 int main(void) {<br>=C2=A0 =C2=A0=
 =C2=A0 wchar_t wch =3D L&#39;w&#39;;<br>=C2=A0 =C2=A0 =C2=A0 setlocale(LC_=
ALL, &quot;&quot;);<br>=C2=A0 =C2=A0 =C2=A0 resize_term(0, 0);<br>=C2=A0 =
=C2=A0 =C2=A0 addwstr(L&quot;wide chars\n&quot;);<br>=C2=A0 =C2=A0 =C2=A0 a=
ddnwstr(&amp;wch, 1);<br>=C2=A0 =C2=A0 =C2=A0 add_wch(WACS_DEGREE);<br>=C2=
=A0 =C2=A0 =C2=A0 return 0;<br>=C2=A0 =C2=A0 }&#39;&#39;&#39;<br>=C2=A0 for=
each curses_libname : curses_libname_list<br>=C2=A0 =C2=A0 =C2=A0 libcurses=
 =3D dependency(curses_libname,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0required:=
 false,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0method: &#39;pkg-config&#39;,<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0static: enable_static)<br><br>=C2=A0 =C2=A0 =
=C2=A0 if not libcurses.found()<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 dirs =3D [&#=
39;/usr/include/ncursesw&#39;]<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if targetos =
=3D=3D &#39;windows&#39;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dirs =3D []<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 endif<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 libcurs=
es =3D cc.find_library(curses_libname,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 required: false,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 dirs: dirs,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 static: enable_static)<br>=C2=A0 =C2=A0 =C2=A0 endif<br>=C2=A0 =
=C2=A0 =C2=A0 if libcurses.found()<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if cc.lin=
ks(curses_test, dependencies: [libcurses])<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 curses =3D declare_dependency(compile_args: &#39;-DNCURSES_WIDECHAR&=
#39;, dependencies: [libcurses])<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 brea=
k<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 endif<br>=C2=A0 =C2=A0 =C2=A0 endif<br>=C2=
=A0 endforeach<br>endif<br></div><div><br></div><div>We also need to define=
 extra=C2=A0

compile_args=C2=A0

&#39;-DNCURSES_WIDECHAR&#39; as the part of dependencies.</div><div><br>&gt=
; But anyway that shouldn&#39;t be a blocker for more improvements to qemu&=
#39;s<br>&gt; meson.build.=C2=A0 Now that we have 5-10 dependencies convert=
ed we have a<br>&gt; clearer idea of how to abstract the tests.<br>&gt;<br>=
&gt; Paolo<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=
=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=
=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--0000000000005afc8a05b0c00e54--

