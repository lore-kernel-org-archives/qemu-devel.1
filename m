Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740C6C4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:04:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4407424683
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBgWCgHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4407424683
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7G1l-0002mN-DI
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 05:04:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1j7G06-00012b-Mg
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:02:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1j7G01-0000JA-N9
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:02:38 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:44411)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>)
 id 1j7Fzs-0008NP-54; Thu, 27 Feb 2020 05:02:24 -0500
Received: by mail-ot1-x32d.google.com with SMTP id h9so2325771otj.11;
 Thu, 27 Feb 2020 02:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1SaTRXLGZ6xhqVh+M+49VL4j/2zUmRwLOKg9dwkpoFY=;
 b=fBgWCgHqkfvOLuCzq7CajVSG65XEN54T+f0rXquMvYK2qu7Ank8kZZjkkq26xhJ+XS
 QGzdk3ke5CcCBXnqIqUvxp74HS1oq819QbqDNEcr2goAYUHJW9NjDSYIA2qrZvZOf3m3
 GeuduxMEoGuw69Fmyl0pkT/i70xgp+9PrHACQqA84dTEIeHw1YnP2M8QKbkDHkHMLjbx
 2cw9gx96y8OIMuGVbSAozC2oj2UJzc34emCfb6VfxxW+La+rKlFlxVZVii3jUZWhRUIH
 NI9+wfenWP1gCHPozZ3vUgmqWQ2wAVxUI3yZVFrD1Zphlqw603lISzGaHNpcVqGFf3E7
 KR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1SaTRXLGZ6xhqVh+M+49VL4j/2zUmRwLOKg9dwkpoFY=;
 b=SotREDOszazlF0GMFTfVB8zTOeeYYNm/3xCqFeUnXi+Tqye93HQ9Yb0pASybnwnxvu
 Ou6W3i5W1l9dtVbLGNrd7BAaoZIzi0xcaahS6/C1ZsA8LKQRoyoxmhjv9edCPzkNL5bP
 F5s5+hrNZJVdBxlEXWrtUMDwxxYY43aLniKa0xmpsvI+OoFxM8w6NGM2wbk6BNGmUJOu
 5UlpfBwXPzmzkvO0c/iwprda8M8LqEkQXbeRVq69Alm7PzDcU/zabKL7DWKQycE+LB7H
 WaBtYOs25Kl4xfDThwN9IyKrQbwwMLRW7eXgrIQF3vNqoYwKX6v9H2oXkzdVBuSg108S
 L8aw==
X-Gm-Message-State: APjAAAXe7GMAvpO6ZklGlmdhvu/e3LTWH9AvFyxdeRTSJHDglDVeytmv
 Z9RCiCsjxqYbXG7eQthnHVWxDH2D7XngtAAywMk=
X-Google-Smtp-Source: APXvYqwv3CHLkk5hNjhQ6RncXfxJva42pztDsahfRWG8Qdq/AfXZA/F8fIYBZ/8FJ65pqKdIybt7LsreMvsBogV8E/k=
X-Received: by 2002:a9d:1706:: with SMTP id i6mr2708265ota.151.1582797740711; 
 Thu, 27 Feb 2020 02:02:20 -0800 (PST)
MIME-Version: 1.0
References: <CABLmASF7CoOufGDz-1d-Py3t1PN3CrWdN64XAzgAx4=rbSxGEA@mail.gmail.com>
 <alpine.BSF.2.22.395.2002261237310.39786@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.22.395.2002261237310.39786@zero.eik.bme.hu>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Thu, 27 Feb 2020 11:02:09 +0100
Message-ID: <CABLmASEsnW8jYtyDHdUdgJ0jALE6f6W0xYSbx9_RSVp4j4RsVg@mail.gmail.com>
Subject: Re: Issue with vl.c: move -m parsing after memory backends has been
 processed. Commit a1b18df9a4848fc8a906e40c275063bfe9ca2047
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: multipart/alternative; boundary="000000000000162378059f8bd1c9"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32d
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000162378059f8bd1c9
Content-Type: text/plain; charset="UTF-8"

On Wed, Feb 26, 2020 at 12:38 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:

> Hello,
>
> On Wed, 26 Feb 2020, Howard Spoelstra wrote:
> > Hi all,
> >
> > Commit a1b18df9a4848fc8a906e40c275063bfe9ca2047 on the ppc-for-50 branch
> > makes qemu-system-ppc running Mac OS 9 extremely slow. I bisected to the
> > result below.
> >
> > Command line used:
> > ./qemu-system-ppc -L pc-bios -M mac99,via=pmu -m 512 -boot c \
> > -hda 9.2.img \
> > -serial stdio -sdl
> >
> > Best,
> > Howard
> >
> > a1b18df9a4848fc8a906e40c275063bfe9ca2047 is the first bad commit
> > commit a1b18df9a4848fc8a906e40c275063bfe9ca2047
> > Author: Igor Mammedov <imammedo@redhat.com>
>
> Isn't this the same as what's discussed in
>
> https://lists.nongnu.org/archive/html/qemu-devel/2020-02/msg07229.html
>
> Regards,
> BALATON Zoltan
>
> Yes, this refers to the same issue. I responded there too with reference
to the bisection result I got.
As it is being dealt with, there is no further need to follow up on this
particular report..

Best,
Howard

--000000000000162378059f8bd1c9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 26, 2020 at 12:38 PM BALA=
TON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu">balaton@eik.bme.hu</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hell=
o,<br>
<br>
On Wed, 26 Feb 2020, Howard Spoelstra wrote:<br>
&gt; Hi all,<br>
&gt;<br>
&gt; Commit a1b18df9a4848fc8a906e40c275063bfe9ca2047 on the ppc-for-50 bran=
ch<br>
&gt; makes qemu-system-ppc running Mac OS 9 extremely slow. I bisected to t=
he<br>
&gt; result below.<br>
&gt;<br>
&gt; Command line used:<br>
&gt; ./qemu-system-ppc -L pc-bios -M mac99,via=3Dpmu -m 512 -boot c \<br>
&gt; -hda 9.2.img \<br>
&gt; -serial stdio -sdl<br>
&gt;<br>
&gt; Best,<br>
&gt; Howard<br>
&gt;<br>
&gt; a1b18df9a4848fc8a906e40c275063bfe9ca2047 is the first bad commit<br>
&gt; commit a1b18df9a4848fc8a906e40c275063bfe9ca2047<br>
&gt; Author: Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com" targe=
t=3D"_blank">imammedo@redhat.com</a>&gt;<br>
<br>
Isn&#39;t this the same as what&#39;s discussed in<br>
<br>
<a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2020-02/msg0722=
9.html" rel=3D"noreferrer" target=3D"_blank">https://lists.nongnu.org/archi=
ve/html/qemu-devel/2020-02/msg07229.html</a><br>
<br>
Regards,<br>
BALATON Zoltan<br>
<br></blockquote><div>Yes, this refers to the same issue. I responded there=
 too with reference to the bisection result I got. <br></div><div>As it is =
being dealt with, there is no further need to follow up on this particular =
report..</div><div><br></div><div>Best,</div><div>Howard<br></div></div></d=
iv>

--000000000000162378059f8bd1c9--

