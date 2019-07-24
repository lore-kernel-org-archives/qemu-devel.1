Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2900EC7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 07:15:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3EE021951
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 07:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3EE021951
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqBUO-00057g-5Z
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 03:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39475)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <zhexu@redhat.com>) id 1hqBUC-0004ij-E2
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 03:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhexu@redhat.com>) id 1hqBUB-0007Iw-Bq
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 03:14:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38047)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <zhexu@redhat.com>) id 1hqBUB-0007HY-6U
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 03:14:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id y15so20459376pfn.5
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 00:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=eIQ4Q2iKprKCYMnqCpDrz5zoVUnoXapv0ubQ9Jns1iw=;
 b=lpxy4XLom4tuymtIIyAGp5KvEUUqFbrpJzmsez1wFJqbVlIhZREr2LxlL4hYwEqGyz
 xK08kQoeivS3hG880JBoy3606dshBwCd5LDm9G465J+y2nKUox3ET4BbN4XGQiYxmsLX
 lG6/UjM5MHuI1Dj6m04g+Enjwl7jAfZ1opR9GWwBcZHW4z1bWD9h+CmjvrKFtDi2/Ghy
 26Aw9T00fqrIRdwEhrgPHrZtebNNf8CnvkTlx5xz5sDSDBr0uEGvz3xpNJNedoYVpwHy
 Hnm3bX90EVxSoiXrfVf4LggP/jyVFK01vA2nASyfy8nayHWmM/yfLz35Nzes+k9qXDPj
 +6Bw==
X-Gm-Message-State: APjAAAVkL/I0VDr0MhfFP+0f2KYAWVjvCFsX0aCaKwZplNwH1CM8k5nf
 BG4BX+J9SxPAxHHte4Ssa9JJ+A==
X-Google-Smtp-Source: APXvYqymSmh+QYhVYDJAHJOaZ6rXF3MzEplrPRKoDQzqcRz9bzyr+ftgbILeCwcpNWNx40EedL2ciA==
X-Received: by 2002:a63:b20f:: with SMTP id x15mr82567593pge.453.1563952489398; 
 Wed, 24 Jul 2019 00:14:49 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b30sm66593219pfr.117.2019.07.24.00.14.46
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 24 Jul 2019 00:14:48 -0700 (PDT)
From: Peter Xu <zhexu@redhat.com>
X-Google-Original-From: Peter Xu <peterx@redhat.com>
Date: Wed, 24 Jul 2019 15:14:39 +0800
To: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190724071439.GB18771@xz-x1>
References: <155364082689.15803.7062874513041742278.stgit@gimli.home>
 <20190329104904.450fefef@x1.home>
 <dbe614f5-47c8-b05d-dd73-2fbcd1579ae3@amd.com>
 <20190723112618.0efafa8d@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190723112618.0efafa8d@x1.home>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.193
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
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>, "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "Suthikulpanit,
 Suravee" <Suravee.Suthikulpanit@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 23, 2019 at 11:26:18AM -0600, Alex Williamson wrote:
> > On 3/29/19 11:49 AM, Alex Williamson wrote:
> > > [Cc +Brijesh]
> > > 
> > > Hi Brijesh, will the change below require the IVRS to be updated to
> > > include aliases for all BDF ranges behind a conventional bridge?  I
> > > think the Linux code handles this regardless of the firmware provided
> > > aliases, but is it required per spec for the ACPI tables to include
> > > bridge aliases?  Thanks,
> > >   
> > 
> > We do need to includes aliases in ACPI table. We need to populate the
> > IVHD type 0x43 and 0x4 for alias range start and end. I believe host
> > IVRS would contain similar information.
> > 
> > Suravee, please correct me if I am missing something?
> 
> I finally found some time to investigate this a little further, yes the
> types mentioned are correct for defining start and end of an alias
> range.  The challenge here is that these entries require a DeviceID,
> which is defined as a BDF, AIUI.  The IVRS is created in QEMU, but bus
> numbers are defined by the guest firmware, and potentially redefined by
> the guest OS.  This makes it non-trivial to insert a few IVHDs into the
> IVRS to describe alias ranges.  I'm wondering if the solution here is
> to define a new linker-loader command that would instruct the guest to
> write a bus number byte to a given offset for a described device.
> These commands would be inserted before the checksum command, such that
> these bus number updates are calculated as part of the checksum.
> 
> I'm imagining the command format would need to be able to distinguish
> between the actual bus number of a described device, the secondary bus
> number of the device, and the subordinate bus number of the device.
> For describing the device, I'm envisioning stealing from the DMAR
> definition, which already includes a bus number invariant mechanism to
> describe a device, starting with a segment and root bus, follow a chain
> of devfns to get to the target device.  Therefore the guest firmware
> would follow the path to the described device, pick the desired bus
> number, and write it to the indicated table offset.
> 
> Does this seem like a reasonable approach?  Better ideas?  I'm not
> thrilled with the increased scope demanded by IVRS support, but so long
> as we have an AMD IOMMU model, I don't see how to avoid it.  Thanks,

I don't have a better idea yet, but just want to say that accidentally
I was trying to look into this as well starting from this week and I'd
say that's mostly what I thought about too (I was still reading a bit
seabios when I saw this email)... so at least this idea makes sense to
me.

Would the guest OS still change the PCI bus number even after the
firmware (BIOS/UEFI)?  Could I ask in what case would that happen?

Thanks,

-- 
Peter Xu

