Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0977AC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 07:44:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D19F22053B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 07:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19F22053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihqUJ-0004Qo-0s
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 02:44:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1ihqTh-0003uQ-N0
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 02:44:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1ihqTf-0005dk-8s
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 02:44:08 -0500
Received: from mga11.intel.com ([192.55.52.93]:5534)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1ihqTe-0005JL-PP
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 02:44:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Dec 2019 23:43:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; d="scan'208";a="218403261"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.238])
 ([10.239.196.238])
 by orsmga003.jf.intel.com with ESMTP; 18 Dec 2019 23:43:57 -0800
Subject: Re: [PATCH] util/cutils: Expand do_strtosz parsing precision to 64
 bits
To: Markus Armbruster <armbru@redhat.com>
References: <20191205021459.29920-1-tao3.xu@intel.com>
 <87a786sse9.fsf@dusky.pond.sub.org>
 <b7c442e3-cc7e-155e-5370-db9a371928a6@intel.com>
 <87y2vbgsf0.fsf@dusky.pond.sub.org>
 <e731445a-4461-3212-c08d-05dc7ad2b742@intel.com>
 <52a11f3a-f2c8-26e9-b823-0093cfe91fdc@intel.com>
 <87y2v9zdzv.fsf@dusky.pond.sub.org>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <d2e95d06-5328-dc48-30fa-a811a6371d4d@intel.com>
Date: Thu, 19 Dec 2019 15:43:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <87y2v9zdzv.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
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
Cc: "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/19/2019 2:26 AM, Markus Armbruster wrote:
> Tao Xu <tao3.xu@intel.com> writes:
> 
>> On 12/18/2019 9:33 AM, Tao Xu wrote:
>>> On 12/17/2019 6:25 PM, Markus Armbruster wrote:
> [...]
>>>> Also fun: for "0123", we use uint64_t 83, not double 123.0.  But for
>>>> "0123.", we use 123.0, not 83.
>>>>
>>>> Do we really want to accept octal and hexadecimal integers?
>>>>
>>>
>>> Thank you for reminding me. Octal and hexadecimal may bring more
>>> confusion. I will use qemu_strtou64(nptr, &suffixu, 10, &valu) and
>>> add test for input like "0123".
>>>
>>
>> Hi Markus,
>>
>> After I use qemu_strtou64(nptr, &suffixu, 10, &valu), it cause another
>> question. Because qemu_strtod_finite support hexadecimal input, so in
>> this situation, it will parsed as double. It will also let large
>> hexadecimal integers be rounded. So there may be two solution:
>>
>> 1: use qemu_strtou64(nptr, &suffixu, 0, &valu) and parse octal as
>> decimal. This will keep hexadecimal valid as now.
>>
>> "0123" --> 123; "0x123" --> 291
> 
> How would you make qemu_strtou64() parse octal as decimal?

How about this solution, set @base as variable, if we detect 
hexadecimal, we use 0, then can prase decimal as u64, else we use 10, 
then can prase octal as decimal, because 0 prefix will be ignored in 
qemu_strtou64(nptr, &suffixu, 10, &valu);

     const char *p = nptr;
     while (qemu_isspace(*p)) {
        p++;
     }
     if (*p == '0' && (qemu_toupper(*(p+1)) == 'X' ||) {
         base = 0;
     } else {
         base = 10;
     }

     retd = qemu_strtod_finite(nptr, &suffixd, &vald);
     retu = qemu_strtou64(nptr, &suffixu, base, &valu);
     use_strtod = strlen(suffixd) < strlen(suffixu);

     if (use_strtod) {
         endptr = suffixd;
         retval = retd;
     } else {
         endptr = suffixu;
         retval = retu;
     }
> 
>> 2: use qemu_strtou64(nptr, &suffixu, 10, &valu) and reject octal and
>> decimal.
>>
>> "0123" --> Error; "0x123" --> Error
> 
> How would you reject the 0x prefix?
> 
How about check the first&second character is '0' and 'x' and then 
return -EINVAL.

