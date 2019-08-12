Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8153C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 16:35:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C0A20679
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 16:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cIhr10vH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C0A20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxDIF-0002CC-Uc
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 12:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54890)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hxDHq-0001kS-9l
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 12:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hxDHp-0004Xe-9z
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 12:35:10 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44814)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hxDHp-0004XI-4F
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 12:35:09 -0400
Received: by mail-ot1-x341.google.com with SMTP id b7so110856137otl.11
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 09:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ocnRsabMQnVKjSBJ2CyPN8JnG/OiQ9P/0FBGBn2PW9A=;
 b=cIhr10vHiayyU59GjkD1sKA2QHCDADj8z3hnqhjQNXI9tLGFIzErWecAZmJ0aeUZas
 zyhpefTFdSFkkly8XUZRcAfQvoXeq3So6g4GX9KNoEuq9iBfQMTFIdN6HTgftEbS1+vm
 grv6pRKIq0T1BCg72Tc6cVpN0GvfeWOnD5XN93myCoDtVbTV45M0iO+hjqnT6Koqref4
 TvuSGhqeTsQ7SzWp7N5ztaE+nL+hIOXh6G0StqSqVDo8ImNva0TyA0N7BEBkcvIakFQ/
 A2VSgvxFuY54U06rTvC0UrnTE1JjJj8b7SN6vCu4qNbCxZEF2mbrjW3L3PN7f8V3fZhe
 N6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ocnRsabMQnVKjSBJ2CyPN8JnG/OiQ9P/0FBGBn2PW9A=;
 b=BefTE11khkQvUQmXLeSigOEQeGnqb6qhmyrChTkV1U5K/iixYGVAsCy9EBN5gyLWEP
 WRzN8r2cd2ec3Gx50hnHc1Xu2i7WbE3tHqEQ2tB5Mae+B10bHoIQ0NkP/g7XdbLyaQ7I
 OAcQdvpLzTUcuNF2q5ovvCKrBfT1m3oEVyR61CbJjK34HxIS5zLqXrcaCfK3Qe6gYR3z
 YHdyATIViwkGt3Kz+pjsCrfzFknLBxTc+w/4j1+stCvJdd2+0ZEEPxMCznQZub+J6ubG
 ZpBzmnsdWCOggiD4nCKQKe62UyeNF82b2cDQG2t043TCjcILimxjoTOxgTtwS5hvPMpp
 s1lg==
X-Gm-Message-State: APjAAAXqKYcqHxcnjgE1UBc/jyBzSNpW/j+X3KH+evrAHSDiRzECo4vR
 PygEljrQ3sYE8V2SsWQctYO8vkDVhqpxEl37ry3aXw==
X-Google-Smtp-Source: APXvYqydyMGGnT0bJ+J5WQl1D4g6NXwL6tgeLoedcyMkUVqfgGqe9M8KnMC5A7ocFfkTVz70IplFLpmQ6m2XAB6NdBQ=
X-Received: by 2002:aca:6185:: with SMTP id v127mr75062oib.163.1565627707530; 
 Mon, 12 Aug 2019 09:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190812065221.20907-1-kraxel@redhat.com>
 <aec51679-b766-5773-86cb-9ebd06a8cb49@redhat.com>
 <c4b30dfe-83d7-f1e0-d868-82791d56d6b6@redhat.com>
 <CAFEAcA-3bFuy2DDG8=-_Y3JO4HWpCW80EcsGWWN8toxiMpafBA@mail.gmail.com>
 <20190812093510.1b85cac8@x1.home>
 <CAFEAcA-PxgCZzMJu8favVEP3x+DX3208TfChsu17fYCkibGg2w@mail.gmail.com>
 <20190812094814.24ad5c80@x1.home>
In-Reply-To: <20190812094814.24ad5c80@x1.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Aug 2019 17:34:56 +0100
Message-ID: <CAFEAcA_4-oEghSWHEH9NWofGNE5_DZJKL8dksLvj2oQq99byPw@mail.gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH 0/1] display/bochs: fix pcie support (qemu
 security issue)
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
 QEMU Developers <qemu-devel@nongnu.org>, Prasad J Pandit <ppandit@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 12 Aug 2019 at 16:48, Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Mon, 12 Aug 2019 16:38:05 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
> > On Mon, 12 Aug 2019 at 16:35, Alex Williamson
> > <alex.williamson@redhat.com> wrote:
> > > Quoting new commit log:
> > >
> > >         This makes sure the pci config space allocation is big enough,
> > >         so accessing the PCIe extended config space doesn't overflow
> > >         the pci config space buffer.
> > >
> > >         PCI(e) config space is guest writable.  Writes are limited
> > >         bywrite mask (which probably is also filled with random stuff),
> > >         so the guest can only flip enabled bits.  But I suspect it
> > >         still might be exploitable, so rather serious because it might
> > >         be a host escape for the guest.  On the other hand the device
> > >         is probably not yet in widespread use.
> > >
> > >         Mitigation: use "-device bochs-display" as conventional pci
> > >         device only.
> > >
> > > Is it clear to others that this mitigation remark seems to be
> > > referencing an alternative configuration constraint to avoid the issue
> > > rather than what's actually implemented in this patch?  IOW, if we
> > > never place the bochs-display device into a PCIe hierarchy, then
> > > extended config space is never accessible to the guest anyway, and
> > > there is no issue.  I think this was meant to be an alternative to the
> > > patch but the enforcement of that would happen above QEMU, probably why
> > > it was mentioned in the cover letter rather than the original commit
> > > log.  Thanks,
> >
> > Yeah, that's unclear in retrospect. How about:
> >
> > # (For a QEMU version without this commit, a mitigation for the
> > # bug is available: use "-device bochs-display" as a conventional pci
> > # device only.)
>
> Yes, better.  Thanks,

Cool. Updated commit message now pushed to master.

-- PMM

