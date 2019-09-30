Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4E5C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 14:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C824020679
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 14:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FubzTzgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C824020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEx4E-0006Bf-Ol
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 10:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57007)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iEx34-0005Ks-9S
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 10:53:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iEx33-0006H4-4M
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 10:53:14 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:37449)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iEx30-0006F1-OL; Mon, 30 Sep 2019 10:53:10 -0400
Received: by mail-oi1-x22c.google.com with SMTP id i16so11364669oie.4;
 Mon, 30 Sep 2019 07:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=EQXZaMSccg691kivGEp/+Qe69jQ8I8z61GVlgTpmQ9o=;
 b=FubzTzggKLGmul1HBsqf/iPG2hlVI/ah9kcD5K4pftKpgs3+PGer5IGeoDXwR7Qp6T
 5CikBBjoHNMrQ3DvVbFurZ4qUoDQD5w1OpcvpDbVpT1+o7RwbaOMSp6P+sivODG49Yqk
 p5jcBZ912ojzNy+TgVFjGhcvAA6SEGVmywDZfDzuhNxYcCzDQCdn6+zWBsWM/aqzTGwH
 IMSWRvn20spgCQ+Uy4PNFr/gwVA9ioOo8eOuqVzVZlS0SSXuHG5FlF9PPK93WqvWlIi5
 Aq4M/7naSCH69cVgIIH/uIeQBaZz6sMzSZbMJ3nELK6ypH+1HPyRpKgZXoZ58gjjtAnx
 HRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=EQXZaMSccg691kivGEp/+Qe69jQ8I8z61GVlgTpmQ9o=;
 b=XhY7+u+k0T320uOf67vcqF/YBy5pdMVP2ZCYfFaHrOULxM07irj9t6XuOpn47Jnxu6
 TLKIgC63P629s87XKY4+DTGZ9UymMzYA7RK45aYtmggHU2Fh9+kAJKFf11g6ha2LDrpq
 df7SIGZ1zEILiXw8FhU5nGUxUNxGQPAWUoMrqsoHnAfGgWqxyFqLkUlKudbI+uGUl3c9
 k6cRl3cG8VH3uhLsPlhMb+z+Ku0QRxn5qLLJiBNM0rV3EX6LUkM7fTzqIAGj2AtbXTYo
 jW9ejB44r/0KWYkd2QMK3gtLtai8qnSvIf1OY9bcTWEIkhvRRvw1Axnq4pjS8bThcRw1
 ISoA==
X-Gm-Message-State: APjAAAUvx41Y4SbRJQGkaYyioCscjEzgi6yWHNuP7HYPUpRHj43o4jz9
 dDCgPjHxID04K831Eg/B5s70q0+j1fc9LeVBy10=
X-Google-Smtp-Source: APXvYqyH8/5V+RkG1XISmaKtmloZtDGJtCDTytl3HQnGQMbOD97NVvhd8ZgdFAVo33G1q5evhgIRAxSFCJ2LUbMumKg=
X-Received: by 2002:aca:ba06:: with SMTP id k6mr18622436oif.136.1569855189905; 
 Mon, 30 Sep 2019 07:53:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Mon, 30 Sep 2019 07:53:09
 -0700 (PDT)
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Mon, 30 Sep 2019 07:53:09
 -0700 (PDT)
In-Reply-To: <18547009-8840-fc6f-1782-dc2b49f66c96@us.ibm.com>
References: <bf30baf5-4d75-dc6f-c30a-57b80714999b@ilande.co.uk>
 <CAL1e-=gcK2mdtrt9vibHGpbm4_FZgQWTA91+p=9ouuMYmZwPqQ@mail.gmail.com>
 <CAL1e-=gXZxKUuNgasSb9d2t=LhDAHJb8ovLjKfQ1Zu9HHg2D3w@mail.gmail.com>
 <18547009-8840-fc6f-1782-dc2b49f66c96@us.ibm.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 30 Sep 2019 16:53:09 +0200
Message-ID: <CAL1e-=j68W7GyRwNB2WAPQTShQV5CRQ4NNV9qCd2kkLuFKw5RQ@mail.gmail.com>
Subject: Re: Re: target/ppc: bug in optimised vsl/vsr implementation?
To: Paul Clarke <pc@us.ibm.com>
Content-Type: multipart/alternative; boundary="000000000000f176420593c664e0"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22c
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
Cc: stefan.brankovic@rt-rk.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f176420593c664e0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

30.09.2019. 16.35, "Paul Clarke" <pc@us.ibm.com> =D1=98=D0=B5 =D0=BD=D0=B0=
=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On 9/28/19 5:17 PM, Aleksandar Markovic wrote:
> > Also, check on the hardware the behavior listed as 'undefined' for
vsl/vsr
> > in the docs - even though it is tehnically irrelevant, I am courious
> > whether the old or the new (or none of them) solution match the
hardware.
>
> There does appear to be some odd behavior when one strays into the
undefined.  For example:
> source vector: 0102030405060708090a0b0c0d0e0f10
> shift  vector: 01020101010101010101010101010101
> after vsl:     020806080a0c0e10121416181a1c1e20
> ...this appears to use the byte-respective shift values
>
> using vsr with that result and the same shift vector:
> after vsr:     0182030405060708090a0b0c0d0e0f10
> I expected to get back a result matching the source vector, but somehow,
an extra bit got set.
>
> It would probably take some more thorough investigation to map out the
undefined behavior, but I doubt there's any value to that.
>

Absolutely agree. I thought if the 'undefined' behavior is something
obviously simple, we could try to match it, assuming also that it remains
constant across all implementations. But, this behaviour is not a simple
one, so, imho, let's leave 'undefined' undefined.

Thanks for a nice experiment!

Aleksandar

> PC

--000000000000f176420593c664e0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
30.09.2019. 16.35, &quot;Paul Clarke&quot; &lt;<a href=3D"mailto:pc@us.ibm.=
com">pc@us.ibm.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; On 9/28/19 5:17 PM, Aleksandar Markovic wrote:<br>
&gt; &gt; Also, check on the hardware the behavior listed as &#39;undefined=
&#39; for vsl/vsr<br>
&gt; &gt; in the docs - even though it is tehnically irrelevant, I am couri=
ous<br>
&gt; &gt; whether the old or the new (or none of them) solution match the h=
ardware.<br>
&gt;<br>
&gt; There does appear to be some odd behavior when one strays into the und=
efined.=C2=A0 For example:<br>
&gt; source vector: 0102030405060708090a0b0c0d0e0f10<br>
&gt; shift=C2=A0 vector: 01020101010101010101010101010101<br>
&gt; after vsl:=C2=A0 =C2=A0 =C2=A0020806080a0c0e10121416181a1c1e20<br>
&gt; ...this appears to use the byte-respective shift values<br>
&gt;<br>
&gt; using vsr with that result and the same shift vector:<br>
&gt; after vsr:=C2=A0 =C2=A0 =C2=A00182030405060708090a0b0c0d0e0f10<br>
&gt; I expected to get back a result matching the source vector, but someho=
w, an extra bit got set.<br>
&gt;<br>
&gt; It would probably take some more thorough investigation to map out the=
 undefined behavior, but I doubt there&#39;s any value to that.<br>
&gt;</p>
<p dir=3D"ltr">Absolutely agree. I thought if the &#39;undefined&#39; behav=
ior is something obviously simple, we could try to match it, assuming also =
that it remains constant across all implementations. But, this behaviour is=
 not a simple one, so, imho, let&#39;s leave &#39;undefined&#39; undefined.=
</p>
<p dir=3D"ltr">Thanks for a nice experiment!</p>
<p dir=3D"ltr">Aleksandar</p>
<p dir=3D"ltr">&gt; PC<br>
</p>

--000000000000f176420593c664e0--

