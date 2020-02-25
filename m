Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6094C35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 19:12:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B48CF2082F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 19:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMS8dtKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B48CF2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6fcz-0003iL-RJ
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 14:12:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j6fbT-0002mT-RT
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 14:10:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j6fbN-0000sY-9Z
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 14:10:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46477
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j6fbN-0000qr-3e
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 14:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582657840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eFRLIZO3NyVYdo9aS7zUnFRUzGA65Q3i2bOGvdZvdyI=;
 b=IMS8dtKKYOr/0sVWXwf43ClcfQkLccwTlfoOxuvNxopWX3exgA0PeHn1BL9pun9DPGQXjX
 x6YsoD0nEERi/zst4EceViKy6wd9cyNBNTWbgoR8zL6f6+3U2m3vEOBDaAwq7NiECJOXHw
 kS1uESU9d25Hv3FSOG+Dt8dojEhafpA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-U89t3XYSNTes8oyNmG_L0Q-1; Tue, 25 Feb 2020 14:10:38 -0500
X-MC-Unique: U89t3XYSNTes8oyNmG_L0Q-1
Received: by mail-ed1-f69.google.com with SMTP id ck15so261505edb.6
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 11:10:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=INC/degVOTdSkbrD26PvxKmGx04Bel5c+TFJDr2h9Pw=;
 b=VEMW3hBvsOYcDiJ1GIc7jZQ8YIqTaGiL7LVaDxD0q4umav0w3mODuVAC9uL9OjEdfL
 RoN6IQM9VYe0uD6yekjFZf0rLr68e8cV8imomeKLpdJPBg8zS5lnqlbvzf0o8z8qIVlp
 kx/XsfM91thxftCxgYXNCzhfG+UObVFPIm2ML5DRzVNX0MjFITapCVe5qsZbE4IgDBcv
 mlFIy3FRdrnA2MInD7xr/BhXHf4jNnVv0wkjBgc2r6rrah6twtIUTAyZ8E2H6nAXpPEm
 Kubf+x+0hxFsBrbuVs382PFMpSmyKCwGz6Khf9G+NNyvdf6n2tSCW9MXYo1M812AV1Ey
 +D5w==
X-Gm-Message-State: APjAAAVdPbGtxjQ9GhegUXu6fnHGdwegUdK7ylylR0FSyGvVzNLeJh4w
 cnIhoUeu9V27Y2I9bK6H4bGik7zsKhk+UWplGESL7TbYwDs2fuYP5Pe2ROWuqvyPhMTeyfbxrK0
 aiIUOjNcnMiD6u4U9rqpiqudQN+YCPQI=
X-Received: by 2002:aa7:cf06:: with SMTP id a6mr464521edy.161.1582657836014;
 Tue, 25 Feb 2020 11:10:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqw6/cClBZW5lMWqEa1eq+4tVxgsXcCr3EgBA3nQSkinqmyzaonHaWK4cg5FA5SMIc11ntumMHmi+avD7J3Z17g=
X-Received: by 2002:aa7:cf06:: with SMTP id a6mr464506edy.161.1582657835785;
 Tue, 25 Feb 2020 11:10:35 -0800 (PST)
MIME-Version: 1.0
References: <20200225154121.21116-1-peter.maydell@linaro.org>
 <5a6757cb-fda2-ba3f-6c24-f09829faf4ab@redhat.com>
 <CAFEAcA-C0o_u8VABdRky7GUCvyiWhkn74cT1UYAtEAAFjGBLAA@mail.gmail.com>
 <6ed08bea-4fcb-08dc-417c-a0f534173a31@redhat.com>
 <CAFEAcA9KmsHS4fnYWvpMMa5SLLUBjiPcOsfmGOHcWopd11M3+g@mail.gmail.com>
 <9f64719b-184c-cd61-1260-f13428ea7369@redhat.com>
 <CAFEAcA9F6jQ7bAp3DuJ+hA48iwi-NtviBxJKQxF-PUD41FyDzg@mail.gmail.com>
In-Reply-To: <CAFEAcA9F6jQ7bAp3DuJ+hA48iwi-NtviBxJKQxF-PUD41FyDzg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 25 Feb 2020 20:10:24 +0100
Message-ID: <CABgObfaFyGE7sFsQ62hoLBJLo+DpO8ftznahUM1EHCzPcOEKuw@mail.gmail.com>
Subject: Re: [PATCH 0/4] docs: Miscellaneous rST conversions
To: Peter Maydell <peter.maydell@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000001a750a059f6b3ee5"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001a750a059f6b3ee5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mar 25 feb 2020, 19:57 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> > The QAPI docs are in other manuals in docs/interop/, aren't they?
>
> Yes, but until we complete the conversion we can't get
> rid of the qemu-doc.html output, because that's where the
> HTML output from the QAPI doc generation goes.
>

Right.

> In general the result is more than acceptable, and I'd rather get a
> > quick-and-slightly-dirty conversion done quickly than do everything
> > manually but risk missing 5.0.
>
> Yeah, seems like a good plan. If the autoconversion works out
> then I think the main thing which makes "do all this for 5.0"
> at risk currently is that the qapidoc conversion series needs
> review and might need overhauling based on that review: it
> doesn't take many cycles of review-and-fix to push close to
> the softfreeze deadline.
>
> What do you want to do with this patchset?
>

This could go in independently. It would make Kashyap's series conflict,
but I have already rebased it on top.

Perhaps we could have the files in both .texi and (automatically converted)
.rst versions at the same time in the tree for a short period. If that's
okay for you, I can post tomorrow a series to do that.

Paolo

--0000000000001a750a059f6b3ee5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">Il mar 25 feb 2020, 19:57 Peter Maydell &lt;<a href=3D"mailto:=
peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; ha scritto:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">&gt; The QAPI docs are in other manuals=
 in docs/interop/, aren&#39;t they?<br>
<br>
Yes, but until we complete the conversion we can&#39;t get<br>
rid of the qemu-doc.html output, because that&#39;s where the<br>
HTML output from the QAPI doc generation goes.<br></blockquote></div></div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">Right.</div><div dir=3D"auto"=
><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">&gt; In general the result is more than acceptable, and I&#39=
;d rather get a<br>
&gt; quick-and-slightly-dirty conversion done quickly than do everything<br=
>
&gt; manually but risk missing 5.0.<br>
<br>
Yeah, seems like a good plan. If the autoconversion works out<br>
then I think the main thing which makes &quot;do all this for 5.0&quot;<br>
at risk currently is that the qapidoc conversion series needs<br>
review and might need overhauling based on that review: it<br>
doesn&#39;t take many cycles of review-and-fix to push close to<br>
the softfreeze deadline.<br>
<br>
What do you want to do with this patchset?<br></blockquote></div></div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">This could go in independently.=
=C2=A0<span style=3D"font-family:sans-serif">It would make Kashyap&#39;s se=
ries conflict, but I have already rebased it on top.</span></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Perhaps we could have the files in bo=
th .texi and (automatically converted) .rst versions at the same time in th=
e tree for a short period. If that&#39;s okay for you, I can post tomorrow =
a series to do that.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Pao=
lo</div></div>

--0000000000001a750a059f6b3ee5--


