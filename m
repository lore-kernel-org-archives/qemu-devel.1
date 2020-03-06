Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028BFC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:31:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE0D2206D5
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE0D2206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAD4z-0007Jc-2g
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 08:31:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jingqi.liu@intel.com>) id 1jAD3a-0005uY-Ra
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:30:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jingqi.liu@intel.com>) id 1jAD3V-0000dD-3C
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:30:25 -0500
Received: from mga04.intel.com ([192.55.52.120]:3469)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
 id 1jAD3T-00007y-Tv
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:30:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Mar 2020 05:30:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,522,1574150400"; d="scan'208";a="275538972"
Received: from jingqili-mobl.ccr.corp.intel.com (HELO [10.254.209.228])
 ([10.254.209.228])
 by fmsmga002.fm.intel.com with ESMTP; 06 Mar 2020 05:30:04 -0800
Subject: Re: [PATCH] util: fix to check if target OS is linux in
 util/mmap-alloc.c
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200306120735.24457-1-jingqi.liu@intel.com>
 <CAFEAcA8jWa8y=uY1M3e9DjXhPE4MMMbdk2fgJbs8jzZvq=iGiw@mail.gmail.com>
From: "Liu, Jingqi" <jingqi.liu@intel.com>
Message-ID: <310ed2da-1f9e-f247-c827-d7cf66f9c826@intel.com>
Date: Fri, 6 Mar 2020 21:30:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8jWa8y=uY1M3e9DjXhPE4MMMbdk2fgJbs8jzZvq=iGiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?J=c3=a1n_Tomko?= <jtomko@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/6/2020 8:14 PM, Peter Maydell wrote:
> On Fri, 6 Mar 2020 at 12:12, Jingqi Liu <jingqi.liu@intel.com> wrote:
>> The CONFIG_LINUX symbol is always undefined before including "qemu/osdep.h".
>> Use __linux__ to check if target OS is linux instead of CONFIG_LINUX.
>>
>> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
>> ---
>>   util/mmap-alloc.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
>> index 27dcccd8ec..8340540292 100644
>> --- a/util/mmap-alloc.c
>> +++ b/util/mmap-alloc.c
>> @@ -10,12 +10,12 @@
>>    * later.  See the COPYING file in the top-level directory.
>>    */
>>
>> -#ifdef CONFIG_LINUX
>> +#ifdef __linux__
>>   #include <linux/mman.h>
>> -#else  /* !CONFIG_LINUX */
>> +#else
>>   #define MAP_SYNC              0x0
>>   #define MAP_SHARED_VALIDATE   0x0
>> -#endif /* CONFIG_LINUX */
>> +#endif
> This is not the right way to fix this. osdep.h must go
> first, no exceptions.

osdep.h pulls in sys/mman.h, which defines the MAP_* constants

except for MAP_SYNC and MAP_SHARED_VALIDATE.

I'm curious that this system header doesn't define them.

How about just adding the following code in util/mmap-alloc.c ?

#ifndef MAP_SYNC
#define MAP_SYNC 0x80000
#endif
#ifndef MAP_SYNC
#define MAP_SYNC 0x80000
#endif

#ifndef MAP_SHARED_VALIDATE
#define MAP_SHARED_VALIDATE 0x03
#endif

Thanks,

Jingqi

>
> thanks
> -- PMM

