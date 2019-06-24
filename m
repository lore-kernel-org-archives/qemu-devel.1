Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7746EC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 09:12:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 090D520657
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 09:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090D520657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48954 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfL1h-0002sQ-1u
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 05:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51065)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peterx@redhat.com>) id 1hfKzE-0001vQ-QR
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 05:10:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hfKzD-0008Ms-RO
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 05:10:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39424)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hfKzD-0008Lc-LN
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 05:10:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E467C3082B25;
 Mon, 24 Jun 2019 09:09:54 +0000 (UTC)
Received: from xz-x1 (ovpn-12-60.pek2.redhat.com [10.72.12.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D54C608E4;
 Mon, 24 Jun 2019 09:09:44 +0000 (UTC)
Date: Mon, 24 Jun 2019 17:09:40 +0800
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190624090940.GH6279@xz-x1>
References: <20190624063733.22079-1-peterx@redhat.com>
 <20190624063733.22079-3-peterx@redhat.com>
 <20190624064122.GB27894@joy-OptiPlex-7040>
 <20190624065750.GE6279@xz-x1>
 <20190624070450.GC27894@joy-OptiPlex-7040>
 <20190624080649.GG6279@xz-x1>
 <a0a6a698-d671-9b4c-badf-75bc258242ff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a0a6a698-d671-9b4c-badf-75bc258242ff@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 24 Jun 2019 09:09:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] intel_iommu: Fix unexpected unmaps
 during global unmap
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
Cc: Auger Eric <eric.auger@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yan Zhao <yan.y.zhao@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 24, 2019 at 10:43:21AM +0200, Paolo Bonzini wrote:
> On 24/06/19 10:06, Peter Xu wrote:
> > Well, if with such an error we'd better fix it right away in this
> > patch... :)
> > 
> > Let me wait for some more comments, I'll touch that up too if I need a
> > repost.
> 
> Looks good to me, except for one minor issue in this patch.  But do not
> attribute this one to me, it's basically all code from you.

OK.

> 
> > +static uint64_t vtd_get_next_mask(uint64_t start, uint64_t size, int gaw)
> > +{
> > +    /* Tries to find smallest mask from start first */
> > +    uint64_t rmask = start & -start, max_mask = 1ULL << gaw;
> > +
> > +    assert(size && gaw > 0 && gaw < 64);
> > +
> > +    /* Zero start, or too big */
> > +    if (!rmask || rmask > max_mask) {
> > +        rmask = max_mask;
> > +    }
> 
> Perhaps simpler:
> 
>     uint64_t max_mask = 1ULL << gaw;
>     uint64_t alignment = start ? start & -start : max_mask;
> 

(I'll add another "alignment = MIN(alignment, max_mask)" here if no
 one disagree...)

>     size = MIN(size, max_mask);
>     if (alignment <= size) {
>         /* Increase the alignment of start */
>         return alignment;
>     } else {
>         /* Find the largest page mask from size */
>         return 1ULL << (63 - clz64(size));
>     }
> 
> Also please rename it to get_naturally_aligned_size.

Will do.  Thanks,

-- 
Peter Xu

