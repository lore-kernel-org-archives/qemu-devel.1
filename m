Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60A2C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 01:41:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C86721835
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 01:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C86721835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihOLM-0001BR-Lo
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 20:41:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1ihOKi-0000n5-LY
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 20:41:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1ihOKf-0000Lo-Mn
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 20:40:58 -0500
Received: from mga12.intel.com ([192.55.52.136]:23399)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1ihOKf-0000FR-Dr
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 20:40:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Dec 2019 17:40:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,327,1571727600"; d="scan'208";a="240629413"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.238])
 ([10.239.196.238])
 by fmsmga004.fm.intel.com with ESMTP; 17 Dec 2019 17:40:51 -0800
Subject: Re: [PATCH RESEND v2] util/cutils: Expand do_strtosz parsing
 precision to 64 bits
To: Christophe de Dinechin <dinechin@redhat.com>
References: <20191209083053.16402-1-tao3.xu@intel.com>
 <E002371E-11D7-4482-9213-DF2C8F12FC4B@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <0ceebef1-de21-a2e9-6d38-2f51350dcd67@intel.com>
Date: Wed, 18 Dec 2019 09:40:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <E002371E-11D7-4482-9213-DF2C8F12FC4B@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
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
 Markus Armbruster <armbru@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/17/2019 7:44 PM, Christophe de Dinechin wrote:
> 
> 
>> On 9 Dec 2019, at 09:30, Tao Xu <tao3.xu@intel.com> wrote:
>>
>> Parse input string both as a double and as a uint64_t, then use the
>> method which consumes more characters. Update the related test cases.
>>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
>>
>> Changes in v2:
>>     - Resend to use double small than DBL_MIN
>>     - Add more test case for double overflow and underflow.
>>     - Set mul as int64_t (Markus)
>>     - Restore endptr (Markus)
>> ---
>> tests/test-cutils.c    | 37 +++++++----------------
>> tests/test-keyval.c    | 47 +++++------------------------
>> tests/test-qemu-opts.c | 39 +++++-------------------
>> util/cutils.c          | 67 +++++++++++++++++++++++++++++++-----------
>> 4 files changed, 75 insertions(+), 115 deletions(-)
>>
[...]
>> +    /*
>> +     * Parse @nptr both as a double and as a uint64_t, then use the method
>> +     * which consumes more characters.
>> +     */
> 
> Why do ever need to parse as double if you have uint64?
> 

Because we want to keep do_strtosz Compatible with double input (such as 
1.5k).
>> +    retd = qemu_strtod_finite(nptr, &suffixd, &vald);
>> +    retu = qemu_strtou64(nptr, &suffixu, 0, &valu);
>> +    use_strtod = strlen(suffixd) < strlen(suffixu);
> 
> You could simply compare suffixd and suffixu:
> 
> use_strtod = suffixd > suffixu;
> 

Thank you for your suggestion.
>> +
>> +    if (use_strtod) {
>> +        endptr = suffixd;
>> +        retval = retd;
>> +    } else {
>> +        endptr = suffixu;
>> +        retval = retu;
>> +    }
>>
>> -    retval = qemu_strtod_finite(nptr, &endptr, &val);
>>      if (retval) {
>>          goto out;
>>      }
>> -    fraction = modf(val, &integral);
>> -    if (fraction != 0) {
>> -        mul_required = 1;
>> +    if (use_strtod) {
>> +        fraction = modf(vald, &integral);
>> +        if (fraction != 0) {
>> +            mul_required = 1;
>> +        }
>>      }
>>      c = *endptr;
>>      mul = suffix_mul(c, unit);
>> @@ -238,17 +258,30 @@ static int do_strtosz(const char *nptr, const char **end,
>>          retval = -EINVAL;
>>          goto out;
>>      }
>> -    /*
>> -     * Values near UINT64_MAX overflow to 2**64 when converting to double
>> -     * precision.  Compare against the maximum representable double precision
>> -     * value below 2**64, computed as "the next value after 2**64 (0x1p64) in
>> -     * the direction of 0".
>> -     */
>> -    if ((val * mul > nextafter(0x1p64, 0)) || val < 0) {
>> -        retval = -ERANGE;
>> -        goto out;
>> +
>> +    if (use_strtod) {
>> +        /*
>> +         * Values near UINT64_MAX overflow to 2**64 when converting to double
>> +         * precision. Compare against the maximum representable double precision
>> +         * value below 2**64, computed as "the next value after 2**64 (0x1p64)
>> +         * in the direction of 0".
>> +         */
>> +        if ((vald * mul > nextafter(0x1p64, 0)) || vald < 0) {
>> +            retval = -ERANGE;
>> +            goto out;
>> +        }
>> +        *result = vald * mul;
>> +    } else {
>> +        /* Reject negative input and overflow output */
>> +        while (qemu_isspace(*nptr)) {
>> +            nptr++;
>> +        }
>> +        if (*nptr == '-' || UINT64_MAX / mul < valu) {
>> +            retval = -ERANGE;
>> +            goto out;
>> +        }
>> +        *result = valu * mul;
>>      }
>> -    *result = val * mul;
>>      retval = 0;
>>
>> out:
>> -- 
>> 2.20.1
>>
>>
> 


