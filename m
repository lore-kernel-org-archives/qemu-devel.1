Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9643C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:58:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC4F20872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC4F20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCtkz-0000iQ-Lv
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 18:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peff@peff.net>) id 1iCtQJ-0002ay-0p
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 18:36:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peff@peff.net>) id 1iCtQH-0001j7-Mj
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 18:36:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:50466)
 by eggs.gnu.org with smtp (Exim 4.71) (envelope-from <peff@peff.net>)
 id 1iCtQH-0001i7-Hv
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 18:36:41 -0400
Received: (qmail 11496 invoked by uid 109); 24 Sep 2019 21:36:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Sep 2019 21:36:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12852 invoked by uid 111); 24 Sep 2019 21:39:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS;
 Tue, 24 Sep 2019 17:39:02 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2019 17:36:38 -0400
From: Jeff King <peff@peff.net>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: git format.from (was: 9p: Fix file ID collisions)
Message-ID: <20190924213638.GE20858@sigill.intra.peff.net>
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
 <56046367.TiUlWITyhT@silver>
 <20190923222415.GA22495@sigill.intra.peff.net>
 <3312839.Zbq2WQg2AT@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3312839.Zbq2WQg2AT@silver>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 104.130.231.41
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
Cc: berrange@redhat.com, stefanha@gmail.com, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Ian Kelling <iank@fsf.org>, dgilbert@redhat.com,
 antonios.motakis@huawei.com, git@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 24, 2019 at 11:03:38AM +0200, Christian Schoenebeck wrote:

> > Yes, the resulting mail would be correct, in the sense that it could be
> > applied just fine by git-am. But I think it would be uglier. IOW, I
> > consider the presence of the in-body From to be a clue that something
> > interesting is going on (like forwarding somebody else's patch). So from
> > my perspective, it would just be useless noise. Other communities may
> > have different opinions, though (I think I have seen some kernel folks
> > always including all of the possible in-body headers, including Date).
> > But it seems like it makes sense to keep both possibilities.
> 
> Exactly, current git behaviour is solely "prettier" (at first thought only 
> though), but does not address anything useful in real life.

I wouldn't agree with that. By being pretty, it also is functionally
more useful (I can tell at a glance whether somebody is sending a patch
from another author).

> Current git behaviour does cause real life problems though: Many email lists 
> are munging emails of patch senders whose domain is configured for requiring 
> domain's emails being DKIM signed and/or being subject to SPF rules (a.k.a 
> DMARC). So original sender's From: header is then automatically replaced by an 
> alias (by e.g. mailman): https://en.wikipedia.org/wiki/DMARC#From:_rewriting
> 
> For instance the email header:
> 
> From: "Bob Bold" <bold@foo.com>
> 
> is automatically replaced by lists by something like
> 
> From: "Bob Bold via Somelist" <somelist@gnu.org>
> 
> And since git currently always drops the From: line from the email's body if
> sender == author, as a consequence maintainers applying patches from such 
> lists, always need to rewrite git history subsequently and have to replace 
> patch author's identity manually for each commit to have their correct, real 
> email address and real name in git history instead of something like
> "Bob Bold via Somelist" <somelist@gnu.org>
> 
> So what do you find "uglier"? I prefer key info not being lost as default 
> behaviour. :-)

Sure, for your list that munges From headers, always including an
in-body From is way better. But for those of us _not_ on such lists, I'd
much prefer not to force the in-body version on them.

-Peff

