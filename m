Return-Path: <SRS0=VgCP=2F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB54C43603
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 15:28:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89DCE206D3
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 15:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="afNFnLcr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89DCE206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igVob-0008Np-NG
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 10:28:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igVnq-0007q3-22
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 10:27:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igVno-0001Zy-Py
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 10:27:25 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45775)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igVno-0001WK-Jg
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 10:27:24 -0500
Received: by mail-ot1-x343.google.com with SMTP id 59so5540173otp.12
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2019 07:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7RRaL3Yvu+i2tlgto54WRPCcxOMll246e8ITYnRGwDI=;
 b=afNFnLcrQzgm3wKSvboSfSwxBBar1xP6aIEXir1TfRJQmEcuWTD8m3Prm2Zq1+sUXn
 mufCXi5v4RO9S72Bxj7dEdCY5OMGgbnL9SHZPMT4lPDfwGWZCW6xGMjfFKwSSeGp468G
 YRwhcW4YLUfvSJhZ/z/W9In99fNBrOcoAY+fPrMzi6LvpiP9gaH4MLQ3TmKbVl/mG5dC
 gNafKso8pqii1V/qe69nCCWYxcY7r/G0x7cTtKThfdT3IrXKQMmv1S5zO/bcFFPL3gQk
 ennG+TzktZvgs3k5QvrL37Gf+inJjSzJTez2gfFOsECR4j63ThkjNmuSzGA84iPqgYQy
 GofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7RRaL3Yvu+i2tlgto54WRPCcxOMll246e8ITYnRGwDI=;
 b=JIEVIfZCVZ7FbV/jDdxc6SZrCMoOO5FE/eOLjqam19Mqqkj34XxPjOFTBo7puRHl+T
 hukoV/QGMJk/9qKDFg24RR2nfK7VgjQ972UPRTk8erYGBLF8YWMszLV8FMr3Ae2ItbGs
 84IPQKNHZtNbPG+ntrDdDBFbp9bdmLZjkrQ4W/oNeXMGwy4W1PnR+m62ywu3eKyQ0CX0
 iN9nYfmeCFfAGoPWFWUw94He9THil2IgVe4AKBLSqMujWkPDgPDZ+jfudytGzQKbR2g9
 PWIN3FzkTPP7fHp97JwAZV4vpJRZhZS0AGhL0NBJyVoQsIIcFLWWbVYZicSMcfMTH54W
 Fh8g==
X-Gm-Message-State: APjAAAWP2EKfBxoMaPXRLRkK2ka2FCxTksuS+UL7R+LK8VEpeSIFgu1g
 WSSrmvgR486iiKhDWtmTLaF9ncu2bnEy3f8DK9BcDQ==
X-Google-Smtp-Source: APXvYqzcSSJVTCjIUsx/inzBCCcsnE8pmcRF5dwcpzLSHO9Pe90yz4G+qrRUaeTTS0bQzZw43vk7O2hwjIga6wmmd6k=
X-Received: by 2002:a05:6830:2001:: with SMTP id
 e1mr25512778otp.97.1576423643528; 
 Sun, 15 Dec 2019 07:27:23 -0800 (PST)
MIME-Version: 1.0
References: <20191214155614.19004-1-philmd@redhat.com>
 <CAFEAcA_QZtU9X4fxZk2oWAkN-zxXdQZejrSKZbDxPKLMwdFWgw@mail.gmail.com>
 <20191215044759-mutt-send-email-mst@kernel.org>
In-Reply-To: <20191215044759-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 15 Dec 2019 15:27:12 +0000
Message-ID: <CAFEAcA9ZF3VTR7kG_D-cJ+vPFTgd8zjmt2VPfJC7urNemF-5AQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] Simplify memory_region_add_subregion_overlap(...,
 priority=0)
To: "Michael S. Tsirkin" <mst@redhat.com>
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Alistair Francis <alistair@alistair23.me>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Joel Stanley <joel@jms.id.au>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 15 Dec 2019 at 09:51, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sat, Dec 14, 2019 at 04:28:08PM +0000, Peter Maydell wrote:
> > (It doesn't actually assert that it doesn't
> > overlap because we have some legacy uses, notably
> > in the x86 PC machines, which do overlap without using
> > the right function, which we've never tried to tidy up.)
>
> It's not exactly legacy uses.
>
> To be more exact, the way the non overlap versions
> are *used* is to mean "I don't care what happens when they overlap"
> as opposed to "will never overlap".

Almost all of the use of the non-overlap versions is
for "these are never going to overlap" -- devices or ram at
fixed addresses in the address space that can't
ever be mapped over by anything else. If you want
"can overlap but I don't care which one wins" then
that would be more clearly expressed by using the _overlap()
version but just giving everything that can overlap there
the same priority.

> There are lots of regions where guest can make things overlapping
> but doesn't, e.g. PCI BARs can be programmed to overlap
> almost anything.
>
> What happens on real hardware if you then access one of
> the BARs is undefined, but programming itself is harmless.
> That's why we can't assert.

Yeah, good point, for the special case where it's the
guest that's determining the addresses where something's
mapped we might want to allow the behaviour to fall out
of the implementation. (You could instead specify set of
priorities that makes the undefined-behaviour something
specific, rather than just an emergent property of
the implementation QEMU happens to have, but it seems
a bit hard to justify.)

thanks
-- PMM

