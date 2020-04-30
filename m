Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BE8C8300B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:35:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73AC7214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73AC7214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU6Xb-000667-BD
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 06:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jU6JO-0001Ii-MP
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:20:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jU6JN-00034E-7U
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:20:57 -0400
Received: from mga17.intel.com ([192.55.52.151]:9548)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jU6JM-00033n-Ll
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:20:56 -0400
IronPort-SDR: GBCzgmAWUhkcRP+RVo38UxCHK0z+jjygNpzv4VjVmiOvaQcWZTT1sj8vpI40tNuLKk2BasdHz/
 KvfYeeYTHV0A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2020 03:20:54 -0700
IronPort-SDR: zJusH0GJhBdNXadHmGH5cgeAI09T5lIOzQ0XCm/MlicRs7d8+ukVSmlGav1AVBUk5jKhUTNqm0
 GRsaAXhoaksw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,334,1583222400"; d="scan'208";a="282814909"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by fmsmga004.fm.intel.com with ESMTP; 30 Apr 2020 03:20:52 -0700
Date: Thu, 30 Apr 2020 06:11:09 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v6 1/3] memory: drop guest writes to read-only ram device
 regions
Message-ID: <20200430101108.GR12879@joy-OptiPlex-7040>
References: <20200430080744.31232-1-yan.y.zhao@intel.com>
 <20200430080946.31286-1-yan.y.zhao@intel.com>
 <CAFEAcA-8NH_4ZV0J9urBZdQWmqOe-Nyy4y2gLAjTJ08MpfFY0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-8NH_4ZV0J9urBZdQWmqOe-Nyy4y2gLAjTJ08MpfFY0g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=192.55.52.151; envelope-from=yan.y.zhao@intel.com;
 helo=mga17.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 06:20:54
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, "Zeng, Xin" <xin.zeng@intel.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 30, 2020 at 05:40:25PM +0800, Peter Maydell wrote:
> On Thu, 30 Apr 2020 at 09:20, Yan Zhao <yan.y.zhao@intel.com> wrote:
> >
> > for ram device regions, drop guest writes if the region is read-only.
> >
> > Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > Signed-off-by: Xin Zeng <xin.zeng@intel.com>
> > ---
> >  memory.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/memory.c b/memory.c
> > index 601b749906..a1bba985b9 100644
> > --- a/memory.c
> > +++ b/memory.c
> > @@ -34,6 +34,7 @@
> >  #include "sysemu/accel.h"
> >  #include "hw/boards.h"
> >  #include "migration/vmstate.h"
> > +#include "qemu/log.h"
> >
> >  //#define DEBUG_UNASSIGNED
> >
> > @@ -1307,12 +1308,19 @@ static uint64_t memory_region_ram_device_read(void *opaque,
> >      return data;
> >  }
> >
> > -static void memory_region_ram_device_write(void *opaque, hwaddr addr,
> > -                                           uint64_t data, unsigned size)
> > +static MemTxResult memory_region_ram_device_write(void *opaque, hwaddr addr,
> > +                                                  uint64_t data, unsigned size,
> > +                                                  MemTxAttrs attrs)
> >  {
> >      MemoryRegion *mr = opaque;
> >
> >      trace_memory_region_ram_device_write(get_cpu_index(), mr, addr, data, size);
> > +    if (mr->readonly) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "Invalid write to read-only ram device region addr 0x%"
> > +                      HWADDR_PRIx" size %u\n", addr, size);
> > +        return MEMTX_ERROR;
> > +    }
> 
> This does not "drop" a write to a r/o region -- it causes it to generate
> whatever the guest architecture's equivalent of a bus error is (eg data
> abort on Arm).
>
hmm, I'm not sure. so your expectation is silently dropping guest writes
without any bus error, right?

> More generally, this change seems a bit odd: currently we do not
> check the mr->readonly flag here, but in general guests don't get
> to write to ROM areas. Where is that check currently done, and
it's not a ROM, but a ram region backed by a device. we wish this region
to be read-only sometimes, in order to implement some useful features.
It can be a virtual BAR region in a virtual mdev device.

> should the vfio case you're trying to fix do its check in whatever
> the equivalent of that place is? Alternatively, if we want to make
> memory_region_ram_device_write() do the check, does that mean we
> now have unnecessary checks elsewhere.
currently, vfio implements the BAR regions in two types:
1. non-mmap'd,  meaning this region will not be added into kvm memory
slots, and whenever guest accesses it, it will be trapped into a host
handler. we do the read-only check in patch 2 of this series.
2. mmap'd, meaning this region will be added into kvm memory slots, and
guest could access it without any hypervisor intervening.
so without patch 3 in the series, there's no write protection to guest
writes.
after setting this mmap'd region to read-only in patch 3, the
corresponding memory slot in kvm is set to read-only, so only guest
writes would be trapped into host, i.e. into the
memory_region_ram_device_write(). guest reads is still within the guest
without hypervisor intervening.


> 
> My guess is that memory_region_ram_device_write() isn't the
> right place to check for read-only-ness, because it only applies
> to RAM-backed MRs, not to any other kind of MR which might equally
> be readonly.
>
there might be other MRs that require checking of read-only-ness.
but their handlers have the right to be called to know it has happened,
and they might want to do some special handling of it. That's why I did
not put the check in general dispatcher.

Thanks
Yan


