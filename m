Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F82C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 19:59:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73BDE222B8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 19:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsdXkKr5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73BDE222B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUbJs-0004XZ-GY
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 15:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kUbJ2-00044J-2f
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 15:58:56 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:36176)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kUbIz-0008My-70
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 15:58:55 -0400
Received: by mail-lf1-x144.google.com with SMTP id h6so1135437lfj.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 12:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=Ti5bXqAaeOHEKBkJq4+6OE/refCQsKQw6YzschOQsCU=;
 b=YsdXkKr5BH9iHCcSjDHtGqThkE9arBf2aVNSLpniX5zp2H0gQbqogLYCusb4esNIpJ
 QjaVqzdEXRAFzdh3VQjEYJK5sIZXOvUfOsdhhoh3W/yZ4SQb30DaILrwXvV/lng/cqxd
 AvUmGkbbDVddEZyvCqNAms4diYYogorOB+VAQnOtXuyeJZ8709JHAA7HTwPwkp/oml2i
 nmyPU8XWfkiQNNHAts9jDOZl7Byxy/eFxvaWRSJygzHGK74CV4KPlEwzSUpZz5PXPr5g
 inHyFxmAuO5m3exeSR7GdC2hM4MllwUhyM7az6KaySWKN/2t4oUiWDDzq1/vM29z7vJ/
 SlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=Ti5bXqAaeOHEKBkJq4+6OE/refCQsKQw6YzschOQsCU=;
 b=rDOrSXoQjMOX9jz8wVyTPTAEHdzI3sjIbYtmY3TYS5GwgLaDqvJsIEPBYgxQmpnvpI
 /OH5GhBdJ8M9YojqBAOO0Am7/At/z4RHUbhCD7BEPhvkBLKyCHbGMQZNN8JOH0Alogv2
 j2eH6+bCnNyh3qWC/7vKlO31yGJFSYR7M116uuCBqNUBWre9EKoB2XzjtXa41mDts8KM
 wUEMrvuZuXrN/+zX54/sKemwgSAhoviz9z7AgmrcqZRhCSii2GVtEdhtXCBIaQXNL1Fx
 dk+vhMhjyy4htvrK04Xa43crQvTRyBrVm9hmXTuKBzMXzR/u4ETNOa3RddRjm/vlW2t/
 Ic7Q==
X-Gm-Message-State: AOAM533lPTqMBX3oyYmwz60tbS8Kzg3BmOoQc2FmzAQBQ00hy+gI8SpU
 Kz77hyjgXp/MsXRMze9oIxR/L8fHOdS2UFCYTfw=
X-Google-Smtp-Source: ABdhPJzu6O3QP7HfW37nWDNM290GocUosceIdS+bqmLUa9ERetSvAwIEfdJZ4i9sG2qXT3IOvKJwE7PM45PmKpP/JUk=
X-Received: by 2002:ac2:54ab:: with SMTP id w11mr412446lfk.50.1603137530180;
 Mon, 19 Oct 2020 12:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <20201019094534.1713842-1-pbonzini@redhat.com>
In-Reply-To: <20201019094534.1713842-1-pbonzini@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 20 Oct 2020 03:58:38 +0800
Message-ID: <CAE2XoE9YRWK64D8w605cwmp+bdNRMYui25mx677pLBmFxxaqXQ@mail.gmail.com>
Subject: Re: [PATCH] meson: rewrite curses/iconv test
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000338d905b20b8b87"
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
Cc: qemu-level <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000338d905b20b8b87
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2020 at 5:45 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Redo the curses test to do the same tests that the configure
> check used to do.  OpenBSD triggers the warning because
> it does not support NCURSES_WIDECHAR and thus the cc.links
> test fails.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build | 109 +++++++++++++++++++++++++++++-----------------------
>  1 file changed, 60 insertions(+), 49 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 05fb59a00b..d1155aea65 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -463,6 +463,59 @@ endif
>  iconv =3D not_found
>  curses =3D not_found
>  if have_system and not get_option('curses').disabled()
> +  curses_test =3D '''
> +    #include <locale.h>
> +    #include <curses.h>
> +    #include <wchar.h>
> +    int main(void) {
> +      wchar_t wch =3D L'w';
> +      setlocale(LC_ALL, "");
> +      resize_term(0, 0);
> +      addwstr(L"wide chars\n");
> +      addnwstr(&wch, 1);
> +      add_wch(WACS_DEGREE);
> +      return 0;
> +    }'''
> +
> +  curses =3D dependency((targetos =3D=3D 'windows' ? 'ncurses' : 'ncurse=
sw'),
> +                      required: false,
> +                      method: 'pkg-config',
> +                      static: enable_static)
> +  msg =3D get_option('curses').enabled() ? 'curses library not found' : =
''
> +  if curses.found()
> +    if cc.links(curses_test, dependencies: [curses])
> +      curses =3D declare_dependency(compile_args: '-DNCURSES_WIDECHAR',
dependencies: [curses])
> +    else
> +      msg =3D 'curses package not usable'
> +      curses =3D not_found
> +    endif
> +  endif
> +  if not curses.found()
> +    curses_compile_args =3D ['-DNCURSES_WIDECHAR']

Here is what I think need improve in meson, when declare dependencies, we
need a extra option compile_args
for easily testing extra compile args, and maybe also need link_args, and
after suceed, these flags should as a
part of the dependencies.

> +    has_curses_h =3D cc.has_header('curses.h', args: curses_compile_args=
)
> +    if targetos !=3D 'windows' and not has_curses_h
> +      message('Trying with /usr/include/ncursesw')
> +      curses_compile_args +=3D ['-I/usr/include/ncursesw']
> +      has_curses_h =3D cc.has_header('curses.h', args: curses_compile_ar=
gs)
> +    endif
> +    if has_curses_h
> +      curses_libname_list =3D (targetos =3D=3D 'windows' ? ['pdcurses'] =
:
['ncursesw', 'cursesw'])
> +      foreach curses_libname : curses_libname_list
> +        libcurses =3D cc.find_library(curses_libname,
> +                                    required: false,
> +                                    static: enable_static)
> +        if libcurses.found()
> +          if cc.links(curses_test, args: curses_compile_args,
dependencies: libcurses)
> +            curses =3D declare_dependency(compile_args:
curses_compile_args,
> +                                        dependencies: [libcurses])
> +            break
> +          else
> +            msg =3D 'curses library not usable'
> +          endif
> +        endif
> +      endforeach
> +    endif
> +  endif
>    if not get_option('iconv').disabled()
>      libiconv =3D cc.find_library('iconv',
>                                 required: false,
> @@ -476,57 +529,15 @@ if have_system and not
get_option('curses').disabled()
>        iconv =3D declare_dependency(dependencies: [libiconv])
>      endif
>    endif
> -  if get_option('iconv').enabled() and not iconv.found()
> -    error('Cannot detect iconv API')
> +  if curses.found() and not iconv.found()
> +    msg =3D 'iconv required for curses UI but not available'
> +    curses =3D not_found
>    endif
> -  if iconv.found()
> -    curses_libname_list =3D ['ncursesw', 'ncurses', 'cursesw', 'pdcurses=
']
> -    curses_test =3D '''
> -      #include <locale.h>
> -      #include <curses.h>
> -      #include <wchar.h>
> -      int main(void) {
> -        wchar_t wch =3D L'w';
> -        setlocale(LC_ALL, "");
> -        resize_term(0, 0);
> -        addwstr(L"wide chars\n");
> -        addnwstr(&wch, 1);
> -        add_wch(WACS_DEGREE);
> -        return 0;
> -      }'''
> -    foreach curses_libname : curses_libname_list
> -      libcurses =3D dependency(curses_libname,
> -                             required: false,
> -                             method: 'pkg-config',
> -                             static: enable_static)
> -
> -      if not libcurses.found()
> -        dirs =3D ['/usr/include/ncursesw']
> -        if targetos =3D=3D 'windows'
> -          dirs =3D []
> -        endif
> -        libcurses =3D cc.find_library(curses_libname,
> -                                    required: false,
> -                                    dirs: dirs,
> -                                    static: enable_static)
> -      endif
> -      if libcurses.found()
> -        if cc.links(curses_test, dependencies: [libcurses])
> -          curses =3D declare_dependency(compile_args:
'-DNCURSES_WIDECHAR', dependencies: [libcurses])
> -          break
> -        endif
> -      endif
> -    endforeach
> -  endif
> -  if not curses.found()
> -    if iconv.found()
> -      if get_option('curses').enabled()
> -        error('Cannot find curses')
> -      endif
> -    elif get_option('curses').enabled()
> -      error('iconv required for curses UI but not available')
> +  if not curses.found() and msg !=3D ''
> +    if get_option('curses').enabled()
> +      error(msg)
>      else
> -      warning('iconv required for curses UI but not available,
disabling')
> +      warning(msg + ', disabling')
>      endif
>    endif
>  endif
> --
> 2.26.2
>

Reviewed-by: Yonggang Luo <l <f4bug@amsat.org>uoyonggang@gmail.com>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000000338d905b20b8b87
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Mon, Oct 19, 2020 at 5:45 PM Paolo Bonzini &lt;=
<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<b=
r>&gt;<br>&gt; Redo the curses test to do the same tests that the configure=
<br>&gt; check used to do.=C2=A0 OpenBSD triggers the warning because<br>&g=
t; it does not support NCURSES_WIDECHAR and thus the cc.links<br>&gt; test =
fails.<br>&gt;<br>&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:p=
bonzini@redhat.com">pbonzini@redhat.com</a>&gt;<br>&gt; ---<br>&gt; =C2=A0m=
eson.build | 109 +++++++++++++++++++++++++++++-----------------------<br>&g=
t; =C2=A01 file changed, 60 insertions(+), 49 deletions(-)<br>&gt;<br>&gt; =
diff --git a/meson.build b/meson.build<br>&gt; index 05fb59a00b..d1155aea65=
 100644<br>&gt; --- a/meson.build<br>&gt; +++ b/meson.build<br>&gt; @@ -463=
,6 +463,59 @@ endif<br>&gt; =C2=A0iconv =3D not_found<br>&gt; =C2=A0curses =
=3D not_found<br>&gt; =C2=A0if have_system and not get_option(&#39;curses&#=
39;).disabled()<br>&gt; + =C2=A0curses_test =3D &#39;&#39;&#39;<br>&gt; + =
=C2=A0 =C2=A0#include &lt;locale.h&gt;<br>&gt; + =C2=A0 =C2=A0#include &lt;=
curses.h&gt;<br>&gt; + =C2=A0 =C2=A0#include &lt;wchar.h&gt;<br>&gt; + =C2=
=A0 =C2=A0int main(void) {<br>&gt; + =C2=A0 =C2=A0 =C2=A0wchar_t wch =3D L&=
#39;w&#39;;<br>&gt; + =C2=A0 =C2=A0 =C2=A0setlocale(LC_ALL, &quot;&quot;);<=
br>&gt; + =C2=A0 =C2=A0 =C2=A0resize_term(0, 0);<br>&gt; + =C2=A0 =C2=A0 =
=C2=A0addwstr(L&quot;wide chars\n&quot;);<br>&gt; + =C2=A0 =C2=A0 =C2=A0add=
nwstr(&amp;wch, 1);<br>&gt; + =C2=A0 =C2=A0 =C2=A0add_wch(WACS_DEGREE);<br>=
&gt; + =C2=A0 =C2=A0 =C2=A0return 0;<br>&gt; + =C2=A0 =C2=A0}&#39;&#39;&#39=
;<br>&gt; +<br>&gt; + =C2=A0curses =3D dependency((targetos =3D=3D &#39;win=
dows&#39; ? &#39;ncurses&#39; : &#39;ncursesw&#39;),<br>&gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0required:=
 false,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0method: &#39;pkg-config&#39;,<br>&gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0static: enabl=
e_static)<br>&gt; + =C2=A0msg =3D get_option(&#39;curses&#39;).enabled() ? =
&#39;curses library not found&#39; : &#39;&#39;<br>&gt; + =C2=A0if curses.f=
ound()<br>&gt; + =C2=A0 =C2=A0if cc.links(curses_test, dependencies: [curse=
s])<br>&gt; + =C2=A0 =C2=A0 =C2=A0curses =3D declare_dependency(compile_arg=
s: &#39;-DNCURSES_WIDECHAR&#39;, dependencies: [curses])<br>&gt; + =C2=A0 =
=C2=A0else<br>&gt; + =C2=A0 =C2=A0 =C2=A0msg =3D &#39;curses package not us=
able&#39;<br>&gt; + =C2=A0 =C2=A0 =C2=A0curses =3D not_found<br>&gt; + =C2=
=A0 =C2=A0endif<br>&gt; + =C2=A0endif<br>&gt; + =C2=A0if not curses.found()=
<br>&gt; + =C2=A0 =C2=A0curses_compile_args =3D [&#39;-DNCURSES_WIDECHAR&#3=
9;]<div><br></div><div>Here is what I think need improve in meson, when dec=
lare dependencies, we need a extra option compile_args</div><div>for easily=
 testing extra compile args, and maybe also need link_args, and after sucee=
d, these flags should as a=C2=A0</div><div>part of the dependencies.</div><=
div><br>&gt; + =C2=A0 =C2=A0has_curses_h =3D cc.has_header(&#39;curses.h&#3=
9;, args: curses_compile_args)<br>&gt; + =C2=A0 =C2=A0if targetos !=3D &#39=
;windows&#39; and not has_curses_h<br>&gt; + =C2=A0 =C2=A0 =C2=A0message(&#=
39;Trying with /usr/include/ncursesw&#39;)<br>&gt; + =C2=A0 =C2=A0 =C2=A0cu=
rses_compile_args +=3D [&#39;-I/usr/include/ncursesw&#39;]<br>&gt; + =C2=A0=
 =C2=A0 =C2=A0has_curses_h =3D cc.has_header(&#39;curses.h&#39;, args: curs=
es_compile_args)<br>&gt; + =C2=A0 =C2=A0endif<br>&gt; + =C2=A0 =C2=A0if has=
_curses_h<br>&gt; + =C2=A0 =C2=A0 =C2=A0curses_libname_list =3D (targetos =
=3D=3D &#39;windows&#39; ? [&#39;pdcurses&#39;] : [&#39;ncursesw&#39;, &#39=
;cursesw&#39;])<br>&gt; + =C2=A0 =C2=A0 =C2=A0foreach curses_libname : curs=
es_libname_list<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0libcurses =3D cc.find_=
library(curses_libname,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0required: false,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0static: enable_static)<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0if=
 libcurses.found()<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if cc.links(=
curses_test, args: curses_compile_args, dependencies: libcurses)<br>&gt; + =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0curses =3D declare_dependency(comp=
ile_args: curses_compile_args,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dependencies: [libcurses])<br>&gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0else<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg =3D &=
#39;curses library not usable&#39;<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0endif<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0endif<br>&gt; + =C2=A0 =C2=
=A0 =C2=A0endforeach<br>&gt; + =C2=A0 =C2=A0endif<br>&gt; + =C2=A0endif<br>=
&gt; =C2=A0 =C2=A0if not get_option(&#39;iconv&#39;).disabled()<br>&gt; =C2=
=A0 =C2=A0 =C2=A0libiconv =3D cc.find_library(&#39;iconv&#39;,<br>&gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 required: false,<br>&gt; @@ -476,57 +529=
,15 @@ if have_system and not get_option(&#39;curses&#39;).disabled()<br>&g=
t; =C2=A0 =C2=A0 =C2=A0 =C2=A0iconv =3D declare_dependency(dependencies: [l=
ibiconv])<br>&gt; =C2=A0 =C2=A0 =C2=A0endif<br>&gt; =C2=A0 =C2=A0endif<br>&=
gt; - =C2=A0if get_option(&#39;iconv&#39;).enabled() and not iconv.found()<=
br>&gt; - =C2=A0 =C2=A0error(&#39;Cannot detect iconv API&#39;)<br>&gt; + =
=C2=A0if curses.found() and not iconv.found()<br>&gt; + =C2=A0 =C2=A0msg =
=3D &#39;iconv required for curses UI but not available&#39;<br>&gt; + =C2=
=A0 =C2=A0curses =3D not_found<br>&gt; =C2=A0 =C2=A0endif<br>&gt; - =C2=A0i=
f iconv.found()<br>&gt; - =C2=A0 =C2=A0curses_libname_list =3D [&#39;ncurse=
sw&#39;, &#39;ncurses&#39;, &#39;cursesw&#39;, &#39;pdcurses&#39;]<br>&gt; =
- =C2=A0 =C2=A0curses_test =3D &#39;&#39;&#39;<br>&gt; - =C2=A0 =C2=A0 =C2=
=A0#include &lt;locale.h&gt;<br>&gt; - =C2=A0 =C2=A0 =C2=A0#include &lt;cur=
ses.h&gt;<br>&gt; - =C2=A0 =C2=A0 =C2=A0#include &lt;wchar.h&gt;<br>&gt; - =
=C2=A0 =C2=A0 =C2=A0int main(void) {<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0w=
char_t wch =3D L&#39;w&#39;;<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0setlocale=
(LC_ALL, &quot;&quot;);<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0resize_term(0,=
 0);<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0addwstr(L&quot;wide chars\n&quot;=
);<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0addnwstr(&amp;wch, 1);<br>&gt; - =
=C2=A0 =C2=A0 =C2=A0 =C2=A0add_wch(WACS_DEGREE);<br>&gt; - =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return 0;<br>&gt; - =C2=A0 =C2=A0 =C2=A0}&#39;&#39;&#39;<br>&g=
t; - =C2=A0 =C2=A0foreach curses_libname : curses_libname_list<br>&gt; - =
=C2=A0 =C2=A0 =C2=A0libcurses =3D dependency(curses_libname,<br>&gt; - =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 required: false,<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 meth=
od: &#39;pkg-config&#39;,<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 static: enable_=
static)<br>&gt; -<br>&gt; - =C2=A0 =C2=A0 =C2=A0if not libcurses.found()<br=
>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0dirs =3D [&#39;/usr/include/ncursesw&#39=
;]<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0if targetos =3D=3D &#39;windows&#39=
;<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dirs =3D []<br>&gt; - =C2=A0 =
=C2=A0 =C2=A0 =C2=A0endif<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0libcurses =
=3D cc.find_library(curses_libname,<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0required: false,<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0dirs: dirs,<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0static: enable_static)<br>&gt; - =C2=A0 =C2=A0 =
=C2=A0endif<br>&gt; - =C2=A0 =C2=A0 =C2=A0if libcurses.found()<br>&gt; - =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if cc.links(curses_test, dependencies: [libcurse=
s])<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0curses =3D declare_dependen=
cy(compile_args: &#39;-DNCURSES_WIDECHAR&#39;, dependencies: [libcurses])<b=
r>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break<br>&gt; - =C2=A0 =C2=A0 =
=C2=A0 =C2=A0endif<br>&gt; - =C2=A0 =C2=A0 =C2=A0endif<br>&gt; - =C2=A0 =C2=
=A0endforeach<br>&gt; - =C2=A0endif<br>&gt; - =C2=A0if not curses.found()<b=
r>&gt; - =C2=A0 =C2=A0if iconv.found()<br>&gt; - =C2=A0 =C2=A0 =C2=A0if get=
_option(&#39;curses&#39;).enabled()<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0er=
ror(&#39;Cannot find curses&#39;)<br>&gt; - =C2=A0 =C2=A0 =C2=A0endif<br>&g=
t; - =C2=A0 =C2=A0elif get_option(&#39;curses&#39;).enabled()<br>&gt; - =C2=
=A0 =C2=A0 =C2=A0error(&#39;iconv required for curses UI but not available&=
#39;)<br>&gt; + =C2=A0if not curses.found() and msg !=3D &#39;&#39;<br>&gt;=
 + =C2=A0 =C2=A0if get_option(&#39;curses&#39;).enabled()<br>&gt; + =C2=A0 =
=C2=A0 =C2=A0error(msg)<br>&gt; =C2=A0 =C2=A0 =C2=A0else<br>&gt; - =C2=A0 =
=C2=A0 =C2=A0warning(&#39;iconv required for curses UI but not available, d=
isabling&#39;)<br>&gt; + =C2=A0 =C2=A0 =C2=A0warning(msg + &#39;, disabling=
&#39;)<br>&gt; =C2=A0 =C2=A0 =C2=A0endif<br>&gt; =C2=A0 =C2=A0endif<br>&gt;=
 =C2=A0endif<br>&gt; --<br>&gt; 2.26.2<br>&gt;</div><div></div><div><br></d=
iv><div>Reviewed-by: Yonggang Luo &lt;<a href=3D"mailto:f4bug@amsat.org" ta=
rget=3D"_blank">l</a><a href=3D"mailto:uoyonggang@gmail.com">uoyonggang@gma=
il.com</a>&gt;</div><div><br class=3D"gmail-Apple-interchange-newline"><br>=
--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=
=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggan=
g Luo</div></div>

--0000000000000338d905b20b8b87--

