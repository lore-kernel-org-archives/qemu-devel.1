Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05A5C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 11:29:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A164520880
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 11:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A164520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hni7x-0002qy-Ue
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 07:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44479)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hni7n-0002SF-AZ
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 07:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hni7m-0006Io-6e
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 07:29:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39868)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>)
 id 1hni7k-0006Hn-KI; Wed, 17 Jul 2019 07:29:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 92C62308A9BE;
 Wed, 17 Jul 2019 11:29:27 +0000 (UTC)
Received: from redhat.com (ovpn-120-247.rdu2.redhat.com [10.10.120.247])
 by smtp.corp.redhat.com (Postfix) with SMTP id 2E33B608A6;
 Wed, 17 Jul 2019 11:29:20 +0000 (UTC)
Date: Wed, 17 Jul 2019 07:29:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190717072551-mutt-send-email-mst@kernel.org>
References: <20190717103550.24657-1-david@redhat.com>
 <20190717103550.24657-4-david@redhat.com>
 <20190717063902-mutt-send-email-mst@kernel.org>
 <0828606b-4cdf-63ea-9211-dc5905b00f4b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0828606b-4cdf-63ea-9211-dc5905b00f4b@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 17 Jul 2019 11:29:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v2 3/3] virtio-balloon: reset pbp
 on device resets
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 17, 2019 at 01:06:29PM +0200, David Hildenbrand wrote:
> On 17.07.19 12:48, Michael S. Tsirkin wrote:
> > On Wed, Jul 17, 2019 at 12:35:50PM +0200, David Hildenbrand wrote:
> >> When a guest reboots (ordinary reboots, but also via kexec), it will
> >> happily reuse any system memory, including previously inflated memory.
> >>
> >> We could have tracking data for a pbp (PartiallyBalloonedPage). It could
> >> happen that a new inflation request from the guest will result in a
> >> discard of such a pbp, although the guest is (again) reusing some
> >> memory.
> >>
> >> We should reset the pbp on any device resets.
> >>
> >> Fixes: ed48c59875b6 ("virtio-balloon: Safely handle BALLOON_PAGE_SIZE <
> >>                      host page size")
> >> Cc: qemu-stable@nongnu.org #v4.0.0
> >> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> >> Cc: David Gibson <david@gibson.dropbear.id.au>
> >> Cc: Michael S. Tsirkin <mst@redhat.com>
> >> Cc: Igor Mammedov <imammedo@redhat.com>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> > 
> > Can't something else remove a ramblock besides a reset?
> 
> Yes, however this patch is not about ramblocks getting removed.
> 
> Take a close look, "balloon->pbp->rb" is only used as a token, it is
> never used besides for comparisons.


You are right but that's still not safe :)

E.g. the bit we are going to set could be out of range of the bitmap because
the backing page size changed.



> -- 
> 
> Thanks,
> 
> David / dhildenb

