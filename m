Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5BBC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 18:09:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A8082192B
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 18:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=koconnor.net header.i=@koconnor.net header.b="Gj/9pPVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A8082192B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=koconnor.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWlT5-0002MV-5c
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 13:09:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin@koconnor.net>) id 1iWlS7-0001m1-PW
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:08:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin@koconnor.net>) id 1iWlS6-0002HI-P2
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:08:43 -0500
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f]:45484)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1iWlS6-0002GF-GW
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:08:42 -0500
Received: by mail-qk1-x72f.google.com with SMTP id q70so15241629qke.12
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 10:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=koconnor.net; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=cgWTWah+qaITd5ImyC0zWdxPt54Y47f//WWylOcYfEU=;
 b=Gj/9pPVAkC2+YiSHe3IENJT5NNYKiUqvJrB2GiilpH9uYazO61DJHE+hpGl8UeHJ+l
 BNik75ka91ahpfH9bWaHyXD9s5tZUaZ+0XXaD+4WwRlL8B1VFj7kt9o41Hr2pxz5bUqX
 b8qe4Dz/TgMAaYYvP7E53kSjXilbgsv2VXLrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=cgWTWah+qaITd5ImyC0zWdxPt54Y47f//WWylOcYfEU=;
 b=nM/3i+cXgAjU/iR4p0CHc0yNks4lc5L0BZmg/Qxd9LmJ78isHURtlzOINiL1bXNQxA
 slxjUspoxUeuzSk/+/ylTBpz7TDn6C21dLaOeoDAJ1PktCe3Qovwge2wr4lVIY+u31+E
 jOa6qpyxhDXjJMI8vgyZasKvXCm9UlZ+hrVFfQCFoFSySilwUP+zZFchsDl11DC4KqlU
 S/cknq9g+uUQKCiN5IWsUqrXCFQn2a2OLaCBHeJ1F3scMOfitKUi5aHvLIbG0vA4/1hj
 x5jC+3alf75dvZ5mrbXZbX44lP2MLMGbF1cTtNsVeli2mDzJ/xBp+TWPpbHZ5kLGJz19
 w1sw==
X-Gm-Message-State: APjAAAWHYy1DlfXR7vyEivKFcptIUwHXuzpFOFzAt/9WArlEfHqP0jBL
 TnMAEeTUF4i4hiUsdRpwB/NInA==
X-Google-Smtp-Source: APXvYqyFmr0Hda5WlT0PbAGeNZHrkQaoO87GjrnmYabVj7oPRh2yvOdltNZsfoR2L1H2mTZjTsB8Hw==
X-Received: by 2002:a37:b044:: with SMTP id z65mr24812975qke.424.1574100521343; 
 Mon, 18 Nov 2019 10:08:41 -0800 (PST)
Received: from localhost ([64.9.249.138])
 by smtp.gmail.com with ESMTPSA id i186sm8865408qkc.8.2019.11.18.10.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2019 10:08:40 -0800 (PST)
Date: Mon, 18 Nov 2019 13:08:39 -0500
From: Kevin O'Connor <kevin@koconnor.net>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [SeaBIOS] Re: 1.13 release?
Message-ID: <20191118180839.GA17869@morn.lan>
References: <20191016104412.ut3jxjwjf64qsjbk@sirius.home.kraxel.org>
 <20191106111255.aladyvsumr2kw47b@sirius.home.kraxel.org>
 <20191106162918.GC19095@morn.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106162918.GC19095@morn.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::72f
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
Cc: seabios@seabios.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 06, 2019 at 11:29:18AM -0500, Kevin O'Connor wrote:
> On Wed, Nov 06, 2019 at 12:12:55PM +0100, Gerd Hoffmann wrote:
> > On Wed, Oct 16, 2019 at 12:44:12PM +0200, Gerd Hoffmann wrote:
> > >   Hi,
> > > 
> > > Almost a year since 1.12.0 was tagged (Nov 17th to be exact),
> > > time to plan the 1.13 release I think ...
> > > 
> > > How about freeze in a week or two, release by mid-november?
> > > 
> > > Pending stuff I'm aware of is the disk geometry patch series.
> > > The corresponding qemu series is still waiting to be merged.
> > 
> > It's finally merged in qemu now.  Going to push the seabios
> > series and prepare a seabios update for qemu, so upcoming
> > seabios release gets some more test coverage.
> 
> Okay, thanks.
> 
> If we're going to update that in SeaBIOS, then we may wish to push
> back the SeaBIOS release by a few weeks.

At this point, I'm targeting early December for the release.  Let me
know if there are any concerns with that.

Cheers,
-Kevin

