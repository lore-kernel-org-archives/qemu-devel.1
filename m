Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B55C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 16:23:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBC3D207F9
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 16:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC3D207F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jehmn-0002Ts-Qs
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 12:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lorenzo.pieralisi@arm.com>)
 id 1jehiO-0001E1-3O
 for qemu-devel@nongnu.org; Fri, 29 May 2020 12:18:36 -0400
Received: from foss.arm.com ([217.140.110.172]:59968)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lorenzo.pieralisi@arm.com>) id 1jehiM-0003w8-9I
 for qemu-devel@nongnu.org; Fri, 29 May 2020 12:18:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EFBE55D;
 Fri, 29 May 2020 09:18:32 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com
 [10.1.196.255])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 140983F6C4;
 Fri, 29 May 2020 09:18:30 -0700 (PDT)
Date: Fri, 29 May 2020 17:18:24 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: "Derrick, Jonathan" <jonathan.derrick@intel.com>
Subject: Re: [PATCH v3 1/2] PCI: vmd: Filter resource type bits from shadow
 register
Message-ID: <20200529161824.GA17642@e121166-lin.cambridge.arm.com>
References: <20200528030240.16024-1-jonathan.derrick@intel.com>
 <20200528030240.16024-3-jonathan.derrick@intel.com>
 <20200529103315.GC12270@e121166-lin.cambridge.arm.com>
 <163e8cb37ece0c8daa6d6e5fd7fcae47ba4fa437.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163e8cb37ece0c8daa6d6e5fd7fcae47ba4fa437.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=217.140.110.172;
 envelope-from=lorenzo.pieralisi@arm.com; helo=foss.arm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 12:18:32
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "andrzej.jakowski@linux.intel.com" <andrzej.jakowski@linux.intel.com>,
 "helgaas@kernel.org" <helgaas@kernel.org>, "hch@lst.de" <hch@lst.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 29, 2020 at 03:53:37PM +0000, Derrick, Jonathan wrote:
> On Fri, 2020-05-29 at 11:33 +0100, Lorenzo Pieralisi wrote:
> > On Wed, May 27, 2020 at 11:02:39PM -0400, Jon Derrick wrote:
> > > Versions of VMD with the Host Physical Address shadow register use this
> > > register to calculate the bus address offset needed to do guest
> > > passthrough of the domain. This register shadows the Host Physical
> > > Address registers including the resource type bits. After calculating
> > > the offset, the extra resource type bits lead to the VMD resources being
> > > over-provisioned at the front and under-provisioned at the back.
> > > 
> > > Example:
> > > pci 10000:80:02.0: reg 0x10: [mem 0xf801fffc-0xf803fffb 64bit]
> > > 
> > > Expected:
> > > pci 10000:80:02.0: reg 0x10: [mem 0xf8020000-0xf803ffff 64bit]
> > > 
> > > If other devices are mapped in the over-provisioned front, it could lead
> > > to resource conflict issues with VMD or those devices.
> > > 
> > > Fixes: a1a30170138c9 ("PCI: vmd: Fix shadow offsets to reflect spec changes")
> > > Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> > > ---
> > >  drivers/pci/controller/vmd.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > Hi Jon,
> > 
> > it looks like I can take this patch for v5.8 whereas patch 2 depends
> > on the QEMU changes acceptance and should probably wait.
> > 
> > Please let me know your thoughts asap and I will try to at least
> > squeeze this patch in.
> > 
> > Lorenzo
> 
> Hi Lorenzo,
> 
> This is fine. Please take Patch 1.
> Patch 2 is harmless without the QEMU changes, but may always need a
> different approach.

Pulled patch 1 into pci/vmd, thanks.

Lorenzo

