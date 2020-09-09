Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A0DC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:19:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4CC12087C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2b9bIDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4CC12087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFvKA-0003Yv-Rn
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 04:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFvIQ-0001bw-Rs; Wed, 09 Sep 2020 04:17:38 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:43519)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFvIN-0003l4-MG; Wed, 09 Sep 2020 04:17:37 -0400
Received: by mail-lj1-x244.google.com with SMTP id u4so2315309ljd.10;
 Wed, 09 Sep 2020 01:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=VmeqkUuoZgXbR647VaBOx6PnGkZQ68f18yV8qIw6WR0=;
 b=o2b9bIDTvGtdOm7gxYMVbRyxCN+sDmtI+g28qdLL4HNJn8seZdZa5encCEDOG2ckcO
 HJ4Xs0frGFJ3/P4pGcoyDtrGHvrJ9KpORxi23yX9D+RgJVtL62+M0fmFkIYSYEurfyrZ
 FpezXdx6JzI4FjkdmUVbTZrI/R/mb2fOLsLnJmOgvn+lrbeS9IOId6mx5+rC27sRbGgA
 7VWPtcIoXPISqHYBUEU3J9qDRdYV5WxD+zjjksqDhCTJ3k7H9ZCl7duNRkmMg6ZiT4Sy
 xZJ9SKebrErmLZNE6JJ104n+QG0aXFRZrclZBvV1vxeNrLJArVzm3N4KS/7MKRh+jHFg
 BpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=VmeqkUuoZgXbR647VaBOx6PnGkZQ68f18yV8qIw6WR0=;
 b=ETWz1I1PdCraNiA7+sag/6xVrLPliT3kPLQfaHEf7CoWnvFvHeo3B7/AmXonrhPbG7
 NgVjtOEId+Vn51+pPh1XHVo0vP39H/hLNAnjtV2Ko+xTmSq8OrSMSfhxBAAOLL0RgYFb
 dke1Clj9yAKNTlqWvKDu8R2duNQ7Rf80kz8RIMhZ7AP9/zmj7+noKn55rsecCBkQGcQ3
 Rrj2CSoQPZgtl0IUz+0nLlELfEwN3WGToqcD4jfhJOadinoQMmE/Kk7suD9la3zdyhkx
 vAsM82LSznyR7zxV1WxJ38h7ftK+ckWc/k6Y6yekGm8KQggLtRSl5QUHe9ATFP842SWJ
 c20A==
X-Gm-Message-State: AOAM532GhFY5G/n8gJSIi5m2s6B24QYfMdVvFmWAAWuxiIM9rpwmjBxS
 8xYwBjeuY6SIgNYOluFxozDlVZaTA4e7xzQTHqM=
X-Google-Smtp-Source: ABdhPJxA551cc3S36I5Djo/x2T/M/CNd0OYCLTYs1bF5OJDaenIjzD64Eh1j+UWm0olqOM62/6enG/DnHpOcqoQEjSQ=
X-Received: by 2002:a05:651c:151:: with SMTP id
 c17mr1362728ljd.467.1599639453499; 
 Wed, 09 Sep 2020 01:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200908194820.702-1-luoyonggang@gmail.com>
 <20200908194820.702-12-luoyonggang@gmail.com>
 <20200909081021.GD1011023@redhat.com>
In-Reply-To: <20200909081021.GD1011023@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 9 Sep 2020 16:17:22 +0800
Message-ID: <CAE2XoE9-DzwqXw7mh8jom8f2Bu+i1jSqxoD+C=4ZbnA-B_X7Xg@mail.gmail.com>
Subject: Re: [PATCH 11/16] meson: disable crypto tests are empty under win32
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006506e705aedd15d2"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Qemu-block <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Markus Armbruster <armbru@redhat.com>, Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006506e705aedd15d2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2020 at 4:11 PM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
>
wrote:

> On Wed, Sep 09, 2020 at 03:48:15AM +0800, Yonggang Luo wrote:
> > Disable following tests on msys2/mingw
> >       'test-crypto-tlscredsx509': ['crypto-tls-x509-helpers.c',
> 'pkix_asn1_tab.c',
> >                                    tasn1, crypto],
> >       'test-crypto-tlssession': ['crypto-tls-x509-helpers.c',
> 'pkix_asn1_tab.c', 'crypto-tls-psk-helpers.c',
> >                                  tasn1, crypto],
> >       'test-io-channel-tls': ['io-channel-helpers.c',
> 'crypto-tls-x509-helpers.c', 'pkix_asn1_tab.c',
> >                               tasn1, io, crypto]}
>
> Why ?   GNUTLS is available on Windows and if it is enabled
> at build time, then we should certainly be running the tests.
>

Don't know why., the header disable it totally. and it's requires
CONFIG_TASN1, don't know if  CONFIG_TASN1 works under win32
```
#ifndef TESTS_CRYPTO_TLS_X509_HELPERS_H
#define TESTS_CRYPTO_TLS_X509_HELPERS_H

#include <gnutls/gnutls.h>
#include <gnutls/x509.h>

#if !(defined WIN32) && \
    defined(CONFIG_TASN1)
# define QCRYPTO_HAVE_TLS_TEST_SUPPORT
#endif

#ifdef QCRYPTO_HAVE_TLS_TEST_SUPPORT
# include <libtasn1.h>
```




>
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  tests/meson.build | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tests/meson.build b/tests/meson.build
> > index 998e4c48f9..b470a90e3a 100644
> > --- a/tests/meson.build
> > +++ b/tests/meson.build
> > @@ -145,7 +145,8 @@ if have_block
> >      'test-crypto-block': [io],
> >    }
> >    if 'CONFIG_GNUTLS' in config_host and \
> > -     'CONFIG_TASN1' in config_host
> > +     'CONFIG_TASN1' in config_host and \
> > +     'CONFIG_POSIX' in config_host
> >      tests +=3D {
> >        'test-crypto-tlscredsx509': ['crypto-tls-x509-helpers.c',
> 'pkix_asn1_tab.c',
> >                                     tasn1, crypto],
> > --
> > 2.28.0.windows.1
> >
> >
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000006506e705aedd15d2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 9, 2020 at 4:11 PM Daniel=
 P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redha=
t.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">On Wed, Sep 09, 2020 at 03:48:15AM +0800, Yonggang Luo wrote:<br>
&gt; Disable following tests on msys2/mingw<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;test-crypto-tlscredsx509&#39;: [&#39;cr=
ypto-tls-x509-helpers.c&#39;, &#39;pkix_asn1_tab.c&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tasn1, crypto],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;test-crypto-tlssession&#39;: [&#39;cryp=
to-tls-x509-helpers.c&#39;, &#39;pkix_asn1_tab.c&#39;, &#39;crypto-tls-psk-=
helpers.c&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tasn1, crypto],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;test-io-channel-tls&#39;: [&#39;io-chan=
nel-helpers.c&#39;, &#39;crypto-tls-x509-helpers.c&#39;, &#39;pkix_asn1_tab=
.c&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tasn1, io, crypto]}<br>
<br>
Why ?=C2=A0 =C2=A0GNUTLS is available on Windows and if it is enabled<br>
at build time, then we should certainly be running the tests.<br></blockquo=
te><div><br></div><div>Don&#39;t know why., the header disable=C2=A0it tota=
lly. and it&#39;s requires=C2=A0

CONFIG_TASN1, don&#39;t know if=C2=A0

CONFIG_TASN1 works under win32</div>```<br>#ifndef TESTS_CRYPTO_TLS_X509_HE=
LPERS_H<br>#define TESTS_CRYPTO_TLS_X509_HELPERS_H<br><br>#include &lt;gnut=
ls/gnutls.h&gt;<br>#include &lt;gnutls/x509.h&gt;<br><br>#if !(defined WIN3=
2) &amp;&amp; \<br>=C2=A0 =C2=A0 defined(CONFIG_TASN1)<br># define QCRYPTO_=
HAVE_TLS_TEST_SUPPORT<br>#endif<br><br>#ifdef QCRYPTO_HAVE_TLS_TEST_SUPPORT=
<br># include &lt;libtasn1.h&gt;<br>```<br><br>=C2=A0<div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 tests/meson.build | 3 ++-<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/tests/meson.build b/tests/meson.build<br>
&gt; index 998e4c48f9..b470a90e3a 100644<br>
&gt; --- a/tests/meson.build<br>
&gt; +++ b/tests/meson.build<br>
&gt; @@ -145,7 +145,8 @@ if have_block<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &#39;test-crypto-block&#39;: [io],<br>
&gt;=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 if &#39;CONFIG_GNUTLS&#39; in config_host and \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0&#39;CONFIG_TASN1&#39; in config_host<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&#39;CONFIG_TASN1&#39; in config_host and \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&#39;CONFIG_POSIX&#39; in config_host<br>
&gt;=C2=A0 =C2=A0 =C2=A0 tests +=3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;test-crypto-tlscredsx509&#39;: [&#39;c=
rypto-tls-x509-helpers.c&#39;, &#39;pkix_asn1_tab.c&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tasn1, crypto=
],<br>
&gt; -- <br>
&gt; 2.28.0.windows.1<br>
&gt; <br>
&gt; <br>
<br>
Regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--0000000000006506e705aedd15d2--

