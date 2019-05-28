Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B629C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 04:49:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42C832070D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 04:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42C832070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57121 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVU3P-00019N-7A
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 00:49:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hVU2W-0000in-PK
	for qemu-devel@nongnu.org; Tue, 28 May 2019 00:48:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hVU2V-0001vM-Mx
	for qemu-devel@nongnu.org; Tue, 28 May 2019 00:48:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>)
	id 1hVU2S-0001tE-FD; Tue, 28 May 2019 00:48:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1E0C63082163;
	Tue, 28 May 2019 04:48:39 +0000 (UTC)
Received: from xz-x1 (dhcp-15-205.nay.redhat.com [10.66.15.205])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EE9617A4E4;
	Tue, 28 May 2019 04:48:27 +0000 (UTC)
Date: Tue, 28 May 2019 12:48:25 +0800
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Message-ID: <20190528044825.GB23180@xz-x1>
References: <20190527114203.2762-1-eric.auger@redhat.com>
	<20190527114203.2762-10-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190527114203.2762-10-eric.auger@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Tue, 28 May 2019 04:48:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC v4 09/27] memory: Prepare for different kinds
 of IOMMU MR notifiers
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, drjones@redhat.com, yi.l.liu@intel.com,
	mst@redhat.com, jean-philippe.brucker@arm.com,
	zhangfei.gao@foxmail.com, qemu-devel@nongnu.org,
	alex.williamson@redhat.com, qemu-arm@nongnu.org,
	vincent.stehle@arm.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 27, 2019 at 01:41:45PM +0200, Eric Auger wrote:

[...]

> @@ -3368,8 +3368,9 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>  {
>      IOMMUTLBEntry entry;
>      hwaddr size;
> -    hwaddr start = n->start;
> -    hwaddr end = n->end;
> +

(extra new line)

> +    hwaddr start = n->iotlb_notifier.start;
> +    hwaddr end = n->iotlb_notifier.end;
>      IntelIOMMUState *s = as->iommu_state;
>      DMAMap map;

[...]

>  typedef void (*IOMMUNotify)(struct IOMMUNotifier *notifier,
>                              IOMMUTLBEntry *data);
>  
> -struct IOMMUNotifier {
> +typedef struct IOMMUIOLTBNotifier {
>      IOMMUNotify notify;

Hi, Eric,

I wasn't following the thread much before so sorry to ask this if too
late - have you thought about using the Notifier struct direct?
Because then it'll (1) allow the user to register with both IOTLB |
CONFIG flags in the same notifier while currently we'll need to
register one for each (and this worries me a bit on when we grow the
types of flags further then one register can have quite a few
notifiers) (2) the notifier part can be shared by different events.
Then when notify the (void *) data can be an union:

struct IOMMUEvent {
  int event; // can be one of the notifier flags
  union {
    struct IOTLBEvent {
      ...
    };
    struct PASIDEvent {
      ...
    };
  }
}

Then the handler hook would be simple too:

handler (data)
{
  switch (data.event) {
    ...
  }
}

I would be fine with current patch if this series is close to be
merged because even if we want that we can do that on top when we
introduce even more notifiers, but just to ask loud first.

> -    IOMMUNotifierFlag notifier_flags;
>      /* Notify for address space range start <= addr <= end */
>      hwaddr start;
>      hwaddr end;
> +} IOMMUIOLTBNotifier;
> +
> +struct IOMMUNotifier {
> +    IOMMUNotifierFlag notifier_flags;
> +    union {
> +        IOMMUIOLTBNotifier iotlb_notifier;
> +    };
>      int iommu_idx;
>      QLIST_ENTRY(IOMMUNotifier) node;
>  };
> @@ -126,15 +132,18 @@ typedef struct IOMMUNotifier IOMMUNotifier;
>  /* RAM is a persistent kind memory */
>  #define RAM_PMEM (1 << 5)
>  
> -static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
> -                                       IOMMUNotifierFlag flags,
> -                                       hwaddr start, hwaddr end,
> -                                       int iommu_idx)
> +static inline void iommu_iotlb_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
> +                                             IOMMUNotifierFlag flags,
> +                                             hwaddr start, hwaddr end,
> +                                             int iommu_idx)
>  {
> -    n->notify = fn;
> +    assert(flags & IOMMU_NOTIFIER_IOTLB_MAP ||
> +           flags & IOMMU_NOTIFIER_IOTLB_UNMAP);

Can use IOMMU_NOTIFIER_IOTLB_ALL directly?

> +    assert(start < end);
>      n->notifier_flags = flags;
> -    n->start = start;
> -    n->end = end;
> +    n->iotlb_notifier.notify = fn;
> +    n->iotlb_notifier.start = start;
> +    n->iotlb_notifier.end = end;
>      n->iommu_idx = iommu_idx;
>  }

Otherwise the patch looks good to me.

Regards,

-- 
Peter Xu

