Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A691C83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:12:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 001472082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 001472082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU3N8-0008O3-6u
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 03:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jU3MY-0007yr-Oh
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jU3MX-00019A-W6
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:12:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:48565)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jU3MX-00018s-E7
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:12:01 -0400
IronPort-SDR: iB/YlAur+q6cO8xcUAt+RxUFaGpizA3Hat989du0lz+E3hYbq6o1+czzVwzSA3Bw+YXwkCw0u4
 8kNO3JEsQE7w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2020 00:11:59 -0700
IronPort-SDR: KFn/8ZXpQGjxyIhqYksPjhbJ7NKjmhf/xR3aOTAHh6YZMczF6Guc7jUj/2TP93OVcUFo1PJhYz
 wlDMXQJx/7EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,334,1583222400"; d="scan'208";a="249667852"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by fmsmga008.fm.intel.com with ESMTP; 30 Apr 2020 00:11:57 -0700
Date: Thu, 30 Apr 2020 03:02:14 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v5 1/3] memory: drop guest writes to read-only ram device
 regions
Message-ID: <20200430070213.GQ12879@joy-OptiPlex-7040>
References: <20200430051558.28991-1-yan.y.zhao@intel.com>
 <20200430051923.29159-1-yan.y.zhao@intel.com>
 <4f99563d-8b52-9cc9-50b2-6e2de7a305b6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f99563d-8b52-9cc9-50b2-6e2de7a305b6@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=192.55.52.120; envelope-from=yan.y.zhao@intel.com;
 helo=mga04.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:32:59
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 192.55.52.120
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
 Xin" <xin.zeng@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 30, 2020 at 03:07:21PM +0800, Philippe Mathieu-Daudé wrote:
> On 4/30/20 7:19 AM, Yan Zhao wrote:
> > for ram device regions, drop guest writes if the regions is read-only.
> > 
> > Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > Signed-off-by: Xin Zeng <xin.zeng@intel.com>
> > ---
> >   memory.c | 15 ++++++++++++---
> >   1 file changed, 12 insertions(+), 3 deletions(-)
> > 
> > diff --git a/memory.c b/memory.c
> > index 601b749906..90a748912f 100644
> > --- a/memory.c
> > +++ b/memory.c
> > @@ -34,6 +34,7 @@
> >   #include "sysemu/accel.h"
> >   #include "hw/boards.h"
> >   #include "migration/vmstate.h"
> > +#include "qemu/log.h"
> >   
> >   //#define DEBUG_UNASSIGNED
> >   
> > @@ -1307,12 +1308,19 @@ static uint64_t memory_region_ram_device_read(void *opaque,
> >       return data;
> >   }
> >   
> > -static void memory_region_ram_device_write(void *opaque, hwaddr addr,
> > -                                           uint64_t data, unsigned size)
> > +static MemTxResult memory_region_ram_device_write(void *opaque, hwaddr addr,
> > +                                           uint64_t data, unsigned size,
> > +                                           MemTxAttrs attrs)
> 
> Style alignment is now of and can be adjusted easily.
> 
> >   {
> >       MemoryRegion *mr = opaque;
> >   
> >       trace_memory_region_ram_device_write(get_cpu_index(), mr, addr, data, size);
> > +    if (mr->readonly) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "Invalid write to read only ram device region addr 0x%"
> > +                       HWADDR_PRIx" size %u\n", addr, size);
> 
> Style alignment of here too.
> 
> Otherwise:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Thanks! I'll update it right now!

> 
> > +        return MEMTX_ERROR;
> > +    }
> >   
> >       switch (size) {
> >       case 1:
> > @@ -1328,11 +1336,12 @@ static void memory_region_ram_device_write(void *opaque, hwaddr addr,
> >           *(uint64_t *)(mr->ram_block->host + addr) = data;
> >           break;
> >       }
> > +    return MEMTX_OK;
> >   }
> >   
> >   static const MemoryRegionOps ram_device_mem_ops = {
> >       .read = memory_region_ram_device_read,
> > -    .write = memory_region_ram_device_write,
> > +    .write_with_attrs = memory_region_ram_device_write,
> >       .endianness = DEVICE_HOST_ENDIAN,
> >       .valid = {
> >           .min_access_size = 1,
> > 
> 

