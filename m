Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14061C3F68F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 10:49:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D75712084D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 10:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gyHZ4btT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75712084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqxHJ-0006cM-21
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 05:49:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iqxGQ-0005j1-LJ
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 05:48:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iqxGP-0002TA-A0
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 05:48:06 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38509)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iqxGP-0002Rz-3m
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 05:48:05 -0500
Received: by mail-ot1-x343.google.com with SMTP id z9so6382441oth.5
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 02:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Jcozb5U7IfZ6soFKC3Q5JL0d27XzrZlN2OMMV/C9MLw=;
 b=gyHZ4btTguxUWzLijPoBsmMZm9heBmi7O/gbQ08r6zg1kkGOCdL3/XXoebYAMxYRFT
 b46ipW5H2HjAhV6LCpSEcTK8CF3xEknUaz+vVLrtsjxayAYwLsgJeux5wUf4znX4bPYK
 CviDQThpgq7ZG998LQodrl7EnG+gi28nOcMjSMwTT91F1fMaH+ZO0WAbjGXWUL620y4g
 ivbv5XYURDU9tCFo6YMb8P9ju8StxSetx8A8EYv3Q/cZLDOj/gSvtONe5oEvlaO0D/uV
 cwTecyHUASfeDo10Zqq0RjyCZM61U4rKLpg4P6ZHNabP4rYx4M4wyxbvwDWFbRfuvtnS
 6XVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Jcozb5U7IfZ6soFKC3Q5JL0d27XzrZlN2OMMV/C9MLw=;
 b=WCbWDWINHoYX3oQNes0G9hq4qL9ccbUvRhokL57QVCLgJOF/zg4eaFr1B5wuEdx4nR
 3agBJRKQlxqwFylViYnUW9gew+8QXLByE9bo+1hQ1BCkTJacu+IcJvS4Qg7Cc1on/Ajh
 c3okf3VEM0smQ0cgEjd96Li7M3+/5lUSZTr+3ghArvx+OJlAchaUpHUHaDWCx3UMEfYD
 xEPjfwrv9Sm6yB7ukpnKlZfTL741WS49dKXuWBhCBEQIpGeFGYaqcJbDbNKpdLuAp3Iq
 DPOGguLueAnF577hAz9j+YHnsAP5+qjgk1cp20ebSjuH0JF2gLUjcHw1SiDSXF9arSWw
 +7JA==
X-Gm-Message-State: APjAAAUhtgcRIsYtOiHXTc/usvwmm/d9fSTpu2zpOsCvWkv5ILaJtS/I
 WcSXROKmC7+18YHYBiBtYFNAQw3ncUznSvdosRvIyg==
X-Google-Smtp-Source: APXvYqyYVN/NWwE1MUhU3RPGQKyflddK9TbXnW+dDMKE2LicZww7Jh7q8ogtJ3ud62EvA3pXixH4K2ZJkXmsl3OU0sg=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr12695724otq.135.1578912483967; 
 Mon, 13 Jan 2020 02:48:03 -0800 (PST)
MIME-Version: 1.0
References: <157709434917.12933.4351155074716553976.stgit@pasha-Precision-3630-Tower>
 <003a01d5c6b3$df62afd0$9e280f70$@ru> <20200109120038.GD9504@linux.fritz.box>
 <87k15v1z71.fsf@dusky.pond.sub.org> <000f01d5c9f4$cfbc1230$6f343690$@ru>
 <20200113100648.GB5549@linux.fritz.box>
 <CAFEAcA8_snB=+i06Vna7t+E_5=ynPAr_KnLAABXrX5A=ntWOjg@mail.gmail.com>
 <20200113102737.GC5549@linux.fritz.box>
In-Reply-To: <20200113102737.GC5549@linux.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jan 2020 10:47:52 +0000
Message-ID: <CAFEAcA-N+xCmjWkC1rHnJgHfiQoV-Spwzu1f0-g2h7fUDS=Esw@mail.gmail.com>
Subject: Re: [for-5.0 PATCH 00/11] Support for reverse debugging with GDB
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Artem Pisarenko <artem.k.pisarenko@gmail.com>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Ciro Santilli <ciro.santilli@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Thomas Dullien <thomas.dullien@googlemail.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>, maria.klimushenkova@ispras.ru,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Gerd Hoffmann <kraxel@redhat.com>,
 Pavel Dovgaluk <pavel.dovgaluk@ispras.ru>, Igor R <boost.lists@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Jan 2020 at 10:27, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 13.01.2020 um 11:14 hat Peter Maydell geschrieben:
> > On Mon, 13 Jan 2020 at 10:07, Kevin Wolf <kwolf@redhat.com> wrote:
> > > In MAINTAINERS, you are listed yourself as the maintainer for
> > > record/replay. I wonder whether you shouldn't just be sending pull
> > > requests after getting Acked-by or Reviewed-by from the maintainers of
> > > other subsystems you touch.
> >
> > Ideally somebody else should be interested enough in record/replay
> > to review patches. "I'm a subsystem maintainer and send pull
> > requests" ideally shouldn't be something we give out just because
> > patches aren't getting code review, though I know that it
> > does sometimes degenerate into that...
>
> I had the impression that he said he had collected (almost) all of the
> necessary reviews, but nobody really seems to be interested to take the
> series through their tree because no matter who you ask, the majority of
> changes will always be for other subsystems.

No, the series has only got acked-bys so far, except for the one patch
that touches qapi, which Markus reviewed. (The bulk of the changes
here are in replay/, and so far nobody's looked at those AFAIK.)

> And as record/replay is already listed as a separate subsystem in
> MAINTAINERS, it seems to make sense to me that it also gets its own pull
> requests rather than trying to get patches merged though the trees of
> various subsystem maintainers who all aren't really responsible for it.

Yeah, pull requests would be fine. Pull requests of whole
patchsets that are basically unreviewed are something I think
we should try to avoid if we can.

thanks
-- PMM

