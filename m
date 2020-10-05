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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78329C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:33:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0709D21527
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rS6sOfLs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0709D21527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPXAt-00035B-TU
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 16:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kPWev-0004u7-KQ; Mon, 05 Oct 2020 16:00:33 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:46518)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kPWet-000843-02; Mon, 05 Oct 2020 16:00:33 -0400
Received: by mail-ej1-x643.google.com with SMTP id cb21so7255973ejb.13;
 Mon, 05 Oct 2020 13:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jN3LE8p6atd5HvhNF0VPAG9XMzJBs38DyeEWeOc6qZ0=;
 b=rS6sOfLsJZO7tVWt2KY7QtGImwzGeI4dRx3Q2Snw71XIsBGcX8PZOP2r45nkf9CQ9b
 4fgNxgDio/wfZk2lo7eh2/dNgmYvpiXJaPkP7UI2sBYG3U/J+Iy3loEcAft+YCuM3Hdh
 ur8bitOi+6mcRwOI/tQ5QBPk0GQhSXlAzIdx2hnNa0sb9ejCRlt89bB21NPJ8sSViC+f
 OEnumemc35Ysd1MFaT5qx3ocw7iVLJNFyDRBJs0obvhFk9F3QeKECa2ihKWkx8rtq79i
 Sk2spMPJPpzb3ftRkU89rx/xmW7ZnvACvN6S7JZ0Z7K8F6UPqYB/+8e5bwnMdZ0gn3UM
 PauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jN3LE8p6atd5HvhNF0VPAG9XMzJBs38DyeEWeOc6qZ0=;
 b=coq3fVcZO0xwzV5SIOI6UPs9BVzniKpoBuSa3eH5eCSLVkV+7psREBugYhyjKujhMH
 OqYMzvWWbWD025PZUXpq1kT5CtLFzPphOkyQmsrGIg0iH3QxEcikG3fyR0S+2VHyghDr
 jc36YXj9z5rAOTGvCIPeJBdSiboDWSpFUXmXHg+S10BgSYKVrjuejMFqnH1fL3A9OYZ4
 PZ7o5z3MwTe0BeF0RliJxGj5qyjoIs0f/q3H+XLt/OSG3rMb0Jz9XWCmNlA15lHaIy/U
 aPR4Ev1PmOGceanI4ujnUYE6ZtMvoQM0LiqPB0c6dQhrzhcZeOa+JryLIbPV7XlRrFo9
 QxEg==
X-Gm-Message-State: AOAM53319/L+d3e2TjsdoTv8/tArtGDK6hlAxF9SEBIsySA15oMYXqaQ
 +rbIpfW47Pof0AAowNx3MOg/Bqb3LbhvsBzk5Dc=
X-Google-Smtp-Source: ABdhPJyUDhTLcmv1merl3ZdQjDOF/Uq6mEPeqmftLlpnBRTGv4rzQnq4ovktmV4F6YNZ59jV+24uqqfLUu3XGOvatEE=
X-Received: by 2002:a17:906:515:: with SMTP id
 j21mr1429736eja.105.1601928028318; 
 Mon, 05 Oct 2020 13:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201005195129.1507-1-luoyonggang@gmail.com>
In-Reply-To: <20201005195129.1507-1-luoyonggang@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 6 Oct 2020 00:00:16 +0400
Message-ID: <CAJ+F1C+6Ur2QJ57P9jZ-d7TtvDgG6OBmpq9fTCBi2W7ee_O2iA@mail.gmail.com>
Subject: Re: [PATCH v3] scripts: Convert qemu-version.sh to qemu-version.py
To: Yonggang Luo <luoyonggang@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000156f0f05b0f1efc2"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x643.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, QEMU <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000156f0f05b0f1efc2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2020 at 11:52 PM Yonggang Luo <luoyonggang@gmail.com> wrote:

> The sh script are harder to maintain for compatible different
> xsh environment so convert it to python script
> Also incorporate the fixes in
>
> https://patchew.org/QEMU/20200929143654.518157-1-marcandre.lureau@redhat.=
com/
>
> Testing args length and if not enough, setting pkgversion and version to =
''
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>

lgtm
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  meson.build             |  2 +-
>  scripts/qemu-version.py | 37 +++++++++++++++++++++++++++++++++++++
>  scripts/qemu-version.sh | 25 -------------------------
>  3 files changed, 38 insertions(+), 26 deletions(-)
>  create mode 100644 scripts/qemu-version.py
>  delete mode 100755 scripts/qemu-version.sh
>
> diff --git a/meson.build b/meson.build
> index 95a532bd29..20f653b6eb 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1072,7 +1072,7 @@ tracetool =3D [
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
> index 0000000000..fc1531ef2b
> --- /dev/null
> +++ b/scripts/qemu-version.py
> @@ -0,0 +1,37 @@
> +#!/usr/bin/env python3
> +
> +#
> +# Script for retrieve qemu git version information
> +#
> +# Author: Yonggang Luo <luoyonggang@gmail.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2.  See
> +# the COPYING file in the top-level directory.
> +#
> +
> +import sys
> +import subprocess
> +
> +def main(args):
> +    pkgversion =3D ''
> +    version =3D ''
> +    if len(args) > 3:
> +        dir =3D args[1]
> +        pkgversion =3D args[2]
> +        version =3D args[3]
> +        if len(pkgversion) =3D=3D 0:
> +            pc =3D subprocess.run(['git', 'describe', '--match', "'v*'",
> '--dirty', '--always'],
> +                                stdout=3Dsubprocess.PIPE,
> stderr=3Dsubprocess.DEVNULL, cwd=3Ddir)
> +            if pc.returncode =3D=3D 0:
> +                pkgversion =3D pc.stdout.decode('utf8').strip()
> +
> +    fullversion =3D version
> +    if len(pkgversion) > 0:
> +        fullversion =3D "{} ({})".format(version, pkgversion)
> +
> +    version_header =3D '''#define QEMU_PKGVERSION "{}"
> +#define QEMU_FULL_VERSION "{}"'''.format(pkgversion, fullversion)
> +    sys.stdout.buffer.write(version_header.encode('utf8'))
> +
> +if __name__ =3D=3D "__main__":
> +    main(sys.argv)
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
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000156f0f05b0f1efc2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 5, 2020 at 11:52 PM Yongg=
ang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">T=
he sh script are harder to maintain for compatible different<br>
xsh environment so convert it to python script<br>
Also incorporate the fixes in<br>
<a href=3D"https://patchew.org/QEMU/20200929143654.518157-1-marcandre.lurea=
u@redhat.com/" rel=3D"noreferrer" target=3D"_blank">https://patchew.org/QEM=
U/20200929143654.518157-1-marcandre.lureau@redhat.com/</a><br>
<br>
Testing args length and if not enough, setting pkgversion and version to &#=
39;&#39;<br>
<br>
Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com" ta=
rget=3D"_blank">luoyonggang@gmail.com</a>&gt;<br></blockquote><div><br></di=
v><div>lgtm</div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"ma=
ilto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div>=
<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 =
+-<br>
=C2=A0scripts/qemu-version.py | 37 +++++++++++++++++++++++++++++++++++++<br=
>
=C2=A0scripts/qemu-version.sh | 25 -------------------------<br>
=C2=A03 files changed, 38 insertions(+), 26 deletions(-)<br>
=C2=A0create mode 100644 scripts/qemu-version.py<br>
=C2=A0delete mode 100755 scripts/qemu-version.sh<br>
<br>
diff --git a/meson.build b/meson.build<br>
index 95a532bd29..20f653b6eb 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -1072,7 +1072,7 @@ tracetool =3D [<br>
=C2=A0 =C2=A0 &#39;--backend=3D&#39; + config_host[&#39;TRACE_BACKENDS&#39;=
]<br>
=C2=A0]<br>
<br>
-qemu_version_cmd =3D [find_program(&#39;scripts/qemu-version.sh&#39;),<br>
+qemu_version_cmd =3D [find_program(&#39;scripts/qemu-version.py&#39;),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0meson.current_source_dir(),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0config_host[&#39;PKGVERSION&#39;], meson.project_version()]<br>
=C2=A0qemu_version =3D custom_target(&#39;qemu-version.h&#39;,<br>
diff --git a/scripts/qemu-version.py b/scripts/qemu-version.py<br>
new file mode 100644<br>
index 0000000000..fc1531ef2b<br>
--- /dev/null<br>
+++ b/scripts/qemu-version.py<br>
@@ -0,0 +1,37 @@<br>
+#!/usr/bin/env python3<br>
+<br>
+#<br>
+# Script for retrieve qemu git version information<br>
+#<br>
+# Author: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com" target=
=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
+#<br>
+# This work is licensed under the terms of the GNU GPL, version 2.=C2=A0 S=
ee<br>
+# the COPYING file in the top-level directory.<br>
+#<br>
+<br>
+import sys<br>
+import subprocess<br>
+<br>
+def main(args):<br>
+=C2=A0 =C2=A0 pkgversion =3D &#39;&#39;<br>
+=C2=A0 =C2=A0 version =3D &#39;&#39;<br>
+=C2=A0 =C2=A0 if len(args) &gt; 3:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dir =3D args[1]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pkgversion =3D args[2]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 version =3D args[3]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(pkgversion) =3D=3D 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pc =3D subprocess.run([&#39;git&=
#39;, &#39;describe&#39;, &#39;--match&#39;, &quot;&#39;v*&#39;&quot;, &#39=
;--dirty&#39;, &#39;--always&#39;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stdout=3Dsubprocess.PIPE, stderr=3Ds=
ubprocess.DEVNULL, cwd=3Ddir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if pc.returncode =3D=3D 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pkgversion =3D pc.=
stdout.decode(&#39;utf8&#39;).strip()<br>
+<br>
+=C2=A0 =C2=A0 fullversion =3D version<br>
+=C2=A0 =C2=A0 if len(pkgversion) &gt; 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fullversion =3D &quot;{} ({})&quot;.format(ver=
sion, pkgversion)<br>
+<br>
+=C2=A0 =C2=A0 version_header =3D &#39;&#39;&#39;#define QEMU_PKGVERSION &q=
uot;{}&quot;<br>
+#define QEMU_FULL_VERSION &quot;{}&quot;&#39;&#39;&#39;.format(pkgversion,=
 fullversion)<br>
+=C2=A0 =C2=A0 sys.stdout.buffer.write(version_header.encode(&#39;utf8&#39;=
))<br>
+<br>
+if __name__ =3D=3D &quot;__main__&quot;:<br>
+=C2=A0 =C2=A0 main(sys.argv)<br>
diff --git a/scripts/qemu-version.sh b/scripts/qemu-version.sh<br>
deleted file mode 100755<br>
index 03128c56a2..0000000000<br>
--- a/scripts/qemu-version.sh<br>
+++ /dev/null<br>
@@ -1,25 +0,0 @@<br>
-#!/bin/sh<br>
-<br>
-set -eu<br>
-<br>
-dir=3D&quot;$1&quot;<br>
-pkgversion=3D&quot;$2&quot;<br>
-version=3D&quot;$3&quot;<br>
-<br>
-if [ -z &quot;$pkgversion&quot; ]; then<br>
-=C2=A0 =C2=A0 cd &quot;$dir&quot;<br>
-=C2=A0 =C2=A0 if [ -e .git ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pkgversion=3D$(git describe --match &#39;v*&#3=
9; --dirty | echo &quot;&quot;)<br>
-=C2=A0 =C2=A0 fi<br>
-fi<br>
-<br>
-if [ -n &quot;$pkgversion&quot; ]; then<br>
-=C2=A0 =C2=A0 fullversion=3D&quot;$version ($pkgversion)&quot;<br>
-else<br>
-=C2=A0 =C2=A0 fullversion=3D&quot;$version&quot;<br>
-fi<br>
-<br>
-cat &lt;&lt;EOF<br>
-#define QEMU_PKGVERSION &quot;$pkgversion&quot;<br>
-#define QEMU_FULL_VERSION &quot;$fullversion&quot;<br>
-EOF<br>
-- <br>
2.28.0.windows.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000156f0f05b0f1efc2--

