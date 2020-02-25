Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34238C35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 18:58:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01F0A2084E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 18:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kudObjUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F0A2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6fPD-0005oM-66
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 13:58:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6fO6-00058A-AD
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:56:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6fO4-0006X7-Tm
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:56:58 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41858)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6fO4-0006Vg-Nt
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:56:56 -0500
Received: by mail-ot1-x343.google.com with SMTP id r27so506044otc.8
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 10:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=U1d4tFTmLO6n/q7x9hbFt+N0XA3a2/2/bSfmUKjkDrI=;
 b=kudObjUyiLmiR+V3WayThJY2M48OT3TS/dE2An7X6iSuv1GV6aLG+6F2Dz7j9Cz4gs
 ekHN9OK6fX4QU1DwJ1rrkuxCKmiF7ISMASRFFnnaDjIjzi1Ul+Skrxx7kX3jvUAdrrO0
 dbyTygPe9tc04xhplKiM9KqXq63raz1t5Td7dnvGem2ZDggyGLTg3A1LuKV8EKK3nH8/
 RlAIwDy7DrWYQL17cLpizzDyhKkVFWsfaKoMgFF2X+aEeurVM8oOqVZJmS3jCWpk9YtX
 WKTgpScZSC4HjqFmWMiUO39+KU2PNmpdOCSEB23+vZWj0sHfWXy9nmFldoIx4VkPU4Gq
 +GaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U1d4tFTmLO6n/q7x9hbFt+N0XA3a2/2/bSfmUKjkDrI=;
 b=jEnbvYIwQDRhhcWpos7FExCzuWr5jNJQ4oh+M7VLk37wTTyB2mfbcwq+eNxj3xNtST
 6MEtL9HLbktnY4dBW6EcA1jed4dE4wGLNUFyqJYHo2bF1GxZ6PAmUgl7eTD1kIYlpwxa
 OmjkMaO0byTi/8CT1NpHJIluNPCdc8cFC8y7iv5P+sMT3dbI5Hh+FdVhl/EsJ+evk/6F
 V8il4AxDwufVxWGkkNjUdf0iymvgQ3iyZnwKj1klh3lQEPSaVnjsyxlrd93TQM08W0R4
 XS2czEWEJz7unhFJJ0ATD64k3Xoi607pe2QPMVElABJO9w66zh1oyfscEcYgJhHXEUcy
 F5fQ==
X-Gm-Message-State: APjAAAXCopVn/UmOQ1Yp+/jFhHsNaXH21zZ+U+S3RIwtiz8+ZlJZkEkK
 OpNH/+d6lXFMB5riS4meaAZ3HfAcAQASRlHh/z/AyQ==
X-Google-Smtp-Source: APXvYqzi/C7FkdrGzFgxEbkn7NGskIDBBDJVqL9TOPo/8qkcE/QO1I2Ri6/Q+KsJGMZJd/MuybBTkvo6L6VD0EMQ3NA=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr18506otq.97.1582657015757; 
 Tue, 25 Feb 2020 10:56:55 -0800 (PST)
MIME-Version: 1.0
References: <20200225154121.21116-1-peter.maydell@linaro.org>
 <5a6757cb-fda2-ba3f-6c24-f09829faf4ab@redhat.com>
 <CAFEAcA-C0o_u8VABdRky7GUCvyiWhkn74cT1UYAtEAAFjGBLAA@mail.gmail.com>
 <6ed08bea-4fcb-08dc-417c-a0f534173a31@redhat.com>
 <CAFEAcA9KmsHS4fnYWvpMMa5SLLUBjiPcOsfmGOHcWopd11M3+g@mail.gmail.com>
 <9f64719b-184c-cd61-1260-f13428ea7369@redhat.com>
In-Reply-To: <9f64719b-184c-cd61-1260-f13428ea7369@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2020 18:56:44 +0000
Message-ID: <CAFEAcA9F6jQ7bAp3DuJ+hA48iwi-NtviBxJKQxF-PUD41FyDzg@mail.gmail.com>
Subject: Re: [PATCH 0/4] docs: Miscellaneous rST conversions
To: Paolo Bonzini <pbonzini@redhat.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 at 18:28, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 25/02/20 18:59, Peter Maydell wrote:
> > My assumption was that we would attack this by:
> >  * converting chunks of the documentation which are in qemu-doc.texi
> >    but which aren't in the qemu.1 manpage (basically in the way this
> >    series is doing)
> >  * get the qapidoc generation conversion reviewed and into
> >    master (since at the moment it outputs into files included
> >    from qemu-doc)
>
> The QAPI docs are in other manuals in docs/interop/, aren't they?

Yes, but until we complete the conversion we can't get
rid of the qemu-doc.html output, because that's where the
HTML output from the QAPI doc generation goes.

> > Incidentally:
> >> makeinfo -o - --docbook security.texi  | pandoc -f docbook -t rst
> > security texi was the really easy one here. I had to do more
> > manual formatting fixups on qemu-deprecated.texi which I'm
> > sceptical would have worked out as nicely done automatically.
>
> The automated conversion of qemu-deprecated.texi is indeed bad because
> the titles in the source are missing @code{...} to activate monospaced
> characters.

To be fair on the automated conversion, the markup in the
source texinfo here is suboptimal :-)

> > The automatic conversion rune also doesn't seem to get quotes
> > and apostrophes right: it has turned "guest B's disk image" into
> > something with a smartquote character in it, for instance.
>
> We probably don't want smartquotes at all, so you'd use "-t rst+smart"
> as the destination.  Also pandoc does not use the "::" at the end of the
> previous paragraph.  That can be fixed with for example
>
>   perl -e '$/=undef; $_ = <>; s/:\n\n::/::/g; print'
>
> In general the result is more than acceptable, and I'd rather get a
> quick-and-slightly-dirty conversion done quickly than do everything
> manually but risk missing 5.0.

Yeah, seems like a good plan. If the autoconversion works out
then I think the main thing which makes "do all this for 5.0"
at risk currently is that the qapidoc conversion series needs
review and might need overhauling based on that review: it
doesn't take many cycles of review-and-fix to push close to
the softfreeze deadline.

What do you want to do with this patchset?

thanks
-- PMM

