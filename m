Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D510C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 21:24:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4031E22CEC
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 21:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4031E22CEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzp8N-0005Bq-Ag
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 17:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1hzp7f-0004md-Hx
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:23:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1hzp7d-0000A3-Tr
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:23:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43594)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1hzp7d-00005I-79
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:23:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 093923090FC6;
 Mon, 19 Aug 2019 21:23:22 +0000 (UTC)
Received: from x1.home (ovpn-116-99.phx2.redhat.com [10.3.116.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD47A1E4;
 Mon, 19 Aug 2019 21:23:16 +0000 (UTC)
Date: Mon, 19 Aug 2019 15:23:16 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190819152316.232bf1e5@x1.home>
In-Reply-To: <20190729151504-mutt-send-email-mst@kernel.org>
References: <156418830210.10856.17740359763468342629.stgit@gimli.home>
 <20190729151504-mutt-send-email-mst@kernel.org>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 19 Aug 2019 21:23:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [for-4.2 PATCH 0/2] PCI DMA alias support
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
Cc: brijesh.singh@amd.com, qemu-devel@nongnu.org, zhexu@redhat.com,
 eric.auger@redhat.com, Suravee.Suthikulpanit@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jul 2019 15:15:29 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Jul 26, 2019 at 06:55:27PM -0600, Alex Williamson wrote:
> > Please see patch 1/ for the motivation and utility of this series.
> > This v1 submission improves on the previous RFC with revised commit
> > logs, comments, and more testing, and the missing IVRS support for DMA
> > alias ranges is now included.  Testing has been done with Linux guests
> > with both SeaBIOS and OVMF with configurations of intel-iommu and
> > amd-iommu.  Intel-iommu testing includes device assignment, amd-iommu
> > is necessarily limited to emulated devices with interrupt remapping
> > disabled and iommu=pt in the guest (enabling interrupt remapping or
> > disabling guest passthrough mode fails to work regardless of this
> > series).  This series is NOT intended for QEMU v4.1.  Thanks,
> > 
> > Alex  
> 
> 
> series looks good to me.
> pls ping when 4.1 is out and I'll queue it.

Here's the requested ping :)  If you'd like a re-posting or comment
update, just say so.  I think Peter was ultimately satisfied enough to
not request a re-spin for comments alone.  Thanks,

Alex

> > ---
> > 
> > Alex Williamson (2):
> >       pci: Use PCI aliases when determining device IOMMU address space
> >       hw/i386: AMD-Vi IVRS DMA alias support
> > 
> > 
> >  hw/i386/acpi-build.c |  127 +++++++++++++++++++++++++++++++++++++++++++++++---
> >  hw/pci/pci.c         |   43 ++++++++++++++++-
> >  2 files changed, 160 insertions(+), 10 deletions(-)  


