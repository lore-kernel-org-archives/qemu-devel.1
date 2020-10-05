Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5F8C47095
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 18:17:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0DD220853
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 18:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owKJroDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0DD220853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPV37-0002S6-TW
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 14:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPV2C-0001sC-0J; Mon, 05 Oct 2020 14:16:28 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:36929)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPV2A-0003Z2-0X; Mon, 05 Oct 2020 14:16:27 -0400
Received: by mail-lf1-x143.google.com with SMTP id z19so12047985lfr.4;
 Mon, 05 Oct 2020 11:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=0Dy7+aGe0krkzZNEYGvv0QTP4Vfv/uE31LQBteMw3D4=;
 b=owKJroDqJmB2M+fsG4fRT6U3Git9YUMlTADmJ2d1eK6zxxY85+YMY61gBfvWBGwAUg
 AJVoceIsqznCTs0AIkiKkZZH4k/vR7BXfj/WvrzKJOkJ3pwYSBljeaOYU7UxpCHNPgr5
 lbKQyozQpkJI1aOXhQF9uwilGIPfdhpNUnOH3PoMhF/4x/StK+IyR7alTXAonwwIWoCv
 QWb2vdMuYwkssn76r/isXGOZVsFK8+R/UsayQhB2e7mi6cLpyyBd7c+xlY3FpsNWa37P
 mQW9P00vvnRZocbvOmdf9TPFVN1IizASwwK3T+okyP9WtEvDG+JmIZ7MXWgDJmoxtqg7
 Sjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=0Dy7+aGe0krkzZNEYGvv0QTP4Vfv/uE31LQBteMw3D4=;
 b=JLkKRrLmbdETgOqQKDX0K9EzGr/UYoCl1iDga66/12M+flwI3ye2PF1jVk8wFVhx4T
 xQAb3o0UD23Hv90KEqUAGDwU5qivBAQvzi/bLqlBd/iakIsfaQFiofoR/ONIoDCVtMPE
 UW7PK44xTBC8MgddNTlznJg+AZ9kYDuBwjN9S0u6Q4sCNZhUtjWcZySgil9CBljGyXiR
 9pfWt7e5R3x5ejPXIQ79rNo8+saCRGOMR6fEa/QTQwCtdZLW0kCGNLveC+oOmCtjaGZP
 ZgNqmCvgDVtUwmVF8VyTuSP2rACy/N2k0xdcVqQOEdD8j7rhKaHfPu2GVKuw6bElyMoS
 Igmg==
X-Gm-Message-State: AOAM531H57D1i6WUe0CwNFXP2pAJ1BxT9ZGJ39shxtqWX+42/+7NwaIR
 7oQOrwkPLws5xEnNT18bhFeMBxTBLWIn2EDJf9s=
X-Google-Smtp-Source: ABdhPJw3SSF+d4xZKvNnm2I41qtPQw+wdjlDQgjd7QtxeEw32VpofQjIKrlRBrfQc6WAugIaTN4/mcwZqByX337CRo4=
X-Received: by 2002:a19:674f:: with SMTP id e15mr224590lfj.50.1601921782883;
 Mon, 05 Oct 2020 11:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <20201005172109.416-1-luoyonggang@gmail.com>
 <afc7c5df-8103-9317-7002-d74b14b30be8@amsat.org>
In-Reply-To: <afc7c5df-8103-9317-7002-d74b14b30be8@amsat.org>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 6 Oct 2020 02:16:11 +0800
Message-ID: <CAE2XoE-vfzshWvsT9XyMkPbUDCaO6gUYXvh=STGtSArJgmf9WQ@mail.gmail.com>
Subject: Re: [PATCH v2] scripts: Convert qemu-version.sh to qemu-version.py
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000d3ad5f05b0f07aca"
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x143.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d3ad5f05b0f07aca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2020 at 2:10 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
wrote:
>
> On 10/5/20 7:21 PM, Yonggang Luo wrote:
> > The sh script are harder to maintain for compatible different
> > xsh environment
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
>
> What are the changes since v1?

+    pc =3D subprocess.run(['git', 'describe', '--match', "'v*'", '--dirty'=
,
'--always'],
+        stdout=3Dsubprocess.PIPE, stderr=3Dsubprocess.DEVNULL, cwd=3Ddir)

I output the stderr to devnull so that doesn't pollute the console.

>
> >  meson.build             |  2 +-
> >  scripts/qemu-version.py | 30 ++++++++++++++++++++++++++++++
> >  scripts/qemu-version.sh | 25 -------------------------
> >  3 files changed, 31 insertions(+), 26 deletions(-)
> >  create mode 100644 scripts/qemu-version.py
> >  delete mode 100755 scripts/qemu-version.sh
> >
> > diff --git a/meson.build b/meson.build
> > index 95a532bd29..20f653b6eb 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -1072,7 +1072,7 @@ tracetool =3D [
> >     '--backend=3D' + config_host['TRACE_BACKENDS']
> >  ]
> >
> > -qemu_version_cmd =3D [find_program('scripts/qemu-version.sh'),
> > +qemu_version_cmd =3D [find_program('scripts/qemu-version.py'),
> >                      meson.current_source_dir(),
> >                      config_host['PKGVERSION'], meson.project_version()=
]
> >  qemu_version =3D custom_target('qemu-version.h',
> > diff --git a/scripts/qemu-version.py b/scripts/qemu-version.py
> > new file mode 100644
> > index 0000000000..384c54027d
> > --- /dev/null
> > +++ b/scripts/qemu-version.py
> > @@ -0,0 +1,30 @@
> > +#!/usr/bin/env python3
> > +
> > +# Script for retrieve qemu git version information
> > +# and output to stdout as QEMU_PKGVERSION and QEMU_FULL_VERSION header
> > +# Author: Yonggang Luo <luoyonggang@gmail.com>
> > +
> > +import sys
> > +import subprocess
> > +
> > +def main(args):
> > +    if len(args) <=3D 3:
> > +        sys.exit(0)
> > +
> > +    dir =3D args[1]
> > +    pkgversion =3D args[2]
> > +    version =3D args[3]
> > +    pc =3D subprocess.run(['git', 'describe', '--match', "'v*'",
'--dirty', '--always'],
> > +        stdout=3Dsubprocess.PIPE, stderr=3Dsubprocess.DEVNULL, cwd=3Dd=
ir)
> > +    if pc.returncode =3D=3D 0:
> > +        pkgversion =3D pc.stdout.decode('utf8').strip()
> > +    fullversion =3D version
> > +    if len(pkgversion) > 0:
> > +        fullversion =3D "{} ({})".format(version, pkgversion)
> > +
> > +    version_header =3D '''#define QEMU_PKGVERSION "{}"
> > +#define QEMU_FULL_VERSION "{}"'''.format(pkgversion, fullversion)
> > +    sys.stdout.buffer.write(version_header.encode('utf8'))
> > +
> > +if __name__ =3D=3D "__main__":
> > +    main(sys.argv)
> > diff --git a/scripts/qemu-version.sh b/scripts/qemu-version.sh
> > deleted file mode 100755
> > index 03128c56a2..0000000000
> > --- a/scripts/qemu-version.sh
> > +++ /dev/null
> > @@ -1,25 +0,0 @@
> > -#!/bin/sh
> > -
> > -set -eu
> > -
> > -dir=3D"$1"
> > -pkgversion=3D"$2"
> > -version=3D"$3"
> > -
> > -if [ -z "$pkgversion" ]; then
> > -    cd "$dir"
> > -    if [ -e .git ]; then
> > -        pkgversion=3D$(git describe --match 'v*' --dirty | echo "")
> > -    fi
> > -fi
> > -
> > -if [ -n "$pkgversion" ]; then
> > -    fullversion=3D"$version ($pkgversion)"
> > -else
> > -    fullversion=3D"$version"
> > -fi
> > -
> > -cat <<EOF
> > -#define QEMU_PKGVERSION "$pkgversion"
> > -#define QEMU_FULL_VERSION "$fullversion"
> > -EOF
> >



--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000d3ad5f05b0f07aca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Tue, Oct 6, 2020 at 2:10 AM Philippe Mathieu-Da=
ud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; wro=
te:<br>&gt;<br>&gt; On 10/5/20 7:21 PM, Yonggang Luo wrote:<br>&gt; &gt; Th=
e sh script are harder to maintain for compatible different<br>&gt; &gt; xs=
h environment<br>&gt; &gt;<br>&gt; &gt; Signed-off-by: Yonggang Luo &lt;<a =
href=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&gt;<br>&gt;=
 &gt; ---<br>&gt;<br>&gt; What are the changes since v1?<div><br></div><div=
><span class=3D"gmail-im" style=3D"color:rgb(80,0,80)">+=C2=A0 =C2=A0 pc =
=3D subprocess.run([&#39;git&#39;, &#39;describe&#39;, &#39;--match&#39;, &=
quot;&#39;v*&#39;&quot;, &#39;--dirty&#39;, &#39;--always&#39;],<br></span>=
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 stdout=3Dsubprocess.PIPE, stderr=3Dsubprocess.=
DEVNULL, cwd=3Ddir)=C2=A0</div><div><br></div><div>I output the stderr to d=
evnull so that doesn&#39;t pollute the console.</div><div>=C2=A0<br>&gt;<br=
>&gt; &gt; =C2=A0meson.build =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
=C2=A02 +-<br>&gt; &gt; =C2=A0scripts/qemu-version.py | 30 ++++++++++++++++=
++++++++++++++<br>&gt; &gt; =C2=A0scripts/qemu-version.sh | 25 ------------=
-------------<br>&gt; &gt; =C2=A03 files changed, 31 insertions(+), 26 dele=
tions(-)<br>&gt; &gt; =C2=A0create mode 100644 scripts/qemu-version.py<br>&=
gt; &gt; =C2=A0delete mode 100755 scripts/qemu-version.sh<br>&gt; &gt;<br>&=
gt; &gt; diff --git a/meson.build b/meson.build<br>&gt; &gt; index 95a532bd=
29..20f653b6eb 100644<br>&gt; &gt; --- a/meson.build<br>&gt; &gt; +++ b/mes=
on.build<br>&gt; &gt; @@ -1072,7 +1072,7 @@ tracetool =3D [<br>&gt; &gt; =
=C2=A0 =C2=A0 &#39;--backend=3D&#39; + config_host[&#39;TRACE_BACKENDS&#39;=
]<br>&gt; &gt; =C2=A0]<br>&gt; &gt; <br>&gt; &gt; -qemu_version_cmd =3D [fi=
nd_program(&#39;scripts/qemu-version.sh&#39;),<br>&gt; &gt; +qemu_version_c=
md =3D [find_program(&#39;scripts/qemu-version.py&#39;),<br>&gt; &gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0me=
son.current_source_dir(),<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config_host[&#39;PKGVERSION&#39;],=
 meson.project_version()]<br>&gt; &gt; =C2=A0qemu_version =3D custom_target=
(&#39;qemu-version.h&#39;,<br>&gt; &gt; diff --git a/scripts/qemu-version.p=
y b/scripts/qemu-version.py<br>&gt; &gt; new file mode 100644<br>&gt; &gt; =
index 0000000000..384c54027d<br>&gt; &gt; --- /dev/null<br>&gt; &gt; +++ b/=
scripts/qemu-version.py<br>&gt; &gt; @@ -0,0 +1,30 @@<br>&gt; &gt; +#!/usr/=
bin/env python3<br>&gt; &gt; +<br>&gt; &gt; +# Script for retrieve qemu git=
 version information<br>&gt; &gt; +# and output to stdout as QEMU_PKGVERSIO=
N and QEMU_FULL_VERSION header<br>&gt; &gt; +# Author: Yonggang Luo &lt;<a =
href=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&gt;<br>&gt;=
 &gt; +<br>&gt; &gt; +import sys<br>&gt; &gt; +import subprocess<br>&gt; &g=
t; +<br>&gt; &gt; +def main(args):<br>&gt; &gt; + =C2=A0 =C2=A0if len(args)=
 &lt;=3D 3:<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.exit(0)<br>&gt; &=
gt; +<br>&gt; &gt; + =C2=A0 =C2=A0dir =3D args[1]<br>&gt; &gt; + =C2=A0 =C2=
=A0pkgversion =3D args[2]<br>&gt; &gt; + =C2=A0 =C2=A0version =3D args[3]<b=
r>&gt; &gt; + =C2=A0 =C2=A0pc =3D subprocess.run([&#39;git&#39;, &#39;descr=
ibe&#39;, &#39;--match&#39;, &quot;&#39;v*&#39;&quot;, &#39;--dirty&#39;, &=
#39;--always&#39;],<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0stdout=3Dsubp=
rocess.PIPE, stderr=3Dsubprocess.DEVNULL, cwd=3Ddir)<br>&gt; &gt; + =C2=A0 =
=C2=A0if pc.returncode =3D=3D 0:<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0=
pkgversion =3D pc.stdout.decode(&#39;utf8&#39;).strip()<br>&gt; &gt; + =C2=
=A0 =C2=A0fullversion =3D version<br>&gt; &gt; + =C2=A0 =C2=A0if len(pkgver=
sion) &gt; 0:<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0fullversion =3D &qu=
ot;{} ({})&quot;.format(version, pkgversion)<br>&gt; &gt; +<br>&gt; &gt; + =
=C2=A0 =C2=A0version_header =3D &#39;&#39;&#39;#define QEMU_PKGVERSION &quo=
t;{}&quot;<br>&gt; &gt; +#define QEMU_FULL_VERSION &quot;{}&quot;&#39;&#39;=
&#39;.format(pkgversion, fullversion)<br>&gt; &gt; + =C2=A0 =C2=A0sys.stdou=
t.buffer.write(version_header.encode(&#39;utf8&#39;))<br>&gt; &gt; +<br>&gt=
; &gt; +if __name__ =3D=3D &quot;__main__&quot;:<br>&gt; &gt; + =C2=A0 =C2=
=A0main(sys.argv)<br>&gt; &gt; diff --git a/scripts/qemu-version.sh b/scrip=
ts/qemu-version.sh<br>&gt; &gt; deleted file mode 100755<br>&gt; &gt; index=
 03128c56a2..0000000000<br>&gt; &gt; --- a/scripts/qemu-version.sh<br>&gt; =
&gt; +++ /dev/null<br>&gt; &gt; @@ -1,25 +0,0 @@<br>&gt; &gt; -#!/bin/sh<br=
>&gt; &gt; -<br>&gt; &gt; -set -eu<br>&gt; &gt; -<br>&gt; &gt; -dir=3D&quot=
;$1&quot;<br>&gt; &gt; -pkgversion=3D&quot;$2&quot;<br>&gt; &gt; -version=
=3D&quot;$3&quot;<br>&gt; &gt; -<br>&gt; &gt; -if [ -z &quot;$pkgversion&qu=
ot; ]; then<br>&gt; &gt; - =C2=A0 =C2=A0cd &quot;$dir&quot;<br>&gt; &gt; - =
=C2=A0 =C2=A0if [ -e .git ]; then<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=
=A0pkgversion=3D$(git describe --match &#39;v*&#39; --dirty | echo &quot;&q=
uot;)<br>&gt; &gt; - =C2=A0 =C2=A0fi<br>&gt; &gt; -fi<br>&gt; &gt; -<br>&gt=
; &gt; -if [ -n &quot;$pkgversion&quot; ]; then<br>&gt; &gt; - =C2=A0 =C2=
=A0fullversion=3D&quot;$version ($pkgversion)&quot;<br>&gt; &gt; -else<br>&=
gt; &gt; - =C2=A0 =C2=A0fullversion=3D&quot;$version&quot;<br>&gt; &gt; -fi=
<br>&gt; &gt; -<br>&gt; &gt; -cat &lt;&lt;EOF<br>&gt; &gt; -#define QEMU_PK=
GVERSION &quot;$pkgversion&quot;<br>&gt; &gt; -#define QEMU_FULL_VERSION &q=
uot;$fullversion&quot;<br>&gt; &gt; -EOF<br>&gt; &gt;<br><br><br><br>--<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=
=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<=
/div></div>

--000000000000d3ad5f05b0f07aca--

