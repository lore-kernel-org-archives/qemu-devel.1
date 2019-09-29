Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B3CC4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 07:41:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CB2521882
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 07:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjWlKdB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB2521882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iETpp-0005Iq-CO
	for qemu-devel@archiver.kernel.org; Sun, 29 Sep 2019 03:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55317)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1iEToC-0003lD-34
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 03:39:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1iEToA-0005JJ-Pw
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 03:39:55 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:36421)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1iEToA-0005Hy-J8
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 03:39:54 -0400
Received: by mail-ot1-x32f.google.com with SMTP id 67so5792633oto.3
 for <qemu-devel@nongnu.org>; Sun, 29 Sep 2019 00:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=maGkITtfiNADjrpV/XvP7j5yceye4PBFyVR/CS7R9mM=;
 b=BjWlKdB9lq9ZwCE41p7nIEtry1oFH+QqKLJ21gMjBX63OgcezeQAKqkQvsuDGLqeTU
 +YXQseeF1VEavuSckJohzGbnDN5G/5ltLqUctk0fbkEWVXjqZK2VCFne93XfMLQFBnCo
 tolSwzzT9DE1jnKk6sTnUS3ZMWX5AabC/ha5Fc9DWGB5wyMkHIHZpZ2FncIPalAW1fnO
 6qa978wJcmBWphpMk1WD5KwTTdOqHm2kKBwYgOTvmK9GT6W02/OaOmni8tJ7aUTP8XvP
 8WWJ2dM78hR847VNyigDnCa4IWKsEdid5Imx/MhSib/hi/VOVzyB6+680tGfXtyor5FL
 AV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=maGkITtfiNADjrpV/XvP7j5yceye4PBFyVR/CS7R9mM=;
 b=EMIuXe6FBhA7mVQHrrnO7qep8VLMMcEDc102tv4DyZbjrejooXuETnnXbFs0olACKz
 ZizRbk/LOikF20Nl2pxZ0HNNklc0rsC5vqivR9tAdGMadjVLuljHRr1LS1vn2T8u8gD8
 qFE/m+vCDbAgwAnZjOCe3r0nVY5lqtbN7yAGwxgFtFpbUgqNERl4Fl5SYJAYet2v0HqB
 L4kEY+XgbdKzY9mls/Qn+7028Q19e9S7nGtXnbyjRxslDeDZGi6eqzp98uPca6lwvUCC
 2lmfLVisawxzF4zPqtWQYAU1jepElJ3j7Rqs9ACDjI+8ztu3IDfKGOYqdReQmbBG4KpM
 J7YQ==
X-Gm-Message-State: APjAAAVegq0E3AtSa2Buq/7UbY75rNikGdElYXzEvygKw1EPYAgpO6fE
 kIzHbIih4PQxTLnWeRJTI+U53pPtdORnsTXP2ug=
X-Google-Smtp-Source: APXvYqzQK4wbs8RMvfO3cwfzsQJaOuQfVUxwayD4huek86PMDZI1Q9dBnxdO2gcV7/WCoRapIuBgs4U2iUG3UHZJfLU=
X-Received: by 2002:a05:6830:86:: with SMTP id
 a6mr8974077oto.353.1569742793417; 
 Sun, 29 Sep 2019 00:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAKXe6SJfZt8WcA43Vsh0=GT=jBedcAOUx9DNGZ4Bsvi10oCkog@mail.gmail.com>
 <644968ffb11c11fd580e96c1e67932501a633fe4.camel@redhat.com>
 <CAKXe6SK+cEytTtgKHw8KXY=jY4xv=27GBu55hTbTmbRyTPsfxg@mail.gmail.com>
 <3d3f3a0e6e796260348c66e69e859e1901501ee8.camel@redhat.com>
 <23789310-35fb-8c93-44f4-532bcd34007d@redhat.com>
In-Reply-To: <23789310-35fb-8c93-44f4-532bcd34007d@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Sun, 29 Sep 2019 15:39:17 +0800
Message-ID: <CAKXe6SL42HeidUzQG_8JkutgRtO8AtC08OHsQRPnVH9POTubAw@mail.gmail.com>
Subject: Re: Questions about the real mode in kvm/qemu
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009728330593ac39ba"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32f
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
Cc: Qemu Developers <qemu-devel@nongnu.org>, Avi Kivity <avi.kivity@gmail.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009728330593ac39ba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Paolo Bonzini <pbonzini@redhat.com> =E4=BA=8E2019=E5=B9=B49=E6=9C=8826=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:18=E5=86=99=E9=81=93=EF=BC=9A

> On 26/09/19 10:59, Maxim Levitsky wrote:
> > If you mean to ask if there is a way to let guest access use no
> > paging at all, that is access host physical addresses directly, then
> > indeed there is no way, since regular non 'unrestricted guest' mode
> > required both protected mode and paging, and 'unrestricted guest'
> > requires EPT. Academically speaking it is of course possible to
> > create paging tables that are 1:1...
>
> Not so academically, it's exactly what KVM does.  However, indeed it
> would also be possible to switch out of EPT mode when CR0.PG=3D0.  I'm no=
t
> sure why it was done this way, maybe when the code was written it was
> simpler to use the identity map.
>


Hi Paolo, what's the meaning of 'switch out of EPT mode'. Do you mean when
the guest in real mode emulation(vm86)
can do something to disable EPT? I don't find the code. Seems my
understanding is wrong.

Thanks,
Li Qiang



>
> Let's see if Avi is listening... :)
>
> Paolo
>

--0000000000009728330593ac39ba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Paolo Bonzini &lt;<a href=3D"mailto:p=
bonzini@redhat.com">pbonzini@redhat.com</a>&gt; =E4=BA=8E2019=E5=B9=B49=E6=
=9C=8826=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:18=E5=86=99=E9=81=
=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
26/09/19 10:59, Maxim Levitsky wrote:<br>
&gt; If you mean to ask if there is a way to let guest access use no<br>
&gt; paging at all, that is access host physical addresses directly, then<b=
r>
&gt; indeed there is no way, since regular non &#39;unrestricted guest&#39;=
 mode<br>
&gt; required both protected mode and paging, and &#39;unrestricted guest&#=
39;<br>
&gt; requires EPT. Academically speaking it is of course possible to<br>
&gt; create paging tables that are 1:1...<br>
<br>
Not so academically, it&#39;s exactly what KVM does.=C2=A0 However, indeed =
it<br>
would also be possible to switch out of EPT mode when <a href=3D"http://CR0=
.PG" rel=3D"noreferrer" target=3D"_blank">CR0.PG</a>=3D0.=C2=A0 I&#39;m not=
<br>
sure why it was done this way, maybe when the code was written it was<br>
simpler to use the identity map.<br></blockquote><div><br></div><div><br></=
div><div>Hi Paolo, what&#39;s the meaning of &#39;switch out of EPT mode&#3=
9;. Do you mean when the guest in real mode emulation(vm86)</div><div>can d=
o something to disable EPT? I don&#39;t find the code. Seems my understandi=
ng is wrong.</div><div><br></div><div>Thanks,</div><div>Li Qiang</div><div>=
<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
<br>
Let&#39;s see if Avi is listening... :)<br>
<br>
Paolo<br>
</blockquote></div></div>

--0000000000009728330593ac39ba--

