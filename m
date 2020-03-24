Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7E7C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:58:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7D3920870
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmDmRb/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D3920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGj8C-0001so-5U
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 08:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuval.shaia.ml@gmail.com>) id 1jGj7a-0001UA-IB
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia.ml@gmail.com>) id 1jGj7Z-0008SQ-Fn
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:57:30 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46173)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuval.shaia.ml@gmail.com>)
 id 1jGj7Z-0008SA-At
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:57:29 -0400
Received: by mail-ot1-x343.google.com with SMTP id 111so16817980oth.13
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 05:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CkJZNrjmhfk/y88Op3KJ2RkjcBGbLJ/wD41EaDCXZuk=;
 b=mmDmRb/01N8r2xrug2Ois6fXJRD7d5YihbpGLFywChReOPHpFjO78CY+4i7tHO/FX7
 8/5KRYu5B8ADjQfGvNz45Rj+UyuqQsqCQGFcMPhbDsiaRCWZhvQaozMt9rh6XdBNwXCn
 jFiU00K0aLRqUXE/xcULZkrdbXRNABspfHy5FsbL0llw18aes2GQCsGaL08hRCUo1GNW
 0FcyQEAPwtvfJJJdAxlmsTyYu2SUbWvpv/Lb0eDgyDshQCsKbKqN7os2hmD/rANATB0I
 ofRqLqmpgjY/RGsRxEBUEs0l3xF8/4XFD/k8wDernhWq27jch3+363T/u8ecLSJ+Dia/
 LjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CkJZNrjmhfk/y88Op3KJ2RkjcBGbLJ/wD41EaDCXZuk=;
 b=HpxrFzz+HufIyekDxuAFe8mx8DyXKEis7rx7IRRUKyWsm5wTj0YvnQqVJq2MIP78kr
 Ving+CnrtYLjTMuzdnM8AcXohgMaBYBDN8GjZSk7LXu6MBHgDMmmwHnQCia6665D4Xqc
 S4x6O7NXhvwgU0ETd7OJwGvUM4NZtMie8uduMRZluTDE5gNdbr7JokbOOmRR3u0Wtgt6
 JVZ2y4eMx0tGP6R7nroyBmgmysE7EDo15Keeof7zDWZYW7Z0JmzZcqEsFgGTtgePYsTT
 /oKQPfoRxTCVICIGsfosTzx1vGj1/h0HQ+/lr4TRQZF7acNLlbwndv1F/CXuAQMDHB6x
 RepQ==
X-Gm-Message-State: ANhLgQ0lbCNShlvNvqq27hGIRtOTLXlS/f1Ylhr3Jj8Y4j6ojgGLerwV
 TPz6vypO2r3t11N5TzQzQR9uvcOldTBnD4XSvD0=
X-Google-Smtp-Source: ADFU+vu1KJm//QXrF0Ru4rEclVGWLtllMNFUlyD/GLx3UY0el6LYRMKgq/3jO7VCHqsDA4TgTfCzxkpXfaXZ0/OfySE=
X-Received: by 2002:a4a:a286:: with SMTP id h6mr1893507ool.47.1585054648429;
 Tue, 24 Mar 2020 05:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200324105356.7998-1-yuval.shaia.ml@gmail.com>
 <CAFEAcA_D3ykX2mJwtJhvdQg3psCX9NdcG0xq4qmP3CkqHtnY8Q@mail.gmail.com>
 <72691a5a-8992-ec54-f2de-6209cafcc426@gmail.com>
 <CAMPkWoNqKpn22Y70vZizFqd3BQjVJaSwjE25KwHOcMJaZsY17w@mail.gmail.com>
 <CAFEAcA9=AGgYAxjixjau8KDet-of4=Vg9a_2k-hV54h=1gbrSA@mail.gmail.com>
In-Reply-To: <CAFEAcA9=AGgYAxjixjau8KDet-of4=Vg9a_2k-hV54h=1gbrSA@mail.gmail.com>
From: Yuval Shaia <yuval.shaia.ml@gmail.com>
Date: Tue, 24 Mar 2020 14:57:17 +0200
Message-ID: <CAMPkWoNh_ZX+kUoEkMndY_ShQ0qKNTvYoq9aVM7G1pFLW2CdCg@mail.gmail.com>
Subject: Re: [PATCH] hw/rdma: Lock before destroy
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000044f1d505a1994b34"
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000044f1d505a1994b34
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Mar 2020 at 13:55, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Tue, 24 Mar 2020 at 11:25, Yuval Shaia <yuval.shaia.ml@gmail.com>
> wrote:
> > As i already said, current code makes sure it will not happen
> > however it better that API will ensure this and will not trust callers.
>
> I agree with the principle, but I think that here there is no
> way to do it -- if you are literally destroying an object
> then it is invalid to use it after destruction and there
> is no way to have a lock that protects against that kind
> of bug, unless the lock is at a higher level (ie the
> thing that owns the destroyed-object has a lock and
> doesn't allow access to it outside the lock or without
> a check for has-been-destroyed). Just throwing an extra
> mutex-lock into the destroy function doesn't add any
> protection.
>

Make sense.
So what i can do is to check list->list at every API since destroy
functions sets it to NULL.

Does it make sense?


>
> thanks
> -- PMM
>

--00000000000044f1d505a1994b34
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, 24 Mar 2020 at 13:55, Peter M=
aydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro=
.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On Tue, 24 Mar 2020 at 11:25, Yuval Shaia &lt;<a href=3D"mailto:yuval.s=
haia.ml@gmail.com" target=3D"_blank">yuval.shaia.ml@gmail.com</a>&gt; wrote=
:<br>
&gt; As i already said, current code makes sure it will not happen<br>
&gt; however it better that API will ensure this and will not trust callers=
.<br>
<br>
I agree with the principle, but I think that here there is no<br>
way to do it -- if you are literally destroying an object<br>
then it is invalid to use it after destruction and there<br>
is no way to have a lock that protects against that kind<br>
of bug, unless the lock is at a higher level (ie the<br>
thing that owns the destroyed-object has a lock and<br>
doesn&#39;t allow access to it outside the lock or without<br>
a check for has-been-destroyed). Just throwing an extra<br>
mutex-lock into the destroy function doesn&#39;t add any<br>
protection.<br></blockquote><div><br></div><div>Make sense.</div><div>So wh=
at i can do is to check list-&gt;list at every API since destroy functions =
sets it to NULL.</div><div><br></div><div>Does it make sense?</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
thanks<br>
-- PMM<br>
</blockquote></div></div>

--00000000000044f1d505a1994b34--

