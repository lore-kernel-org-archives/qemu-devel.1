Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16265ECE588
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 17:56:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E087E2067B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 17:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E087E2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKR3c-0000xL-09
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 13:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iKR1O-0007gz-Rv
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iKR1L-0004PM-S9
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:54:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57094)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iKR1L-0004ON-ME
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:54:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2AC23307D974;
 Tue, 15 Oct 2019 17:54:05 +0000 (UTC)
Received: from x1.home (ovpn-118-102.phx2.redhat.com [10.3.118.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B9245C1D6;
 Tue, 15 Oct 2019 17:53:56 +0000 (UTC)
Date: Tue, 15 Oct 2019 11:53:55 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [for-4.2 PATCH 0/2] PCI DMA alias support
Message-ID: <20191015115355.5a46000e@x1.home>
In-Reply-To: <20191014025957.GA8666@xz-x1>
References: <156418830210.10856.17740359763468342629.stgit@gimli.home>
 <20190729151504-mutt-send-email-mst@kernel.org>
 <20190819152316.232bf1e5@x1.home> <20191014025957.GA8666@xz-x1>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 15 Oct 2019 17:54:05 +0000 (UTC)
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
Cc: brijesh.singh@amd.com, Suravee.Suthikulpanit@amd.com,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, zhexu@redhat.com,
 eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Oct 2019 10:59:57 +0800
Peter Xu <peterx@redhat.com> wrote:

> On Mon, Aug 19, 2019 at 03:23:16PM -0600, Alex Williamson wrote:
> > On Mon, 29 Jul 2019 15:15:29 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> > > On Fri, Jul 26, 2019 at 06:55:27PM -0600, Alex Williamson wrote:  
> > > > Please see patch 1/ for the motivation and utility of this series.
> > > > This v1 submission improves on the previous RFC with revised commit
> > > > logs, comments, and more testing, and the missing IVRS support for DMA
> > > > alias ranges is now included.  Testing has been done with Linux guests
> > > > with both SeaBIOS and OVMF with configurations of intel-iommu and
> > > > amd-iommu.  Intel-iommu testing includes device assignment, amd-iommu
> > > > is necessarily limited to emulated devices with interrupt remapping
> > > > disabled and iommu=pt in the guest (enabling interrupt remapping or
> > > > disabling guest passthrough mode fails to work regardless of this
> > > > series).  This series is NOT intended for QEMU v4.1.  Thanks,
> > > > 
> > > > Alex    
> > > 
> > > 
> > > series looks good to me.
> > > pls ping when 4.1 is out and I'll queue it.  
> > 
> > Here's the requested ping :)  If you'd like a re-posting or comment
> > update, just say so.  I think Peter was ultimately satisfied enough to
> > not request a re-spin for comments alone.  Thanks,  
> 
> Hi, Michael,
> 
> Do you plan to merge this series?  Or do you still wait for an ack?
> 
> In all cases:
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks Peter, somehow I had it in my head that MST has already queued
these, but it seems not.  There's been hardly any churn in these files
upstream, so please consider these patches in play.  Thanks,

Alex

