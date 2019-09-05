Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C02C3A59E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 00:58:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4128520828
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 00:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4128520828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5g6w-00037Z-Cv
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 20:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1i5g5W-0002SZ-GU
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 20:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1i5g5U-0000HH-Ao
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 20:57:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:4156)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>)
 id 1i5g5T-0000BE-Mn; Wed, 04 Sep 2019 20:57:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Sep 2019 17:57:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,468,1559545200"; d="scan'208";a="334392470"
Received: from unknown (HELO [10.239.196.169]) ([10.239.196.169])
 by orsmga004.jf.intel.com with ESMTP; 04 Sep 2019 17:57:17 -0700
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190805071302.6260-1-tao3.xu@intel.com>
 <20190903175258.GS3694@habkost.net>
 <428a67b2-4bf4-b9ab-b06e-f06bc12e721d@intel.com>
 <20190904204347.GC4617@habkost.net>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <46f87693-7d48-f5c1-d506-6dc177c88af7@intel.com>
Date: Thu, 5 Sep 2019 08:57:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904204347.GC4617@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
Subject: Re: [Qemu-devel] [PATCH] numa: Introduce
 MachineClass::auto_enable_numa for implicit NUMA node
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
Cc: "imammedo@redhat.com" <imammedo@redhat.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/5/2019 4:43 AM, Eduardo Habkost wrote:
> On Wed, Sep 04, 2019 at 02:22:39PM +0800, Tao Xu wrote:
>> On 9/4/2019 1:52 AM, Eduardo Habkost wrote:
>>> On Mon, Aug 05, 2019 at 03:13:02PM +0800, Tao Xu wrote:
>>>> Add MachineClass::auto_enable_numa field. When it is true, a NUMA node
>>>> is expected to be created implicitly.
>>>>
>>>> Acked-by: David Gibson <david@gibson.dropbear.id.au>
>>>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>>>> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
>>>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>>>
>>> This introduces spurious warnings when running qemu-system-ppc64.
>>> See: https://lore.kernel.org/qemu-devel/CAFEAcA-AvFS2cbDH-t5SxgY9hA=LGL81_8dn-vh193vtV9W1Lg@mail.gmail.com/
>>>
>>> To reproduce it, just run 'qemu-system-ppc64 -machine pseries'
>>> without any -numa arguments.
>>>
>>> I have removed this patch from machine-next so it won't block the
>>> existing pull request.
>>>
>> I got it. If default splitting of RAM between nodes is
>> deprecated, this patch can't reuse the splitting code. I agree with droping
>> this patch.
> 
> Probably all we need to fix this issue is to replace
>    NumaNodeOptions node = { };
> with
>    NumaNodeOptions node = { .size = ram_size };
> in the auto_enable_numa block.
> 
> Do you plan to send v2?
> 
OK, thank you for your suggestion. I will fix it and send v2.

