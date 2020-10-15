Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8629FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 21:34:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E1D320759
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 21:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uNgYy8oC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1D320759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTAtW-0000Oh-C4
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 17:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTAsG-0008NW-An
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 17:33:24 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e]:46224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTAsE-0002vG-88
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 17:33:24 -0400
Received: by mail-lf1-x12e.google.com with SMTP id v6so332077lfa.13
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 14:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=+aNeSTOaDDFMnEfVibBRPSQnDePQ0b4XWHlAPHOKf4s=;
 b=uNgYy8oCIGirdivRatZ/DDNmj6E078+6PqtI4nXRGUMuzDTG6yvlg+3Tp84vJLtxlr
 gAsqEzus/Cc3BueFZxf2S+RAZNzLWNFTl0bcAXfUsh/CXBLmj8QADGR4pUTF1WrJab1u
 wmDGDCcLLenRlJfYeb8Ahuqw8BAF8DEBFJ88UUCHMgQouPPhDJEWY2ZNdhkdIbxbeyA6
 Ljxnod+g9736DzvBjDwvZUwzJ+s+VF5zshsEAD9k5DtSxkckq02yKUuc9aiSj239gl/T
 4RmSa4NmDxNHtW3LlQ+3DtdIVcNv60a/irQS3Ldic9P4lpoEfDX1ZQT4LcRBAhN9gjke
 /KsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=+aNeSTOaDDFMnEfVibBRPSQnDePQ0b4XWHlAPHOKf4s=;
 b=JU0mssfD24UWBgv5jLwXDHlKfIw6h51N3v+lAgUh0UC8/wBSBX3yaYVBG+PW+XGzRc
 A19r0NarHXQFSBv79LyRbvmGugno+BBqHnpzwbB4NyKtoT/leKB4n962ZI8F0F0jtGya
 pr0ZgTXCJqrswGo6RrF69I7tjMxwe2wj8bacjQeqFfRNbM29/qWztItFEApdOVZoOhwH
 dbVN48WOUfK9/O8TsLTOGxhEb67W/mTzNop9zVWx6aR+YRTLyVWibIAGZdRKflTQOLxq
 ARxOb7vElSfbcXFnNVPNAI/ObHAcOfB1+mgPHVPH1BxHaiIjTach3Rb1sYaM4z6Jv5y7
 l4uA==
X-Gm-Message-State: AOAM531ZW3NiUECv087pp1el8qhd7twB9m61yVtH4Uz2kr62PnyPGsgj
 oCC7BDtrNNlaiykzNbFYhga45wKu/69+GoBybl4=
X-Google-Smtp-Source: ABdhPJxS0c2dyzAPuP1jLRD0mjIfLYVpHqEBdtk+1yWc8E216D0XqHdyfdO0mabnx468j2fST198j5FHEP/r7XR8IoE=
X-Received: by 2002:ac2:4ed0:: with SMTP id p16mr165876lfr.554.1602797600212; 
 Thu, 15 Oct 2020 14:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201015201035.1964-1-luoyonggang@gmail.com>
 <20201015201035.1964-2-luoyonggang@gmail.com>
 <CAFEAcA_BtP6vgHpV8zS6U4dCgmB3npfbCOKGd1XOg9Jd0j8=nQ@mail.gmail.com>
 <CABgObfaA_zv-GWiM0fR=adRZ0wcMN=nEnNmL5Q32WkLFOZ7vMA@mail.gmail.com>
In-Reply-To: <CABgObfaA_zv-GWiM0fR=adRZ0wcMN=nEnNmL5Q32WkLFOZ7vMA@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 16 Oct 2020 05:33:08 +0800
Message-ID: <CAE2XoE8MJao1qOKazsKbFTMcTejFOnjV4z2WHxH_f2OUB1=hfw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] docs: Fixes build docs on msys2/mingw
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009b8c4505b1bc65c6"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x12e.google.com
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

--0000000000009b8c4505b1bc65c6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It's tests, running by make

On Fri, Oct 16, 2020 at 5:23 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
>
> Il gio 15 ott 2020, 22:30 Peter Maydell <peter.maydell@linaro.org> ha
scritto:
>>
>> On Thu, 15 Oct 2020 at 21:13, Yonggang Luo <luoyonggang@gmail.com> wrote=
:
>> >
>> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>> > ---
>> >  docs/conf.py                  |  2 +-
>> >  docs/sphinx/kerneldoc.py      |  2 +-
>> >  scripts/rst-sanitize.py       | 21 +++++++++++++++++++++
>> >  tests/qapi-schema/meson.build |  5 +++--
>> >  4 files changed, 26 insertions(+), 4 deletions(-)
>> >  create mode 100644 scripts/rst-sanitize.py
>> >
>> > diff --git a/scripts/rst-sanitize.py b/scripts/rst-sanitize.py
>> > new file mode 100644
>> > index 0000000000..26060f1208
>> > --- /dev/null
>> > +++ b/scripts/rst-sanitize.py
>> > @@ -0,0 +1,21 @@
>> > +#!/usr/bin/env python3
>> > +
>> > +#
>> > +# Script for remove cr line ending in file
>> > +#
>> > +# Authors:
>> > +#  Yonggang Luo <luoyonggang@gmail.com>
>> > +#
>> > +# This work is licensed under the terms of the GNU GPL, version 2
>> > +# or, at your option, any later version.  See the COPYING file in
>> > +# the top-level directory.
>> > +
>> > +import sys
>> > +
>> > +def main(_program, file, *unused):
>> > +    with open(file, 'rb') as content_file:
>> > +        content =3D content_file.read()
>> > +        sys.stdout.buffer.write(content.replace(b'\r', b''))
>> > +
>> > +if __name__ =3D=3D "__main__":
>> > +    main(*sys.argv)
>>
>> Why doesn't the perl rune work? Your commit message doesn't say.
>
>
> Ninjatool gets confused by Windows escapes. So it's a QEMU-ism and
switching to ninja fixes it. There's no need to use a separate script for
this.
>
> Paolo
>
>>
>> > diff --git a/tests/qapi-schema/meson.build
b/tests/qapi-schema/meson.build
>> > index 1f222a7a13..20a7641af8 100644
>> > --- a/tests/qapi-schema/meson.build
>> > +++ b/tests/qapi-schema/meson.build
>> > @@ -251,18 +251,19 @@ qapi_doc_out =3D custom_target('QAPI rST doc',
>> >  # using an explicit '\' character in the command arguments to
>> >  # a custom_target(), as Meson will unhelpfully replace it with a '/'
>> >  # (https://github.com/mesonbuild/meson/issues/1564)
>> > +rst_sanitize_cmd =3D [find_program('../../scripts/rst-sanitize.py'),
'@INPUT@']
>> >  qapi_doc_out_nocr =3D custom_target('QAPI rST doc newline-sanitized',
>> >                                    output: ['doc-good.txt.nocr'],
>> >                                    input: qapi_doc_out[0],
>> >                                    build_by_default: build_docs,
>> > -                                  command: ['perl', '-pe', '$x =3D ch=
r
13; s/$x$//', '@INPUT@'],
>> > +                                  command: rst_sanitize_cmd,
>> >                                    capture: true)
>> >
>> >  qapi_doc_ref_nocr =3D custom_target('QAPI rST doc reference
newline-sanitized',
>> >                                    output: ['doc-good.ref.nocr'],
>> >                                    input: files('doc-good.txt'),
>> >                                    build_by_default: build_docs,
>> > -                                  command: ['perl', '-pe', '$x =3D ch=
r
13; s/$x$//', '@INPUT@'],
>> > +                                  command: rst_sanitize_cmd,
>> >                                    capture: true)
>>
>> thanks
>> -- PMM
>>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000009b8c4505b1bc65c6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">It&#39;s tests, running by make<br><br>On Fri, Oct 16, 202=
0 at 5:23 AM Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonz=
ini@redhat.com</a>&gt; wrote:<br>&gt;<br>&gt;<br>&gt;<br>&gt; Il gio 15 ott=
 2020, 22:30 Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">=
peter.maydell@linaro.org</a>&gt; ha scritto:<br>&gt;&gt;<br>&gt;&gt; On Thu=
, 15 Oct 2020 at 21:13, Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmai=
l.com">luoyonggang@gmail.com</a>&gt; wrote:<br>&gt;&gt; &gt;<br>&gt;&gt; &g=
t; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com"=
>luoyonggang@gmail.com</a>&gt;<br>&gt;&gt; &gt; ---<br>&gt;&gt; &gt; =C2=A0=
docs/conf.py =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| =C2=A02 +-<br>&gt;&gt; &gt; =C2=A0docs/sphinx/kerneldoc.py =C2=A0 =C2=A0 =
=C2=A0| =C2=A02 +-<br>&gt;&gt; &gt; =C2=A0scripts/rst-sanitize.py =C2=A0 =
=C2=A0 =C2=A0 | 21 +++++++++++++++++++++<br>&gt;&gt; &gt; =C2=A0tests/qapi-=
schema/meson.build | =C2=A05 +++--<br>&gt;&gt; &gt; =C2=A04 files changed, =
26 insertions(+), 4 deletions(-)<br>&gt;&gt; &gt; =C2=A0create mode 100644 =
scripts/rst-sanitize.py<br>&gt;&gt; &gt;<br>&gt;&gt; &gt; diff --git a/scri=
pts/rst-sanitize.py b/scripts/rst-sanitize.py<br>&gt;&gt; &gt; new file mod=
e 100644<br>&gt;&gt; &gt; index 0000000000..26060f1208<br>&gt;&gt; &gt; ---=
 /dev/null<br>&gt;&gt; &gt; +++ b/scripts/rst-sanitize.py<br>&gt;&gt; &gt; =
@@ -0,0 +1,21 @@<br>&gt;&gt; &gt; +#!/usr/bin/env python3<br>&gt;&gt; &gt; =
+<br>&gt;&gt; &gt; +#<br>&gt;&gt; &gt; +# Script for remove cr line ending =
in file<br>&gt;&gt; &gt; +#<br>&gt;&gt; &gt; +# Authors:<br>&gt;&gt; &gt; +=
# =C2=A0Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com">luoyongga=
ng@gmail.com</a>&gt;<br>&gt;&gt; &gt; +#<br>&gt;&gt; &gt; +# This work is l=
icensed under the terms of the GNU GPL, version 2<br>&gt;&gt; &gt; +# or, a=
t your option, any later version.=C2=A0 See the COPYING file in<br>&gt;&gt;=
 &gt; +# the top-level directory.<br>&gt;&gt; &gt; +<br>&gt;&gt; &gt; +impo=
rt sys<br>&gt;&gt; &gt; +<br>&gt;&gt; &gt; +def main(_program, file, *unuse=
d):<br>&gt;&gt; &gt; + =C2=A0 =C2=A0with open(file, &#39;rb&#39;) as conten=
t_file:<br>&gt;&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0content =3D content_f=
ile.read()<br>&gt;&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.stdout.buffer.=
write(content.replace(b&#39;\r&#39;, b&#39;&#39;))<br>&gt;&gt; &gt; +<br>&g=
t;&gt; &gt; +if __name__ =3D=3D &quot;__main__&quot;:<br>&gt;&gt; &gt; + =
=C2=A0 =C2=A0main(*sys.argv)<br>&gt;&gt;<br>&gt;&gt; Why doesn&#39;t the pe=
rl rune work? Your commit message doesn&#39;t say.<br>&gt;<br>&gt;<br>&gt; =
Ninjatool gets confused by Windows escapes. So it&#39;s a QEMU-ism and swit=
ching to ninja fixes it. There&#39;s no need to use a separate script for t=
his.<br>&gt;<br>&gt; Paolo<br>&gt;<br>&gt;&gt;<br>&gt;&gt; &gt; diff --git =
a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build<br>&gt;&gt;=
 &gt; index 1f222a7a13..20a7641af8 100644<br>&gt;&gt; &gt; --- a/tests/qapi=
-schema/meson.build<br>&gt;&gt; &gt; +++ b/tests/qapi-schema/meson.build<br=
>&gt;&gt; &gt; @@ -251,18 +251,19 @@ qapi_doc_out =3D custom_target(&#39;QA=
PI rST doc&#39;,<br>&gt;&gt; &gt; =C2=A0# using an explicit &#39;\&#39; cha=
racter in the command arguments to<br>&gt;&gt; &gt; =C2=A0# a custom_target=
(), as Meson will unhelpfully replace it with a &#39;/&#39;<br>&gt;&gt; &gt=
; =C2=A0# (<a href=3D"https://github.com/mesonbuild/meson/issues/1564">http=
s://github.com/mesonbuild/meson/issues/1564</a>)<br>&gt;&gt; &gt; +rst_sani=
tize_cmd =3D [find_program(&#39;../../scripts/rst-sanitize.py&#39;), &#39;@=
INPUT@&#39;]<br>&gt;&gt; &gt; =C2=A0qapi_doc_out_nocr =3D custom_target(&#3=
9;QAPI rST doc newline-sanitized&#39;,<br>&gt;&gt; &gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0output: [&#39;doc-good.txt.nocr&#39;],<br=
>&gt;&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input: qa=
pi_doc_out[0],<br>&gt;&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0build_by_default: build_docs,<br>&gt;&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0command: [&#39;perl&#39;, &#39;-pe&#39;, &#3=
9;$x =3D chr 13; s/$x$//&#39;, &#39;@INPUT@&#39;],<br>&gt;&gt; &gt; + =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0command: rst_sanitize_cmd,<br>&gt;=
&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0capture: true=
)<br>&gt;&gt; &gt;<br>&gt;&gt; &gt; =C2=A0qapi_doc_ref_nocr =3D custom_targ=
et(&#39;QAPI rST doc reference newline-sanitized&#39;,<br>&gt;&gt; &gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0output: [&#39;doc-good.ref.=
nocr&#39;],<br>&gt;&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0input: files(&#39;doc-good.txt&#39;),<br>&gt;&gt; &gt; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0build_by_default: build_docs,<br>&gt;=
&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0command: [&#39;perl&=
#39;, &#39;-pe&#39;, &#39;$x =3D chr 13; s/$x$//&#39;, &#39;@INPUT@&#39;],<=
br>&gt;&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0command: rst_=
sanitize_cmd,<br>&gt;&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0capture: true)<br>&gt;&gt;<br>&gt;&gt; thanks<br>&gt;&gt; -- PMM<=
br>&gt;&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo</div>

--0000000000009b8c4505b1bc65c6--

