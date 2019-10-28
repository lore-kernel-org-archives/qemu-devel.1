Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1FCCA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:26:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D292220650
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D292220650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOzQK-0004e7-AT
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 03:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iOzPY-0004EU-0z
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iOzPW-000649-A3
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:25:55 -0400
Received: from mga14.intel.com ([192.55.52.115]:35192)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iOzPW-00061b-14
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:25:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Oct 2019 00:25:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,239,1569308400"; d="scan'208";a="400729502"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.179])
 ([10.239.196.179])
 by fmsmga006.fm.intel.com with ESMTP; 28 Oct 2019 00:25:48 -0700
Subject: Re: [PATCH v13 06/12] numa: Extend CLI to provide memory latency and
 bandwidth information
To: Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <20191020111125.27659-1-tao3.xu@intel.com>
 <20191020111125.27659-7-tao3.xu@intel.com>
 <20191023172854.42c495d5@redhat.com>
 <9e30d8fe-7274-4ee8-3c4b-64c370141358@intel.com>
 <20191025152720.4068bfae@redhat.com> <87wocsobil.fsf@dusky.pond.sub.org>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <520bca1d-e585-3619-d43f-7359fb37c1cc@intel.com>
Date: Mon, 28 Oct 2019 15:25:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87wocsobil.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
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
Cc: "Liu, Jingqi" <jingqi.liu@intel.com>, "Du, Fan" <fan.du@intel.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/26/2019 3:44 AM, Markus Armbruster wrote:
> Igor Mammedov <imammedo@redhat.com> writes:
> 
[...]
>>>>    1st: above is applicable to both bw and lat values and should be documented as such
>>>>    2nd: 'max NUM is 65534' when different suffixes is fleeting target,
>>>>         spec says that entry with 0xFFFF is unreachable, so how about documenting
>>>>         unreachable value as 0xFFFFFFFFFFFFFFFF (then CLI parsing code will
>>>>         exclude it from range detection and acpi table building code translate it
>>>>         to internal 0xFFFF it could fit into the tables)
>>>>    
>>>
>>> If we input 0xFFFFFFFFFFFFFFFF, qemu will raise error that parameter
>>> expect a size value.
>>
>> opts_type_size() can't handle values >= 0xfffffffffffffc00
>>
>> commit f46bfdbfc8f (util/cutils: Change qemu_strtosz*() from int64_t to uint64_t)
>>
>> so behavior would change depending on if the value is parsed by CLI (size) or QMP (unit64) parsers.
> 
> Do these values matter?  Is there a use case for passing
> 18446744073709550593 via CLI?
> 

There is a case that we need to input 0xFFFF as ACPI HMAT entry (an 
unreachable case). But I am thinking drop this case because Linux kernel 
HMAT as blow:

          /*
          * Check for invalid and overflow values
          */
         if (entry == 0xffff || !entry)
                 return 0;
         else if (base > (UINT_MAX / (entry)))
                 return 0;

So 0xFFFF and 0 are the same.

>> we can cannibalize 0x0 as the unreachable value and an absent bandwidth/lat option
>> for not specified case.
>> It would be conflicting with matrix [1] values in spec, but CLI/QMP deals with
>> absolute values which are later processed into HMAT substructure.
>>
>> Markus,
>> Can we make opts_type_size() handle full range of uint64_t?
> 
> Maybe.
> 



