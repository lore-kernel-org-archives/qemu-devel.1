Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E87DC4646B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 10:12:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F2F205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 10:12:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F2F205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49428 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfLxq-0006NM-Fw
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 06:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39016)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hfLwk-0005Jt-DC
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 06:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hfLwa-0007vL-J6
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 06:11:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46458)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hfLwS-0007fd-Aj
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 06:11:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D233785550;
 Mon, 24 Jun 2019 10:11:13 +0000 (UTC)
Received: from [10.36.116.89] (ovpn-116-89.ams2.redhat.com [10.36.116.89])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E93DA5D717;
 Mon, 24 Jun 2019 10:11:12 +0000 (UTC)
To: Yan Zhao <yan.y.zhao@intel.com>, pbonzini@redhat.com
References: <1561364781-6897-1-git-send-email-yan.y.zhao@intel.com>
 <1561365559-10235-1-git-send-email-yan.y.zhao@intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <bcdc42ec-e60c-5048-da04-8122032f4a09@redhat.com>
Date: Mon, 24 Jun 2019 12:11:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1561365559-10235-1-git-send-email-yan.y.zhao@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Mon, 24 Jun 2019 10:11:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3] memory: warning on out of scope
 notification
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

Hi Yan,

On 6/24/19 10:39 AM, Yan Zhao wrote:
> if an entry has parts out of scope of notifier's range, print warning
> message.
> 
> Out of scope mapping/unmapping would cause problem, as in below case:
> 
> 1. initially there are two notifiers with ranges
> 0-0xfedfffff, 0xfef00000-0xffffffffffffffff,
> IOVAs from 0x3c000000 - 0x3c1fffff is in shadow page table.
> 
> 2. in vfio, memory_region_register_iommu_notifier() is followed by
> memory_region_iommu_replay(), which will first call address space
> unmap,
> and walk and add back all entries in vtd shadow page table. e.g.
> (1) for notifier 0-0xfedfffff,
>     IOVAs from 0 - 0xffffffff get unmapped,
>     and IOVAs from 0x3c000000 - 0x3c1fffff get mapped
> (2) for notifier 0xfef00000-0xffffffffffffffff
>     IOVAs from 0 - 0x7fffffffff get unmapped,
>     but IOVAs from 0x3c000000 - 0x3c1fffff cannot get mapped back.
> 
> Cc: Auger Eric <eric.auger@redhat.com>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> 
> ---
> v3:
> refined code style and message format
> 
> v2:
> 1. added a local variable entry_end (Auger Eric)
> 2. using PRIx64 as format for address range in warning message
> (Auger Eric)
> ---
>  memory.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/memory.c b/memory.c
> index 0a089a7..c7154ab 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1937,13 +1937,13 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
>                                IOMMUTLBEntry *entry)
>  {
>      IOMMUNotifierFlag request_flags;
> +    hwaddr entry_end = entry->iova + entry->addr_mask;
>  
>      /*
>       * Skip the notification if the notification does not overlap
>       * with registered range.
>       */
> -    if (notifier->start > entry->iova + entry->addr_mask ||
> -        notifier->end < entry->iova) {
> +    if (notifier->start > entry_end || notifier->end < entry->iova) {
>          return;
>      }
>  
> @@ -1953,6 +1953,15 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
>          request_flags = IOMMU_NOTIFIER_UNMAP;
>      }
>  
> +    if (entry->iova < notifier->start || entry_end > notifier->end) {
> +        warn_report("%s IOMMUTLBEntry 0x%" PRIx64 " - 0x%" PRIx64
> +                " outside of notifier scope 0x%" PRIx64 " - 0x%" PRIx64,
> +                (request_flags == IOMMU_NOTIFIER_MAP) ?
> +                "Mapping" : "Unmapping",
> +                entry->iova, entry->iova + entry->addr_mask,
entry_end as well.

Then shouldn't we assert in that case?

Thanks

Eric
> +                notifier->start, notifier->end);
> +    }
> +
>      if (notifier->notifier_flags & request_flags) {
>          notifier->notify(notifier, entry);
>      }
> 

