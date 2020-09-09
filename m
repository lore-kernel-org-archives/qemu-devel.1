Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F35EC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:31:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA5221532
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEffI4Qi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA5221532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFvVr-0001eH-Js
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 04:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFvV3-0000eM-Mc; Wed, 09 Sep 2020 04:30:41 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233]:43465)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFvV1-0005ob-NX; Wed, 09 Sep 2020 04:30:41 -0400
Received: by mail-lj1-x233.google.com with SMTP id u4so2361875ljd.10;
 Wed, 09 Sep 2020 01:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=yymDOur0DMmp+NHeXCYHenH2buu805cNbW26Gz7fne4=;
 b=XEffI4QiTLME3PrKObRl2oHyPshLlsTjK99VorJqV79VnSA3inUoOopHJX16xdmGFQ
 halZFeHccw5kTcnDniNEW6/P8jEENrNgzk4orbujbLdndel9gJwmPZJmG/zDniqpR36m
 v3JpGE/FJ4+WyIp93j/VbAiJBkN50FYLMvohbg7303nOLM4cFFTZluiocoxpi1lBBqGd
 JTPqV8OTP8qfqqqJxyQ9iiGCbNS1i4/FlEd4MBy+5qJQ9OYYLHgTNx23Avj7nG53E20R
 ZXt5HI1BVwREUk+EGlMULGbez66oFiO0A7av3dGjxZXgFEpkAAWHp9+ka578XknZ56WZ
 Jz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=yymDOur0DMmp+NHeXCYHenH2buu805cNbW26Gz7fne4=;
 b=ivO/EHhIHRgsQL9HlxR3eUenGr75tSS/T18y1kfOI+f3WFWjq4uMF1PUD/xqooAlRr
 9l+FMQ/k15Snx+eVvkMZdJwhleWU7Y39IVe1naL9OjpQg662curDDpFnj2ENej+w/9kO
 OOCHEY4diMv7uz1ZPMJk3tFFfsRJp1fOSBx1LxkncWLoveXd5Kp4WlKlA3oZpnqfxIY0
 9sE/2VT9bJosUQD2DSWku9/V/CyPhdDOaMFfW09LLiqsm+QIaz+qNL3PMpPxWPPCabH5
 raQRH3fUuZCccVlDYd7FvdZolxOC1RwhZuqfp3vjkLzql+X2TiBVKBnR1fWGEI91870O
 ch1Q==
X-Gm-Message-State: AOAM531OgGkSntr3EzYRR7jjLUOXs+YXTrjjyVySV+FPH9nDGSQp+pE4
 SfYK/IPxZI7BeWIUgOFpAOIq3Evxue8Ey3hJbqY=
X-Google-Smtp-Source: ABdhPJy36PHhPkWy/5z20ssuR0RA/3M8/qHVfvRzrkEg4hPYd5NkyFv0ojpv/kyyT6YiM78e/hvtZPhB92AGxASI0Gs=
X-Received: by 2002:a2e:9dc7:: with SMTP id x7mr1398119ljj.447.1599640237492; 
 Wed, 09 Sep 2020 01:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200908194820.702-1-luoyonggang@gmail.com>
 <20200908194820.702-12-luoyonggang@gmail.com>
 <20200909081021.GD1011023@redhat.com>
 <CAE2XoE9-DzwqXw7mh8jom8f2Bu+i1jSqxoD+C=4ZbnA-B_X7Xg@mail.gmail.com>
 <20200909082229.GF1011023@redhat.com>
In-Reply-To: <20200909082229.GF1011023@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 9 Sep 2020 16:30:26 +0800
Message-ID: <CAE2XoE_SW0t-r0urDb12ENZrXzKuKCPMM7cETo13p5-tJ3+E_Q@mail.gmail.com>
Subject: Re: [PATCH 11/16] meson: disable crypto tests are empty under win32
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001fcf5405aedd44b9"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x233.google.com
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

--0000000000001fcf5405aedd44b9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2020 at 4:22 PM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
>
wrote:

> On Wed, Sep 09, 2020 at 04:17:22PM +0800, =E7=BD=97=E5=8B=87=E5=88=9A(Yon=
ggang Luo) wrote:
> > On Wed, Sep 9, 2020 at 4:11 PM Daniel P. Berrang=C3=A9 <berrange@redhat=
.com>
> > wrote:
> >
> > > On Wed, Sep 09, 2020 at 03:48:15AM +0800, Yonggang Luo wrote:
> > > > Disable following tests on msys2/mingw
> > > >       'test-crypto-tlscredsx509': ['crypto-tls-x509-helpers.c',
> > > 'pkix_asn1_tab.c',
> > > >                                    tasn1, crypto],
> > > >       'test-crypto-tlssession': ['crypto-tls-x509-helpers.c',
> > > 'pkix_asn1_tab.c', 'crypto-tls-psk-helpers.c',
> > > >                                  tasn1, crypto],
> > > >       'test-io-channel-tls': ['io-channel-helpers.c',
> > > 'crypto-tls-x509-helpers.c', 'pkix_asn1_tab.c',
> > > >                               tasn1, io, crypto]}
> > >
> > > Why ?   GNUTLS is available on Windows and if it is enabled
> > > at build time, then we should certainly be running the tests.
> > >
> >
> > Don't know why., the header disable it totally.
>
> Yes, I know the source disables it, because it creates various
> files and no effort has been made to use WIndows filename
> building code.
>
> Given that it is already disabled in the source, why do we need
> to disable it a second time in meson.build ?
>
Because when there is no testcase ,the test runner would complain
ERROR - missing test plan


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

--0000000000001fcf5405aedd44b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 9, 2020 at 4:22 PM Daniel=
 P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redha=
t.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">On Wed, Sep 09, 2020 at 04:17:22PM +0800, =E7=BD=97=E5=8B=87=E5=88=9A(=
Yonggang Luo) wrote:<br>
&gt; On Wed, Sep 9, 2020 at 4:11 PM Daniel P. Berrang=C3=A9 &lt;<a href=3D"=
mailto:berrange@redhat.com" target=3D"_blank">berrange@redhat.com</a>&gt;<b=
r>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Wed, Sep 09, 2020 at 03:48:15AM +0800, Yonggang Luo wrote:<br>
&gt; &gt; &gt; Disable following tests on msys2/mingw<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;test-crypto-tlscredsx509&#39;=
: [&#39;crypto-tls-x509-helpers.c&#39;,<br>
&gt; &gt; &#39;pkix_asn1_tab.c&#39;,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tasn1, c=
rypto],<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;test-crypto-tlssession&#39;: =
[&#39;crypto-tls-x509-helpers.c&#39;,<br>
&gt; &gt; &#39;pkix_asn1_tab.c&#39;, &#39;crypto-tls-psk-helpers.c&#39;,<br=
>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tasn1, crypto],=
<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;test-io-channel-tls&#39;: [&#=
39;io-channel-helpers.c&#39;,<br>
&gt; &gt; &#39;crypto-tls-x509-helpers.c&#39;, &#39;pkix_asn1_tab.c&#39;,<b=
r>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tasn1, io, crypto]}<br>
&gt; &gt;<br>
&gt; &gt; Why ?=C2=A0 =C2=A0GNUTLS is available on Windows and if it is ena=
bled<br>
&gt; &gt; at build time, then we should certainly be running the tests.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Don&#39;t know why., the header disable it totally.<br>
<br>
Yes, I know the source disables it, because it creates various<br>
files and no effort has been made to use WIndows filename<br>
building code.<br>
<br>
Given that it is already disabled in the source, why do we need<br>
to disable it a second time in meson.build ?<br></blockquote><div>Because w=
hen there is no testcase ,the test runner would complain</div>ERROR - missi=
ng test plan<br><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
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

--0000000000001fcf5405aedd44b9--

