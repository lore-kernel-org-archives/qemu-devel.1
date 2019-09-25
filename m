Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AB3C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 12:40:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8418720673
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 12:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dCtfYAMu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8418720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD6bF-0006pH-KC
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 08:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iD6a2-0005t2-HL
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iD6a1-0006rC-6S
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:39:38 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34376)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iD6a0-0006qy-Uo
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:39:37 -0400
Received: by mail-oi1-x244.google.com with SMTP id 83so4746896oii.1
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 05:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Xf5vFOXD7Mv1BXn2YAX9IJHa9Xt+SJ9sCNHzT8AZ1Ps=;
 b=dCtfYAMuI1zy2cjUfy0dkwHxfOr7av8c3ZaGzCU4DRtX0mV0jBUKVvwXyTmeHU5HJv
 HdmdaRaecpCXNkf8QdUjFwrYaLvjnq+gExJG4KrTo/xxXuqD4FXNLFuSSx8qe1T5ewkl
 pxT26rXIDQ1m2bZa0rjApefRPbqCj+tXgHnbTIcJsUo2jqawOtClMe0fOJ8aiEGUDw2s
 +ZTWnZfbFvJRp4hn4U3VTTkj+eQOFGGgcH10V1oBSjn3ARywPSGdFN+NRZ039vDIl+lf
 3IRBi7uV9LdDHFmhQgAXk4JQkPQ70R6exw37A0nxxneOlc2Hsl2nXZoClQYra7H47EER
 jeug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Xf5vFOXD7Mv1BXn2YAX9IJHa9Xt+SJ9sCNHzT8AZ1Ps=;
 b=rt8YwZomYucCga7i/hRMQw2k+vBv8h+qjenhCOUry0bpyq66kYwgOwklE0O817E5Vo
 1gmWsMhpCe/ltrkLHbgJkWdVF4SSq0tHIBXRgmGBhcxfUGtuBT4LleHlc850lTV5z8yu
 Q9wFOqJZwkOWf/JHCvJujeaoGEuxOGA/HW+6VWWpOrKOGVuN3Pr3HnnVxUImn6I8kFQV
 Gl9AcP/UQZEqP0tI5cZaQYgVhpOHI8bSLgalV2HHfY2uh6hPOL8DvVseU8L/15Bwlbwh
 pg633uukalFbrUIuGdA6X1Lmz2/d98pswOQt6wZUo43HXGeLwEj0uLkHS+hkBOWrh9H2
 rC1w==
X-Gm-Message-State: APjAAAUMpi7ksGgSBmURmrrpnJBIR5O186f3nz0CBMypCHHhSqL/CngH
 z+jKi+SHugylKFuEMkzPK/KpAkdwfP47bfIuvH8mjQ==
X-Google-Smtp-Source: APXvYqxYMpY1dlzqlS4B9tujbrtFz7tvtCmcTYopohKNOD2tKHVk1C09pXvx/8PLbfyHONbP+cLdD/90Th9/X6mBjFg=
X-Received: by 2002:aca:b646:: with SMTP id g67mr4371688oif.163.1569415175883; 
 Wed, 25 Sep 2019 05:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190924124433.96810-1-slp@redhat.com>
 <CAFEAcA_2-achqUpTk1fDGWXcWPvTTLPvEtL+owNSWuZ5L3p=XA@mail.gmail.com>
 <87pnjosz3d.fsf@redhat.com> <2d5d7297-0a02-276b-5482-948321f5a8bc@redhat.com>
In-Reply-To: <2d5d7297-0a02-276b-5482-948321f5a8bc@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Sep 2019 13:39:24 +0100
Message-ID: <CAFEAcA-bQvP1vA1E6jCeDz4LnqTwT8HoQWtDE3r4--zkRJsMYw@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Introduce the microvm machine type
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Sergio Lopez <slp@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Laszlo Ersek <lersek@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Sep 2019 at 12:33, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 9/25/19 7:51 AM, Sergio Lopez wrote:
> > Peter Maydell <peter.maydell@linaro.org> writes:
> >
> >> On Tue, 24 Sep 2019 at 14:25, Sergio Lopez <slp@redhat.com> wrote:
> >>>
> >>> Microvm is a machine type inspired by both NEMU and Firecracker, and
> >>> constructed after the machine model implemented by the latter.
> >>>
> >>> It's main purpose is providing users a minimalist machine type free
> >>> from the burden of legacy compatibility, serving as a stepping stone
> >>> for future projects aiming at improving boot times, reducing the
> >>> attack surface and slimming down QEMU's footprint.
> >>
> >>
> >>>  docs/microvm.txt                 |  78 +++
> >>
> >> I'm not sure how close to acceptance this patchset is at the
> >> moment, so not necessarily something you need to do now,
> >> but could new documentation in docs/ be in rst format, not
> >> plain text, please? (Ideally also they should be in the right
> >> manual subdirectory, but documentation of system emulation
> >> machines at the moment is still in texinfo format, so we
> >> don't have a subdir for it yet.)
> >
> > Sure. What I didn't get is, should I put it in "docs/microvm.rst" or in
> > some other subdirectory?
>
> Should we introduce docs/machines/?

This should live in the not-yet-created docs/system (the "system emulation
user's guide"), along with much of the content currently still in
the texinfo docs. But we don't have that structure yet and won't
until we do the texinfo conversion, so I think for the moment we
have two reasonable choices:
 (1) put it in the texinfo, so it is at least shipped to
     users until we get around to doing our docs conversion
 (2) leave it in docs/microvm.rst for now (we have a bunch
     of other docs in docs/ which are basically there because
     they're also awaiting the texinfo conversion and creation
     of the docs/user and docs/system manuals)

My ideal vision of how to do documentation of individual
machines, incidentally, would be to do it via doc comments
or some other kind of structured markup in the .c files
that define the machine, so that we could automatically
collect up the docs for the machines we're building,
put them in to per-architecture sections of the docs,
have autogenerated stub "this machine exists but isn't
documented yet" entries, etc. But that's not something that
we could easily do today so I don't want to block interim
improvements to our documentation just because I have some
nice theoretical idea for how it ought to work :-)

thanks
-- PMM

