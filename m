Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22799C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 21:52:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FB2D20872
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 21:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skwHyqRb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB2D20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQHMV-0000ZE-9b
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 17:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQHLb-0008Cb-3Q; Wed, 07 Oct 2020 17:51:43 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:40300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQHLX-0003LN-Ds; Wed, 07 Oct 2020 17:51:42 -0400
Received: by mail-lj1-x241.google.com with SMTP id f21so3529723ljh.7;
 Wed, 07 Oct 2020 14:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=GL168ILH8ImCdhILc5N5qgCHgbZzeYI36cJ87SU4j7Y=;
 b=skwHyqRb028IqXHqd12cLxIjrHficYJgEnPVuu6wUUmH6ucdexcq4UXSczzEy+tlvY
 LOK0YSXA3s0zMOhY05lFWnGC5NHuVZuMThM0h0LjxbG0y3+ww//gPaqeSkUKHTayCB/H
 nVlxfyXQi+tzG0Z4MZKnj3mg+Opl/CMfOZhumMO8rXxeHmlEy0Ybu7YL8NllHWo03VRW
 QuRGLfciR6Vy4VM3EuGK3lm3SvtbC733lcQQl0GM11erJVWDCA/AybVd36ruW4Xbpc6O
 ZExJudRqDaUZBmvMULuvM1qkaaOSCv/fMtbH3WeBTcksklaxEZjJDUEzm9SZPKfSXgig
 c6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=GL168ILH8ImCdhILc5N5qgCHgbZzeYI36cJ87SU4j7Y=;
 b=NzJfTZ5iK/Fia066itsvfxKAbpf8L1vebIDUlMMTCQU67cDJzIxT3T+1akT5TvvWaX
 JSWPeTkVMvMnOx+/Gp7oA4GkkiPzpU5YESFFub97ehj7YJTNz1xvoQFXdN0Wcp1tJSHS
 yZYFJbH1brjJ4mf9w//f9qoNeXQZCsvxCisa2Umjh02kO65WTmEvfuTD6zjMAxQOgR0x
 EN75mXeLZTpFW4o52vG86DATI+d+fke9v/otLyrRaUUKdUogNwWfIO9GrJJxpjwX/Kbz
 fueAZCUJX/STTqM3oQDqM8vcI18UXeZq49hKAv9rgdJ3hXpc8UT6vCsYk9FTWDn1c094
 iIaQ==
X-Gm-Message-State: AOAM532c0BS0KdWXNuPY/bzgu0WrHbGEsaTDC2zL2d5yJE41S7KB6/bB
 j1ZvwkxxIkQNsG/D1FPa2SdAFwuY+EuyrHMC6x8=
X-Google-Smtp-Source: ABdhPJze65Jq8x+A8ZjoNfBX0BGD6JG5wtR+ciE05dJAdvMt/vcDPoHB6OxHQxW5us6+YBkv1rRIOr74GvSt6WzacVU=
X-Received: by 2002:a2e:9dc7:: with SMTP id x7mr2172876ljj.447.1602107497392; 
 Wed, 07 Oct 2020 14:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201007195934.297-1-luoyonggang@gmail.com>
 <CABgObfboc5-01TVBgLw-u8eKzR2QJkRYA5cTQ0wpx4SD2D92yw@mail.gmail.com>
In-Reply-To: <CABgObfboc5-01TVBgLw-u8eKzR2QJkRYA5cTQ0wpx4SD2D92yw@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 8 Oct 2020 05:51:25 +0800
Message-ID: <CAE2XoE8JV0G=3yK3HzMuXb19925p1J76rm2rVQH-OMhniPS8-g@mail.gmail.com>
Subject: Re: [PATCH v10] scripts: Convert qemu-version.sh to qemu-version.py
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000462fe905b11bb83d"
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000462fe905b11bb83d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2020 at 4:31 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> You won't hear no for an answer, right?...
I am trying to figure out the real issue, it's the issue of git,
https://github.com/msys2/MSYS2-packages/issues/2176

The windows wildcard can be disabled and git disabled it, didn't know
what's happened to
the msys's git, but git-for-windows are works fine.

>
> Paolo
>
>
> Il mer 7 ott 2020, 22:00 Yonggang Luo <luoyonggang@gmail.com> ha scritto:
>>
>> The sh script are harder to maintain for compatible different
>> xsh environment so convert it to python script
>> Also incorporate the fixes in
>>
https://patchew.org/QEMU/20200929143654.518157-1-marcandre.lureau@redhat.co=
m/
>>
>> Using v\\* on Windows and v* on other platform for matching version.
>> Tested under Ubuntu/msys2/mingw.
>>
>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>> Message-Id: <20201006112139.700-1-luoyonggang@gmail.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  meson.build             |  2 +-
>>  scripts/qemu-version.py | 37 +++++++++++++++++++++++++++++++++++++
>>  scripts/qemu-version.sh | 25 -------------------------
>>  3 files changed, 38 insertions(+), 26 deletions(-)
>>  create mode 100644 scripts/qemu-version.py
>>  delete mode 100755 scripts/qemu-version.sh
>>
>> diff --git a/meson.build b/meson.build
>> index 26230614ba..1d3bb25bc6 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -1132,7 +1132,7 @@ tracetool =3D [
>>     '--backend=3D' + config_host['TRACE_BACKENDS']
>>  ]
>>
>> -qemu_version_cmd =3D [find_program('scripts/qemu-version.sh'),
>> +qemu_version_cmd =3D [find_program('scripts/qemu-version.py'),
>>                      meson.current_source_dir(),
>>                      config_host['PKGVERSION'], meson.project_version()]
>>  qemu_version =3D custom_target('qemu-version.h',
>> diff --git a/scripts/qemu-version.py b/scripts/qemu-version.py
>> new file mode 100644
>> index 0000000000..063b3720f7
>> --- /dev/null
>> +++ b/scripts/qemu-version.py
>> @@ -0,0 +1,37 @@
>> +#!/usr/bin/env python3
>> +
>> +#
>> +# Script for retrieve qemu git version information
>> +#
>> +# Authors:
>> +#  Yonggang Luo <luoyonggang@gmail.com>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2
>> +# or, at your option, any later version.  See the COPYING file in
>> +# the top-level directory.
>> +
>> +import sys
>> +import subprocess
>> +import os, os.path
>> +import platform
>> +
>> +def main(_program, dir, pkgversion, version, *unused):
>> +    os.chdir(dir)
>> +    if not pkgversion and os.path.exists('.git'):
>> +        match_expression =3D 'v\\*' if platform.system() =3D=3D 'Window=
s'
else 'v*'
>> +        pc =3D subprocess.run(['git', 'describe', '--match',
 match_expression,
>> +                            '--dirty', '--always'],
>> +                            stdout=3Dsubprocess.PIPE,
stderr=3Dsubprocess.DEVNULL,
>> +                            encoding=3D'utf8', shell=3DFalse)
>> +        if pc.returncode =3D=3D 0:
>> +            pkgversion =3D pc.stdout.strip()
>> +
>> +    fullversion =3D version
>> +    if pkgversion:
>> +        fullversion =3D "{} ({})".format(version, pkgversion)
>> +
>> +    print('#define QEMU_PKGVERSION "%s"' % pkgversion)
>> +    print('#define QEMU_FULL_VERSION "%s"' % fullversion)
>> +
>> +if __name__ =3D=3D "__main__":
>> +    main(*sys.argv)
>> diff --git a/scripts/qemu-version.sh b/scripts/qemu-version.sh
>> deleted file mode 100755
>> index 03128c56a2..0000000000
>> --- a/scripts/qemu-version.sh
>> +++ /dev/null
>> @@ -1,25 +0,0 @@
>> -#!/bin/sh
>> -
>> -set -eu
>> -
>> -dir=3D"$1"
>> -pkgversion=3D"$2"
>> -version=3D"$3"
>> -
>> -if [ -z "$pkgversion" ]; then
>> -    cd "$dir"
>> -    if [ -e .git ]; then
>> -        pkgversion=3D$(git describe --match 'v*' --dirty | echo "")
>> -    fi
>> -fi
>> -
>> -if [ -n "$pkgversion" ]; then
>> -    fullversion=3D"$version ($pkgversion)"
>> -else
>> -    fullversion=3D"$version"
>> -fi
>> -
>> -cat <<EOF
>> -#define QEMU_PKGVERSION "$pkgversion"
>> -#define QEMU_FULL_VERSION "$fullversion"
>> -EOF
>> --
>> 2.28.0.windows.1
>>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000462fe905b11bb83d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>On Thu, Oct 8, 2020 at 4:31 AM Paolo Bonzini &lt;<a hr=
ef=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<br>&gt=
;<br>&gt; You won&#39;t hear no for an answer, right?...<div>I am trying to=
 figure out the real issue, it&#39;s the issue of git,</div><div><a href=3D=
"https://github.com/msys2/MSYS2-packages/issues/2176">https://github.com/ms=
ys2/MSYS2-packages/issues/2176</a></div><div><br></div><div>The windows wil=
dcard can be disabled and git disabled it, didn&#39;t know what&#39;s happe=
ned to</div><div>the msys&#39;s git, but git-for-windows are works fine.<br=
><br></div><div>&gt;<br>&gt; Paolo<br>&gt;<br>&gt;<br>&gt; Il mer 7 ott 202=
0, 22:00 Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com">luoyongg=
ang@gmail.com</a>&gt; ha scritto:<br>&gt;&gt;<br>&gt;&gt; The sh script are=
 harder to maintain for compatible different<br>&gt;&gt; xsh environment so=
 convert it to python script<br>&gt;&gt; Also incorporate the fixes in<br>&=
gt;&gt; <a href=3D"https://patchew.org/QEMU/20200929143654.518157-1-marcand=
re.lureau@redhat.com/">https://patchew.org/QEMU/20200929143654.518157-1-mar=
candre.lureau@redhat.com/</a><br>&gt;&gt;<br>&gt;&gt; Using v\\* on Windows=
 and v* on other platform for matching version.<br>&gt;&gt; Tested under Ub=
untu/msys2/mingw.<br>&gt;&gt;<br>&gt;&gt; Signed-off-by: Yonggang Luo &lt;<=
a href=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&gt;<br>&g=
t;&gt; Message-Id: &lt;<a href=3D"mailto:20201006112139.700-1-luoyonggang@g=
mail.com">20201006112139.700-1-luoyonggang@gmail.com</a>&gt;<br>&gt;&gt; Si=
gned-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonz=
ini@redhat.com</a>&gt;<br>&gt;&gt; ---<br>&gt;&gt; =C2=A0meson.build =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A02 +-<br>&gt;&gt; =C2=A0scripts/=
qemu-version.py | 37 +++++++++++++++++++++++++++++++++++++<br>&gt;&gt; =C2=
=A0scripts/qemu-version.sh | 25 -------------------------<br>&gt;&gt; =C2=
=A03 files changed, 38 insertions(+), 26 deletions(-)<br>&gt;&gt; =C2=A0cre=
ate mode 100644 scripts/qemu-version.py<br>&gt;&gt; =C2=A0delete mode 10075=
5 scripts/qemu-version.sh<br>&gt;&gt;<br>&gt;&gt; diff --git a/meson.build =
b/meson.build<br>&gt;&gt; index 26230614ba..1d3bb25bc6 100644<br>&gt;&gt; -=
-- a/meson.build<br>&gt;&gt; +++ b/meson.build<br>&gt;&gt; @@ -1132,7 +1132=
,7 @@ tracetool =3D [<br>&gt;&gt; =C2=A0 =C2=A0 &#39;--backend=3D&#39; + co=
nfig_host[&#39;TRACE_BACKENDS&#39;]<br>&gt;&gt; =C2=A0]<br>&gt;&gt;<br>&gt;=
&gt; -qemu_version_cmd =3D [find_program(&#39;scripts/qemu-version.sh&#39;)=
,<br>&gt;&gt; +qemu_version_cmd =3D [find_program(&#39;scripts/qemu-version=
.py&#39;),<br>&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0meson.current_source_dir(),<br>&gt;&gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config_ho=
st[&#39;PKGVERSION&#39;], meson.project_version()]<br>&gt;&gt; =C2=A0qemu_v=
ersion =3D custom_target(&#39;qemu-version.h&#39;,<br>&gt;&gt; diff --git a=
/scripts/qemu-version.py b/scripts/qemu-version.py<br>&gt;&gt; new file mod=
e 100644<br>&gt;&gt; index 0000000000..063b3720f7<br>&gt;&gt; --- /dev/null=
<br>&gt;&gt; +++ b/scripts/qemu-version.py<br>&gt;&gt; @@ -0,0 +1,37 @@<br>=
&gt;&gt; +#!/usr/bin/env python3<br>&gt;&gt; +<br>&gt;&gt; +#<br>&gt;&gt; +=
# Script for retrieve qemu git version information<br>&gt;&gt; +#<br>&gt;&g=
t; +# Authors:<br>&gt;&gt; +# =C2=A0Yonggang Luo &lt;<a href=3D"mailto:luoy=
onggang@gmail.com">luoyonggang@gmail.com</a>&gt;<br>&gt;&gt; +#<br>&gt;&gt;=
 +# This work is licensed under the terms of the GNU GPL, version 2<br>&gt;=
&gt; +# or, at your option, any later version.=C2=A0 See the COPYING file i=
n<br>&gt;&gt; +# the top-level directory.<br>&gt;&gt; +<br>&gt;&gt; +import=
 sys<br>&gt;&gt; +import subprocess<br>&gt;&gt; +import os, os.path<br>&gt;=
&gt; +import platform<br>&gt;&gt; +<br>&gt;&gt; +def main(_program, dir, pk=
gversion, version, *unused):<br>&gt;&gt; + =C2=A0 =C2=A0os.chdir(dir)<br>&g=
t;&gt; + =C2=A0 =C2=A0if not pkgversion and os.path.exists(&#39;.git&#39;):=
<br>&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0match_expression =3D &#39;v\\*&#3=
9; if platform.system() =3D=3D &#39;Windows&#39; else &#39;v*&#39;<br>&gt;&=
gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0pc =3D subprocess.run([&#39;git&#39;, &#39=
;describe&#39;, &#39;--match&#39;, =C2=A0match_expression,<br>&gt;&gt; + =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&#39;--dirty&#39;, &#39;--always&#39;],<br>&gt;&gt;=
 + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0stdout=3Dsubprocess.PIPE, stderr=3Dsubprocess.DE=
VNULL,<br>&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0encoding=3D&#39;utf8&#39;, she=
ll=3DFalse)<br>&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0if pc.returncode =3D=
=3D 0:<br>&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pkgversion =
=3D pc.stdout.strip()<br>&gt;&gt; +<br>&gt;&gt; + =C2=A0 =C2=A0fullversion =
=3D version<br>&gt;&gt; + =C2=A0 =C2=A0if pkgversion:<br>&gt;&gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0fullversion =3D &quot;{} ({})&quot;.format(version, pkg=
version)<br>&gt;&gt; +<br>&gt;&gt; + =C2=A0 =C2=A0print(&#39;#define QEMU_P=
KGVERSION &quot;%s&quot;&#39; % pkgversion)<br>&gt;&gt; + =C2=A0 =C2=A0prin=
t(&#39;#define QEMU_FULL_VERSION &quot;%s&quot;&#39; % fullversion)<br>&gt;=
&gt; +<br>&gt;&gt; +if __name__ =3D=3D &quot;__main__&quot;:<br>&gt;&gt; + =
=C2=A0 =C2=A0main(*sys.argv)<br>&gt;&gt; diff --git a/scripts/qemu-version.=
sh b/scripts/qemu-version.sh<br>&gt;&gt; deleted file mode 100755<br>&gt;&g=
t; index 03128c56a2..0000000000<br>&gt;&gt; --- a/scripts/qemu-version.sh<b=
r>&gt;&gt; +++ /dev/null<br>&gt;&gt; @@ -1,25 +0,0 @@<br>&gt;&gt; -#!/bin/s=
h<br>&gt;&gt; -<br>&gt;&gt; -set -eu<br>&gt;&gt; -<br>&gt;&gt; -dir=3D&quot=
;$1&quot;<br>&gt;&gt; -pkgversion=3D&quot;$2&quot;<br>&gt;&gt; -version=3D&=
quot;$3&quot;<br>&gt;&gt; -<br>&gt;&gt; -if [ -z &quot;$pkgversion&quot; ];=
 then<br>&gt;&gt; - =C2=A0 =C2=A0cd &quot;$dir&quot;<br>&gt;&gt; - =C2=A0 =
=C2=A0if [ -e .git ]; then<br>&gt;&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0pkgvers=
ion=3D$(git describe --match &#39;v*&#39; --dirty | echo &quot;&quot;)<br>&=
gt;&gt; - =C2=A0 =C2=A0fi<br>&gt;&gt; -fi<br>&gt;&gt; -<br>&gt;&gt; -if [ -=
n &quot;$pkgversion&quot; ]; then<br>&gt;&gt; - =C2=A0 =C2=A0fullversion=3D=
&quot;$version ($pkgversion)&quot;<br>&gt;&gt; -else<br>&gt;&gt; - =C2=A0 =
=C2=A0fullversion=3D&quot;$version&quot;<br>&gt;&gt; -fi<br>&gt;&gt; -<br>&=
gt;&gt; -cat &lt;&lt;EOF<br>&gt;&gt; -#define QEMU_PKGVERSION &quot;$pkgver=
sion&quot;<br>&gt;&gt; -#define QEMU_FULL_VERSION &quot;$fullversion&quot;<=
br>&gt;&gt; -EOF<br>&gt;&gt; --<br>&gt;&gt; 2.28.0.windows.1<br>&gt;&gt;<br=
><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=
=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<=
br>Yonggang Luo</div></div>

--000000000000462fe905b11bb83d--

