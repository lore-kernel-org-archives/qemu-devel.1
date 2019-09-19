Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE04C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:58:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9518021924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9518021924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAv4k-0005qk-Q1
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 07:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iAuy7-00055K-QZ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:51:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iAusc-0005Yh-G7
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:45:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51580)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iAusb-0005Xm-9s; Thu, 19 Sep 2019 07:45:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C5946302C08E;
 Thu, 19 Sep 2019 11:45:43 +0000 (UTC)
Received: from [10.36.117.220] (ovpn-117-220.ams2.redhat.com [10.36.117.220])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 32A935C1B5;
 Thu, 19 Sep 2019 11:45:34 +0000 (UTC)
To: Peter Xu <peterx@redhat.com>
References: <20190913083615.14719-1-eric.auger@redhat.com>
 <20190913083615.14719-2-eric.auger@redhat.com> <20190916032326.GC14232@xz-x1>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <b7422cc9-f5d0-43bc-0f2e-2472f0243460@redhat.com>
Date: Thu, 19 Sep 2019 13:45:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190916032326.GC14232@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 19 Sep 2019 11:45:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 1/6] memory: allow
 memory_region_register_iommu_notifier() to fail
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
Cc: peter.maydell@linaro.org, mst@redhat.com, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, qemu-arm@nongnu.org, pbonzini@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 9/16/19 5:23 AM, Peter Xu wrote:
> On Fri, Sep 13, 2019 at 10:36:10AM +0200, Eric Auger wrote:
>> Currently, when a notifier is attempted to be registered and its
>> flags are not supported (especially the MAP one) by the IOMMU MR,
>> we generally abruptly exit in the IOMMU code. The failure could be
>> handled more nicely in the caller and especially in the VFIO code.
>>
>> So let's allow memory_region_register_iommu_notifier() to fail as
>> well as notify_flag_changed() callback.
>>
>> All sites implementing the callback are updated. This patch does
>> not yet remove the exit(1) in the intel_iommu and amd_iommu code.
> 
> The idea looks sane to me, though how about using "Error **" instead
> of returning int (or, both)?  Just like the majority of rest of QEMU.
None of the memory_region_register_iommu_notifier callsites would really
use the Error object and pass it up. I am a bit reluctant to add it if
not really used. There are still plenty of functions in the memory API
that do not use any Error handle. Anyway I will follow recommendations
if there is a consensus.

Thanks

Eric
> 
> Regards,
> 

