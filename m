Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C71C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 23:21:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30059206D4
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 23:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5uPrzEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30059206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwwe6-0005VX-Bt
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 18:21:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iwwbv-0002nl-38
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:19:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iwwbt-0005JO-DN
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:19:02 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36902)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iwwbq-0005GK-7f; Wed, 29 Jan 2020 18:18:58 -0500
Received: by mail-ot1-x343.google.com with SMTP id d3so1358335otp.4;
 Wed, 29 Jan 2020 15:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IRXA4QU4OGTvy6DdZWXU1sLsnyXf4WoTJI6RzxaLF18=;
 b=o5uPrzElWAwCtQ1t64dKcz1dnSXyJh0IfmKwW3Xn5vcRmUSytRV0hjhi56aJBYUuFd
 NNtUNpsCYKdK7qBl5onDgK8AdDpZe7qdICW1CiYA3r3Z8KG0hIHOvZEVfCTcQjBCg/po
 sjP1X5chOh42X4DdvFKVYZAyGLqT8Va5dDpqvj7L5Drtiz/XBurRgl/fCQdZ1QGX3zN2
 /u7oJRL1mWqKDs8Es4mnvx7JFUz7h8BftyvuJzxj1Jrmd3VCDI2/o4FChhyBpRGzyh/5
 cLs0jUAFJi/fXOeUe3YumV2hiUD0YCLXSoITcJ3vd4TQENYYodXDKBN4CjM9w0zY996H
 P+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IRXA4QU4OGTvy6DdZWXU1sLsnyXf4WoTJI6RzxaLF18=;
 b=hFTAjdzD7bkVi97XOJ92itVJDiz1MJjv6UldXd8KjfeRZ9vfS3NwOyvzCz6D4+H8mZ
 lzcHg1kljmbQW9WPvR7vuLYY2KJa0AbNQU3qKUhwYg8932SYF1q13mDAWaqL5QPiMLcP
 OuShiBJQuhTs4HQ/miHnfQyELro2SAmW84MpmoCeCkeRuSnHKOSAjnJqEA2N++ZnF/J+
 5qq6wMwkflJgLRgmBR0AnQNlPkXzPNhz0ItyuM2XjTw+5GlPL1UaI87a5vKvHVuHJJqS
 FGi+4WJ2gtrxQi97dQJ2skyz7PMAW7MWXzlI8QbA0X96VWDTAE0Uz2VPCrSF4XHUwqcx
 iRIA==
X-Gm-Message-State: APjAAAW1m1uYjB6U+pxru07SLgoIuIEfIEU/JtvF/NluKkDVyC6Map01
 QLS+6a9n+e2r6uFdovtfj5QIMvuhJipvMVFxE8I=
X-Google-Smtp-Source: APXvYqw0FXa90azq2eD0XYBYzNwkRsKLjW3aA8Xib2abhVtD3O/FuMpTu7B4cB1IhqYua977X0PJYnwAXZAKdTsj3Nc=
X-Received: by 2002:a9d:831:: with SMTP id 46mr1360190oty.295.1580339937139;
 Wed, 29 Jan 2020 15:18:57 -0800 (PST)
MIME-Version: 1.0
References: <20200109095116.18201-1-thuth@redhat.com>
 <CAL1e-=jnAMtpNNHO1rqG-63K_5uM-QfVYoMcj0NZeHwKCWG4uQ@mail.gmail.com>
 <af4485d4-1706-c464-2320-dff3b5f29fd7@redhat.com>
In-Reply-To: <af4485d4-1706-c464-2320-dff3b5f29fd7@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 30 Jan 2020 00:18:36 +0100
Message-ID: <CAL1e-=iT9Ve7nVFHeMpcfNzwxtLK8Q5C2hbLRSv4PreLfR+3pQ@mail.gmail.com>
Subject: Re: [PATCH] qemu-deprecated: Remove text about Python 2
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000093e195059d4f90c1"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000093e195059d4f90c1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

23:14 Sre, 29.01.2020. Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =D1=
=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Hi Aleksandar,
>
> On 1/9/20 1:49 PM, Aleksandar Markovic wrote:
> >
> >
> > On Thursday, January 9, 2020, Thomas Huth <thuth@redhat.com
> > <mailto:thuth@redhat.com>> wrote:
> >
> >     Python 2 support has been removed, so we should now also remove
> >     the announcement text for the deprecation.
> >
> >     Signed-off-by: Thomas Huth <thuth@redhat.com <mailto:
thuth@redhat.com>>
> >     ---
> >       qemu-deprecated.texi | 8 --------
> >       1 file changed, 8 deletions(-)
> >
> >
> > Reviewed by: Aleksandar Markovic <amarkovic@wavecomp.com
> > <mailto:amarkovic@wavecomp.com>>
>
> I use pwclient to collect patchwork patches, this one is:
> https://patchwork.kernel.org/patch/11325373/
> Your comment is listed, but your tag is ignored... I am not sure why.
>
> John used:
> Content-Transfer-Encoding: 7bit
>
> You:
> Content-Transfer-Encoding: quoted-printable
>
> This might be why? I have no clue.
>

It could be. I use a variety of mail clients. Not all provide the same
level of control of sent mails format. Almost sure they have different
settings. I may do some experimentation on a suitable patch series. Thanks
for noticing it.

OR: I wrote "Reviewed by:" without hyphen.

Reviewed-by: Aleksandar Markovic  <amarkovic@wavecomp.com>

Is now patchwork picking it up?

> >
> >     diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> >     index 7033e531de..8b23e98474 100644
> >     --- a/qemu-deprecated.texi
> >     +++ b/qemu-deprecated.texi
> >     @@ -341,14 +341,6 @@ they have no effect when used with @option{-n}
> >     to skip image creation.
> >       Silently ignored options can be confusing, so this combination of
> >       options will be made an error in future versions.
> >
> >     -@section Build system
> >     -
> >     -@subsection Python 2 support (since 4.1.0)
> >     -
> >     -In the future, QEMU will require Python 3 to be available at
> >     -build time.  Support for Python 2 in scripts shipped with QEMU
> >     -is deprecated.
> >     -
> >       @section Backwards compatibility
> >
> >       @subsection Runnability guarantee of CPU models (since 4.1.0)
> >     --
> >     2.18.1
> >
> >
>

--00000000000093e195059d4f90c1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">23:14 Sre, 29.01.2020. Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; =D1=98=D0=B5 =D0=
=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; Hi Aleksandar,<br>
&gt;<br>
&gt; On 1/9/20 1:49 PM, Aleksandar Markovic wrote:<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; On Thursday, January 9, 2020, Thomas Huth &lt;<a href=3D"mailto:t=
huth@redhat.com">thuth@redhat.com</a> <br>
&gt; &gt; &lt;mailto:<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</=
a>&gt;&gt; wrote:<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Python 2 support has been removed, so we shoul=
d now also remove<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0the announcement text for the deprecation.<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Thomas Huth &lt;<a href=3D"mail=
to:thuth@redhat.com">thuth@redhat.com</a> &lt;mailto:<a href=3D"mailto:thut=
h@redhat.com">thuth@redhat.com</a>&gt;&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu-deprecated.texi | 8 --------<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A01 file changed, 8 deletions(-)<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; Reviewed by: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@=
wavecomp.com">amarkovic@wavecomp.com</a> <br>
&gt; &gt; &lt;mailto:<a href=3D"mailto:amarkovic@wavecomp.com">amarkovic@wa=
vecomp.com</a>&gt;&gt;<br>
&gt;<br>
&gt; I use pwclient to collect patchwork patches, this one is:<br>
&gt; <a href=3D"https://patchwork.kernel.org/patch/11325373/">https://patch=
work.kernel.org/patch/11325373/</a><br>
&gt; Your comment is listed, but your tag is ignored... I am not sure why.<=
br>
&gt;<br>
&gt; John used:<br>
&gt; Content-Transfer-Encoding: 7bit<br>
&gt;<br>
&gt; You:<br>
&gt; Content-Transfer-Encoding: quoted-printable<br>
&gt;<br>
&gt; This might be why? I have no clue.<br>
&gt;</p>
<p dir=3D"ltr">It could be. I use a variety of mail clients. Not all provid=
e the same level of control of sent mails format. Almost sure they have dif=
ferent settings. I may do some experimentation on a suitable patch series. =
Thanks for noticing it.</p>
<p dir=3D"ltr">OR: I wrote &quot;Reviewed by:&quot; without hyphen.</p>
<p dir=3D"ltr">Reviewed-by: Aleksandar Markovic=C2=A0 &lt;<a href=3D"mailto=
:amarkovic@wavecomp.com">amarkovic@wavecomp.com</a>&gt;</p>
<p dir=3D"ltr">Is now patchwork picking it up?</p>
<p dir=3D"ltr">&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0diff --git a/qemu-deprecated.texi b/qemu-depre=
cated.texi<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0index 7033e531de..8b23e98474 100644<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0--- a/qemu-deprecated.texi<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0+++ b/qemu-deprecated.texi<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0@@ -341,14 +341,6 @@ they have no effect when =
used with @option{-n}<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0to skip image creation.<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Silently ignored options can be confusi=
ng, so this combination of<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0options will be made an error in future=
 versions.<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0-@section Build system<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0-<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0-@subsection Python 2 support (since 4.1.0)<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0-<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0-In the future, QEMU will require Python 3 to =
be available at<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0-build time.=C2=A0 Support for Python 2 in scr=
ipts shipped with QEMU<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0-is deprecated.<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0-<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0@section Backwards compatibility<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0@subsection Runnability guarantee of CP=
U models (since 4.1.0)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0-- <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A02.18.1<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt;<br>
</p>

--00000000000093e195059d4f90c1--

