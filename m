Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD1BC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 20:33:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AD0420659
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 20:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD0420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ1bj-0000qO-Kd
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 16:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47448)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iJ1Yy-0007s5-8D
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 16:31:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iJ1Yx-0002Of-5B
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 16:31:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41176)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iJ1Ys-0002M8-Iz; Fri, 11 Oct 2019 16:30:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 68DD2C024B00;
 Fri, 11 Oct 2019 20:30:51 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.36.118.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CD845C223;
 Fri, 11 Oct 2019 20:30:47 +0000 (UTC)
Date: Fri, 11 Oct 2019 22:30:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH v2 1/4] qemu-iotests: remove bash shebang from library
 files
Message-ID: <20191011203046.GI5158@localhost.localdomain>
References: <20191009194740.8079-1-crosa@redhat.com>
 <20191009194740.8079-2-crosa@redhat.com>
 <20191011093610.GD5158@localhost.localdomain>
 <CAMRbyyu=NdwhKFwb=JzMyHfbnP4XzzpaHTCd7ucT7tLEk9HdFA@mail.gmail.com>
 <20191011200501.GA18783@dhcp-17-179.bos.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011200501.GA18783@dhcp-17-179.bos.redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 11 Oct 2019 20:30:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-block <qemu-block@nongnu.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Nir Soffer <nsoffer@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 11.10.2019 um 22:05 hat Cleber Rosa geschrieben:
> On Fri, Oct 11, 2019 at 02:27:25PM +0300, Nir Soffer wrote:
> > On Fri, Oct 11, 2019, 12:36 Kevin Wolf <kwolf@redhat.com> wrote:
> > 
> > > Am 09.10.2019 um 21:47 hat Cleber Rosa geschrieben:
> > > > Due to not being able to find a reason to have shebangs on files that
> > > > are not executable.
> > > >
> > > > While at it, add a mode hint to emacs, which would be clueless or
> > > > plain wrong about these containing shell code.
> > >
> > > vim still doesn't like the change.
> > >
> > > Of course, we could also add another line for vim and for every other
> > > editor in use, but actually, I think I'd prefer just dropping this
> > > patch. It even makes each file a few bytes larger instead of saving
> > > something. Shebang lines are a shorter and more portable format
> > > indicator than the alternatives.
> > >
> > > So I think in the end we have found a good reason to keep them. :-)
> > 
> > What about .sh suffix? Should be most portable way.
> 
> That's the approach I tend to follow for my sh code.  Explicit is
> better than implicit if you ask me.

I would certainly agree for new files.

> Kevin,
> 
> Do you have any strong feelings here?  I'd be fine with either this
> or dropping the patch.

No strong feelings. The result of renaming the files would be a bit
nicer than what we have today, but renaming always comes with a cost
when working with the version history later. Hard to tell if it's a net
gain or loss in the end.

Myself, I would probably pick the lazy way and stick with "if it ain't
broke, don't fix it", but I'm not objecting to a change either.

Kevin

