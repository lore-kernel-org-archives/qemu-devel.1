Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E40BC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 07:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A2AD2083D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 07:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2AD2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48416 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfJAj-0001u1-I7
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 03:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50449)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hfJ6w-0007Za-96
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 03:09:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hfJ6v-0008Qs-2z
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 03:09:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33990)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hfJ6u-00081M-S1
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 03:09:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 29C404ACDF;
 Mon, 24 Jun 2019 07:09:28 +0000 (UTC)
Received: from [10.36.116.89] (ovpn-116-89.ams2.redhat.com [10.36.116.89])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A5F860BF7;
 Mon, 24 Jun 2019 07:09:27 +0000 (UTC)
To: Yan Zhao <yan.y.zhao@intel.com>, pbonzini@redhat.com
References: <1561354383-21322-1-git-send-email-yan.y.zhao@intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ff6e9034-5e23-7a29-1377-1892036bfec2@redhat.com>
Date: Mon, 24 Jun 2019 09:09:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1561354383-21322-1-git-send-email-yan.y.zhao@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Mon, 24 Jun 2019 07:09:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] memory: warning on out of scope
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

On 6/24/19 7:33 AM, Yan Zhao wrote:
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
> ---
>  memory.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/memory.c b/memory.c
> index 0a089a7..18927f2 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1953,6 +1953,16 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
>          request_flags = IOMMU_NOTIFIER_UNMAP;
>      }
I think introducing a local variable for entry end would be worth now
>  
> +    if (entry->iova < notifier->start ||
> +            entry->iova + entry->addr_mask > notifier->end) {
> +        warn_report("%s IOMMUTLBEntry %lx-%lx outside of "
> +                "notifier scope %lx-%lx",
Also I think you should use PRIx64 instead.

Thanks

Eric
> +                (request_flags == IOMMU_NOTIFIER_MAP) ?
> +                "Mapping" : "Unmapping",
> +                entry->iova, entry->iova + entry->addr_mask,
> +                notifier->start, notifier->end);
> +    }
> +
>      if (notifier->notifier_flags & request_flags) {
>          notifier->notify(notifier, entry);
>      }
> 

