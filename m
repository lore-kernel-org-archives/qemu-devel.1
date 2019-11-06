Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6334DC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:43:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30F362173E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F362173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJii-0007U1-1A
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:43:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iSJaR-0005b9-FH
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:34:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iSJaQ-0008DY-67
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:34:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46208)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iSJaP-0008DJ-Tu
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:34:54 -0500
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 212E63683C
 for <qemu-devel@nongnu.org>; Wed,  6 Nov 2019 11:34:53 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id m189so24454086qkc.7
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 03:34:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PfKQklS6tzecCLpji5MibHGWmje8I14bHB/hCKBrvLc=;
 b=Mqg6HZhppNTW6fFaCIwXI3t7+x2mr/UbO6qPM43SUG3Jvve98DyGk2ms+x+KHqLAC/
 xovq70dU7fyVqNMACW23XsjwO2ZtJUIQJuv5oTzwavPJUp8nIF5+P2nQWXnUFV2kuPd7
 92VA+u9SMr0qchg+Le+B/N71QGgMBRBUYj0HZft3X2eKCqtS5zpaELW4k0/WMiKmY8dv
 hw8YUkCISOaHGnPGsw7b4x7YNy9g8n9n7ObIlx77rhM3nn/RAF7zpTiayjAyVivP0G45
 3j5NinF/uTK1nkchzsHrReNgCAQN9VPQr6VkhPejhH8suZRuvdIrdExfOpBYhvI3xuYC
 lhOA==
X-Gm-Message-State: APjAAAXneQxRVRMH7Gkgt/PadfT8XmwhFpbwi6k5nruKZexIBwM1Hmi+
 5RJC/1bfIIiRGJxrGQf6JGWy4oelZN6H/57q+l7WI2RpCSRzVZrdwEzt3QhkqlrWKfvC6WUUzPB
 5/ArGtjDd30Kp8iE=
X-Received: by 2002:a05:620a:20c5:: with SMTP id
 f5mr1523496qka.226.1573040092083; 
 Wed, 06 Nov 2019 03:34:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqxW9fsFatkAUExTX4iSwdlHqaqWiUMn2I4RpjkgPnPiZyokhmHSt5VQP5wtWDvl++oCedId7Q==
X-Received: by 2002:a05:620a:20c5:: with SMTP id
 f5mr1523486qka.226.1573040091842; 
 Wed, 06 Nov 2019 03:34:51 -0800 (PST)
Received: from redhat.com (bzq-79-178-12-128.red.bezeqint.net. [79.178.12.128])
 by smtp.gmail.com with ESMTPSA id t11sm8079660qtj.15.2019.11.06.03.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 03:34:51 -0800 (PST)
Date: Wed, 6 Nov 2019 06:34:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RESEND PATCH 0/2] PCI DMA alias support
Message-ID: <20191106063404-mutt-send-email-mst@kernel.org>
References: <157187055395.5439.6693401317571144578.stgit@gimli.home>
 <20191104150353.0a694812@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104150353.0a694812@x1.home>
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
Cc: qemu-devel@nongnu.org, peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 04, 2019 at 03:03:53PM -0700, Alex Williamson wrote:
> On Wed, 23 Oct 2019 16:47:02 -0600
> Alex Williamson <alex.williamson@redhat.com> wrote:
> 
> > Previous posting:
> > https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg06182.html
> > 
> > Rebased (no change) and added Peter's R-b.  Please apply for QEMU 4.2.
> 
> Anyone?  I suppose this has missed another release despite pings from
> me, Peter, and a resend :-(
> 
> Alex

It can be considered a bugfix so I think ok after freeze.

> > Previous cover letter:
> > 
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
> > 
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

