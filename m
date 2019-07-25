Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16ECC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:22:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D7420659
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D7420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqfZf-000454-1q
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46909)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hqfZU-0003f6-JU
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:22:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hqfZT-0003vJ-MP
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:22:20 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33456)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hqfZT-0003v9-Ht
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:22:19 -0400
Received: by mail-qt1-f195.google.com with SMTP id r6so45225275qtt.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 08:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=glXy1hHBHBaz60wgQfXt41x7b3C2atHxP3ge3rxZisI=;
 b=TpAvjQO4L7j5fN2fB9rJ/S2eCiiUy/mzNnqkAUSm5i32eMx79RZSg2ruut/s/j4ICg
 t1UlyDRtp/fd5wa3bb5qNsfsweGA0vLFJG1FK153yF+BmH8Uo+J1Y85U9ObOQkJsMz0S
 EbeQuOWXPz1e4lNpBZe84RTwfquFb8CEUmobKFqYnbBlwZWpT32uvmh+iMm+s1ek/TOw
 6C9gvHbe/tV8ymvfmPNHnB5LFPT8jmITHd+wlCvTNSNlPi3V9cPt53IjUiFCWgw3KOrh
 qRyK8OOvtxnNbyfOwwmzCUBUX63w6lifYKtlXlGS/I0ewdVYVV6qXZts2yp1zSYWDzjz
 ayAA==
X-Gm-Message-State: APjAAAVRpdesfVKeHktmzcsUAaCPfozUZHnAMbZTxYrqmBoKh72ncvVg
 mrfej/SuI66deXVKeVDU/miptQ==
X-Google-Smtp-Source: APXvYqy29fZ4MWaFLqlihFMv98uPe3Fj/COGoWjVDwtiuqBXw0A1Jya1tJJ1/sf1enAu6u5Mr6G+tA==
X-Received: by 2002:ad4:5283:: with SMTP id v3mr63979805qvr.207.1564068138961; 
 Thu, 25 Jul 2019 08:22:18 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 j184sm20075739qkc.65.2019.07.25.08.22.15
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 08:22:18 -0700 (PDT)
Date: Thu, 25 Jul 2019 11:22:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190725112132-mutt-send-email-mst@kernel.org>
References: <20190329104904.450fefef@x1.home>
 <dbe614f5-47c8-b05d-dd73-2fbcd1579ae3@amd.com>
 <20190723112618.0efafa8d@x1.home> <20190724071439.GB18771@xz-x1>
 <20190724040837-mutt-send-email-mst@kernel.org>
 <20190724100331.GA14454@xz-x1> <20190724084355.627d44cf@x1.home>
 <20190725063733.GH14454@xz-x1>
 <20190725064244-mutt-send-email-mst@kernel.org>
 <20190725080023.24de0d82@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725080023.24de0d82@x1.home>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.195
Subject: Re: [Qemu-devel] [RFC PATCH] pci: Use PCI aliases when determining
 device IOMMU address space
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
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Xu <zhexu@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "Suthikulpanit,
 Suravee" <Suravee.Suthikulpanit@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 25, 2019 at 08:00:23AM -0600, Alex Williamson wrote:
> On Thu, 25 Jul 2019 06:43:04 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Thu, Jul 25, 2019 at 02:37:33PM +0800, Peter Xu wrote:
> > > After re-read Michael's reply, I feel like what Michael suggested is
> > > that we can simply ignore the bus-number-change case by the guest OS
> > > for now, but I might be wrong.  
> > That's what I suggested, yes.
> 
> "by the guest OS", yes, that's the part that's beyond the scope of this
> effort.  If we deem it necessary to support IVHD DMA alias though, it's
> the guest firmware that determines the initial bus numbers, which is
> part of the DeviceID used to defined IVHD entries and we would not be
> able to ignore that initial programming.  Everything related to the
> guest OS renumber PCI buses is out of scope, the guest firmware
> programming initial bus numbers is not.  

Right. That's par for the course, we have same issues with MCFG
and others. bios programs it and then we generate acpi based on
that.

>Thanks,
> 
> Alex

