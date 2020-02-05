Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564B9C35249
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 03:10:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2211A2085B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 03:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoSnevlR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2211A2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izB4z-0004a5-6s
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 22:10:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shan.gavin@gmail.com>) id 1izB4J-00048t-Ez
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 22:09:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shan.gavin@gmail.com>) id 1izB4H-0006nH-DE
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 22:09:35 -0500
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:44683)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shan.gavin@gmail.com>)
 id 1izB4F-0006g0-7k; Tue, 04 Feb 2020 22:09:31 -0500
Received: by mail-qv1-xf42.google.com with SMTP id n8so442188qvg.11;
 Tue, 04 Feb 2020 19:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0PE2uu4ZBM2cwypMrN5QyWKooyeC7GQaJC62Y5Zgbc4=;
 b=OoSnevlRXNwVaZtJd/vmiaRJFn/Pt6OxAKuN+IWYTuMyPyB2rxjfSFamFs5qbci0Xb
 6PuWQDoY4ZTpOMFCmZ+Yw5Li7Bl6AGVwlUjx56QoXzUYI28nGEl8XLPc5TntrbyFNRGx
 YqCfJB7oPjv6OoXzRpNGxiZz96ojQfeT/CZGwSx331WGF/AtosuqTFh2MjyqB+8x3TZh
 pSJhaxrSuWX/TQpxmxUorqMqLtJvaaVwSQQIQ2i3NPNSXgsGyGm0OZZ51HjIZY1aGJrc
 k2D3qFb6lPdWw/Y96oFCR6DS2rVQbDme0lmWDaxh8/BtEDwNF/K6qaSDicIwedvrErZu
 h1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0PE2uu4ZBM2cwypMrN5QyWKooyeC7GQaJC62Y5Zgbc4=;
 b=mMrHiDDew1dXq7syGIwTEVEeIJNjeJhYrqJxEWC+/w4BhMx/15svOSdhhAuE5XoGSH
 BeEABlsT3ZNxW36EtshIB/3ohAovcwpyjtQyW6fkStEYvLd6fzjFXW2xLViCGgXco9ac
 1xd/7hundoMAkyRK/64jGcAvyoHtlySAk0bPv1L6qGhPd6NJ8GyGQQllHHcONN5rshoH
 fpHu6NZ5EpbaxymVlnPX4gG9WcgWAvmfvQqrUAK8FruP482gT36fzxKHUaghYl0IbCVv
 4gxDp0bf8hC9uURIydapEazlasKeFTF91rMa9uTYEset1u+2CG9gKWOqQISyImY73fCR
 PCwA==
X-Gm-Message-State: APjAAAXARnpgzqHfkOjcTBeFes2MboYHhy3bhRDmq2AipBmsXSw0GOr1
 Q2r69BSh2PS68yWuP2VQzfqp4OuVJhB65rvS0zA=
X-Google-Smtp-Source: APXvYqzuvjw6pkrNp/xOeiEVRMBLTzHpcihuy+LVoldUqAJDx3fw42vPX6H/WcNGE/EYTnhCc/BHgGGjbbli7IfhBBU=
X-Received: by 2002:a0c:fe10:: with SMTP id x16mr30285840qvr.188.1580872170282; 
 Tue, 04 Feb 2020 19:09:30 -0800 (PST)
MIME-Version: 1.0
References: <20191219040612.28431-1-gshan@redhat.com>
 <d972631d-7db7-b6d5-61b8-244ae2c85882@redhat.com>
 <7f6e29e6-1df9-4513-79ba-b53873b0735e@ozlabs.ru>
 <544f261e4b9c97f1d3a5fb64cef42ba5@kernel.org>
 <ff584722-1b51-e538-7c45-c71cdc40105f@redhat.com>
 <c61c95c434dbcf97a0c946f0993d4843@kernel.org>
 <8a286e1c-c3f3-3052-e497-d44a90667451@redhat.com>
 <CAFEAcA-wKbF7mYToaAsxDxahuJ_X3_i3Z+8DqXmj8mKySmTW7Q@mail.gmail.com>
In-Reply-To: <CAFEAcA-wKbF7mYToaAsxDxahuJ_X3_i3Z+8DqXmj8mKySmTW7Q@mail.gmail.com>
From: Shan Gavin <shan.gavin@gmail.com>
Date: Wed, 5 Feb 2020 14:09:19 +1100
Message-ID: <CAOL5Tw=CQ-oWd1=+xtFHyLEieAENt83d27iK11SwtsF7qhOy9Q@mail.gmail.com>
Subject: Re: [RFC PATCH] hw/arm/virt: Support NMI injection
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000252431059dcb7c4a"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f42
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
Cc: Andrew Jones <drjones@redhat.com>, Gavin Shan <gshan@redhat.com>,
 jthierry@redhat.com, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Marc Zyngier <maz@kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000252431059dcb7c4a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Peter Maydell <peter.maydell@linaro.org> =E4=BA=8E2020=E5=B9=B42=E6=9C=884=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=889:22=E5=86=99=E9=81=93=EF=BC=
=9A

> On Tue, 4 Feb 2020 at 03:51, Gavin Shan <gshan@redhat.com> wrote:
> > Note: I'm still investigating the code to see how SError can be injecte=
d
> when TCG
> > is used. I think we need same function when TCG is enabled, or it's
> something for
> > future.
>
> TCG doesn't currently implement SError -- it could be added, but
> there's a bit of plumbing you'd need to do to get it to work and to
> ensure the exception is taken, routed and masked correctly.
>
>
Thanks, Peter. Yeah, I will post v2 RFC patch shortly. Please let me
know if there are anything wrong :)

Thanks,
Gavin


> thanks
> -- PMM
>

--000000000000252431059dcb7c4a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Peter Maydell &lt;<a href=3D"mailto:peter=
.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; =E4=BA=8E2020=E5=B9=
=B42=E6=9C=884=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=889:22=E5=86=99=
=E9=81=93=EF=BC=9A<br></div><div class=3D"gmail_quote"><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">On Tue, 4 Feb 2020 at 03:51, Gavin Shan &lt;<=
a href=3D"mailto:gshan@redhat.com" target=3D"_blank">gshan@redhat.com</a>&g=
t; wrote:<br>
&gt; Note: I&#39;m still investigating the code to see how SError can be in=
jected when TCG<br>
&gt; is used. I think we need same function when TCG is enabled, or it&#39;=
s something for<br>
&gt; future.<br>
<br>
TCG doesn&#39;t currently implement SError -- it could be added, but<br>
there&#39;s a bit of plumbing you&#39;d need to do to get it to work and to=
<br>
ensure the exception is taken, routed and masked correctly.<br>
<br></blockquote><div><br></div><div>Thanks, Peter. Yeah, I will post v2 RF=
C patch shortly. Please let me</div><div>know if there are anything wrong :=
)</div><div><br>Thanks,<br>Gavin</div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
thanks<br>
-- PMM<br>
</blockquote></div></div>

--000000000000252431059dcb7c4a--

