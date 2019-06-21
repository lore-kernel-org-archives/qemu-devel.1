Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CFAC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 02:48:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93D822084A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 02:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D822084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54328 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he9bJ-0001Ro-PM
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 22:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56752)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peterx@redhat.com>) id 1he9ZE-0000Im-PU
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 22:46:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1he9Pe-0003yw-ER
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 22:36:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39348)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1he9Pe-0003yO-81
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 22:36:26 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2EF6330842A0;
 Fri, 21 Jun 2019 02:36:25 +0000 (UTC)
Received: from xz-x1 (unknown [10.66.60.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B7211601A5;
 Fri, 21 Jun 2019 02:36:18 +0000 (UTC)
Date: Fri, 21 Jun 2019 10:36:13 +0800
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190621023613.GB9371@xz-x1>
References: <1560934185-14152-1-git-send-email-yan.y.zhao@intel.com>
 <39c4c32b-e34a-8d8f-abbc-ab346ec5bed7@redhat.com>
 <20190620040230.GB9073@xz-x1>
 <6829b139-3eab-449e-04d6-07f1e381316d@redhat.com>
 <20190620125955.GB9657@xz-x1>
 <df223a1f-bb87-0914-6216-8a4a70aae3ab@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df223a1f-bb87-0914-6216-8a4a70aae3ab@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 21 Jun 2019 02:36:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] memory: do not do out of bound notification
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
Cc: Auger Eric <eric.auger@redhat.com>, Yan Zhao <yan.y.zhao@intel.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 20, 2019 at 03:14:04PM +0200, Paolo Bonzini wrote:
> On 20/06/19 14:59, Peter Xu wrote:
> > I feel like this can be problematic.  I'm imaging:
> > 
> > start=0x1000_0000, size=0x1000_1000
> > 
> > This will get size=0x1000 but actually we can do size=0x1000_0000 as
> > the first.
> 
> Right, we can do:
> 
> /*
>  * If a naturally aligned region starting at "start" ends before "end",
>  * use it.  Otherwise, keep the lowest bit of size.
>  */
> if (size > (start & -start))
>     size = start & -start;

May need to consider start==0, otherwise size will be zero here?

> else
>     size = size & -size;

Should use MSB rather than LSB of size?

> 
> >>
> >> +        trace_vtd_as_unmap_whole(pci_bus_num(as->bus),
> >> +                                 VTD_PCI_SLOT(as->devfn),
> >> +                                 VTD_PCI_FUNC(as->devfn),
> >> +                                 entry.iova, size);
> > 
> > Can move this out because this is a trace only so we don't have
> > restriction on mask?
> > 
> >>
> >> -    map.iova = entry.iova;
> >> -    map.size = entry.addr_mask;
> >> -    iova_tree_remove(as->iova_tree, &map);
> >> +        map.iova = entry.iova;
> >> +        map.size = entry.addr_mask;
> >> +        iova_tree_remove(as->iova_tree, &map);
> > 
> > Same here?
> > 
> 
> Yes, I would move these and the iova_tree_remove outside the loop, while
> keeping entry's initialization inside looks cleaner.

Yeah that's ok to me too.

Thanks,

-- 
Peter Xu

