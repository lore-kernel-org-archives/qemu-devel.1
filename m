Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8E9C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:28:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87C872075E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQWCKERa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C872075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAxLK-0004oh-Rr
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 11:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAxKa-0003eX-Or
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:27:20 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:40907)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAxKW-00064e-WD
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:27:20 -0400
Received: by mail-lj1-x244.google.com with SMTP id 185so2833002ljj.7
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 08:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=+VLptgIWzQOAFe4B0MO4F6fS+w0IO9qQrS46WglSJRI=;
 b=SQWCKERaS9QjvYl+udgQ0qfjYLjXIzOVFjvFPMETWQTskE0a8tcvbdllw9f9CaWKZJ
 JBTxxbVDl2TsnEd4a7kKW1risjkd2wmJgEVeBLakzPpZSmVMqyWY58pKylPlj4JqNqr1
 +b/BH0Qw+xQ/5m9IYqt72eV8ACcWY5NiafR0VF/qXWnTE15jLvc83bvQ5sHIeeGKvm3u
 HjqwjVktMrigYjzAiQGxMdMkuNNPZztGoWQRxwCz84sMvj5sgpWFDGLjf63gvQ7kc1J7
 Dg/PsbKObhQq4fxRa+1wrh+blYMtv/FxCJonEbXYgrPyLJvKvEexO8CAGrTpQimdrj5j
 hYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=+VLptgIWzQOAFe4B0MO4F6fS+w0IO9qQrS46WglSJRI=;
 b=eARB82Qj0jZMv16Br0aKw+v3qRTMo1nKUuLpar1+cjEScFhfZoM3Q4TO80cbUe7Rg2
 XqKI8H3cj7hSTAbOWZmFJTbzQzLW+PQuPU+GUxlNOoUTtHheoseBy9qtL+GjdORCzlmn
 1cHVUAdOW6ETTH+PrRlOiY/IwTrD/Ro6VDo390kUEVCOPlPP/ZG4Nlw6AebfeMNuLzjZ
 zfKGYx/frv2W+TXKoa1HzAcSqkPrc9f68qNWSEjPJA/tpvWeQdWk7ff7rFIHjAXKI0X9
 oAYMe0bABiXvtOaTX1kB69ZapGYrHN7n5qvLqqQBsYvWjc/5OtyQXHbstuFhrwwkplwj
 BdoQ==
X-Gm-Message-State: AOAM5323y6HHzVLCX8KPwzmVnCjdUskTQ4qaewxp1hHAN47PsYEn/n1s
 9kvPSiZZ22SN+YBudgs709Libe55aIB8AIZG+y8=
X-Google-Smtp-Source: ABdhPJwI5LzE/t7PnP0uveq8cr/fg32J7QQwBAxRX51+kqLBGdnNab4tUKGxNkgjeCKj7B5AV41OF3VSoe2K4QwjM0o=
X-Received: by 2002:a2e:7215:: with SMTP id n21mr8006532ljc.242.1598455635108; 
 Wed, 26 Aug 2020 08:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200826151006.80-1-luoyonggang@gmail.com>
 <20200826151006.80-6-luoyonggang@gmail.com>
 <CABgObfYK_BC0U+iXC9Y8VPSRXJT+vwZHhzT+Db+N4hTTqEVKRA@mail.gmail.com>
In-Reply-To: <CABgObfYK_BC0U+iXC9Y8VPSRXJT+vwZHhzT+Db+N4hTTqEVKRA@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 26 Aug 2020 23:27:03 +0800
Message-ID: <CAE2XoE9tqet4KW34iUQBwRmNyNukJBx=srwc-LxWwE+v82XAWQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] meson: Convert undefsym.sh to undefsym.py
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000051ea1b05adc97475"
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x244.google.com
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
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000051ea1b05adc97475
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gotcha, I am confusing about submitting a patch, This is my script to
submit patch, but didn't got the things work.


https://wiki.qemu.org/Contribute/SubmitAPatch#Base_patches_against_current_=
git_master

Are very long, but I still didn't got the way how to submit patches
properly....

Windows bat for submit patch:

```
rd /s /q v2
git format-patch --subject-prefix=3D"PATCH v5" HEAD~6 -o v2/
git send-email --to=3Dqemu-devel@nongnu.org ^
"--cc=3DPaolo Bonzini ^<pbonzini@redhat.com^>,Daniel P. Berrang=C3=A9 ^<
berrange@redhat.com^>" v2
:: git send-email --annotate --to=3Dqemu-devel@nongnu.org --cc=3DQEMU
Developers <qemu-devel@nongnu.org> Paolo Bonzini <pbonzini@redhat.com> v2
pause
```

On Wed, Aug 26, 2020 at 11:23 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> Careful, the original script:
>
> -comm -12 \
> -  <( $NM -P -g $staticlib | awk '$2!=3D"U"{print "-Wl,-u," $1}' | sort -=
u) \
> -  <( $NM -P -g "$@" | awk '$2=3D=3D"U"{print "-Wl,-u," $1}' | sort -u)
>
> looks for lines that *are* U in the modules. So using filter_lines_set
> is correct for static libraries but wrong for modules.
>
> Paolo
>
> On Wed, Aug 26, 2020 at 5:13 PM <luoyonggang@gmail.com> wrote:
> >
> > From: Yonggang Luo <luoyonggang@gmail.com>
> >
> > undefsym.sh are not msys2 compatible, convert it to python script
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  meson.build         |  2 +-
> >  scripts/undefsym.py | 56 +++++++++++++++++++++++++++++++++++++++++++++
> >  scripts/undefsym.sh | 20 ----------------
> >  3 files changed, 57 insertions(+), 21 deletions(-)
> >  create mode 100644 scripts/undefsym.py
> >  delete mode 100755 scripts/undefsym.sh
> >
> > diff --git a/meson.build b/meson.build
> > index 1644bbd83c..d6e3bcea7e 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -845,7 +845,7 @@ foreach d, list : modules
> >  endforeach
> >
> >  nm =3D find_program('nm')
> > -undefsym =3D find_program('scripts/undefsym.sh')
> > +undefsym =3D find_program('scripts/undefsym.py')
> >  block_syms =3D custom_target('block.syms', output: 'block.syms',
> >                               input: [libqemuutil, block_mods],
> >                               capture: true,
> > diff --git a/scripts/undefsym.py b/scripts/undefsym.py
> > new file mode 100644
> > index 0000000000..ebc009fb24
> > --- /dev/null
> > +++ b/scripts/undefsym.py
> > @@ -0,0 +1,56 @@
> > +#!/usr/bin/env python3
> > +# -*- coding: utf-8 -*-
> > +
> > +# Before a shared module's DSO is produced, a static library is built
> for it
> > +# and passed to this script.  The script generates -Wl,-u options to
> force
> > +# the inclusion of symbol from libqemuutil.a if the shared modules nee=
d
> them,
> > +# This is necessary because the modules may use functions not needed b=
y
> the
> > +# executable itself, which would cause the function to not be linked i=
n.
> > +# Then the DSO loading would fail because of the missing symbol.
> > +
> > +
> > +"""
> > +Compare the static library for compute the symbol duplication
> > +"""
> > +
> > +import sys
> > +import subprocess
> > +
> > +def filter_lines_set(stdout):
> > +    linesSet =3D set()
> > +    for line in stdout.splitlines():
> > +        tokens =3D line.split(b' ')
> > +        if len(tokens) >=3D 1:
> > +            if len(tokens) > 1 and tokens[1] =3D=3D b'U':
> > +                continue
> > +            new_line =3D b'-Wl,-u,' + tokens[0]
> > +            if not new_line in linesSet:
> > +                linesSet.add(new_line)
> > +    return linesSet
> > +
> > +def main(args):
> > +    global _SCRIPT
> > +    print(" ".join(args),  file=3Dsys.stderr)
> > +    if len(args) <=3D 3:
> > +        sys.exit(0)
> > +
> > +    nm =3D args[1]
> > +    staticlib =3D args[2]
> > +    pc =3D subprocess.run([nm, "-P", "-g", staticlib],
> stdout=3Dsubprocess.PIPE)
> > +    if pc.returncode !=3D 0:
> > +        sys.exit(-1)
> > +    lines_set_left =3D filter_lines_set(pc.stdout)
> > +
> > +    shared_modules =3D args[3:]
> > +    pc =3D subprocess.run([nm, "-P", "-g"] + shared_modules,
> stdout=3Dsubprocess.PIPE)
> > +    if pc.returncode !=3D 0:
> > +        sys.exit(-1)
> > +    lines_set_right =3D filter_lines_set(pc.stdout)
> > +    lines =3D []
> > +    for line in sorted(list(lines_set_right)):
> > +        if line in lines_set_left:
> > +            lines.append(line)
> > +    sys.stdout.write(b'\n'.join(lines).decode())
> > +
> > +if __name__ =3D=3D "__main__":
> > +    main(sys.argv)
> > diff --git a/scripts/undefsym.sh b/scripts/undefsym.sh
> > deleted file mode 100755
> > index b9ec332e95..0000000000
> > --- a/scripts/undefsym.sh
> > +++ /dev/null
> > @@ -1,20 +0,0 @@
> > -#! /usr/bin/env bash
> > -
> > -# Before a shared module's DSO is produced, a static library is built
> for it
> > -# and passed to this script.  The script generates -Wl,-u options to
> force
> > -# the inclusion of symbol from libqemuutil.a if the shared modules nee=
d
> them,
> > -# This is necessary because the modules may use functions not needed b=
y
> the
> > -# executable itself, which would cause the function to not be linked i=
n.
> > -# Then the DSO loading would fail because of the missing symbol.
> > -
> > -if test $# -le 2; then
> > -  exit 0
> > -fi
> > -
> > -NM=3D$1
> > -staticlib=3D$2
> > -shift 2
> > -# Find symbols defined in static libraries and undefined in shared
> modules
> > -comm -12 \
> > -  <( $NM -P -g $staticlib | awk '$2!=3D"U"{print "-Wl,-u," $1}' | sort
> -u) \
> > -  <( $NM -P -g "$@" | awk '$2=3D=3D"U"{print "-Wl,-u," $1}' | sort -u)
> > --
> > 2.27.0.windows.1
> >
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000051ea1b05adc97475
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Gotcha, I am confusing about submitting a patch, This is m=
y script to submit patch, but didn&#39;t got the things work.<div><br></div=
><div><br></div><div><a href=3D"https://wiki.qemu.org/Contribute/SubmitAPat=
ch#Base_patches_against_current_git_master">https://wiki.qemu.org/Contribut=
e/SubmitAPatch#Base_patches_against_current_git_master</a>=C2=A0</div><div>=
Are very long, but I still didn&#39;t got the way how to submit patches pro=
perly....</div><div><br></div><div>Windows bat for submit patch:</div><div>=
<br></div><div>```</div><div>rd /s /q v2<br>git format-patch --subject-pref=
ix=3D&quot;PATCH v5&quot; HEAD~6 -o v2/<br>git send-email --to=3D<a href=3D=
"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a> ^<br>&quot;--cc=3D=
Paolo Bonzini ^&lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.c=
om</a>^&gt;,Daniel P. Berrang=C3=A9 ^&lt;<a href=3D"mailto:berrange@redhat.=
com">berrange@redhat.com</a>^&gt;&quot; v2<br>:: git send-email --annotate =
--to=3D<a href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a> -=
-cc=3DQEMU Developers &lt;<a href=3D"mailto:qemu-devel@nongnu.org">qemu-dev=
el@nongnu.org</a>&gt; Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.c=
om">pbonzini@redhat.com</a>&gt; v2<br>pause<br></div><div>```=C2=A0<br></di=
v></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr=
">On Wed, Aug 26, 2020 at 11:23 PM Paolo Bonzini &lt;<a href=3D"mailto:pbon=
zini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Careful, the original script:<br>
<br>
-comm -12 \<br>
-=C2=A0 &lt;( $NM -P -g $staticlib | awk &#39;$2!=3D&quot;U&quot;{print &qu=
ot;-Wl,-u,&quot; $1}&#39; | sort -u) \<br>
-=C2=A0 &lt;( $NM -P -g &quot;$@&quot; | awk &#39;$2=3D=3D&quot;U&quot;{pri=
nt &quot;-Wl,-u,&quot; $1}&#39; | sort -u)<br>
<br>
looks for lines that *are* U in the modules. So using filter_lines_set<br>
is correct for static libraries but wrong for modules.<br>
<br>
Paolo<br>
<br>
On Wed, Aug 26, 2020 at 5:13 PM &lt;<a href=3D"mailto:luoyonggang@gmail.com=
" target=3D"_blank">luoyonggang@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com" target=
=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt;<br>
&gt; undefsym.sh are not msys2 compatible, convert it to python script<br>
&gt;<br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
&gt;=C2=A0 scripts/undefsym.py | 56 +++++++++++++++++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 scripts/undefsym.sh | 20 ----------------<br>
&gt;=C2=A0 3 files changed, 57 insertions(+), 21 deletions(-)<br>
&gt;=C2=A0 create mode 100644 scripts/undefsym.py<br>
&gt;=C2=A0 delete mode 100755 scripts/undefsym.sh<br>
&gt;<br>
&gt; diff --git a/meson.build b/meson.build<br>
&gt; index 1644bbd83c..d6e3bcea7e 100644<br>
&gt; --- a/meson.build<br>
&gt; +++ b/meson.build<br>
&gt; @@ -845,7 +845,7 @@ foreach d, list : modules<br>
&gt;=C2=A0 endforeach<br>
&gt;<br>
&gt;=C2=A0 nm =3D find_program(&#39;nm&#39;)<br>
&gt; -undefsym =3D find_program(&#39;scripts/undefsym.sh&#39;)<br>
&gt; +undefsym =3D find_program(&#39;scripts/undefsym.py&#39;)<br>
&gt;=C2=A0 block_syms =3D custom_target(&#39;block.syms&#39;, output: &#39;=
block.syms&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input: [libqemuutil, block_mods],<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0capture: true,<br>
&gt; diff --git a/scripts/undefsym.py b/scripts/undefsym.py<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..ebc009fb24<br>
&gt; --- /dev/null<br>
&gt; +++ b/scripts/undefsym.py<br>
&gt; @@ -0,0 +1,56 @@<br>
&gt; +#!/usr/bin/env python3<br>
&gt; +# -*- coding: utf-8 -*-<br>
&gt; +<br>
&gt; +# Before a shared module&#39;s DSO is produced, a static library is b=
uilt for it<br>
&gt; +# and passed to this script.=C2=A0 The script generates -Wl,-u option=
s to force<br>
&gt; +# the inclusion of symbol from libqemuutil.a if the shared modules ne=
ed them,<br>
&gt; +# This is necessary because the modules may use functions not needed =
by the<br>
&gt; +# executable itself, which would cause the function to not be linked =
in.<br>
&gt; +# Then the DSO loading would fail because of the missing symbol.<br>
&gt; +<br>
&gt; +<br>
&gt; +&quot;&quot;&quot;<br>
&gt; +Compare the static library for compute the symbol duplication<br>
&gt; +&quot;&quot;&quot;<br>
&gt; +<br>
&gt; +import sys<br>
&gt; +import subprocess<br>
&gt; +<br>
&gt; +def filter_lines_set(stdout):<br>
&gt; +=C2=A0 =C2=A0 linesSet =3D set()<br>
&gt; +=C2=A0 =C2=A0 for line in stdout.splitlines():<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tokens =3D line.split(b&#39; &#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(tokens) &gt;=3D 1:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(tokens) &gt; 1 and t=
okens[1] =3D=3D b&#39;U&#39;:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 new_line =3D b&#39;-Wl,-u,&=
#39; + tokens[0]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not new_line in linesSet=
:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linesSet.add(=
new_line)<br>
&gt; +=C2=A0 =C2=A0 return linesSet<br>
&gt; +<br>
&gt; +def main(args):<br>
&gt; +=C2=A0 =C2=A0 global _SCRIPT<br>
&gt; +=C2=A0 =C2=A0 print(&quot; &quot;.join(args),=C2=A0 file=3Dsys.stderr=
)<br>
&gt; +=C2=A0 =C2=A0 if len(args) &lt;=3D 3:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(0)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 nm =3D args[1]<br>
&gt; +=C2=A0 =C2=A0 staticlib =3D args[2]<br>
&gt; +=C2=A0 =C2=A0 pc =3D subprocess.run([nm, &quot;-P&quot;, &quot;-g&quo=
t;, staticlib], stdout=3Dsubprocess.PIPE)<br>
&gt; +=C2=A0 =C2=A0 if pc.returncode !=3D 0:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(-1)<br>
&gt; +=C2=A0 =C2=A0 lines_set_left =3D filter_lines_set(pc.stdout)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 shared_modules =3D args[3:]<br>
&gt; +=C2=A0 =C2=A0 pc =3D subprocess.run([nm, &quot;-P&quot;, &quot;-g&quo=
t;] + shared_modules, stdout=3Dsubprocess.PIPE)<br>
&gt; +=C2=A0 =C2=A0 if pc.returncode !=3D 0:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(-1)<br>
&gt; +=C2=A0 =C2=A0 lines_set_right =3D filter_lines_set(pc.stdout)<br>
&gt; +=C2=A0 =C2=A0 lines =3D []<br>
&gt; +=C2=A0 =C2=A0 for line in sorted(list(lines_set_right)):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if line in lines_set_left:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lines.append(line)<br>
&gt; +=C2=A0 =C2=A0 sys.stdout.write(b&#39;\n&#39;.join(lines).decode())<br=
>
&gt; +<br>
&gt; +if __name__ =3D=3D &quot;__main__&quot;:<br>
&gt; +=C2=A0 =C2=A0 main(sys.argv)<br>
&gt; diff --git a/scripts/undefsym.sh b/scripts/undefsym.sh<br>
&gt; deleted file mode 100755<br>
&gt; index b9ec332e95..0000000000<br>
&gt; --- a/scripts/undefsym.sh<br>
&gt; +++ /dev/null<br>
&gt; @@ -1,20 +0,0 @@<br>
&gt; -#! /usr/bin/env bash<br>
&gt; -<br>
&gt; -# Before a shared module&#39;s DSO is produced, a static library is b=
uilt for it<br>
&gt; -# and passed to this script.=C2=A0 The script generates -Wl,-u option=
s to force<br>
&gt; -# the inclusion of symbol from libqemuutil.a if the shared modules ne=
ed them,<br>
&gt; -# This is necessary because the modules may use functions not needed =
by the<br>
&gt; -# executable itself, which would cause the function to not be linked =
in.<br>
&gt; -# Then the DSO loading would fail because of the missing symbol.<br>
&gt; -<br>
&gt; -if test $# -le 2; then<br>
&gt; -=C2=A0 exit 0<br>
&gt; -fi<br>
&gt; -<br>
&gt; -NM=3D$1<br>
&gt; -staticlib=3D$2<br>
&gt; -shift 2<br>
&gt; -# Find symbols defined in static libraries and undefined in shared mo=
dules<br>
&gt; -comm -12 \<br>
&gt; -=C2=A0 &lt;( $NM -P -g $staticlib | awk &#39;$2!=3D&quot;U&quot;{prin=
t &quot;-Wl,-u,&quot; $1}&#39; | sort -u) \<br>
&gt; -=C2=A0 &lt;( $NM -P -g &quot;$@&quot; | awk &#39;$2=3D=3D&quot;U&quot=
;{print &quot;-Wl,-u,&quot; $1}&#39; | sort -u)<br>
&gt; --<br>
&gt; 2.27.0.windows.1<br>
&gt;<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div>

--00000000000051ea1b05adc97475--

