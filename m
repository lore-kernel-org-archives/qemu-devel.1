Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4E7C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 21:26:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85B3620759
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 21:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tu8buc2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B3620759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTAlB-0002Rh-95
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 17:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTAjB-0000qr-P2
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 17:24:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32298)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTAj8-0001gq-EY
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 17:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602797036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yJqYnLXGxbRf2eN8a27EaIkzV/Yl6mWcwrOEF7PpKlQ=;
 b=Tu8buc2NfHrDyskb4fbrT7DmwyA85rSqQZpMhSx5O5vAkfsj3OuOZpWWIDDHjXBVi1/4oJ
 O+KbVDs3hi8SMfwgDoyKiZXmdyRqSoHORp4tseSr0Knp+R65uJZE2AtuAd8ui7rW6pYgjS
 N6RDm8R4b2JE4Q2SPKxonhsciFTM9mw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-D-zWNOqLPxGuYJm2DT1www-1; Thu, 15 Oct 2020 17:22:33 -0400
X-MC-Unique: D-zWNOqLPxGuYJm2DT1www-1
Received: by mail-ej1-f69.google.com with SMTP id ga21so62341ejb.14
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 14:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yJqYnLXGxbRf2eN8a27EaIkzV/Yl6mWcwrOEF7PpKlQ=;
 b=epHCZXVUqciB82mrSW5Z0K6yd4j7X8qcxer3eri6udZq8R5hOogVHFO1nkN6CGhu9a
 L+f8esXH8o/HTRrEJDDy2UKn0yV34izq3y5JUWfHRmClvHTSiL/C+13WPoym4chdFFH2
 vARN2njiohHLV8Bp6+TofPiGIFLHbdCsaO5xQa40r6pYWFDxkZhHH1tgbIYq3w8f+XB9
 Vn6luKnwE76ydfRlzMQcE1N5xNfTIbSQKAa+AQ70or+3AE/KxsNT9ptxW+qhq1myYO+I
 Qb3dMW+85DRkRGs3Ja3J1hAAQam3fjFomKGB8RCdHmHi0CmhYVwViCHhIVVuZdyX5uhy
 4Qpg==
X-Gm-Message-State: AOAM532+wQKLKNXsHI2Qjmdubsq0PM76ijDtncMXPA5CPCfGIAT7Uhe4
 8STrrrNM/j91abwaWQ3Kz4hEp05W0B+FM083y2RfOXOX6cZakvJBnnlfSyPRi1Xd+Uh1eS8R8oh
 Okqbcvt1luAtffMiD7676ZemDZIN1Jkc=
X-Received: by 2002:a17:906:9483:: with SMTP id
 t3mr335432ejx.390.1602796952312; 
 Thu, 15 Oct 2020 14:22:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVQMfjByYqSmwq2f+x6SPuAasjvZL89kmlgO/XcuvfrBTWqM+okcme6mAkO+I3cZ6KB+TmQe07rMCm2+CGmjg=
X-Received: by 2002:a17:906:9483:: with SMTP id
 t3mr335415ejx.390.1602796952098; 
 Thu, 15 Oct 2020 14:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201015201035.1964-1-luoyonggang@gmail.com>
 <20201015201035.1964-2-luoyonggang@gmail.com>
 <CAFEAcA_BtP6vgHpV8zS6U4dCgmB3npfbCOKGd1XOg9Jd0j8=nQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_BtP6vgHpV8zS6U4dCgmB3npfbCOKGd1XOg9Jd0j8=nQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Oct 2020 23:22:20 +0200
Message-ID: <CABgObfaA_zv-GWiM0fR=adRZ0wcMN=nEnNmL5Q32WkLFOZ7vMA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] docs: Fixes build docs on msys2/mingw
To: Peter Maydell <peter.maydell@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000fa323205b1bc3e75"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Yonggang Luo <luoyonggang@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fa323205b1bc3e75
Content-Type: text/plain; charset="UTF-8"

Il gio 15 ott 2020, 22:30 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> On Thu, 15 Oct 2020 at 21:13, Yonggang Luo <luoyonggang@gmail.com> wrote:
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  docs/conf.py                  |  2 +-
> >  docs/sphinx/kerneldoc.py      |  2 +-
> >  scripts/rst-sanitize.py       | 21 +++++++++++++++++++++
> >  tests/qapi-schema/meson.build |  5 +++--
> >  4 files changed, 26 insertions(+), 4 deletions(-)
> >  create mode 100644 scripts/rst-sanitize.py
> >
> > diff --git a/scripts/rst-sanitize.py b/scripts/rst-sanitize.py
> > new file mode 100644
> > index 0000000000..26060f1208
> > --- /dev/null
> > +++ b/scripts/rst-sanitize.py
> > @@ -0,0 +1,21 @@
> > +#!/usr/bin/env python3
> > +
> > +#
> > +# Script for remove cr line ending in file
> > +#
> > +# Authors:
> > +#  Yonggang Luo <luoyonggang@gmail.com>
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2
> > +# or, at your option, any later version.  See the COPYING file in
> > +# the top-level directory.
> > +
> > +import sys
> > +
> > +def main(_program, file, *unused):
> > +    with open(file, 'rb') as content_file:
> > +        content = content_file.read()
> > +        sys.stdout.buffer.write(content.replace(b'\r', b''))
> > +
> > +if __name__ == "__main__":
> > +    main(*sys.argv)
>
> Why doesn't the perl rune work? Your commit message doesn't say.
>

Ninjatool gets confused by Windows escapes. So it's a QEMU-ism and
switching to ninja fixes it. There's no need to use a separate script for
this.

Paolo


> > diff --git a/tests/qapi-schema/meson.build
> b/tests/qapi-schema/meson.build
> > index 1f222a7a13..20a7641af8 100644
> > --- a/tests/qapi-schema/meson.build
> > +++ b/tests/qapi-schema/meson.build
> > @@ -251,18 +251,19 @@ qapi_doc_out = custom_target('QAPI rST doc',
> >  # using an explicit '\' character in the command arguments to
> >  # a custom_target(), as Meson will unhelpfully replace it with a '/'
> >  # (https://github.com/mesonbuild/meson/issues/1564)
> > +rst_sanitize_cmd = [find_program('../../scripts/rst-sanitize.py'),
> '@INPUT@']
> >  qapi_doc_out_nocr = custom_target('QAPI rST doc newline-sanitized',
> >                                    output: ['doc-good.txt.nocr'],
> >                                    input: qapi_doc_out[0],
> >                                    build_by_default: build_docs,
> > -                                  command: ['perl', '-pe', '$x = chr
> 13; s/$x$//', '@INPUT@'],
> > +                                  command: rst_sanitize_cmd,
> >                                    capture: true)
> >
> >  qapi_doc_ref_nocr = custom_target('QAPI rST doc reference
> newline-sanitized',
> >                                    output: ['doc-good.ref.nocr'],
> >                                    input: files('doc-good.txt'),
> >                                    build_by_default: build_docs,
> > -                                  command: ['perl', '-pe', '$x = chr
> 13; s/$x$//', '@INPUT@'],
> > +                                  command: rst_sanitize_cmd,
> >                                    capture: true)
>
> thanks
> -- PMM
>
>

--000000000000fa323205b1bc3e75
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 15 ott 2020, 22:30 Peter Maydell &lt;<a href=3D=
"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; ha scrit=
to:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">On Thu, 15 Oct 2020 at 21:13, Y=
onggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com" target=3D"_blank" =
rel=3D"noreferrer">luoyonggang@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank" rel=3D"noreferrer">luoyonggang@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/conf.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 2 +-<br>
&gt;=C2=A0 docs/sphinx/kerneldoc.py=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
&gt;=C2=A0 scripts/rst-sanitize.py=C2=A0 =C2=A0 =C2=A0 =C2=A0| 21 +++++++++=
++++++++++++<br>
&gt;=C2=A0 tests/qapi-schema/meson.build |=C2=A0 5 +++--<br>
&gt;=C2=A0 4 files changed, 26 insertions(+), 4 deletions(-)<br>
&gt;=C2=A0 create mode 100644 scripts/rst-sanitize.py<br>
&gt;<br>
&gt; diff --git a/scripts/rst-sanitize.py b/scripts/rst-sanitize.py<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..26060f1208<br>
&gt; --- /dev/null<br>
&gt; +++ b/scripts/rst-sanitize.py<br>
&gt; @@ -0,0 +1,21 @@<br>
&gt; +#!/usr/bin/env python3<br>
&gt; +<br>
&gt; +#<br>
&gt; +# Script for remove cr line ending in file<br>
&gt; +#<br>
&gt; +# Authors:<br>
&gt; +#=C2=A0 Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com" tar=
get=3D"_blank" rel=3D"noreferrer">luoyonggang@gmail.com</a>&gt;<br>
&gt; +#<br>
&gt; +# This work is licensed under the terms of the GNU GPL, version 2<br>
&gt; +# or, at your option, any later version.=C2=A0 See the COPYING file i=
n<br>
&gt; +# the top-level directory.<br>
&gt; +<br>
&gt; +import sys<br>
&gt; +<br>
&gt; +def main(_program, file, *unused):<br>
&gt; +=C2=A0 =C2=A0 with open(file, &#39;rb&#39;) as content_file:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 content =3D content_file.read()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.stdout.buffer.write(content.replace(b=
&#39;\r&#39;, b&#39;&#39;))<br>
&gt; +<br>
&gt; +if __name__ =3D=3D &quot;__main__&quot;:<br>
&gt; +=C2=A0 =C2=A0 main(*sys.argv)<br>
<br>
Why doesn&#39;t the perl rune work? Your commit message doesn&#39;t say.<br=
></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Nin=
jatool gets confused by Windows escapes. So it&#39;s a QEMU-ism and switchi=
ng to ninja fixes it. There&#39;s no need to use a separate script for this=
.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D=
"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">
<br>
&gt; diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.b=
uild<br>
&gt; index 1f222a7a13..20a7641af8 100644<br>
&gt; --- a/tests/qapi-schema/meson.build<br>
&gt; +++ b/tests/qapi-schema/meson.build<br>
&gt; @@ -251,18 +251,19 @@ qapi_doc_out =3D custom_target(&#39;QAPI rST doc=
&#39;,<br>
&gt;=C2=A0 # using an explicit &#39;\&#39; character in the command argumen=
ts to<br>
&gt;=C2=A0 # a custom_target(), as Meson will unhelpfully replace it with a=
 &#39;/&#39;<br>
&gt;=C2=A0 # (<a href=3D"https://github.com/mesonbuild/meson/issues/1564" r=
el=3D"noreferrer noreferrer" target=3D"_blank">https://github.com/mesonbuil=
d/meson/issues/1564</a>)<br>
&gt; +rst_sanitize_cmd =3D [find_program(&#39;../../scripts/rst-sanitize.py=
&#39;), &#39;@INPUT@&#39;]<br>
&gt;=C2=A0 qapi_doc_out_nocr =3D custom_target(&#39;QAPI rST doc newline-sa=
nitized&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 output: [&#39;doc-g=
ood.txt.nocr&#39;],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input: qapi_doc_out=
[0],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 build_by_default: b=
uild_docs,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command: [&#39;perl&#39;,=
 &#39;-pe&#39;, &#39;$x =3D chr 13; s/$x$//&#39;, &#39;@INPUT@&#39;],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command: rst_sanitize_cmd=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 capture: true)<br>
&gt;<br>
&gt;=C2=A0 qapi_doc_ref_nocr =3D custom_target(&#39;QAPI rST doc reference =
newline-sanitized&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 output: [&#39;doc-g=
ood.ref.nocr&#39;],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input: files(&#39;d=
oc-good.txt&#39;),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 build_by_default: b=
uild_docs,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command: [&#39;perl&#39;,=
 &#39;-pe&#39;, &#39;$x =3D chr 13; s/$x$//&#39;, &#39;@INPUT@&#39;],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command: rst_sanitize_cmd=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 capture: true)<br>
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div></div></div>

--000000000000fa323205b1bc3e75--


