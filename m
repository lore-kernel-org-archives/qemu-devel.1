Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365D5C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 06:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 223B720578
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 06:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 223B720578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCH1t-0005Nl-69
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 02:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jCH1K-0004VL-9c
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 02:08:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jCH1J-0006r7-65
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 02:08:38 -0400
Received: from charlie.dont.surf ([128.199.63.193]:40176)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jCH1G-0006o4-Pf; Thu, 12 Mar 2020 02:08:34 -0400
Received: from apples.localdomain (80-62-117-144-mobile.dk.customer.tdc.net
 [80.62.117.144])
 by charlie.dont.surf (Postfix) with ESMTPSA id 957B9BF58E;
 Thu, 12 Mar 2020 06:08:31 +0000 (UTC)
Date: Wed, 11 Mar 2020 23:08:27 -0700
From: Klaus Birkelund Jensen <its@irrelevant.dk>
To: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Subject: Re: [PATCH RESEND v2] block/nvme: introduce PMR support from NVMe
 1.4 spec
Message-ID: <20200312060827.gjddwgmevyptsmpl@apples.localdomain>
References: <20200306223853.37958-1-andrzej.jakowski@linux.intel.com>
 <20200310095147.GC140737@stefanha-x1.localdomain>
 <15b8a77d-50de-2228-a0e6-a461b82f1873@linux.intel.com>
 <CAJSP0QXatOWgicLo5sGt9KA2QupC2qXD2LCdHWKgHFdzgt9pEg@mail.gmail.com>
 <12576914-0ef4-efd2-355a-cff3f4eeae69@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <12576914-0ef4-efd2-355a-cff3f4eeae69@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 128.199.63.193
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
Cc: Kevin Wolf <kwolf@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>,
 qemu block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, Dave Gilbert <dgilbert@redhat.com>,
 Zhang Yi <yi.z.zhang@linux.intel.com>, "He, Junyan" <junyan.he@intel.com>,
 kbusch@kernel.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mar 11 15:54, Andrzej Jakowski wrote:
> On 3/11/20 2:20 AM, Stefan Hajnoczi wrote:
> > Please try:
> > 
> >   $ git grep pmem
> > 
> > backends/hostmem-file.c is the backend that can be used and the
> > pmem_persist() API can be used to flush writes.
> 
> I've reworked this patch into hostmem-file type of backend.
> From simple tests in virtual machine: writing to PMR region
> and then reading from it after VM power cycle I have observed that
> there is no persistency.
> 
> I guess that persistent behavior can be achieved if memory backend file
> resides on actual persistent memory in VMM. I haven't found mechanism to
> persist memory backend file when it resides in the file system on block
> storage. My original mmap + msync based solution worked well there.
> I believe that main problem with mmap was with "ifdef _WIN32" that made it 
> platform specific and w/o it patchew CI complained. 
> Is there a way that I could rework mmap + msync solution so it would fit
> into qemu design?
> 

Hi Andrzej,

Thanks for working on this!

FWIW, I have implemented other stuff for the NVMe device that requires
persistent storage (e.g. LBA allocation tracking for DULBE support). I
used the approach of adding an additional blockdev and simply use the
qemu block layer. This would also make it work on WIN32. And if we just
set bit 0 in PMRWBM and disable the write cache on the blockdev we
should be good on the durability requirements.

Unfortunately, I do not see (or know, maybe Stefan has an idea?) an easy
way of using the MemoryRegionOps nicely with async block backend i/o. so
we either have to use blocking I/O or fire and forget aio. Or, we can
maybe keep bit 1 set in PMRWBM and force a blocking blk_flush on PMRSTS
read.

Finally, a thing to consider is that this is adding an optional NVMe 1.4
feature to an already frankenstein device that doesn't even implement
mandatory v1.2. I think that bumping the NVMe version to 1.4 is out of
the question until we actually implement it fully wrt. mandatory
features. My patchset brings the device up to v1.3 and I have v1.4 ready
for posting, so I think we can get there.


Klaus

