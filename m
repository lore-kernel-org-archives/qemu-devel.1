Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6F5C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 05:39:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A6D206D3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 05:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A6D206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieBlU-0004j5-DK
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 00:39:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1ieBkt-0004Jw-2X
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 00:38:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1ieBkq-0005zZ-Qf
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 00:38:46 -0500
Received: from mga11.intel.com ([192.55.52.93]:63958)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1ieBkq-0005xM-HJ
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 00:38:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Dec 2019 21:38:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,294,1571727600"; d="scan'208";a="387126860"
Received: from shzintpr01.sh.intel.com (HELO [0.0.0.0]) ([10.239.4.80])
 by orsmga005.jf.intel.com with ESMTP; 08 Dec 2019 21:38:39 -0800
Subject: Re: [PATCH] util/cutils: Expand do_strtosz parsing precision to 64
 bits
To: Markus Armbruster <armbru@redhat.com>
References: <20191205021459.29920-1-tao3.xu@intel.com>
 <87a786sse9.fsf@dusky.pond.sub.org>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <b7c442e3-cc7e-155e-5370-db9a371928a6@intel.com>
Date: Mon, 9 Dec 2019 13:38:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <87a786sse9.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 12/5/19 11:29 PM, Markus Armbruster wrote:
> Tao Xu <tao3.xu@intel.com> writes:
> 
>> Parse input string both as a double and as a uint64_t, then use the
>> method which consumes more characters. Update the related test cases.
>>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
> [...]
>> diff --git a/util/cutils.c b/util/cutils.c
>> index 77acadc70a..b08058c57c 100644
>> --- a/util/cutils.c
>> +++ b/util/cutils.c
>> @@ -212,24 +212,43 @@ static int do_strtosz(const char *nptr, const char **end,
>>                         const char default_suffix, int64_t unit,
>>                         uint64_t *result)
>>   {
>> -    int retval;
>> -    const char *endptr;
>> +    int retval, retd, retu;
>> +    const char *suffix, *suffixd, *suffixu;
>>       unsigned char c;
>>       int mul_required = 0;
>> -    double val, mul, integral, fraction;
>> +    bool use_strtod;
>> +    uint64_t valu;
>> +    double vald, mul, integral, fraction;
> 
> Note for later: @mul is double.
> 
>> +
>> +    retd = qemu_strtod_finite(nptr, &suffixd, &vald);
>> +    retu = qemu_strtou64(nptr, &suffixu, 0, &valu);
>> +    use_strtod = strlen(suffixd) < strlen(suffixu);
>> +
>> +    /*
>> +     * Parse @nptr both as a double and as a uint64_t, then use the method
>> +     * which consumes more characters.
>> +     */
> 
> The comment is in a funny place.  I'd put it right before the
> qemu_strtod_finite() line.
> 
>> +    if (use_strtod) {
>> +        suffix = suffixd;
>> +        retval = retd;
>> +    } else {
>> +        suffix = suffixu;
>> +        retval = retu;
>> +    }
>>   
>> -    retval = qemu_strtod_finite(nptr, &endptr, &val);
>>       if (retval) {
>>           goto out;
>>       }
> 
> This is even more subtle than it looks.
> 
> A close reading of the function contracts leads to three cases for each
> conversion:
> 
> * parse error (including infinity and NaN)
> 
>    @retu / @retd is -EINVAL
>    @valu / @vald is uninitialized
>    @suffixu / @suffixd is @nptr
> 
> * range error
> 
>    @retu / @retd is -ERANGE
>    @valu / @vald is our best approximation of the conversion result
>    @suffixu / @suffixd points to the first character not consumed by the
>    conversion.
> 
>    Sub-cases:
> 
>    - uint64_t overflow
> 
>      We know the conversion result exceeds UINT64_MAX.
> 
>    - double overflow
> 
>      we know the conversion result's magnitude exceeds the largest
>      representable finite double DBL_MAX.
> 
>    - double underflow
> 
>      we know the conversion result is close to zero (closer than DBL_MIN,
>      the smallest normalized positive double).
> 
> * success
> 
>    @retu / @retd is 0
>    @valu / @vald is the conversion result
>    @suffixu / @suffixd points to the first character not consumed by the
>    conversion.
> 
> This leads to a matrix (parse error, uint64_t overflow, success) x
> (parse error, double overflow, double underflow, success).  We need to
> check the code does what we want for each element of this matrix, and
> document any behavior that's not perfectly obvious.
> 
> (success, success): we pick uint64_t if qemu_strtou64() consumed more
> characters than qemu_strtod_finite(), else double.  "More" is important
> here; when they consume the same characters, we *need* to use the
> uint64_t result.  Example: for "18446744073709551615", we need to use
> uint64_t 18446744073709551615, not double 18446744073709551616.0.  But
> for "18446744073709551616.", we need to use the double.  Good.
> 
> (success, parse error) and (parse error, success): we pick the one that
> succeeds, because success consumes characters, and failure to parse does
> not.  Good.
> 
> (parse error, parse error): neither consumes characters, so we pick
> uint64_t.  Good.
> 
> (parse error, double overflow), (parse error, double underflow) and
> (uint64_t overflow, parse error): we pick the range error, because it
> consumes characters.  Good.
> 
> These are the simple combinations.  The remainder are hairier: (success,
> double overflow), (success, double underflow), (uint64_t overflow,
> success).  I lack the time to analyze them today.  Must be done before
> we take this patch.  Any takers?

(success, double overflow), (success, double underflow), pick double 
overflow error, return -ERANGE. Because it consumes characters. Example: 
for "1.79769e+309", qemu_strtou64 consumes "1", and prases as uint64_t; 
but qemu_strtod_finite return -ERANGE and consumes all characters. It is OK.

(uint64_t overflow, success), consume the same characters, use the
uint64_t return -ERANGE. Note that even if qemu_strtod_finite can parse 
these cases such as "18446744073709551617", but the result is uint64_t 
so we also need to return -ERANGE. It is OK.

Thank you for your analysis and suggestion. I will add more test cases 
to cover some of these analysis.
> 
>> -    fraction = modf(val, &integral);
>> -    if (fraction != 0) {
>> -        mul_required = 1;
>> +    if (use_strtod) {
>> +        fraction = modf(vald, &integral);
>> +        if (fraction != 0) {
>> +            mul_required = 1;
>> +        }
>>       }
> 
> Here, @suffix points to the suffix character, if any.
> 
>> -    c = *endptr;
>> +    c = *suffix;
>>       mul = suffix_mul(c, unit);
>>       if (mul >= 0) {
>> -        endptr++;
>> +        suffix++;
> 
> Now @suffix points to the first character not consumed, *not* the
> suffix.
> 
> Your patch effectively renames @endptr to @suffix.  I think @endptr is
> the better name.  Keeping the name also makes the diff smaller and
> slightly easier to review.
> 
>>       } else {
>>           mul = suffix_mul(default_suffix, unit);
> 
> suffix_mul() returns int64_t.  The assignment converts it to double.
> Fine before the patch, because @mul is the multiplier for a double
> value.  No longer true after the patch, see below.
> 
>>           assert(mul >= 0);
>> @@ -238,23 +257,36 @@ static int do_strtosz(const char *nptr, const char **end,
>>           retval = -EINVAL;
>>           goto out;
>>       }
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
> 
> Here, @mul is a multiplier for double vald.
> 
>> +    } else {
>> +        /* Reject negative input and overflow output */
>> +        while (qemu_isspace(*nptr)) {
>> +            nptr++;
>> +        }
>> +        if (*nptr == '-' || UINT64_MAX / (uint64_t) mul < valu) {
>> +            retval = -ERANGE;
>> +            goto out;
>> +        }
>> +        *result = valu * (uint64_t) mul;
> 
> Here, @mul is a multiplier for uint64_t valu.
> 
> Please change @mul to int64_t to reduce conversions.
> 
>>       }
>> -    *result = val * mul;
>>       retval = 0;
>>   
>>   out:
>>       if (end) {
>> -        *end = endptr;
>> -    } else if (*endptr) {
>> +        *end = suffix;
>> +    } else if (*suffix) {
>>           retval = -EINVAL;
>>       }
> 

