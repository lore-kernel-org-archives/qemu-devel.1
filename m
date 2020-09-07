Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6750C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 04:22:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D105021775
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 04:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaXkOvIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D105021775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF8fP-0000nA-Ms
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 00:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kF8ea-0007Kx-Oc; Mon, 07 Sep 2020 00:21:16 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:44626)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kF8eT-000779-W1; Mon, 07 Sep 2020 00:21:16 -0400
Received: by mail-lj1-x243.google.com with SMTP id b19so14395721lji.11;
 Sun, 06 Sep 2020 21:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=/p2TOiopRIgSurQLd4nhfiV/DqyqlmYffO/L0hz+0Vs=;
 b=VaXkOvIJdp8gD2hMXPpux0+qcWbFQhROWBFIUND+jdD+8RL+n39pwc5NZ2H9B4wCtM
 C12Qq3i5lCE0HuIPfh1tHKRFvQcpKj4UAYwqHIGvuDvXYnzYMDyQbhXlWVuDtDgDhXop
 7Su4wlzmXB7FveVMbmrfNPHEUis66G+gdArMVnhlA+Folkz/xozHpXOgdCxaUOeBftxU
 /AuyKM5vbYALo1rjmoznV4XGBSF14xHRpX/iZAsT2bdJcXuFv56osaU6vk1+MqW6eQm5
 Fj/YVrUGIBwN1FERhowZp8ZSXmfsjW1M09VddkLKI5VYTeCTmMd4f0t84S9H/lTO3CTq
 xIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=/p2TOiopRIgSurQLd4nhfiV/DqyqlmYffO/L0hz+0Vs=;
 b=R8rlJZEJ2jW9dmV3DL4GNps+5ynN1UB8Ks7eaC9LVbA++podwEzeH2h1X4S4tMhJzf
 o+HIMRm4GDdnW5GRarh2Tpn2PCya/lKTTrsE7b9o3vTWrOdenCsRKX9BlwQP34x5IRH3
 +7hcmsMrNzSwusLdkF9HAbrTnpjzNv6eEW7JKCl6/+gHDwdk4ZdIjByA9Npw9o2H2xMQ
 VZpRWSZoebNoJAib1nawKsApVzqVclxMl8Nb2/S4c14eGRoNG8ViLV+HFpNL3Da/ipxQ
 GW3VZBwsAzXkz+NXn3zQold4jzxxjQRmkndzviyyEUMNxCzGSa4/mXRSDKBN3eQu9jwu
 69tQ==
X-Gm-Message-State: AOAM533lspj4FQN5HTr8mcubUXuL6IlEMxtMGJYr0EirVUgEmizlN/KM
 xByTxoVnY7xmkXpu78D7lU3cYMRkMih+S7OHkgM=
X-Google-Smtp-Source: ABdhPJwc3ydj98+jdE+s6JcWOeQ2NV/7TqhBaTZik1Ch8JZv068DweQ7bJCvV0vt1h5Qee5QpodS7X84oKwmu9zFxuE=
X-Received: by 2002:a2e:854c:: with SMTP id u12mr9149602ljj.120.1599452466163; 
 Sun, 06 Sep 2020 21:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200905062333.1087-1-luoyonggang@gmail.com>
 <20200905062333.1087-10-luoyonggang@gmail.com>
 <cdbe94fa-01a3-52b2-c2bc-6f92d2fda154@redhat.com>
In-Reply-To: <cdbe94fa-01a3-52b2-c2bc-6f92d2fda154@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 7 Sep 2020 12:20:55 +0800
Message-ID: <CAE2XoE_AdBDZV7HD6U4hn3SJOcU7TvR-_BD_dv=jPeShPO4P6Q@mail.gmail.com>
Subject: Re: [PATCH v5 09/11] meson: Fixes qapi tests.
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000014b50405aeb18ce7"
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Block <qemu-block@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>,
 qemu-level <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000014b50405aeb18ce7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2020 at 4:42 PM Thomas Huth <thuth@redhat.com> wrote:

> On 05/09/2020 08.23, Yonggang Luo wrote:
> > The error are:
> > +@end table
> > +
> > +@end deftypefn
> > +
> > make: *** [Makefile.mtest:63: check-qapi-schema] Error 1
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  tests/qapi-schema/meson.build | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tests/qapi-schema/meson.build
> b/tests/qapi-schema/meson.build
> > index c87d141417..67ba0a5ebd 100644
> > --- a/tests/qapi-schema/meson.build
> > +++ b/tests/qapi-schema/meson.build
> > @@ -220,6 +220,7 @@ qapi_doc =3D custom_target('QAPI doc',
> >
> >  # "full_path()" needed here to work around
> >  # https://github.com/mesonbuild/meson/issues/7585
> > -test('QAPI doc', diff, args: ['-u', files('doc-good.texi'),
> qapi_doc[0].full_path()],
> > +test('QAPI doc', diff, args: ['--strip-trailing-cr',
> > +                              '-u', files('doc-good.texi'),
> qapi_doc[0].full_path()],
>
> I just had a look at the POSIX man page of "diff", and it seems like
> "'--strip-trailing-cr" is not a portable option :-( Thus this will
> likely fail on the BSDs and Solaris-based systems.
> I think it's maybe best if you replace it with "-b" instead.

updated

>
>  Thomas
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000014b50405aeb18ce7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Sep 5, 2020 at 4:42 PM Thomas=
 Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 05/09/2020=
 08.23, Yonggang Luo wrote:<br>
&gt; The error are:<br>
&gt; +@end table<br>
&gt; +<br>
&gt; +@end deftypefn<br>
&gt; +<br>
&gt; make: *** [Makefile.mtest:63: check-qapi-schema] Error 1<br>
&gt; <br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 tests/qapi-schema/meson.build | 3 ++-<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.b=
uild<br>
&gt; index c87d141417..67ba0a5ebd 100644<br>
&gt; --- a/tests/qapi-schema/meson.build<br>
&gt; +++ b/tests/qapi-schema/meson.build<br>
&gt; @@ -220,6 +220,7 @@ qapi_doc =3D custom_target(&#39;QAPI doc&#39;,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 # &quot;full_path()&quot; needed here to work around<br>
&gt;=C2=A0 # <a href=3D"https://github.com/mesonbuild/meson/issues/7585" re=
l=3D"noreferrer" target=3D"_blank">https://github.com/mesonbuild/meson/issu=
es/7585</a><br>
&gt; -test(&#39;QAPI doc&#39;, diff, args: [&#39;-u&#39;, files(&#39;doc-go=
od.texi&#39;), qapi_doc[0].full_path()],<br>
&gt; +test(&#39;QAPI doc&#39;, diff, args: [&#39;--strip-trailing-cr&#39;,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-u&#39;, files(&#39;doc-good.texi&=
#39;), qapi_doc[0].full_path()],<br>
<br>
I just had a look at the POSIX man page of &quot;diff&quot;, and it seems l=
ike<br>
&quot;&#39;--strip-trailing-cr&quot; is not a portable option :-( Thus this=
 will<br>
likely fail on the BSDs and Solaris-based systems.<br>
I think it&#39;s maybe best if you replace it with &quot;-b&quot; instead.<=
/blockquote><div>updated=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
=C2=A0Thomas<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--00000000000014b50405aeb18ce7--

