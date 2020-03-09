Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083B3C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 13:24:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D278520727
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 13:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D278520727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBIOd-0004lW-3b
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 09:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jingqi.liu@intel.com>) id 1jBIO4-0004LU-Lq
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:24:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jingqi.liu@intel.com>) id 1jBIO2-0008Uz-QM
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:24:03 -0400
Received: from mga03.intel.com ([134.134.136.65]:7711)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
 id 1jBIO2-0008Ry-IP
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:24:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Mar 2020 06:23:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,533,1574150400"; d="scan'208";a="245341927"
Received: from jingqili-mobl.ccr.corp.intel.com (HELO [10.254.215.94])
 ([10.254.215.94])
 by orsmga006.jf.intel.com with ESMTP; 09 Mar 2020 06:23:53 -0700
Subject: Re: [PATCH] util: fix to get configuration macros in util/mmap-alloc.c
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?J=c3=a1n_Tomko?=
 <jtomko@redhat.com>
References: <20200305154142.63070-1-jingqi.liu@intel.com>
 <20200305161047.GB3627464@lpt>
 <CAFEAcA-OQncMrU_-DJJ9g5rEcrJvbhTOjOVs0YqO3NS_Y413OQ@mail.gmail.com>
From: "Liu, Jingqi" <jingqi.liu@intel.com>
Message-ID: <f774652b-5145-1e47-62c4-99a69a037506@intel.com>
Date: Mon, 9 Mar 2020 21:23:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-OQncMrU_-DJJ9g5rEcrJvbhTOjOVs0YqO3NS_Y413OQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/6/2020 12:40 AM, Peter Maydell wrote:
> On Thu, 5 Mar 2020 at 16:11, Ján Tomko <jtomko@redhat.com> wrote:
>> On a Thursday in 2020, Jingqi Liu wrote:
>>> The CONFIG_LINUX symbol is always not defined in this file.
>>> This fixes that "config-host.h" header file is not included
>>> for getting macros.
>>>
>>> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
>>> ---
>>> util/mmap-alloc.c | 2 ++
>>> 1 file changed, 2 insertions(+)
>>>
>>> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
>>> index 27dcccd8ec..24c0e380f3 100644
>>> --- a/util/mmap-alloc.c
>>> +++ b/util/mmap-alloc.c
>>> @@ -10,6 +10,8 @@
>>>   * later.  See the COPYING file in the top-level directory.
>>>   */
>>>
>>> +#include "config-host.h"
>>> +
>> According to CODING_STYLE.rst, qemu/osdep.h is the header file
>> that should be included first, before all the other includes.
>>
>> So the minimal fix would be moving qemu/osdep.h up here.
> Yes, osdep must always be first.
>
>>> #ifdef CONFIG_LINUX
>>> #include <linux/mman.h>
>>> #else  /* !CONFIG_LINUX */
> Do we really need this? osdep.h will pull in sys/mman.h
> for you, which should define the MAP_* constants.
>
> Also, you have no fallbmack for "I'm on Linux but the
> system headers don't define MAP_SHARED_VALIDATE or
> MAP_SYNC". Wouldn't it be better to just have
> #ifndef MAP_SYNC
> #define MAP_SYNC 0
> #endif
>
> etc ?
osdep.h pulls in sys/mman.h, which defines the MAP_* constants

except for MAP_SYNC and MAP_SHARED_VALIDATE on Linux.

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

