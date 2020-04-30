Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B56EC83006
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:11:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64CBE2186A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CBE2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU3MF-0007HV-IB
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 03:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jU3LU-0006FJ-VX
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:10:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jU3LT-0000fT-5Z
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:10:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:5923)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jU3LS-0000ej-K9
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:10:54 -0400
IronPort-SDR: IEoyXF9GVn1v5hRJFKlsO0N1iPQ7KdGgQOTJVunlnwG5l0wJ/NUjDgwBGFp1RbTeTHty6YyEac
 B6rKJUcEerSw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2020 00:10:52 -0700
IronPort-SDR: h+KiIGiez+A3lYlmCd6DAqHPmnXb9m1NIMq2Ae0y+k3WNqYrHv/nVmUs9+AqAWW8t3dw1KfInw
 gDR4c53JyG5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,334,1583222400"; d="scan'208";a="459466673"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by fmsmga005.fm.intel.com with ESMTP; 30 Apr 2020 00:10:50 -0700
Date: Thu, 30 Apr 2020 03:01:07 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v5 2/3] hw/vfio: drop guest writes to ro regions
Message-ID: <20200430070106.GP12879@joy-OptiPlex-7040>
References: <20200430051558.28991-1-yan.y.zhao@intel.com>
 <20200430052307.29235-1-yan.y.zhao@intel.com>
 <d78ed9ed-f78d-4aa5-efcc-77cb33fb1c76@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d78ed9ed-f78d-4aa5-efcc-77cb33fb1c76@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=192.55.52.115; envelope-from=yan.y.zhao@intel.com;
 helo=mga14.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 03:10:52
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 192.55.52.115
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

On Thu, Apr 30, 2020 at 03:02:36PM +0800, Philippe Mathieu-Daudé wrote:
> On 4/30/20 7:23 AM, Yan Zhao wrote:
> > for vfio regions that are without write permission,
> > drop guest writes to those regions.
> > 
> > Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.co>
> 
> The full domain name is redhat.com.
>
oops. really sorry....

> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > Signed-off-by: Xin Zeng <xin.zeng@intel.com>
> > ---
> >   hw/vfio/common.c | 13 +++++++++++--
> >   1 file changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > index 0b3593b3c0..2a4fedfeaa 100644
> > --- a/hw/vfio/common.c
> > +++ b/hw/vfio/common.c
> > @@ -38,6 +38,7 @@
> >   #include "sysemu/reset.h"
> >   #include "trace.h"
> >   #include "qapi/error.h"
> > +#include "qemu/log.h"
> >   
> >   VFIOGroupList vfio_group_list =
> >       QLIST_HEAD_INITIALIZER(vfio_group_list);
> > @@ -190,6 +191,16 @@ void vfio_region_write(void *opaque, hwaddr addr,
> >           uint64_t qword;
> >       } buf;
> >   
> > +    trace_vfio_region_write(vbasedev->name, region->nr, addr, data, size);
> > +    if (!(region->flags & VFIO_REGION_INFO_FLAG_WRITE)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "Invalid write to read only vfio region (%s:region%d"
> > +                      "+0x%"HWADDR_PRIx" size %d)\n", vbasedev->name,
> > +                      region->nr, addr, size);
> > +
> > +        return;
> > +    }
> > +
> >       switch (size) {
> >       case 1:
> >           buf.byte = data;
> > @@ -215,8 +226,6 @@ void vfio_region_write(void *opaque, hwaddr addr,
> >                        addr, data, size);
> >       }
> >   
> > -    trace_vfio_region_write(vbasedev->name, region->nr, addr, data, size);
> > -
> >       /*
> >        * A read or write to a BAR always signals an INTx EOI.  This will
> >        * do nothing if not pending (including not in INTx mode).  We assume
> > 
> 

