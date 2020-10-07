Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEA1C47095
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:42:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 040AA206FC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuUFwp2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040AA206FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCWl-0008Pr-Sx
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQCEg-0004nJ-Nn; Wed, 07 Oct 2020 12:24:14 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:37421)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQCEe-0005mD-C5; Wed, 07 Oct 2020 12:24:14 -0400
Received: by mail-lj1-x241.google.com with SMTP id i2so2603909ljg.4;
 Wed, 07 Oct 2020 09:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=8HZ10kVzw8MqGx7lsQqBexIug+exnwtTH3Aeq+3Q5wY=;
 b=FuUFwp2LHacf3qxmjKZxxlMiy7ffuwXYoEDgN6A83RjtwFHeqzVJFIDwlYTj57QGQL
 0+/iKN+tta70gu8OSr2RljZIO3g9G2WVXPuQ9ooTCPiLmiTOVdCgz2Th5KXBUehQ0V82
 PiEXIrzbAL42+sJxpKIFFgnXiry6wWCPX0VKraomD0/EudhVgTj9E03jMFp29ZUDo/SA
 Cp8JeHCo5BUEzI0BwE1GGVt3SLwUAyaEe3tdgz/6FeOUuLy+wlqeAMO725hMmYGW5ZHD
 iwdIOipdNS892Ez6iNd5fj+J7kRuQV5EPGhP/oqdjHBQB5AAhj2C2mCnPlU/7iVqTIDZ
 z4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=8HZ10kVzw8MqGx7lsQqBexIug+exnwtTH3Aeq+3Q5wY=;
 b=OqaiUg0PEucbG5RrWqelaiELycl0aS8h9p5FrbAqghYeclLDelk/uSzWsZCfAR+R+4
 AWAD3ttwXm6UV/fZtfnT3Ait241sXyqfWcvIiVAtTNp9QUNYmRpP4Awpt/KS/+2onoG+
 Q9S9Kh0FAYjb2PzwQXKY2fuPeLmEv5f0x4ACKnwa5iVTDgq/yMe7hDubV38JZPYiQqpD
 yhSw9y8iaHl5IvcdNwiRo6dgZtxddzwB6dzySpAjVcEih/6MYv5tL0f3uLoXvDT+hFgU
 GZYjg7MpEWU2rbKRv8veKMHKp04ntTHOZhuEIJ+7bxn6aEvMSyQY0VgGgVIVYAoUNP1J
 6UWw==
X-Gm-Message-State: AOAM530tLLJhSwdBzzaql5ckoF/uzHrcYLTyJ8Q3k+EY32mh0QAcdSvr
 6MaHkFqz1EdRx/+980M0+8SThyEsUeoytfOoN2bQObXS1zOBPA==
X-Google-Smtp-Source: ABdhPJyNk1B7bnLW3Yp8pMEjIvnVlnZaVq4U8uA97dbiC/h+TNUdigCwtU4Ch+k0bub+3UZCcfkWOPz9maaHo7BSBAI=
X-Received: by 2002:a2e:8983:: with SMTP id c3mr1592170lji.171.1602087849172; 
 Wed, 07 Oct 2020 09:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201007162138.425-1-luoyonggang@gmail.com>
In-Reply-To: <20201007162138.425-1-luoyonggang@gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 8 Oct 2020 00:23:56 +0800
Message-ID: <CAE2XoE9sf0p5QuG=dSqbOvmGvbzDaEBN8qSG1ejM=RH+D+zq1g@mail.gmail.com>
Subject: Re: [PATCH v6] scripts: Convert qemu-version.sh to qemu-version.py
To: qemu-level <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002625ee05b11725a4"
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002625ee05b11725a4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo, the qemu-version script you queued are mis removed the quote of
"'v*'", that's
would cause the building of qemu failed.
please queue this instead.
I also revised the commit message

On Thu, Oct 8, 2020 at 12:21 AM Yonggang Luo <luoyonggang@gmail.com> wrote:
>
> The sh script are harder to maintain for compatible different
> xsh environment so convert it to python script
> Also incorporate the fixes in
>
https://patchew.org/QEMU/20200929143654.518157-1-marcandre.lureau@redhat.co=
m/
>
> The quote of v* should preserve, otherwise git command would fail
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> Message-Id: <20201006112139.700-1-luoyonggang@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build             |  2 +-
>  scripts/qemu-version.py | 34 ++++++++++++++++++++++++++++++++++
>  scripts/qemu-version.sh | 25 -------------------------
>  3 files changed, 35 insertions(+), 26 deletions(-)
>  create mode 100644 scripts/qemu-version.py
>  delete mode 100755 scripts/qemu-version.sh
>
> diff --git a/meson.build b/meson.build
> index 26230614ba..1d3bb25bc6 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1132,7 +1132,7 @@ tracetool =3D [
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
> index 0000000000..019911b270
> --- /dev/null
> +++ b/scripts/qemu-version.py
> @@ -0,0 +1,34 @@
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
> +import os, os.path
> +
> +def main(_program, dir, pkgversion, version, *unused):
> +    os.chdir(dir)
> +    if not pkgversion and os.path.exists('.git'):
> +        # The quote of v* should preserve, otherwise git command would
fail
> +        pc =3D subprocess.run(['git', 'describe', '--match', "'v*'",
'--dirty', '--always'],
> +                            stdout=3Dsubprocess.PIPE,
stderr=3Dsubprocess.DEVNULL, encoding=3D'utf8')
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
> index 03128c56a2..0000000000
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
> -        pkgversion=3D$(git describe --match 'v*' --dirty | echo "")
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

--0000000000002625ee05b11725a4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Paolo, the qemu-version script you queued are mis remov=
ed the quote of=C2=A0

&quot;&#39;v*&#39;&quot;, that&#39;s<div>would cause the building of qemu f=
ailed.</div><div>please queue this instead.</div><div>I also revised the co=
mmit message<br><div><br>On Thu, Oct 8, 2020 at 12:21 AM Yonggang Luo &lt;<=
a href=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&gt; wrote=
:<br>&gt;<br>&gt; The sh script are harder to maintain for compatible diffe=
rent<br>&gt; xsh environment so convert it to python script<br>&gt; Also in=
corporate the fixes in<br>&gt; <a href=3D"https://patchew.org/QEMU/20200929=
143654.518157-1-marcandre.lureau@redhat.com/">https://patchew.org/QEMU/2020=
0929143654.518157-1-marcandre.lureau@redhat.com/</a><br>&gt;<br>&gt; The qu=
ote of v* should preserve, otherwise git command would fail<br>&gt;<br>&gt;=
 Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com">l=
uoyonggang@gmail.com</a>&gt;<br>&gt; Message-Id: &lt;<a href=3D"mailto:2020=
1006112139.700-1-luoyonggang@gmail.com">20201006112139.700-1-luoyonggang@gm=
ail.com</a>&gt;<br>&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:=
pbonzini@redhat.com">pbonzini@redhat.com</a>&gt;<br>&gt; ---<br>&gt; =C2=A0=
meson.build =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A02 +-<br>&gt; =
=C2=A0scripts/qemu-version.py | 34 ++++++++++++++++++++++++++++++++++<br>&g=
t; =C2=A0scripts/qemu-version.sh | 25 -------------------------<br>&gt; =C2=
=A03 files changed, 35 insertions(+), 26 deletions(-)<br>&gt; =C2=A0create =
mode 100644 scripts/qemu-version.py<br>&gt; =C2=A0delete mode 100755 script=
s/qemu-version.sh<br>&gt;<br>&gt; diff --git a/meson.build b/meson.build<br=
>&gt; index 26230614ba..1d3bb25bc6 100644<br>&gt; --- a/meson.build<br>&gt;=
 +++ b/meson.build<br>&gt; @@ -1132,7 +1132,7 @@ tracetool =3D [<br>&gt; =
=C2=A0 =C2=A0 &#39;--backend=3D&#39; + config_host[&#39;TRACE_BACKENDS&#39;=
]<br>&gt; =C2=A0]<br>&gt;<br>&gt; -qemu_version_cmd =3D [find_program(&#39;=
scripts/qemu-version.sh&#39;),<br>&gt; +qemu_version_cmd =3D [find_program(=
&#39;scripts/qemu-version.py&#39;),<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0meson.current_source_dir(),<br=
>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0config_host[&#39;PKGVERSION&#39;], meson.project_version()]<br>&gt; =
=C2=A0qemu_version =3D custom_target(&#39;qemu-version.h&#39;,<br>&gt; diff=
 --git a/scripts/qemu-version.py b/scripts/qemu-version.py<br>&gt; new file=
 mode 100644<br>&gt; index 0000000000..019911b270<br>&gt; --- /dev/null<br>=
&gt; +++ b/scripts/qemu-version.py<br>&gt; @@ -0,0 +1,34 @@<br>&gt; +#!/usr=
/bin/env python3<br>&gt; +<br>&gt; +#<br>&gt; +# Script for retrieve qemu g=
it version information<br>&gt; +#<br>&gt; +# Authors:<br>&gt; +# =C2=A0Yong=
gang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail.com=
</a>&gt;<br>&gt; +#<br>&gt; +# This work is licensed under the terms of the=
 GNU GPL, version 2<br>&gt; +# or, at your option, any later version.=C2=A0=
 See the COPYING file in<br>&gt; +# the top-level directory.<br>&gt; +<br>&=
gt; +import sys<br>&gt; +import subprocess<br>&gt; +import os, os.path<br>&=
gt; +<br>&gt; +def main(_program, dir, pkgversion, version, *unused):<br>&g=
t; + =C2=A0 =C2=A0os.chdir(dir)<br>&gt; + =C2=A0 =C2=A0if not pkgversion an=
d os.path.exists(&#39;.git&#39;):<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0# Th=
e quote of v* should preserve, otherwise git command would fail<br>&gt; + =
=C2=A0 =C2=A0 =C2=A0 =C2=A0pc =3D subprocess.run([&#39;git&#39;, &#39;descr=
ibe&#39;, &#39;--match&#39;, &quot;&#39;v*&#39;&quot;, &#39;--dirty&#39;, &=
#39;--always&#39;],<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stdout=3Dsubprocess.PIP=
E, stderr=3Dsubprocess.DEVNULL, encoding=3D&#39;utf8&#39;)<br>&gt; + =C2=A0=
 =C2=A0 =C2=A0 =C2=A0if pc.returncode =3D=3D 0:<br>&gt; + =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0pkgversion =3D pc.stdout.strip()<br>&gt; +<br>&gt; =
+ =C2=A0 =C2=A0fullversion =3D version<br>&gt; + =C2=A0 =C2=A0if pkgversion=
:<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0fullversion =3D &quot;{} ({})&quot;.=
format(version, pkgversion)<br>&gt; +<br>&gt; + =C2=A0 =C2=A0print(&#39;#de=
fine QEMU_PKGVERSION &quot;%s&quot;&#39; % pkgversion)<br>&gt; + =C2=A0 =C2=
=A0print(&#39;#define QEMU_FULL_VERSION &quot;%s&quot;&#39; % fullversion)<=
br>&gt; +<br>&gt; +if __name__ =3D=3D &quot;__main__&quot;:<br>&gt; + =C2=
=A0 =C2=A0main(*sys.argv)<br>&gt; diff --git a/scripts/qemu-version.sh b/sc=
ripts/qemu-version.sh<br>&gt; deleted file mode 100755<br>&gt; index 03128c=
56a2..0000000000<br>&gt; --- a/scripts/qemu-version.sh<br>&gt; +++ /dev/nul=
l<br>&gt; @@ -1,25 +0,0 @@<br>&gt; -#!/bin/sh<br>&gt; -<br>&gt; -set -eu<br=
>&gt; -<br>&gt; -dir=3D&quot;$1&quot;<br>&gt; -pkgversion=3D&quot;$2&quot;<=
br>&gt; -version=3D&quot;$3&quot;<br>&gt; -<br>&gt; -if [ -z &quot;$pkgvers=
ion&quot; ]; then<br>&gt; - =C2=A0 =C2=A0cd &quot;$dir&quot;<br>&gt; - =C2=
=A0 =C2=A0if [ -e .git ]; then<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0pkgvers=
ion=3D$(git describe --match &#39;v*&#39; --dirty | echo &quot;&quot;)<br>&=
gt; - =C2=A0 =C2=A0fi<br>&gt; -fi<br>&gt; -<br>&gt; -if [ -n &quot;$pkgvers=
ion&quot; ]; then<br>&gt; - =C2=A0 =C2=A0fullversion=3D&quot;$version ($pkg=
version)&quot;<br>&gt; -else<br>&gt; - =C2=A0 =C2=A0fullversion=3D&quot;$ve=
rsion&quot;<br>&gt; -fi<br>&gt; -<br>&gt; -cat &lt;&lt;EOF<br>&gt; -#define=
 QEMU_PKGVERSION &quot;$pkgversion&quot;<br>&gt; -#define QEMU_FULL_VERSION=
 &quot;$fullversion&quot;<br>&gt; -EOF<br>&gt; --<br>&gt; 2.28.0.windows.1<=
br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=
=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 s=
incerely,<br>Yonggang Luo</div></div></div>

--0000000000002625ee05b11725a4--

