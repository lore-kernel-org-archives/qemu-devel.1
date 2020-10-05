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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C78C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:26:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86C4520853
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9rVGwK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C4520853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPX3m-0002qg-FZ
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 16:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPWaV-0005Jt-82; Mon, 05 Oct 2020 15:55:59 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:44004)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPWaS-0007jC-RI; Mon, 05 Oct 2020 15:55:58 -0400
Received: by mail-lj1-x243.google.com with SMTP id l13so5532067ljg.10;
 Mon, 05 Oct 2020 12:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=kIgkJgwRnlXzAi/N6bYPqXdd1GzIP0MwV+Ya7hdUJwQ=;
 b=B9rVGwK9fKwiTKAgXV/CsVM8pQF2hNecLvB+Yc0Bl2EneFnDuP73GuOe7yMPCS0Jkj
 EZbAdErtkKTFjb4iC73yvzezX4EoOg2J6x68BmDk+CyjE13RCF8uwGUMSpnT5fiZXoNj
 fbIg7BwQQJaniSK5GOP7hkR4fCfSU/AERAIYeYsOUR3dmddfcO9j+E7uQcAV5ezwozTc
 j9OLqsKJE0H2ugYSlf6cMXFCHGT+6ONUJk0gmrehz/Gu3GlKFHDjAkEnh68ubOJTYrxH
 ocNnJTbrYGYnn2PJbXsnTDLH/D+14k4W6qX44ZVQMzjFIRraRC6kwSI63kBWToDiuvZB
 Y2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=kIgkJgwRnlXzAi/N6bYPqXdd1GzIP0MwV+Ya7hdUJwQ=;
 b=rl6yyfyYavo3yu0YUtdLX47XSp8wzrEYpiLghsLQEp3no9u37kM9s4QJz58qfVHgMN
 xkPKWIoXF5RnaewhZUlTUdo6MEhoFAVM37llkVAzS02XsEuHRur/SusTerJXVmIGvojg
 Q7OVzbbfQTLtQFMllIAMGvEvnbTzERD1sU3C6TU0CnAm8ensex+Fx2Y2b/u8SM2N1KnP
 SR8moNxUBaHSh6bavh74TzUiMctewMUWXiP+z4fa/bDRmohUfUCe8eGnoaa/7OvM6/Hz
 guvAxYqSxIHjB1Zt/Vpp5IWlZcsjzsToMOV4GXQmZP6zK94z4T+uQKECW1vEVPpCF6jn
 8fqg==
X-Gm-Message-State: AOAM531MIT/SddJPJ1gUZSf1eXPEKuedzW3vLOsSFRgmTuX+Z5bu4QNh
 KgTBYsQeTD0wFgQlSCOzHamSrHxLrAv0fo6sH5M=
X-Google-Smtp-Source: ABdhPJwWlkqiA9FlZf6P1ZMOc8WE8FinwWK7yB6bSp9DtZtpzmeeUl7QW49Wb7wpgbqtYcqZPnrM4zjxl2IJUMKSDUg=
X-Received: by 2002:a2e:978f:: with SMTP id y15mr412200lji.300.1601927753868; 
 Mon, 05 Oct 2020 12:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201005172109.416-1-luoyonggang@gmail.com>
 <CAFEAcA95r2FZibphrO0N_rckWOKigM_d80Qi0grtpWWzN3d19A@mail.gmail.com>
In-Reply-To: <CAFEAcA95r2FZibphrO0N_rckWOKigM_d80Qi0grtpWWzN3d19A@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 6 Oct 2020 03:55:42 +0800
Message-ID: <CAE2XoE_a4Q++HAbe2_MgbOgAqTqCtEDGOegQL+mJ5CKCp5HtAA@mail.gmail.com>
Subject: Re: [PATCH v2] scripts: Convert qemu-version.sh to qemu-version.py
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000b9a95705b0f1de34"
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b9a95705b0f1de34
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2020 at 3:23 AM Peter Maydell <peter.maydell@linaro.org>
wrote:
>
> On Mon, 5 Oct 2020 at 18:24, Yonggang Luo <luoyonggang@gmail.com> wrote:
> >
> > The sh script are harder to maintain for compatible different
> > xsh environment
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
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
>
> Can we have a license statement in all new files, please?
>
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
>
> Wow, python really makes this kind of task clunky compared to shell...
That's right, the size are bloated, but for me, easier to understand
>
> This doesn't seem to be the same logic as the original shell.
> I'm not too familiar with python, but:
>  * the shell script doesn't run git if pkgversion is not the empty string
>  * the shell script doesn't run git unless the .git directory exists
> If these are intentional behaviour changes you should mention
> them in the commit message.
>
> Also worth mentioning that you're fixing the bug in the shell
> script where we ignore the output from git (the intention was
> to ignore a failure from git but otherwise to keep its output;
> this patch:
>
https://patchew.org/QEMU/20200929143654.518157-1-marcandre.lureau@redhat.co=
m/
> is the fix for that in the existing shell script).
>
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
>
> thanks
> -- PMM



--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000b9a95705b0f1de34
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Tue, Oct 6, 2020 at 3:23 AM Peter Maydell &lt;<=
a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt;=
 wrote:<br>&gt;<br>&gt; On Mon, 5 Oct 2020 at 18:24, Yonggang Luo &lt;<a hr=
ef=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&gt; wrote:<br=
>&gt; &gt;<br>&gt; &gt; The sh script are harder to maintain for compatible=
 different<br>&gt; &gt; xsh environment<br>&gt; &gt;<br>&gt; &gt; Signed-of=
f-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com">luoyonggang=
@gmail.com</a>&gt;<br>&gt; &gt; ---<br>&gt; &gt; =C2=A0meson.build =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A02 +-<br>&gt; &gt; =C2=A0scripts/=
qemu-version.py | 30 ++++++++++++++++++++++++++++++<br>&gt; &gt; =C2=A0scri=
pts/qemu-version.sh | 25 -------------------------<br>&gt; &gt; =C2=A03 fil=
es changed, 31 insertions(+), 26 deletions(-)<br>&gt; &gt; =C2=A0create mod=
e 100644 scripts/qemu-version.py<br>&gt; &gt; =C2=A0delete mode 100755 scri=
pts/qemu-version.sh<br>&gt; &gt;<br>&gt; &gt; diff --git a/meson.build b/me=
son.build<br>&gt; &gt; index 95a532bd29..20f653b6eb 100644<br>&gt; &gt; ---=
 a/meson.build<br>&gt; &gt; +++ b/meson.build<br>&gt; &gt; @@ -1072,7 +1072=
,7 @@ tracetool =3D [<br>&gt; &gt; =C2=A0 =C2=A0 &#39;--backend=3D&#39; + c=
onfig_host[&#39;TRACE_BACKENDS&#39;]<br>&gt; &gt; =C2=A0]<br>&gt; &gt;<br>&=
gt; &gt; -qemu_version_cmd =3D [find_program(&#39;scripts/qemu-version.sh&#=
39;),<br>&gt; &gt; +qemu_version_cmd =3D [find_program(&#39;scripts/qemu-ve=
rsion.py&#39;),<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0meson.current_source_dir(),<br>&gt; &gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0co=
nfig_host[&#39;PKGVERSION&#39;], meson.project_version()]<br>&gt; &gt; =C2=
=A0qemu_version =3D custom_target(&#39;qemu-version.h&#39;,<br>&gt; &gt; di=
ff --git a/scripts/qemu-version.py b/scripts/qemu-version.py<br>&gt; &gt; n=
ew file mode 100644<br>&gt; &gt; index 0000000000..384c54027d<br>&gt; &gt; =
--- /dev/null<br>&gt; &gt; +++ b/scripts/qemu-version.py<br>&gt; &gt; @@ -0=
,0 +1,30 @@<br>&gt; &gt; +#!/usr/bin/env python3<br>&gt; &gt; +<br>&gt; &gt=
; +# Script for retrieve qemu git version information<br>&gt; &gt; +# and o=
utput to stdout as QEMU_PKGVERSION and QEMU_FULL_VERSION header<br>&gt; &gt=
; +# Author: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com">luoy=
onggang@gmail.com</a>&gt;<br>&gt;<br>&gt; Can we have a license statement i=
n all new files, please?<br>&gt;<br>&gt; &gt; +<br>&gt; &gt; +import sys<br=
>&gt; &gt; +import subprocess<br>&gt; &gt; +<br>&gt; &gt; +def main(args):<=
br>&gt; &gt; + =C2=A0 =C2=A0if len(args) &lt;=3D 3:<br>&gt; &gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0sys.exit(0)<br>&gt; &gt; +<br>&gt; &gt; + =C2=A0 =C2=A0=
dir =3D args[1]<br>&gt; &gt; + =C2=A0 =C2=A0pkgversion =3D args[2]<br>&gt; =
&gt; + =C2=A0 =C2=A0version =3D args[3]<br>&gt; &gt; + =C2=A0 =C2=A0pc =3D =
subprocess.run([&#39;git&#39;, &#39;describe&#39;, &#39;--match&#39;, &quot=
;&#39;v*&#39;&quot;, &#39;--dirty&#39;, &#39;--always&#39;],<br>&gt; &gt; +=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0stdout=3Dsubprocess.PIPE, stderr=3Dsubprocess.D=
EVNULL, cwd=3Ddir)<br>&gt; &gt; + =C2=A0 =C2=A0if pc.returncode =3D=3D 0:<b=
r>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0pkgversion =3D pc.stdout.decode(&#=
39;utf8&#39;).strip()<br>&gt; &gt; + =C2=A0 =C2=A0fullversion =3D version<b=
r>&gt; &gt; + =C2=A0 =C2=A0if len(pkgversion) &gt; 0:<br>&gt; &gt; + =C2=A0=
 =C2=A0 =C2=A0 =C2=A0fullversion =3D &quot;{} ({})&quot;.format(version, pk=
gversion)<br>&gt; &gt; +<br>&gt; &gt; + =C2=A0 =C2=A0version_header =3D &#3=
9;&#39;&#39;#define QEMU_PKGVERSION &quot;{}&quot;<br>&gt; &gt; +#define QE=
MU_FULL_VERSION &quot;{}&quot;&#39;&#39;&#39;.format(pkgversion, fullversio=
n)<br>&gt; &gt; + =C2=A0 =C2=A0sys.stdout.buffer.write(version_header.encod=
e(&#39;utf8&#39;))<br>&gt; &gt; +<br>&gt; &gt; +if __name__ =3D=3D &quot;__=
main__&quot;:<br>&gt; &gt; + =C2=A0 =C2=A0main(sys.argv)<br>&gt;<br>&gt; Wo=
w, python really makes this kind of task clunky compared to shell...<div>Th=
at&#39;s right, the size are bloated, but for me, easier to understand<br>&=
gt;<br>&gt; This doesn&#39;t seem to be the same logic as the original shel=
l.<br>&gt; I&#39;m not too familiar with python, but:<br>&gt; =C2=A0* the s=
hell script doesn&#39;t run git if pkgversion is not the empty string<br>&g=
t; =C2=A0* the shell script doesn&#39;t run git unless the .git directory e=
xists<br>&gt; If these are intentional behaviour changes you should mention=
<br>&gt; them in the commit message.<br>&gt;<br>&gt; Also worth mentioning =
that you&#39;re fixing the bug in the shell<br>&gt; script where we ignore =
the output from git (the intention was<br>&gt; to ignore a failure from git=
 but otherwise to keep its output;<br>&gt; this patch:<br>&gt; <a href=3D"h=
ttps://patchew.org/QEMU/20200929143654.518157-1-marcandre.lureau@redhat.com=
/">https://patchew.org/QEMU/20200929143654.518157-1-marcandre.lureau@redhat=
.com/</a><br>&gt; is the fix for that in the existing shell script).<br>&gt=
;<br>&gt; &gt; diff --git a/scripts/qemu-version.sh b/scripts/qemu-version.=
sh<br>&gt; &gt; deleted file mode 100755<br>&gt; &gt; index 03128c56a2..000=
0000000<br>&gt; &gt; --- a/scripts/qemu-version.sh<br>&gt; &gt; +++ /dev/nu=
ll<br>&gt; &gt; @@ -1,25 +0,0 @@<br>&gt; &gt; -#!/bin/sh<br>&gt; &gt; -<br>=
&gt; &gt; -set -eu<br>&gt; &gt; -<br>&gt; &gt; -dir=3D&quot;$1&quot;<br>&gt=
; &gt; -pkgversion=3D&quot;$2&quot;<br>&gt; &gt; -version=3D&quot;$3&quot;<=
br>&gt; &gt; -<br>&gt; &gt; -if [ -z &quot;$pkgversion&quot; ]; then<br>&gt=
; &gt; - =C2=A0 =C2=A0cd &quot;$dir&quot;<br>&gt; &gt; - =C2=A0 =C2=A0if [ =
-e .git ]; then<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0pkgversion=3D$(gi=
t describe --match &#39;v*&#39; --dirty | echo &quot;&quot;)<br>&gt; &gt; -=
 =C2=A0 =C2=A0fi<br>&gt; &gt; -fi<br>&gt; &gt; -<br>&gt; &gt; -if [ -n &quo=
t;$pkgversion&quot; ]; then<br>&gt; &gt; - =C2=A0 =C2=A0fullversion=3D&quot=
;$version ($pkgversion)&quot;<br>&gt; &gt; -else<br>&gt; &gt; - =C2=A0 =C2=
=A0fullversion=3D&quot;$version&quot;<br>&gt; &gt; -fi<br>&gt; &gt; -<br>&g=
t; &gt; -cat &lt;&lt;EOF<br>&gt; &gt; -#define QEMU_PKGVERSION &quot;$pkgve=
rsion&quot;<br>&gt; &gt; -#define QEMU_FULL_VERSION &quot;$fullversion&quot=
;<br>&gt; &gt; -EOF<br>&gt;<br>&gt; thanks<br>&gt; -- PMM<br><br><br><br>--=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=
=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggan=
g Luo</div></div>

--000000000000b9a95705b0f1de34--

