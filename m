Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498CAC7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 10:04:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D034229ED
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 10:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D034229ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqE7z-0001gc-1H
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 06:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56031)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <zhexu@redhat.com>) id 1hqE7o-0001Fr-58
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 06:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhexu@redhat.com>) id 1hqE7m-0008F9-TM
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 06:03:56 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42616)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <zhexu@redhat.com>) id 1hqE7m-0008Ea-ND
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 06:03:54 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay6so21838289plb.9
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 03:03:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=EyYz+DbsQQN3oAVpJpHuHdTuEQaEneK6+IhZDJIzA1A=;
 b=D9Ob6E70h2SK3ZLO5/GmzSWQzGBd/WavSxii5wX3K6qzokW+MonsiaUHEY6JEKZvH1
 khcpf4TrVMjOsK2e09W5cKOtv267APwNO+ay6J+8GfqGUe/tj7tjVyC/x5oBzLMAnna4
 jFE2euBHiXG/PsFX7IC7NI3N1kvNi5/j718fdg6x5WjoTGa+92p5TNWthwvlAjE9TFxM
 6ZmdnzdmHP+KENfkaOTsGY+vFAMbyoswgNaTwjKTEk/wki0hdiIuizNFZExbQkSaRjey
 Wdr7ZDpRJZzbrRTOdP/1OM7/QhSOzWOFfdwFxLqxsp9Ii/cCBhBtT9abaaM9ndjOQqf1
 f74Q==
X-Gm-Message-State: APjAAAWvfdjjlGaarC9eOcaBbMla2ylfiRyE/vsDl8QsIF/kdnrMFjki
 oqiKlAQM5k72c9bm6jSUu+EBuw==
X-Google-Smtp-Source: APXvYqyrtUeWv4bTYCeCg1f/GbT2qC7FxdQ4dVVNaQBboZxKbBtxga3sV9fUHvDs4cj+xdArhiD+4w==
X-Received: by 2002:a17:902:788f:: with SMTP id
 q15mr86538658pll.236.1563962633500; 
 Wed, 24 Jul 2019 03:03:53 -0700 (PDT)
Received: from xz-x1 ([2409:8900:1d40:ee00:2db6:3c13:8375:7f91])
 by smtp.gmail.com with ESMTPSA id j128sm39606686pfg.28.2019.07.24.03.03.42
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 24 Jul 2019 03:03:52 -0700 (PDT)
From: Peter Xu <zhexu@redhat.com>
X-Google-Original-From: Peter Xu <peterx@redhat.com>
Date: Wed, 24 Jul 2019 18:03:31 +0800
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190724100331.GA14454@xz-x1>
References: <155364082689.15803.7062874513041742278.stgit@gimli.home>
 <20190329104904.450fefef@x1.home>
 <dbe614f5-47c8-b05d-dd73-2fbcd1579ae3@amd.com>
 <20190723112618.0efafa8d@x1.home> <20190724071439.GB18771@xz-x1>
 <20190724040837-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190724040837-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.194
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
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>, "Suthikulpanit,
 Suravee" <Suravee.Suthikulpanit@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Xu <zhexu@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 24, 2019 at 05:39:22AM -0400, Michael S. Tsirkin wrote:
> On Wed, Jul 24, 2019 at 03:14:39PM +0800, Peter Xu wrote:
> > On Tue, Jul 23, 2019 at 11:26:18AM -0600, Alex Williamson wrote:
> > > > On 3/29/19 11:49 AM, Alex Williamson wrote:
> > > > > [Cc +Brijesh]
> > > > > 
> > > > > Hi Brijesh, will the change below require the IVRS to be updated to
> > > > > include aliases for all BDF ranges behind a conventional bridge?  I
> > > > > think the Linux code handles this regardless of the firmware provided
> > > > > aliases, but is it required per spec for the ACPI tables to include
> > > > > bridge aliases?  Thanks,
> > > > >   
> > > > 
> > > > We do need to includes aliases in ACPI table. We need to populate the
> > > > IVHD type 0x43 and 0x4 for alias range start and end. I believe host
> > > > IVRS would contain similar information.
> > > > 
> > > > Suravee, please correct me if I am missing something?
> > > 
> > > I finally found some time to investigate this a little further, yes the
> > > types mentioned are correct for defining start and end of an alias
> > > range.  The challenge here is that these entries require a DeviceID,
> > > which is defined as a BDF, AIUI.  The IVRS is created in QEMU, but bus
> > > numbers are defined by the guest firmware, and potentially redefined by
> > > the guest OS.  This makes it non-trivial to insert a few IVHDs into the
> > > IVRS to describe alias ranges.  I'm wondering if the solution here is
> > > to define a new linker-loader command that would instruct the guest to
> > > write a bus number byte to a given offset for a described device.
> > > These commands would be inserted before the checksum command, such that
> > > these bus number updates are calculated as part of the checksum.
> > > 
> > > I'm imagining the command format would need to be able to distinguish
> > > between the actual bus number of a described device, the secondary bus
> > > number of the device, and the subordinate bus number of the device.
> > > For describing the device, I'm envisioning stealing from the DMAR
> > > definition, which already includes a bus number invariant mechanism to
> > > describe a device, starting with a segment and root bus, follow a chain
> > > of devfns to get to the target device.  Therefore the guest firmware
> > > would follow the path to the described device, pick the desired bus
> > > number, and write it to the indicated table offset.
> > > 
> > > Does this seem like a reasonable approach?  Better ideas?  I'm not
> > > thrilled with the increased scope demanded by IVRS support, but so long
> > > as we have an AMD IOMMU model, I don't see how to avoid it.  Thanks,
> > 
> > I don't have a better idea yet, but just want to say that accidentally
> > I was trying to look into this as well starting from this week and I'd
> > say that's mostly what I thought about too (I was still reading a bit
> > seabios when I saw this email)... so at least this idea makes sense to
> > me.
> > 
> > Would the guest OS still change the PCI bus number even after the
> > firmware (BIOS/UEFI)?  Could I ask in what case would that happen?
> > 
> > Thanks,
> 
> Guest OSes can in theory rebalance resources. Changing bus numbers
> would be useful if new bridges are added by hotplug.
> In practice at least Linux doesn't do the rebalancing.
> I think that if we start reporting PNP OS support in BIOS then windows
> might start doing that more aggressively.

It's surprising me a bit...  IMHO if we allow the bus number to change
then at least many scripts can even fail which might work before.
E.g. , a very common script can run "lspci-like" program to list each
device and then do "lspci-like -vvv" again upon the BDF it fetched
from previous commands.  Any kind of BDF caching would be invalid
since that from either userspace or kernel.

Also, obviously the data to be stored in IVRS is closely bound to how
bus number is defined.  Even if we can add a new linker-loader command
to all the open firmwares like seabios or OVMF but still we can't do
that to Windows (or, could we?...).

Now one step back, I'm also curious on the reason behind on why AMD
spec required the IVRS with BDF information, rather than the scope
information like what Intel DMAR spec was asking for.

Thanks,

-- 
Peter Xu

