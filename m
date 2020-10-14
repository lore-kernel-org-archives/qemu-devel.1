Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F260C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 17:57:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6579B2222A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 17:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6579B2222A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSl20-0005Qd-AQ
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 13:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.widawsky@intel.com>)
 id 1kSl1J-0004nl-MR
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 13:57:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:29147)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.widawsky@intel.com>)
 id 1kSl1F-0007UZ-WD
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 13:57:00 -0400
IronPort-SDR: TpkMiknKQgCZP5JppPMjkWbbAr2aoKXibxuKlgQkzo2y34g3aOIJJtNomyof5GssbJrgnr1VQx
 kDOkPbyhmRfw==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="146025270"
X-IronPort-AV: E=Sophos;i="5.77,375,1596524400"; d="scan'208";a="146025270"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2020 10:56:53 -0700
IronPort-SDR: +Bkp6bQlYZATXQ49CDRVedZDaVCt2ycaaOa+GKme8PGmWnuZ0PGGlukiYFnv7mUvYls4ICRpCZ
 I1dqOAhqVJ4g==
X-IronPort-AV: E=Sophos;i="5.77,375,1596524400"; d="scan'208";a="345751917"
Received: from pankajk1-mobl.amr.corp.intel.com (HELO intel.com)
 ([10.252.132.199])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2020 10:56:52 -0700
Date: Wed, 14 Oct 2020 10:56:51 -0700
From: Ben Widawsky <ben.widawsky@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RESEND] pci: Disallow improper BAR registration for type 1
Message-ID: <20201014175651.52dfubrzfob2fv2o@intel.com>
References: <20201014171853.71130-1-ben.widawsky@intel.com>
 <20201014135146-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014135146-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=192.55.52.151;
 envelope-from=ben.widawsky@intel.com; helo=mga17.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 13:56:53
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20-10-14 13:52:29, Michael S. Tsirkin wrote:
> On Wed, Oct 14, 2020 at 10:18:53AM -0700, Ben Widawsky wrote:
> > This patch informs future developers working on root complexes, root
> > ports, or bridges that also wish to implement a BAR for those. PCI type
> > 1 headers only support 2 base address registers. It is incorrect and
> > difficult to figure out what is wrong with the device when this mistake
> > is made. With this, it is immediate and obvious what has gone wrong.
> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> 
> How about an assert + a comment?
> This is how we usually handle developer bugs. error_report is
> for user errors and similar issues ...

Sure, I can do that. I was copying the error above mine which should probably
also be changed to an assert then, yes?

I can submit that as well with v2 of this if you'd like.

> 
> > ---
> >  hw/pci/pci.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index 3c8f10b461..55b0302c57 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -1141,6 +1141,7 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
> >      uint32_t addr; /* offset in pci config space */
> >      uint64_t wmask;
> >      pcibus_t size = memory_region_size(memory);
> > +    uint8_t hdr_type;
> >  
> >      assert(region_num >= 0);
> >      assert(region_num < PCI_NUM_REGIONS);
> > @@ -1150,6 +1151,15 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
> >          exit(1);
> >      }
> >  
> > +    hdr_type =
> > +        pci_dev->config[PCI_HEADER_TYPE] & ~PCI_HEADER_TYPE_MULTI_FUNCTION;
> > +    if (hdr_type == PCI_HEADER_TYPE_BRIDGE && region_num > 1) {
> > +        error_report("ERROR: PCI Type 1 header only has 2 BARs "
> > +                     "requested BAR=%d",
> > +                     region_num);
> > +        exit(1);
> > +    }
> > +
> >      r = &pci_dev->io_regions[region_num];
> >      r->addr = PCI_BAR_UNMAPPED;
> >      r->size = size;
> > -- 
> > 2.28.0
> 

