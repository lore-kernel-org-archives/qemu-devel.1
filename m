Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCE1C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 16:48:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19A7C2074A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 16:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpZPsioX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A7C2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTpNQ-0003WG-6z
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 12:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTpMR-00034s-Ns
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 12:47:15 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131]:41851)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTpMP-0004jl-DM
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 12:47:15 -0400
Received: by mail-lf1-x131.google.com with SMTP id d24so7309618lfa.8
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 09:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=PA82ky01KBl/hHsyobJkiyHAKGuS/CEsJ5FmCxQG9hY=;
 b=jpZPsioXu8eDcmueXfy+0weputO+s8YL6DLw49R507FcEX6Gc0FZf/DA+kITJr+FCX
 0a//x62LRfMLuR+GSLv2zFypiB1FfSFdpNPgE61tgkEgvEaK5XIEfOuoaRWUXhL2rbV8
 Qet4cr0J5kAfTIN2BKDuLFjtMR9DSnkv1Lt01tZkS4oJqtfG3Z5gEEr4u+bB3WAWxQzj
 NHVHwTb/Qmd3lKU3ruZEu3xWOXunA44R/d+QP66zh+dcQXK7IJBRYamZVsPxZc6oh1Ou
 PCYnIiZZPbdHMEHiRYQAtW9f4SXjkTmvh1C5k7WMCGbooAudNr7ckpmPguAJFkgIiPZa
 MC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=PA82ky01KBl/hHsyobJkiyHAKGuS/CEsJ5FmCxQG9hY=;
 b=D622ZeqBKaHwuVQjO1edQ87VhdFQSxLYhuIKLcLMrj13tqAVy0FLJM60GZTk1y6XiI
 04XJ6TJvIdMG8+xYdkZQhN4g56voc32NCHPpQg2y2xtvy2klmB3bDncJxvuwWNXba9vJ
 aMU82hHD37t1pbpUgneL7qmp3Zffwg6vCKw16wrbCpCUu7vZPFV54QqxZIPhmnpPus6o
 cJ51xN6WZTiux7rGAvDEwlp8iJbe8aZT9ahwvee+wfr71f9fdKSizoCgKFHrrePdve3q
 7BAvQiHoiGBu5fY5ezk1HlU9iAP78DvPh5TPDQ8Ag0w+X1zgsdG06p481RFDG8GJ9TlZ
 4uqg==
X-Gm-Message-State: AOAM533AtIpD+P7Mqz+EAeP839SYhGbG27fn83L0MNwgtAjbDGuYT8CU
 FRaE3gOLyxX3wah5SlLsO0mhmI4tXxchIIhv1K1Gu5ryEbAgvg==
X-Google-Smtp-Source: ABdhPJxm5dd1TMDx0c+kFBy7XWloF7XB+ykNnMNMI3sXYJcQBQl7eiXf3YWtNRQA02XVrjj2i28KQNnOjMo9n+4oDVA=
X-Received: by 2002:ac2:4ed0:: with SMTP id p16mr3120704lfr.554.1602953230385; 
 Sat, 17 Oct 2020 09:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201017164329.1634-1-luoyonggang@gmail.com>
In-Reply-To: <20201017164329.1634-1-luoyonggang@gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sun, 18 Oct 2020 00:46:59 +0800
Message-ID: <CAE2XoE-XCJR_M-K8Xft1CJOD0r=0U=zV-67wOy4+OqQNmncj5w@mail.gmail.com>
Subject: Re: [PATCH v11] scripts: Convert qemu-version.sh to qemu-version.py
To: qemu-level <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000e388b005b1e0a1db"
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x131.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e388b005b1e0a1db
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2020 at 12:43 AM Yonggang Luo <luoyonggang@gmail.com> wrote=
:
>
> The sh script are harder to maintain for compatible different
> xsh environment so convert it to python script
> Also incorporate the fixes in
>
https://patchew.org/QEMU/20200929143654.518157-1-marcandre.lureau@redhat.co=
m/
>
> According to https://github.com/msys2/MSYS2-packages/issues/2176
> We need use CYGWIN=3Dnoglob and MSYS=3Dnoglob in the environment variable
> for disable wildcard expanding in msys or cygwin git, and setting the
shell=3DFalse
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> Message-Id: <20201006112139.700-1-luoyonggang@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build             |  2 +-
>  scripts/qemu-version.py | 37 +++++++++++++++++++++++++++++++++++++
>  scripts/qemu-version.sh | 25 -------------------------
>  3 files changed, 38 insertions(+), 26 deletions(-)
>  create mode 100644 scripts/qemu-version.py
>  delete mode 100755 scripts/qemu-version.sh
>
> diff --git a/meson.build b/meson.build
> index 05fb59a00b..b100b6d7be 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1240,7 +1240,7 @@ tracetool =3D [
>     '--backend=3D' + config_host['TRACE_BACKENDS']
>  ]
>
> -qemu_version_cmd =3D [find_program('scripts/qemu-version.sh'),
> +qemu_version_cmd =3D [find_program('scripts/qemu-version.py'),
>                      meson.current_source_dir(),
>                      config_host['PKGVERSION'], meson.project_version()]
>  qemu_version =3D custom_target('qemu-version.h',
> diff --git a/scripts/qemu-version.py b/scripts/qemu-version.py
> new file mode 100644
> index 0000000000..cf97b2bbb5
> --- /dev/null
> +++ b/scripts/qemu-version.py
> @@ -0,0 +1,37 @@
> +#!/usr/bin/env python3
> +
> +#
> +# Script for retrieve qemu git version information
> +#
> +# Authors:
> +#  Yonggang Luo <luoyonggang@gmail.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2
> +# or, at your option, any later version.  See the COPYING file in
> +# the top-level directory.
> +
> +import sys
> +import subprocess
> +import os
> +import os.path
> +
> +def main(_program, dir, pkgversion, version, *unused):
> +    os.chdir(dir)
> +    if not pkgversion and os.path.exists('.git'):
> +        pc =3D subprocess.run(
> +            ['git', 'describe', '--match', 'v*', '--dirty', '--always'],
> +            env=3Ddict(os.environ, CYGWIN=3D"noglob", MSYS=3D'noglob'),
Sorry for disturb, under msys2,  use   env=3Ddict(os.environ,
CYGWIN=3D"noglob", MSYS=3D'noglob') we make sure
'v*=E2=80=98 are passed into git without wildcard. So I send this patch aga=
in for
fixes this issue
> +            stdout=3Dsubprocess.PIPE, stderr=3Dsubprocess.DEVNULL,
> +            encoding=3D'utf8', shell=3DFalse)
> +        if pc.returncode =3D=3D 0:
> +            pkgversion =3D pc.stdout.strip()
> +
> +    fullversion =3D version
> +    if pkgversion:
> +        fullversion =3D "{} ({})".format(version, pkgversion)
> +
> +    print('#define QEMU_PKGVERSION "%s"' % pkgversion)
> +    print('#define QEMU_FULL_VERSION "%s"' % fullversion)
> +
> +if __name__ =3D=3D "__main__":
> +    main(*sys.argv)
> diff --git a/scripts/qemu-version.sh b/scripts/qemu-version.sh
> deleted file mode 100755
> index 3f6e7e6d41..0000000000
> --- a/scripts/qemu-version.sh
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -#!/bin/sh
> -
> -set -eu
> -
> -dir=3D"$1"
> -pkgversion=3D"$2"
> -version=3D"$3"
> -
> -if [ -z "$pkgversion" ]; then
> -    cd "$dir"
> -    if [ -e .git ]; then
> -        pkgversion=3D$(git describe --match 'v*' --dirty) || :
> -    fi
> -fi
> -
> -if [ -n "$pkgversion" ]; then
> -    fullversion=3D"$version ($pkgversion)"
> -else
> -    fullversion=3D"$version"
> -fi
> -
> -cat <<EOF
> -#define QEMU_PKGVERSION "$pkgversion"
> -#define QEMU_FULL_VERSION "$fullversion"
> -EOF
> --
> 2.28.0.windows.1
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000e388b005b1e0a1db
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Sun, Oct 18, 2020 at 12:43 AM Yonggang Luo &lt;=
<a href=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&gt; wrot=
e:<br>&gt;<br>&gt; The sh script are harder to maintain for compatible diff=
erent<br>&gt; xsh environment so convert it to python script<br>&gt; Also i=
ncorporate the fixes in<br>&gt; <a href=3D"https://patchew.org/QEMU/2020092=
9143654.518157-1-marcandre.lureau@redhat.com/">https://patchew.org/QEMU/202=
00929143654.518157-1-marcandre.lureau@redhat.com/</a><br>&gt;<br>&gt; Accor=
ding to <a href=3D"https://github.com/msys2/MSYS2-packages/issues/2176">htt=
ps://github.com/msys2/MSYS2-packages/issues/2176</a><br>&gt; We need use CY=
GWIN=3Dnoglob and MSYS=3Dnoglob in the environment variable<br>&gt; for dis=
able wildcard expanding in msys or cygwin git, and setting the shell=3DFals=
e<br>&gt;<br>&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyong=
gang@gmail.com">luoyonggang@gmail.com</a>&gt;<br>&gt; Message-Id: &lt;<a hr=
ef=3D"mailto:20201006112139.700-1-luoyonggang@gmail.com">20201006112139.700=
-1-luoyonggang@gmail.com</a>&gt;<br>&gt; Signed-off-by: Paolo Bonzini &lt;<=
a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt;<br>&gt; -=
--<br>&gt; =C2=A0meson.build =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
=C2=A02 +-<br>&gt; =C2=A0scripts/qemu-version.py | 37 +++++++++++++++++++++=
++++++++++++++++<br>&gt; =C2=A0scripts/qemu-version.sh | 25 ---------------=
----------<br>&gt; =C2=A03 files changed, 38 insertions(+), 26 deletions(-)=
<br>&gt; =C2=A0create mode 100644 scripts/qemu-version.py<br>&gt; =C2=A0del=
ete mode 100755 scripts/qemu-version.sh<br>&gt;<br>&gt; diff --git a/meson.=
build b/meson.build<br>&gt; index 05fb59a00b..b100b6d7be 100644<br>&gt; ---=
 a/meson.build<br>&gt; +++ b/meson.build<br>&gt; @@ -1240,7 +1240,7 @@ trac=
etool =3D [<br>&gt; =C2=A0 =C2=A0 &#39;--backend=3D&#39; + config_host[&#39=
;TRACE_BACKENDS&#39;]<br>&gt; =C2=A0]<br>&gt;<br>&gt; -qemu_version_cmd =3D=
 [find_program(&#39;scripts/qemu-version.sh&#39;),<br>&gt; +qemu_version_cm=
d =3D [find_program(&#39;scripts/qemu-version.py&#39;),<br>&gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0meson.cur=
rent_source_dir(),<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0config_host[&#39;PKGVERSION&#39;], meson.projec=
t_version()]<br>&gt; =C2=A0qemu_version =3D custom_target(&#39;qemu-version=
.h&#39;,<br>&gt; diff --git a/scripts/qemu-version.py b/scripts/qemu-versio=
n.py<br>&gt; new file mode 100644<br>&gt; index 0000000000..cf97b2bbb5<br>&=
gt; --- /dev/null<br>&gt; +++ b/scripts/qemu-version.py<br>&gt; @@ -0,0 +1,=
37 @@<br>&gt; +#!/usr/bin/env python3<br>&gt; +<br>&gt; +#<br>&gt; +# Scrip=
t for retrieve qemu git version information<br>&gt; +#<br>&gt; +# Authors:<=
br>&gt; +# =C2=A0Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com">=
luoyonggang@gmail.com</a>&gt;<br>&gt; +#<br>&gt; +# This work is licensed u=
nder the terms of the GNU GPL, version 2<br>&gt; +# or, at your option, any=
 later version.=C2=A0 See the COPYING file in<br>&gt; +# the top-level dire=
ctory.<br>&gt; +<br>&gt; +import sys<br>&gt; +import subprocess<br>&gt; +im=
port os<br>&gt; +import os.path<br>&gt; +<br>&gt; +def main(_program, dir, =
pkgversion, version, *unused):<br>&gt; + =C2=A0 =C2=A0os.chdir(dir)<br>&gt;=
 + =C2=A0 =C2=A0if not pkgversion and os.path.exists(&#39;.git&#39;):<br>&g=
t; + =C2=A0 =C2=A0 =C2=A0 =C2=A0pc =3D subprocess.run(<br>&gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[&#39;git&#39;, &#39;describe&#39;, &#39;--m=
atch&#39;, &#39;v*&#39;, &#39;--dirty&#39;, &#39;--always&#39;],<br>&gt; + =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env=3Ddict(os.environ, CYGWIN=3D&q=
uot;noglob&quot;, MSYS=3D&#39;noglob&#39;),<div>Sorry for disturb, under ms=
ys2,=C2=A0 use=C2=A0

=C2=A0env=3Ddict(os.environ, CYGWIN=3D&quot;noglob&quot;, MSYS=3D&#39;noglo=
b&#39;) we make sure</div><div>&#39;v*=E2=80=98 are passed into git without=
 wildcard. So I send this patch again for fixes this issue<br>&gt; + =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stdout=3Dsubprocess.PIPE, stderr=3Dsubpr=
ocess.DEVNULL,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0encoding=
=3D&#39;utf8&#39;, shell=3DFalse)<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0if p=
c.returncode =3D=3D 0:<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p=
kgversion =3D pc.stdout.strip()<br>&gt; +<br>&gt; + =C2=A0 =C2=A0fullversio=
n =3D version<br>&gt; + =C2=A0 =C2=A0if pkgversion:<br>&gt; + =C2=A0 =C2=A0=
 =C2=A0 =C2=A0fullversion =3D &quot;{} ({})&quot;.format(version, pkgversio=
n)<br>&gt; +<br>&gt; + =C2=A0 =C2=A0print(&#39;#define QEMU_PKGVERSION &quo=
t;%s&quot;&#39; % pkgversion)<br>&gt; + =C2=A0 =C2=A0print(&#39;#define QEM=
U_FULL_VERSION &quot;%s&quot;&#39; % fullversion)<br>&gt; +<br>&gt; +if __n=
ame__ =3D=3D &quot;__main__&quot;:<br>&gt; + =C2=A0 =C2=A0main(*sys.argv)<b=
r>&gt; diff --git a/scripts/qemu-version.sh b/scripts/qemu-version.sh<br>&g=
t; deleted file mode 100755<br>&gt; index 3f6e7e6d41..0000000000<br>&gt; --=
- a/scripts/qemu-version.sh<br>&gt; +++ /dev/null<br>&gt; @@ -1,25 +0,0 @@<=
br>&gt; -#!/bin/sh<br>&gt; -<br>&gt; -set -eu<br>&gt; -<br>&gt; -dir=3D&quo=
t;$1&quot;<br>&gt; -pkgversion=3D&quot;$2&quot;<br>&gt; -version=3D&quot;$3=
&quot;<br>&gt; -<br>&gt; -if [ -z &quot;$pkgversion&quot; ]; then<br>&gt; -=
 =C2=A0 =C2=A0cd &quot;$dir&quot;<br>&gt; - =C2=A0 =C2=A0if [ -e .git ]; th=
en<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0pkgversion=3D$(git describe --match=
 &#39;v*&#39; --dirty) || :<br>&gt; - =C2=A0 =C2=A0fi<br>&gt; -fi<br>&gt; -=
<br>&gt; -if [ -n &quot;$pkgversion&quot; ]; then<br>&gt; - =C2=A0 =C2=A0fu=
llversion=3D&quot;$version ($pkgversion)&quot;<br>&gt; -else<br>&gt; - =C2=
=A0 =C2=A0fullversion=3D&quot;$version&quot;<br>&gt; -fi<br>&gt; -<br>&gt; =
-cat &lt;&lt;EOF<br>&gt; -#define QEMU_PKGVERSION &quot;$pkgversion&quot;<b=
r>&gt; -#define QEMU_FULL_VERSION &quot;$fullversion&quot;<br>&gt; -EOF<br>=
&gt; --<br>&gt; 2.28.0.windows.1<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=
=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--000000000000e388b005b1e0a1db--

