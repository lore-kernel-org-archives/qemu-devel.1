Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60F4C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 02:30:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A8DF21582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 02:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8DF21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihP6g-00052y-PH
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 21:30:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46906)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1ihP5k-0004A3-Ba
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 21:29:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1ihP5h-0007ys-Q0
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 21:29:35 -0500
Received: from mga06.intel.com ([134.134.136.31]:26834)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1ihP5h-0007rp-H4
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 21:29:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Dec 2019 18:29:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,327,1571727600"; d="scan'208";a="240640272"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.238])
 ([10.239.196.238])
 by fmsmga004.fm.intel.com with ESMTP; 17 Dec 2019 18:29:28 -0800
Subject: Re: [PATCH] util/cutils: Expand do_strtosz parsing precision to 64
 bits
To: Markus Armbruster <armbru@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>
References: <20191205021459.29920-1-tao3.xu@intel.com>
 <87a786sse9.fsf@dusky.pond.sub.org>
 <64E0F779-B750-4766-9978-58A8B4737839@redhat.com>
 <87v9qfcae1.fsf@dusky.pond.sub.org>
 <50B6643C-78A7-4724-8A0B-3D51B1898FFE@redhat.com>
 <87o8w7ate6.fsf@dusky.pond.sub.org>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <0b0767cc-2f97-e1a1-f479-295e36877f89@intel.com>
Date: Wed, 18 Dec 2019 10:29:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <87o8w7ate6.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.31
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

On 12/17/2019 11:01 PM, Markus Armbruster wrote:
> Christophe de Dinechin <dinechin@redhat.com> writes:
> 
>>> On 17 Dec 2019, at 15:08, Markus Armbruster <armbru@redhat.com> wrote:
>>>
>>> Christophe de Dinechin <dinechin@redhat.com> writes:
>>>
>>>>> On 5 Dec 2019, at 16:29, Markus Armbruster <armbru@redhat.com> wrote:
>>>>>
>>>>> Tao Xu <tao3.xu@intel.com> writes:
>>>>>
>>>>>> Parse input string both as a double and as a uint64_t, then use the
>>>>>> method which consumes more characters. Update the related test cases.
>>>>>>
>>>>>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>>>>>> ---
>>>>> [...]
>>>>>> diff --git a/util/cutils.c b/util/cutils.c
>>>>>> index 77acadc70a..b08058c57c 100644
>>>>>> --- a/util/cutils.c
>>>>>> +++ b/util/cutils.c
>>>>>> @@ -212,24 +212,43 @@ static int do_strtosz(const char *nptr, const char **end,
>>>>>>                       const char default_suffix, int64_t unit,
>>>>>>                       uint64_t *result)
>>>>>> {
>>>>>> -    int retval;
>>>>>> -    const char *endptr;
>>>>>> +    int retval, retd, retu;
>>>>>> +    const char *suffix, *suffixd, *suffixu;
>>>>>>     unsigned char c;
>>>>>>     int mul_required = 0;
>>>>>> -    double val, mul, integral, fraction;
>>>>>> +    bool use_strtod;
>>>>>> +    uint64_t valu;
>>>>>> +    double vald, mul, integral, fraction;
>>>>>
>>>>> Note for later: @mul is double.
>>>>>
>>>>>> +
>>>>>> +    retd = qemu_strtod_finite(nptr, &suffixd, &vald);
>>>>>> +    retu = qemu_strtou64(nptr, &suffixu, 0, &valu);
>>>>>> +    use_strtod = strlen(suffixd) < strlen(suffixu);
>>>>>> +
>>>>>> +    /*
>>>>>> +     * Parse @nptr both as a double and as a uint64_t, then use the method
>>>>>> +     * which consumes more characters.
>>>>>> +     */
>>>>>
>>>>> The comment is in a funny place.  I'd put it right before the
>>>>> qemu_strtod_finite() line.
>>>>>
>>>>>> +    if (use_strtod) {
>>>>>> +        suffix = suffixd;
>>>>>> +        retval = retd;
>>>>>> +    } else {
>>>>>> +        suffix = suffixu;
>>>>>> +        retval = retu;
>>>>>> +    }
>>>>>>
>>>>>> -    retval = qemu_strtod_finite(nptr, &endptr, &val);
>>>>>>     if (retval) {
>>>>>>         goto out;
>>>>>>     }
>>>>>
>>>>> This is even more subtle than it looks.
>>>>
>>>> But why it is even necessary?
>>>>
>>>> The “contract” for the function used to be that it returned rounded values
>>>> beyond 2^53, which in itself is curious.
>>>>
>>>> But now it’s a 6-dimensional matrix of hell with NaNs and barfnots, when the
>>>> name implies it’s simply doing a text to u64 conversion…
>>>>
>>>> There is certainly a reason, but I’m really curious what it is :-)
>>>
>>> It all goes back to commit 9f9b17a4f0 "Introduce strtosz() library
>>> function to convert a string to a byte count.".  To support "convenient"
>>> usage like "1.5G", it parses the number part with strtod().  This limits
>>> us to 53 bits of precision.  Larger sizes get rounded.
>>>
>>> I guess the excuse for this was that when you're dealing with sizes that
>>> large (petabytes!), your least significant bits are zero anyway.
>>>
>>> Regardless, the interface is *awful*.  We should've forced the author to
>>> spell it out in all its glory in a proper function contract.  That tends
>>> to cool the enthusiasm for "convenient" syntax amazingly fast.
>>>
>>> The awful interface has been confusing people for close to a decade now.
>>>
>>> What to do?
>>
>> I see. Thanks for the rationale. I knew it had to make sense :-)
> 
> For a value of "sense"...
> 
>> I’d probably avoid strtod even with the convenient syntax above.
>> Do you want 1.33e-6M to be allowed? Do we want to ever
>> accept or generate NaN or Inf values?
> 
> NaN or Inf definitely not.  That's why we use qemu_strtod_finite()
> before and after the patch.
> 
> No sane person should ever use 1.33e-6M.  Or even 1.1k (which yields
> 1126, rounded silently from machine number 1126.4000000000001, which
> approximates the true value 1126.4).
> 
> Certain fractions are actually sane.  1.5k denotes a perfectly fine
> integer, which the code manages not to screw up.  I'd recommend against
> using fractions regardless.
> 
> What usage are we prepared to break?  What kind of confusion are we
> willing to bear?  Those are the questions.
> 
>>> Tao Xu's patch tries to make the function do what its users expect,
>>> namely parse a bleepin' 64 bit integer, without breaking any of the
>>> "convenience" syntax.  Turns out that's amazingly subtle.  Are we making
>>> things less confusing or more?
> 
Thanks for your explanation. I think another reason is build-in 'size' 
is really commonly used. May be someone use '-m 1.5G' to boot QEMU or 
write it to a config file.

