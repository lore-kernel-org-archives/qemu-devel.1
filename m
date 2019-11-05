Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F20C49EAA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:05:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBB2A20869
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB2A20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRumI-0001ZM-1J
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 04:05:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iRul1-0000v7-09
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:04:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iRuku-0004Df-2R
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:04:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58036)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iRukt-0004Cj-PU
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:04:04 -0500
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2292537F75
 for <qemu-devel@nongnu.org>; Tue,  5 Nov 2019 09:04:01 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id d144so20530600qke.16
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 01:04:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lSTUawn9pzlzND92vhb4XquSuXQivwtASgCgnap9X/w=;
 b=Xl+Plx+jcC77sBywkaXO/Imn1kC3OBnGJyOj9z0UOPKRp+ssHO5lEBoDqGWjztHTBf
 xJMKuD+gj54YujOAjlGCI9cHaYkoSZNhU8JANXkBoZNg9BP+mjpeNMXY/9Q5XZhY8lEO
 dnVHuESRevnLTY99Pzcs/BW8Q0lVlj4VF9aIF05hBfM+WjEVbKTDNIWEJztdwUH69xPW
 6HjJF2eL9njxXZCg+AwQYS9wleOaW/U4laA43H1PvCgC23sU825vNeI+w2Fa4Wpi/Suf
 JlExjK6ieOqjPimxnozG0Om67odkcJbGgk3HSaNbHyB0bJ6toIDC6XiqmO4sRzvs28Hw
 /new==
X-Gm-Message-State: APjAAAW8TI+IoIH7ZO5vWvGw4yCMdPeZNbjLeMvXnPjLVoAvIP09zU+1
 XWr92OPbsCcnfDXcmQM+BMWqoHSJudBJ9rTJ1T6+1DG9kgfDEya2EYhpkXFc7Zf1YbDU9bPHF4j
 H7V37W+FKKsYzQEI=
X-Received: by 2002:ac8:6f7c:: with SMTP id u28mr5231087qtv.273.1572944640418; 
 Tue, 05 Nov 2019 01:04:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqw8QEtpdX8KmVsuKwEb89JpfQd2ELtZpZqxvkDrLtm3XFi2NBHdtSjyuTfc6ZW3vmi0qG5CMg==
X-Received: by 2002:ac8:6f7c:: with SMTP id u28mr5231074qtv.273.1572944640228; 
 Tue, 05 Nov 2019 01:04:00 -0800 (PST)
Received: from redhat.com (bzq-79-178-12-128.red.bezeqint.net. [79.178.12.128])
 by smtp.gmail.com with ESMTPSA id y27sm10883929qtj.49.2019.11.05.01.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2019 01:03:59 -0800 (PST)
Date: Tue, 5 Nov 2019 04:03:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RESEND PATCH 0/2] PCI DMA alias support
Message-ID: <20191105040254-mutt-send-email-mst@kernel.org>
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

Yes but I put it in the tree for the next release, will merge
right after the release.


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

