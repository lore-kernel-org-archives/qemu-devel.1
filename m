Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5B4C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 08:29:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E76A020768
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 08:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76A020768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOdQT-0000up-2U
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 04:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jOdPr-0000O1-0E
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1jOdPo-0002jo-HS
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:29:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:39219)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1jOdPo-0002bS-9G
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:29:00 -0400
IronPort-SDR: 5LJWVOM8CKs7uhNkMZ2mwiQK5G/yaOoekVIPvZ6zQmU9+2OYPQPgiRSomqKaS47SfgaQm1eLA2
 w74/XHaIhAdQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2020 01:28:49 -0700
IronPort-SDR: lX6mjKVafODiv4PntA5x8rhAXsvxivlZ2BPRAXw0nPztH+JR0d+5c2/aBexz9/IVP4nSM3slCn
 Fzl2hlE+I7hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; d="scan'208";a="427358874"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by orsmga005.jf.intel.com with ESMTP; 15 Apr 2020 01:28:47 -0700
Date: Wed, 15 Apr 2020 04:19:09 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 2/3] hw/vfio: drop guest writes to ro regions
Message-ID: <20200415081909.GG10586@joy-OptiPlex-7040>
References: <20200413063627.84608-1-yan.y.zhao@intel.com>
 <20200413063737.84706-1-yan.y.zhao@intel.com>
 <9cfa324b-65a3-be61-58b8-f51d6a0ea91d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9cfa324b-65a3-be61-58b8-f51d6a0ea91d@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.151
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
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Zeng,
 Xin" <xin.zeng@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 14, 2020 at 05:34:29PM +0800, Philippe Mathieu-Daudé wrote:
> Hi Yan,
> 
> On 4/13/20 8:37 AM, Yan Zhao wrote:
> > for vfio regions that are without write permission,
> > drop guest writes to those regions.
> > 
> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > Signed-off-by: Xin Zeng <xin.zeng@intel.com>
> > ---
> >   hw/vfio/common.c     | 8 +++++++-
> >   hw/vfio/trace-events | 2 +-
> >   2 files changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > index 0b3593b3c0..fd6ee1fe3e 100644
> > --- a/hw/vfio/common.c
> > +++ b/hw/vfio/common.c
> > @@ -190,6 +190,11 @@ void vfio_region_write(void *opaque, hwaddr addr,
> >           uint64_t qword;
> >       } buf;
> >   
> 
> I'd move the trace here (trace always):
> 
>         trace_vfio_region_write(vbasedev->name, region->nr, addr, data, 
> size);
> 
> > +    if (!(region->flags & VFIO_REGION_INFO_FLAG_WRITE)) {
> > +        trace_vfio_region_write(vbasedev->name, region->nr,
> > +                                   addr, data, size, true);
> 
> And use qemu_log_mask(LOG_GUEST_ERROR, ...) here instead.
>

ok. will change it. Thanks!

Yan
> > +        return;
> > +    }
> >       switch (size) {
> >       case 1:
> >           buf.byte = data;
> > @@ -215,7 +220,8 @@ void vfio_region_write(void *opaque, hwaddr addr,
> >                        addr, data, size);
> >       }
> >   
> > -    trace_vfio_region_write(vbasedev->name, region->nr, addr, data, size);
> > +    trace_vfio_region_write(vbasedev->name, region->nr, addr, data, size,
> > +                            false);
> >   
> >       /*
> >        * A read or write to a BAR always signals an INTx EOI.  This will
> > diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> > index b1ef55a33f..fb9ff604e6 100644
> > --- a/hw/vfio/trace-events
> > +++ b/hw/vfio/trace-events
> > @@ -91,7 +91,7 @@ vfio_pci_nvlink2_setup_quirk_ssatgt(const char *name, uint64_t tgt, uint64_t siz
> >   vfio_pci_nvlink2_setup_quirk_lnkspd(const char *name, uint32_t link_speed) "%s link_speed=0x%x"
> >   
> >   # common.c
> > -vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
> > +vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size, bool readonly) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)" " is_readonly_region=%d."
> >   vfio_region_read(char *name, int index, uint64_t addr, unsigned size, uint64_t data) " (%s:region%d+0x%"PRIx64", %d) = 0x%"PRIx64
> >   vfio_iommu_map_notify(const char *op, uint64_t iova_start, uint64_t iova_end) "iommu %s @ 0x%"PRIx64" - 0x%"PRIx64
> >   vfio_listener_region_add_skip(uint64_t start, uint64_t end) "SKIPPING region_add 0x%"PRIx64" - 0x%"PRIx64
> > 
> 

