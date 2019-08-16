Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FB2C3A589
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 01:05:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C42BB206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 01:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C42BB206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyQgR-0006oK-0b
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 21:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <like.xu@linux.intel.com>) id 1hyQfM-0005vK-SS
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 21:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <like.xu@linux.intel.com>) id 1hyQfL-0000d7-AE
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 21:04:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:2311)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
 id 1hyQfL-0000aS-0p
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 21:04:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Aug 2019 18:04:20 -0700
X-IronPort-AV: E=Sophos;i="5.64,391,1559545200"; d="scan'208";a="182036144"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.239.196.83])
 ([10.239.196.83])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/AES256-SHA;
 15 Aug 2019 18:04:18 -0700
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20190815183803.13346-1-ehabkost@redhat.com>
 <20190815183803.13346-2-ehabkost@redhat.com>
From: Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <107f312a-15cd-da33-f0d6-5777bbb53150@linux.intel.com>
Date: Fri, 16 Aug 2019 09:04:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815183803.13346-2-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
Subject: Re: [Qemu-devel] [PATCH 1/3] pc: Fix error message on die-id
 validation
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
Cc: Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Peter Krempa <pkrempa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 2019/8/16 2:38, Eduardo Habkost wrote:
> The error message for die-id range validation is incorrect.  Example:
> 
>    $ qemu-system-x86_64 -smp 1,sockets=6,maxcpus=6 \
>      -device qemu64-x86_64-cpu,socket-id=1,die-id=1,core-id=0,thread-id=0
>    qemu-system-x86_64: -device qemu64-x86_64-cpu,socket-id=1,die-id=1,core-id=0,thread-id=0: \
>      Invalid CPU die-id: 1 must be in range 0:5
> 
> The actual range for die-id in this example is 0:0.

There is one die per socket by default.

The case sockets=6 means there are 6 dies by default
and the range for die-id is 0:5.

> 
> Fix the error message to use smp_dies and print the correct range.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>   hw/i386/pc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 549c437050..24b03bb49c 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2412,7 +2412,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>               return;
>           } else if (cpu->die_id > pcms->smp_dies - 1) {
>               error_setg(errp, "Invalid CPU die-id: %u must be in range 0:%u",
> -                       cpu->die_id, max_socket);
> +                       cpu->die_id, pcms->smp_dies - 1);
>               return;
>           }
>           if (cpu->core_id < 0) {
> 


