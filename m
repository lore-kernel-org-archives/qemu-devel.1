Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F469C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 10:11:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF602214AE
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 10:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF602214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhtHa-0004UM-8i
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 06:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58152)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hhtGq-00043A-Jo
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 06:10:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hhtGp-0004I4-GI
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 06:10:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38982)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hhtGp-0004HR-7u
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 06:10:47 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 20E0C59449;
 Mon,  1 Jul 2019 10:10:38 +0000 (UTC)
Received: from [10.36.116.89] (ovpn-116-89.ams2.redhat.com [10.36.116.89])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CAE531001E64;
 Mon,  1 Jul 2019 10:10:34 +0000 (UTC)
To: Yan Zhao <yan.y.zhao@intel.com>, pbonzini@redhat.com
References: <1561760389-31325-1-git-send-email-yan.y.zhao@intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <42713cac-27fb-f4a9-1b06-bfee409690a5@redhat.com>
Date: Mon, 1 Jul 2019 12:10:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1561760389-31325-1-git-send-email-yan.y.zhao@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 01 Jul 2019 10:10:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5] memory: do not notify for non inclusive
 overlap entry
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
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Yan,

On 6/29/19 12:19 AM, Yan Zhao wrote:
> if an entry has non inclusive overlap with the notifier, print warning
> message and do not do notification for it.
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
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> 
> ---
> v5:
> 1. still using warn_report instead of "assert"
> 2. returning at the end to refuse notification for entry which has non
> inclusive overlap with the notifier.
> 3. updated commit title and warning message.
> 
> v4:
> 1. modified commit title
> 2. using "assert" instead of printing warning message
> 
> v3:
> refined code style and message format
> 
> v2:
> 1. added a local variable entry_end (Eric Auger)
> 2. using PRIx64 as format for address range in warning message
> (Eric Auger)
> ---
>  memory.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/memory.c b/memory.c
> index 0a089a7..fe0d08d 100644
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
> @@ -1953,6 +1953,18 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
>          request_flags = IOMMU_NOTIFIER_UNMAP;
>      }
>  
> +    if (entry->iova < notifier->start || entry_end > notifier->end) {
> +        warn_report("IOMMUTLBEntry 0x%" PRIx64 " - 0x%" PRIx64
> +                " has non inclusive overlap with notifier 0x%" PRIx64
> +                " - 0x%" PRIx64 ". %s is not allowed."
> +                " Try to divide it into smaller sections.",
> +                entry->iova, entry_end,
> +                notifier->start, notifier->end,
> +                (request_flags == IOMMU_NOTIFIER_MAP) ?
> +                "Mapping" : "Unmapping");
> +        return;
> +    }
> +
>      if (notifier->notifier_flags & request_flags) {
>          notifier->notify(notifier, entry);
>      }
> 

