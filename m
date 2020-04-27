Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D893C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:26:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB69020656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB69020656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT01u-00049g-46
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 05:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jT01D-0003Lq-5F
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:25:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jT01B-0008K5-TM
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:25:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:40008)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jT01B-0008IF-CT
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:25:37 -0400
IronPort-SDR: zPjwaYWB2fAsXIbxiaBb29qZ0zhdvcYPA+uCuKLY2Mw+iGySwzyH2pz809NKmgeNEJlZQBpbWn
 NgqVlazE5A9g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2020 02:25:29 -0700
IronPort-SDR: vPQYFQO4ZOTRv1vzs3aX8VLlWbLRSSx7R0RSdzrrGU5iZ/8j/GPa9rf//LytudYxsmj/svSqLn
 haYU8PMuSGzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,323,1583222400"; d="scan'208";a="302311645"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by FMSMGA003.fm.intel.com with ESMTP; 27 Apr 2020 02:25:27 -0700
Date: Mon, 27 Apr 2020 05:15:45 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 1/3] memory: drop guest writes to read-only ram device
 regions
Message-ID: <20200427091545.GH12879@joy-OptiPlex-7040>
References: <20200417074437.28526-1-yan.y.zhao@intel.com>
 <f96581ca-055e-ecc6-4a44-6bd26396bfc0@redhat.com>
 <20200426010430.GB12879@joy-OptiPlex-7040>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200426010430.GB12879@joy-OptiPlex-7040>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=134.134.136.31; envelope-from=yan.y.zhao@intel.com;
 helo=mga06.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 05:25:30
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 134.134.136.31
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
Cc: "philmd@redhat.com" <philmd@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Zeng,
 Xin" <xin.zeng@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Apr 26, 2020 at 09:04:31AM +0800, Yan Zhao wrote:
> On Sat, Apr 25, 2020 at 06:55:33PM +0800, Paolo Bonzini wrote:
> > On 17/04/20 09:44, Yan Zhao wrote:
> > > for ram device regions, drop guest writes if the regions is read-only.
> > > 
> > > Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> > > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > > Signed-off-by: Xin Zeng <xin.zeng@intel.com>
> > > ---
> > >  memory.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/memory.c b/memory.c
> > > index 601b749906..9576dd6807 100644
> > > --- a/memory.c
> > > +++ b/memory.c
> > > @@ -34,6 +34,7 @@
> > >  #include "sysemu/accel.h"
> > >  #include "hw/boards.h"
> > >  #include "migration/vmstate.h"
> > > +#include "qemu/log.h"
> > >  
> > >  //#define DEBUG_UNASSIGNED
> > >  
> > > @@ -1313,6 +1314,12 @@ static void memory_region_ram_device_write(void *opaque, hwaddr addr,
> > >      MemoryRegion *mr = opaque;
> > >  
> > >      trace_memory_region_ram_device_write(get_cpu_index(), mr, addr, data, size);
> > > +    if (mr->readonly) {
> > > +        qemu_log_mask(LOG_GUEST_ERROR,
> > > +                      "Invalid write to read only ram device region 0x%"
> > > +                       HWADDR_PRIx" size %u\n", addr, size);
> > > +        return;
> > > +    }
> > 
> > As mentioned in the review of v1, memory_region_ram_device_write should
> > be changed to a .write_with_attrs operation, so that it can return
> > MEMTX_ERROR.
> >
hi Paolo and Alex,
need I also change vfio_region_write() in patch 2 to a .write_with_attrs
operation?
vfio_region_read() is also possible to fail, so should I change it to a
.read_with_attrs, too?

Thanks
Yan

> > Otherwise this looks good.
> > 
> hi Paolo,
> thanks for pointing it out again!
> I didn't get your meaning in v1. will update the patch!
> 
> Thanks
> Yan
> > 
> 

