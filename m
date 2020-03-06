Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB52FC3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 02:49:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE1922072D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 02:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1922072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA337-0002OC-Uq
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 21:49:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jingqi.liu@intel.com>) id 1jA32Z-0001eP-JM
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 21:48:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jingqi.liu@intel.com>) id 1jA32X-0004d1-Kt
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 21:48:42 -0500
Received: from mga07.intel.com ([134.134.136.100]:5992)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
 id 1jA32X-0004ZF-CT
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 21:48:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Mar 2020 18:48:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; d="scan'208";a="259419046"
Received: from jingqili-mobl.ccr.corp.intel.com (HELO [10.254.209.228])
 ([10.254.209.228])
 by orsmga002.jf.intel.com with ESMTP; 05 Mar 2020 18:48:35 -0800
Subject: Re: [PATCH] util: fix to get configuration macros in util/mmap-alloc.c
To: =?UTF-8?Q?J=c3=a1n_Tomko?= <jtomko@redhat.com>
References: <20200305154142.63070-1-jingqi.liu@intel.com>
 <20200305161047.GB3627464@lpt>
From: "Liu, Jingqi" <jingqi.liu@intel.com>
Message-ID: <d90eec28-b90c-3eb1-066c-a48907e200ef@intel.com>
Date: Fri, 6 Mar 2020 10:48:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200305161047.GB3627464@lpt>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.100
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/6/2020 12:10 AM, Ján Tomko wrote:
> On a Thursday in 2020, Jingqi Liu wrote:
>> The CONFIG_LINUX symbol is always not defined in this file.
>> This fixes that "config-host.h" header file is not included
>> for getting macros.
>>
>> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
>> ---
>> util/mmap-alloc.c | 2 ++
>> 1 file changed, 2 insertions(+)
>>
>> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
>> index 27dcccd8ec..24c0e380f3 100644
>> --- a/util/mmap-alloc.c
>> +++ b/util/mmap-alloc.c
>> @@ -10,6 +10,8 @@
>>  * later.  See the COPYING file in the top-level directory.
>>  */
>>
>> +#include "config-host.h"
>> +
>
> According to CODING_STYLE.rst, qemu/osdep.h is the header file
> that should be included first, before all the other includes.
>
> So the minimal fix would be moving qemu/osdep.h up here.
>
Thanks for your review.

I've tried to simply move "qemu/osdep.h" to the first line.

It caused many macros redefinition errors.


>> #ifdef CONFIG_LINUX
>> #include <linux/mman.h>
>> #else  /* !CONFIG_LINUX */
>
>
> Introduced by commit 119906afa5ca610adb87c55ab0d8e53c9104bfc3

I've checked this commit.

Thanks,

Jingqi

>
> Jano
>
>> -- 
>> 2.17.1
>>
>>

