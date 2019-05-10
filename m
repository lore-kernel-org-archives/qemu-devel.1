Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C60C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 08:41:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED7292087E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 08:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED7292087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39063 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP15b-00051m-94
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 04:41:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hP13T-0003V8-Hv
	for qemu-devel@nongnu.org; Fri, 10 May 2019 04:39:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hP13S-0000zb-AO
	for qemu-devel@nongnu.org; Fri, 10 May 2019 04:38:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hP13R-0000yj-VA
	for qemu-devel@nongnu.org; Fri, 10 May 2019 04:38:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id f2so6484387wmj.3
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 01:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=hTXgwz1IQ+e5bYrpOulSTXrXedtopLsbIHu+29rgw+M=;
	b=AKir7bPLPGClfMbwhJIQGKwHfM4/lGymMIYEpaa6OxwTyH8TXGdFQqtGnJa2HfvLfI
	wqdn/l2b5GOZc8A9OSR+8H4dPa2MrHHbliap2ZUgaV4LeySb5ibKzsU1Ko97tvnp+vQq
	Xl7udbtGdWF2+wkCYi2M7boZ2iOk8Yz9zKRO3WUFCV6K/fEzz9KV4OczKDOftOTq4MrZ
	0CXccnE4c3bULfOqWBBrOHXl9a3ySNeUuZbytBXclZR098fIToKkqSVUY4PtHqjU3Cay
	YRHWQothXQ3tQJhf9v2rXO+5I/o7WKi3b4GUJmudHk0gfTuz6WZS8xXKxnTlzny/bwJY
	Y56w==
X-Gm-Message-State: APjAAAUXCB5T3QoUK0AfpRgaJPXCVeX/3lUU4ZOgBrgE37ORca1eGsR2
	sPU1WxaKtYliwsRNCdq5/Afdpg==
X-Google-Smtp-Source: APXvYqwUVVuurEehu6oOml1kOd4tVvfqhWYj5IMQDJwO6tZ40jMWD9Iy6QUezdYj7aEuUsLko/PcRQ==
X-Received: by 2002:a7b:c04b:: with SMTP id u11mr5775953wmc.95.1557477536724; 
	Fri, 10 May 2019 01:38:56 -0700 (PDT)
Received: from steredhat (host151-251-static.12-87-b.business.telecomitalia.it.
	[87.12.251.151]) by smtp.gmail.com with ESMTPSA id
	d14sm3124727wre.78.2019.05.10.01.38.55
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 10 May 2019 01:38:55 -0700 (PDT)
Date: Fri, 10 May 2019 10:38:53 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20190510083853.q5bdem64e4y3kyeh@steredhat>
References: <20190427113625.46594-1-sgarzare@redhat.com>
	<877eb2hiwk.fsf@dusky.pond.sub.org>
	<20190507083615.as7shlq7fwjgwz54@steredhat>
	<8736lp5fxg.fsf@dusky.pond.sub.org>
	<20190509082646.lrfllcqszjlmnyfe@steredhat>
	<20190509132913.GF10858@angien.pipo.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509132913.GF10858@angien.pipo.sk>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] Use of PreallocMode in block drivers
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>,
	qemu-block@nongnu.org, qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 09, 2019 at 03:29:13PM +0200, Peter Krempa wrote:
> On Thu, May 09, 2019 at 10:26:46 +0200, Stefano Garzarella wrote:
> > On Wed, May 08, 2019 at 01:44:27PM +0200, Markus Armbruster wrote:
> > > Stefano Garzarella <sgarzare@redhat.com> writes:
> > > 
> > > > On Tue, May 07, 2019 at 08:34:51AM +0200, Markus Armbruster wrote:
> > > >> Cc: Peter for a libvirt perspective.
> > > >> 
> > > >> Stefano Garzarella <sgarzare@redhat.com> writes:
> > > >> 
> > > >> > This patch adds the support of preallocation (off/full) for the RBD
> > > >> > block driver.
> > > >> > If available, we use rbd_writesame() to quickly fill the image when
> > > >> > full preallocation is required.
> > > >> >
> > > >> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > >> > ---
> > > >> >  block/rbd.c          | 149 ++++++++++++++++++++++++++++++++++++++-----
> > > >> >  qapi/block-core.json |   4 +-
> > > >> >  2 files changed, 136 insertions(+), 17 deletions(-)
> 
> [...]
> 
> 
> > > >> >  ##
> > > >> >  # @BlockdevVmdkSubformat:
> > > >> 
> > > >> The non-support of values 'metadata' and 'falloc' is not visible in
> > > >> introspection, only in documentation.  No reason to block this patch, as
> > > >> the other block drivers have the same introspection weakness (only
> > > >> sheepdog and vdi bother to document).
> > > >> 
> > > >> Should we address the introspection weakness?  Only if there's a use for
> > > >> the information, I think.
> > > >
> > > > If the management applications will use that information (or maybe also
> > > > our help pages), could be useful to have an array of 'PreallocMode'
> > > > supported per-driver.
> > > 
> > > Ideally, query-qmp-schema would show only the supported values.
> > > 
> > > Not hard to do, just tedious: we'd get a number of sub-enums in addition
> > > to the full one, and we'd have to map from sub-enum to the full one.
> > > 
> > > QAPI language support for sub-enums would remove most of the tedium.
> > > Not worthwhile unless the need for sub-enums is actually common.
> > 
> > I should study better the QMP and QAPI to understand how to implement
> > the sub-enums.
> > 
> > If you agree, I'll put it as a background task, until somebody from
> > management applications tell us his interest.
> 
> Sorry for the late response. Libvirt currently does not deal that much
> with the preallocation settings. Preallocation isn't in current state
> implemented at all for 'blockdev-create' and only the 'metadata' and
> 'falloc' modes are used in the storage driver via qemu-img.
> 
> We currently hardcode the knowledge for which formats actually support
> it internally.
> 
> I'd say it's not criticall to expose this in the QMP schema but
> obviously if we'll ever need to use it for a recent enough qemu it's
> welcome to have a way to check.

Thank you for sharing this information!

Cheers,
Stefano

