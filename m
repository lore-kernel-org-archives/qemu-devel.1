Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19823C3A589
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 00:55:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D98B521773
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 00:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D98B521773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzVx2-0007vw-Vc
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 20:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33167)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <like.xu@linux.intel.com>) id 1hzVwG-0007SE-MA
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 20:54:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <like.xu@linux.intel.com>) id 1hzVwF-0002Re-H4
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 20:54:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:36191)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
 id 1hzVwF-0001ks-6z
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 20:54:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Aug 2019 17:53:17 -0700
X-IronPort-AV: E=Sophos;i="5.64,402,1559545200"; d="scan'208";a="195423281"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.239.196.83])
 ([10.239.196.83])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/AES256-SHA;
 18 Aug 2019 17:53:16 -0700
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190815183803.13346-1-ehabkost@redhat.com>
 <20190815183803.13346-2-ehabkost@redhat.com>
 <107f312a-15cd-da33-f0d6-5777bbb53150@linux.intel.com>
 <20190816134946.GZ3908@habkost.net>
From: Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <ff46bbe4-7581-a77b-251a-32418f488e1d@linux.intel.com>
Date: Mon, 19 Aug 2019 08:53:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816134946.GZ3908@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
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
Cc: Peter Krempa <pkrempa@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019/8/16 21:49, Eduardo Habkost wrote:
> On Fri, Aug 16, 2019 at 09:04:16AM +0800, Like Xu wrote:
>> Hi,
>>
>> On 2019/8/16 2:38, Eduardo Habkost wrote:
>>> The error message for die-id range validation is incorrect.  Example:
>>>
>>>     $ qemu-system-x86_64 -smp 1,sockets=6,maxcpus=6 \
>>>       -device qemu64-x86_64-cpu,socket-id=1,die-id=1,core-id=0,thread-id=0
>>>     qemu-system-x86_64: -device qemu64-x86_64-cpu,socket-id=1,die-id=1,core-id=0,thread-id=0: \
>>>       Invalid CPU die-id: 1 must be in range 0:5
>>>
>>> The actual range for die-id in this example is 0:0.
>>
>> There is one die per socket by default.
>>
>> The case sockets=6 means there are 6 dies by default
>> and the range for die-id is 0:5.
>>
> 
> I don't understand why you say that.  die-id supposed to identify
> a die inside a socket.  The code below is already checking for
> (cpu->die_id > pcms->smp_dies - 1) because of that.
> 

You're right about this.
Sorry to make a mess to support die topology.

> 
>>>
>>> Fix the error message to use smp_dies and print the correct range.
>>>
>>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>>> ---
>>>    hw/i386/pc.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>> index 549c437050..24b03bb49c 100644
>>> --- a/hw/i386/pc.c
>>> +++ b/hw/i386/pc.c
>>> @@ -2412,7 +2412,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>>                return;
>>>            } else if (cpu->die_id > pcms->smp_dies - 1) {
>>>                error_setg(errp, "Invalid CPU die-id: %u must be in range 0:%u",
>>> -                       cpu->die_id, max_socket);
>>> +                       cpu->die_id, pcms->smp_dies - 1);
>>>                return;
>>>            }
>>>            if (cpu->core_id < 0) {
>>>
>>
> 


