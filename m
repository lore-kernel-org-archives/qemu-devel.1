Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A813DC433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 10:16:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D01620663
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 10:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cs6ZgcoV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D01620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHP3x-0006Gw-CZ
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 06:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHP3H-0005PL-QW
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 06:16:07 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:40846)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHP3F-0003SL-Mw
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 06:16:07 -0400
Received: by mail-lj1-x241.google.com with SMTP id s205so16077078lja.7
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 03:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=mNmrvo8yAMqubBqg/kOxlQh0QcxzZEnVg5pgR5+988w=;
 b=Cs6ZgcoVOiqakSBQ6lC8qp0tltVGZ+TurNhtWOSYizfnWlO9CZvTQAFLC80N75Ct3L
 1nzD/tV5tH34A7WGV8pcYQNA7IeI9Dqsu13YAyUbTY9pa7j0F7ZzKCAcTyKAUJG5Rvk+
 qhBIevYGy66HhqwaKWvOzUUFcq+PT/oa+MQHdhFi3V8dz+oL/t2ejO5ti1MKWWYyJRPJ
 NL2MG7SzExNrUdHupiOEWq22317BK7UfEUGVf8Kgxmt1UJo4ckR4FZ/m4h9FKcl4S05W
 nAHdVQp3yve/D55FuO2ZuodGAZ1rq9deQZ6t2t9GF7kAQ0hDHg/g3jfamUZVFjlxujkS
 JnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=mNmrvo8yAMqubBqg/kOxlQh0QcxzZEnVg5pgR5+988w=;
 b=fN/6wknxdwLm+/IN55ey4qqM0BtOhZsLH/J68XaYghBbi9gv7H2V+MC1iMgSLwAWkW
 IY6M9Mb2zdlvIJ4mbPjvnq8YgRo7L+cjHmTZ0aeUDU46HjcY02HmF+OmE9e966oHGXEb
 B0hMO7wqgXKSPhyt9LrHxWGj4+y00bWUBqac5uDMQtMYsPenjZfaoNgxqseW6XbvdesL
 FNaU/ejYRjDZU6NoE9WACxORvyp8Nw5ScAZjyv5cNAyQS5S8v7kiMwJ63YrmdxgCTHLm
 J01jeFj421UbvqQiJDCYOZoyh6MlHPM+rj7z8xPrMcAhjsTc2CrrrSGSU22YhYfTSe5o
 iqcg==
X-Gm-Message-State: AOAM5307Gx8bSWunJUTrL1akq3SPYP3fi60AI6/MoPwuew4ow1+XjLhL
 d2KpU1DWpswYvtCdCl8OC25iByuleLdrbv+5khc=
X-Google-Smtp-Source: ABdhPJwRi8V/3iqsjfoIi6PEx43Is1+FclCQksc8rD4IpbITd48/UBXySBKto5Rzck/Ajc4QDa1BLmAiSgnP/XlYeQA=
X-Received: by 2002:a2e:9dc7:: with SMTP id x7mr3721864ljj.447.1599992163905; 
 Sun, 13 Sep 2020 03:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200913100534.22084-1-pbonzini@redhat.com>
In-Reply-To: <20200913100534.22084-1-pbonzini@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sun, 13 Sep 2020 18:15:52 +0800
Message-ID: <CAE2XoE8sgGfeoxn7+g4vEnYF52Axx3DOA=37hCO05sCkf+cEdw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Automatically convert configure options to meson
 build options
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000092b2a405af2f347f"
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000092b2a405af2f347f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2020 at 6:07 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> Right now meson_options.txt lists less than a dozen options, but about
> 40 more could come as configure tests are converted and moved to
> meson.build.  Each option needs code in configure to parse it and pass
> the option down to Meson as a -D command-line argument; in addition the
> default must be duplicated between configure and meson_options.txt.
>
> This series tries to remove the code duplication by passing unknown
> --enable and --disable options to a Python program, and using
> Meson's introspection support to match those to meson_options.txt
>
> The disadvantages are:
>
> - because we parse command-line options before meson is available,
> the introspection output is stored in the source tree.  The output
> is slightly modified using the "jq" tool in order to ensure that it's
> stable and that modifications to meson_buildoptions.txt do not cause
> horrible conflicts.  This is the main reason for the unattractive
> diffstat (the number of JSON lines added is higher than the number
> of configure lines removed, though of course the latter are code
> that must be maintained manually and the former is not).
>
> - we now need Python to generate the full help, so if Python is
> missing we can only print a partial message and direct the user
> to specify the interpreter with --python.  It would be possible to fix
> this by rewriting the script in Perl (at least on Fedora, JSON::PP is
> always installed if Perl is, because it's a dependency for CPAN; I'd
> have to check Ubuntu and the BSDs), or if we want to write it as a
> Bourne shell script, to further massage the introspection output into
> for example TAB-separated values.
>
I am confusing about this? we were converting configure to meson, and
python is a
force dependencies, why we need rewrite the script in Perl? If we wanna
build qemu, the first thing
we need to install is python+meson, so there is no need convert to Perl or
bash script.
And perl/bash will incur msys2/mingw user, the ideal way is we only depends
on python+meson to building qemu

>
> Opinions are welcome on whether this is worthwhile and how to solve
> the above doubts.
>
> Paolo
>
> Paolo Bonzini (3):
>   configure: quote command line arguments in config.status
>   configure: early test for Python
>   configure: automatically parse command line for meson -D options
>
>  Makefile                                |   6 ++
>  configure                               | 107 ++++++++-----------
>  docs/devel/build-system.rst             |  35 +------
>  meson-buildoptions.json                 | 130 ++++++++++++++++++++++++
>  scripts/configure-parse-buildoptions.py |  94 +++++++++++++++++
>  5 files changed, 280 insertions(+), 92 deletions(-)
>  create mode 100644 meson-buildoptions.json
>  create mode 100644 scripts/configure-parse-buildoptions.py
>
> --
> 2.26.2
>
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000092b2a405af2f347f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Sep 13, 2020 at 6:07 PM Paolo=
 Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Righ=
t now meson_options.txt lists less than a dozen options, but about<br>
40 more could come as configure tests are converted and moved to<br>
meson.build.=C2=A0 Each option needs code in configure to parse it and pass=
<br>
the option down to Meson as a -D command-line argument; in addition the<br>
default must be duplicated between configure and meson_options.txt.<br>
<br>
This series tries to remove the code duplication by passing unknown<br>
--enable and --disable options to a Python program, and using<br>
Meson&#39;s introspection support to match those to meson_options.txt<br>
<br>
The disadvantages are:<br>
<br>
- because we parse command-line options before meson is available,<br>
the introspection output is stored in the source tree.=C2=A0 The output<br>
is slightly modified using the &quot;jq&quot; tool in order to ensure that =
it&#39;s<br>
stable and that modifications to meson_buildoptions.txt do not cause<br>
horrible conflicts.=C2=A0 This is the main reason for the unattractive<br>
diffstat (the number of JSON lines added is higher than the number<br>
of configure lines removed, though of course the latter are code<br>
that must be maintained manually and the former is not).<br>
<br>
- we now need Python to generate the full help, so if Python is<br>
missing we can only print a partial message and direct the user<br>
to specify the interpreter with --python.=C2=A0 It would be possible to fix=
<br>
this by rewriting the script in Perl (at least on Fedora, JSON::PP is<br>
always installed if Perl is, because it&#39;s a dependency for CPAN; I&#39;=
d<br>
have to check Ubuntu and the BSDs), or if we want to write it as a<br>
Bourne shell script, to further massage the introspection output into<br>
for example TAB-separated values.<br></blockquote><div>I am confusing about=
 this? we were converting configure to meson, and python is a=C2=A0</div><d=
iv>force dependencies, why we need rewrite the script in Perl? If we wanna =
build qemu, the first thing</div><div>we need to install is python+meson, s=
o there is no need convert to Perl or bash script.</div><div>And perl/bash =
will incur msys2/mingw user, the ideal way is we only depends on python+mes=
on to building qemu</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Opinions are welcome on whether this is worthwhile and how to solve<br>
the above doubts.<br>
<br>
Paolo<br>
<br>
Paolo Bonzini (3):<br>
=C2=A0 configure: quote command line arguments in config.status<br>
=C2=A0 configure: early test for Python<br>
=C2=A0 configure: automatically parse command line for meson -D options<br>
<br>
=C2=A0Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 ++<br>
=C2=A0configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 107 ++++++++---------=
--<br>
=C2=A0docs/devel/build-system.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 35 +------<br>
=C2=A0meson-buildoptions.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 130 ++++++++++++++++++++++++<br>
=C2=A0scripts/configure-parse-buildoptions.py |=C2=A0 94 +++++++++++++++++<=
br>
=C2=A05 files changed, 280 insertions(+), 92 deletions(-)<br>
=C2=A0create mode 100644 meson-buildoptions.json<br>
=C2=A0create mode 100644 scripts/configure-parse-buildoptions.py<br>
<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--00000000000092b2a405af2f347f--

