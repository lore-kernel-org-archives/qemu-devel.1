Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DAFC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 07:37:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9488020B80
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 07:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9488020B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jp5PM-0006ZT-Qm
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 03:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@linux.intel.com>)
 id 1jp5OY-00068y-Jq
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 03:37:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:53041)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@linux.intel.com>)
 id 1jp5OU-00010Z-4e
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 03:37:02 -0400
IronPort-SDR: HCwgxxSKfcEyxweSCoNYkDk5QhynJvPyNrsWGVbuIPkV8cW6oovhOFQhmcPNVQQcp6MG3hMnAZ
 fIVIYMqpzmJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="143108764"
X-IronPort-AV: E=Sophos;i="5.75,286,1589266800"; d="scan'208";a="143108764"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2020 00:36:53 -0700
IronPort-SDR: qMs1dShKQZ1cXnOO/bX6zS/0jAh329FWqmoRLHoWx2uGZozZqh8ZmVEyZKD8EsvKI0HbT0ROtq
 w2HTnMy3vk7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,286,1589266800"; d="scan'208";a="480232312"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by fmsmga005.fm.intel.com with ESMTP; 27 Jun 2020 00:36:50 -0700
Date: Sat, 27 Jun 2020 03:26:45 -0400
From: Yan Zhao <yan.y.zhao@linux.intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [RFC v2 1/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
Message-ID: <20200627072644.GC18338@joy-OptiPlex-7040>
References: <20200626064122.9252-1-eperezma@redhat.com>
 <20200626064122.9252-2-eperezma@redhat.com>
 <20200626212917.GD175520@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200626212917.GD175520@xz-x1>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: none client-ip=192.55.52.120;
 envelope-from=yan.y.zhao@linux.intel.com; helo=mga04.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/27 03:36:54
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Reply-To: Yan Zhao <yan.y.zhao@linux.intel.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>,
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 26, 2020 at 05:29:17PM -0400, Peter Xu wrote:
> Hi, Eugenio,
> 
> (CCing Eric, Yan and Michael too)

> On Fri, Jun 26, 2020 at 08:41:22AM +0200, Eugenio Pérez wrote:
> > diff --git a/memory.c b/memory.c
> > index 2f15a4b250..7f789710d2 100644
> > --- a/memory.c
> > +++ b/memory.c
> > @@ -1915,8 +1915,6 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
> >          return;
> >      }
> >  
> > -    assert(entry->iova >= notifier->start && entry_end <= notifier->end);
> 
> I can understand removing the assertion should solve the issue, however imho
> the major issue is not about this single assertion but the whole addr_mask
> issue behind with virtio...
Yes, the background for this assertion is
https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg04218.html


> 
> For normal IOTLB invalidations, we were trying our best to always make
> IOMMUTLBEntry contain a valid addr_mask to be 2**N-1.  E.g., that's what we're
> doing with the loop in vtd_address_space_unmap().
> 
> But this is not the first time that we may want to break this assumption for
> virtio so that we make the IOTLB a tuple of (start, len), then that len can be
> not a address mask any more.  That seems to be more efficient for things like
> vhost because iotlbs there are not page based, so it'll be inefficient if we
> always guarantee the addr_mask because it'll be quite a lot more roundtrips of
> the same range of invalidation.  Here we've encountered another issue of
> triggering the assertion with virtio-net, but only with the old RHEL7 guest.
> 
> I'm thinking whether we can make the IOTLB invalidation configurable by
> specifying whether the backend of the notifier can handle arbitary address
> range in some way.  So we still have the guaranteed addr_masks by default
> (since I still don't think totally break the addr_mask restriction is wise...),
> however we can allow the special backends to take adavantage of using arbitary
> (start, len) ranges for reasons like performance.
> 
> To do that, a quick idea is to introduce a flag IOMMU_NOTIFIER_ARBITRARY_MASK
> to IOMMUNotifierFlag, to declare that the iommu notifier (and its backend) can
> take arbitrary address mask, then it can be any value and finally becomes a
> length rather than an addr_mask.  Then for every iommu notify() we can directly
> deliver whatever we've got from the upper layer to this notifier.  With the new
> flag, vhost can do iommu_notifier_init() with UNMAP|ARBITRARY_MASK so it
> declares this capability.  Then no matter for device iotlb or normal iotlb, we
> skip the complicated procedure to split a big range into small ranges that are
> with strict addr_mask, but directly deliver the message to the iommu notifier.
> E.g., we can skip the loop in vtd_address_space_unmap() if the notifier is with
> ARBITRARY flag set.
> 
> Then, the assert() is not accurate either, and may become something like:
> 
> diff --git a/memory.c b/memory.c
> index 2f15a4b250..99d0492509 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1906,6 +1906,7 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
>  {
>      IOMMUNotifierFlag request_flags;
>      hwaddr entry_end = entry->iova + entry->addr_mask;
> +    IOMMUTLBEntry tmp = *entry;
> 
>      /*
>       * Skip the notification if the notification does not overlap
> @@ -1915,7 +1916,13 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
>          return;
>      }
> 
> -    assert(entry->iova >= notifier->start && entry_end <= notifier->end);
> +    if (notifier->notifier_flags & IOMMU_NOTIFIER_ARBITRARY_MASK) {
> +        tmp.iova = MAX(tmp.iova, notifier->start);
> +        tmp.addr_mask = MIN(tmp.addr_mask, notifier->end);
NIT:
       tmp.addr_mask = MIN(entry_end, notifier->end) - tmp.iova;
> +        assert(tmp.iova <= tmp.addr_mask);
no this assertion then.

Thanks
Yan
       
> +    } else {
> +        assert(entry->iova >= notifier->start && entry_end <= notifier->end);
> +    }
> 
>      if (entry->perm & IOMMU_RW) {
>          request_flags = IOMMU_NOTIFIER_MAP;
> @@ -1924,7 +1931,7 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
>      }
> 
>      if (notifier->notifier_flags & request_flags) {
> -        notifier->notify(notifier, entry);
> +        notifier->notify(notifier, &tmp);
>      }
>  }
> 
> Then we can keep the assert() for e.g. vfio, however vhost can skip it and even
> get some further performance boosts..  Does that make sense?
> 
> Thanks,
> 
> -- 
> Peter Xu
> 
> 

