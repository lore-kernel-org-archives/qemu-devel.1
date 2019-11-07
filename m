Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531D4FA372C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 01:40:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FA1F217F5
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 01:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA1F217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSWmj-0004sy-24
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 20:40:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iSWky-0003lw-1F
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 20:38:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iSWkv-0002NE-E5
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 20:38:39 -0500
Received: from mga03.intel.com ([134.134.136.65]:27083)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iSWkv-0002Mh-4x
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 20:38:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Nov 2019 17:38:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,276,1569308400"; d="scan'208";a="206015622"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.161])
 ([10.239.196.161])
 by orsmga006.jf.intel.com with ESMTP; 06 Nov 2019 17:38:30 -0800
Subject: Re: [PATCH v14 01/11] util/cutils: Add qemu_strtotime_ns()
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20191028075220.25673-1-tao3.xu@intel.com>
 <20191028075220.25673-2-tao3.xu@intel.com>
 <20191106195645.GQ3812@habkost.net>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <abc99a22-5784-4287-f114-a8339a6b81ee@intel.com>
Date: Thu, 7 Nov 2019 09:38:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191106195645.GQ3812@habkost.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Liu,
 Jingqi" <jingqi.liu@intel.com>, "Du, Fan" <fan.du@intel.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/7/2019 3:56 AM, Eduardo Habkost wrote:
> On Mon, Oct 28, 2019 at 03:52:10PM +0800, Tao Xu wrote:
>> To convert strings with time suffixes to numbers, support time unit are
>> "ns" for nanosecond, "us" for microsecond, "ms" for millisecond or "s"
>> for second. Add test for qemu_strtotime_ns, test the input of basic,
>> time suffixes, float, invaild, trailing and overflow.
>>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
>>
>> Changes in v14:
>>      - Reuse the codes of do_strtosz to build qemu_strtotime_ns
>>        (Eduardo)
>>      - Squash patch v13 01/12 and 02/12 together (Daniel and Eduardo)
>>      - Drop time unit picosecond (Eric)
> 
> Suggestion for the next version: if you are refactoring existing
> do_strtosz() code, please refactor it in one patch, and add new
> functionality in another patch.
> 
Thank you for your suggestions and comments blew. I will improve in next 
version.

>> ---
>>   include/qemu/cutils.h |   1 +
>>   tests/test-cutils.c   | 204 ++++++++++++++++++++++++++++++++++++++++++
>>   util/cutils.c         |  89 +++++++++++-------
>>   3 files changed, 262 insertions(+), 32 deletions(-)
>>
>> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
>> index b54c847e0f..ff2b3f4614 100644
>> --- a/include/qemu/cutils.h
>> +++ b/include/qemu/cutils.h
>> @@ -182,5 +182,6 @@ int uleb128_decode_small(const uint8_t *in, uint32_t *n);
>>    * *str1 is <, == or > than *str2.
>>    */
>>   int qemu_pstrcmp0(const char **str1, const char **str2);
>> +int qemu_strtotime_ns(const char *nptr, const char **end, uint64_t *result);
>>   
>>   #endif
>> diff --git a/tests/test-cutils.c b/tests/test-cutils.c
>> index 1aa8351520..d6a0824efd 100644
>> --- a/tests/test-cutils.c
>> +++ b/tests/test-cutils.c
> [...]
>> +static void test_qemu_strtotime_ns_trailing(void)
>> +{
>> +    const char *str;
>> +    const char *endptr;
>> +    int err;
>> +    uint64_t res = 0xbaadf00d;
>> +
>> +    str = "123xxx";
>> +
>> +    err = qemu_strtotime_ns(str, NULL, &res);
>> +    g_assert_cmpint(err, ==, -EINVAL);
>> +
>> +    str = "1msxxx";
>> +    err = qemu_strtotime_ns(str, &endptr, &res);
>> +    g_assert_cmpint(err, ==, 0);
>> +    g_assert_cmpint(res, ==, 1000000);
>> +    g_assert(endptr == str + 3);
>> +
>> +    err = qemu_strtotime_ns(str, NULL, &res);
>> +    g_assert_cmpint(err, ==, -EINVAL);
>> +}
> 
> This is better than the test case in v13, where trailing strings
> were not handled consistently.  Good.
> 
> [...]
>> diff --git a/util/cutils.c b/util/cutils.c
>> index fd591cadf0..d83825f8b4 100644
>> --- a/util/cutils.c
>> +++ b/util/cutils.c
>> @@ -181,41 +181,38 @@ int fcntl_setfl(int fd, int flag)
>>   }
>>   #endif
>>   
>> -static int64_t suffix_mul(char suffix, int64_t unit)
>> -{
>> -    switch (qemu_toupper(suffix)) {
>> -    case 'B':
>> -        return 1;
>> -    case 'K':
>> -        return unit;
>> -    case 'M':
>> -        return unit * unit;
>> -    case 'G':
>> -        return unit * unit * unit;
>> -    case 'T':
>> -        return unit * unit * unit * unit;
>> -    case 'P':
>> -        return unit * unit * unit * unit * unit;
>> -    case 'E':
>> -        return unit * unit * unit * unit * unit * unit;
>> +static int64_t suffix_mul(const char *suffixes[], int num_suffix,
>> +                          const char *endptr, int *offset, int64_t unit)
>> +{
>> +    int i, suffix_len;
>> +    int64_t mul = 1;
>> +
>> +    for (i = 0; i < num_suffix; i++) {
>> +        suffix_len = strlen(suffixes[i]);
>> +        if (strlen(endptr) >= suffix_len &&
> 
> Is the strlen(endptr) check here really necessary?
> 
> 
>> +            g_ascii_strncasecmp(suffixes[i], endptr, suffix_len) == 0) {
>> +            *offset = suffix_len;
>> +            return mul;
>> +        }
>> +        mul *= unit;
>>       }
>> +
>>       return -1;
>>   }
>>   
>>   /*
>> - * Convert string to bytes, allowing either B/b for bytes, K/k for KB,
>> - * M/m for MB, G/g for GB or T/t for TB. End pointer will be returned
>> - * in *end, if not NULL. Return -ERANGE on overflow, and -EINVAL on
>> - * other error.
>> + * Convert string according to different suffixes. End pointer will be returned
>> + * in *end, if not NULL. Return -ERANGE on overflow, and -EINVAL on other error.
>>    */
>> -static int do_strtosz(const char *nptr, const char **end,
>> -                      const char default_suffix, int64_t unit,
>> -                      uint64_t *result)
>> +static int do_strtomul(const char *nptr, const char **end,
>> +                       const char *suffixes[], int num_suffix,
>> +                       const char *default_suffix, int64_t unit,
>> +                       uint64_t *result)
>>   {
>>       int retval;
>>       const char *endptr;
>> -    unsigned char c;
>>       int mul_required = 0;
>> +    int offset = 0;
>>       double val, mul, integral, fraction;
>>   
>>       retval = qemu_strtod_finite(nptr, &endptr, &val);
>> @@ -226,12 +223,12 @@ static int do_strtosz(const char *nptr, const char **end,
>>       if (fraction != 0) {
>>           mul_required = 1;
>>       }
>> -    c = *endptr;
>> -    mul = suffix_mul(c, unit);
>> +
>> +    mul = suffix_mul(suffixes, num_suffix, endptr, &offset, unit);
>>       if (mul >= 0) {
>> -        endptr++;
>> +        endptr += offset;
>>       } else {
>> -        mul = suffix_mul(default_suffix, unit);
>> +        mul = suffix_mul(suffixes, num_suffix, default_suffix, &offset, unit);
>>           assert(mul >= 0);
>>       }
>>       if (mul == 1 && mul_required) {
>> @@ -259,19 +256,47 @@ out:
>>       return retval;
>>   }
>>   
>> +/*
>> + * Convert string to bytes, allowing either B/b for bytes, K/k for KB,
>> + * M/m for MB, G/g for GB or T/t for TB. End pointer will be returned
>> + * in *end, if not NULL. Return -ERANGE on overflow, and -EINVAL on
>> + * other error.
>> + */
>> +static int do_strtosz(const char *nptr, const char **end,
>> +                      const char *default_suffix, int64_t unit,
>> +                      uint64_t *result)
>> +{
>> +    static const char *suffixes[] = { "B", "K", "M", "G", "T", "P", "E" };
>> +
>> +    return do_strtomul(nptr, end, suffixes, 7, default_suffix, unit, result);
> 
> [1] You can use ARRAY_SIZE(suffixes) instead of hardcoding the
> array size.
> 
>> +}
>> +
>>   int qemu_strtosz(const char *nptr, const char **end, uint64_t *result)
>>   {
>> -    return do_strtosz(nptr, end, 'B', 1024, result);
>> +    return do_strtosz(nptr, end, "B", 1024, result);
>>   }
>>   
>>   int qemu_strtosz_MiB(const char *nptr, const char **end, uint64_t *result)
>>   {
>> -    return do_strtosz(nptr, end, 'M', 1024, result);
>> +    return do_strtosz(nptr, end, "M", 1024, result);
>>   }
>>   
>>   int qemu_strtosz_metric(const char *nptr, const char **end, uint64_t *result)
>>   {
>> -    return do_strtosz(nptr, end, 'B', 1000, result);
>> +    return do_strtosz(nptr, end, "B", 1000, result);
>> +}
>> +
>> +/*
>> + * Convert string to time, support time unit are ns for nanosecond, us for
>> + * microsecond, ms for millisecond and s for second. End pointer will be
>> + * returned in *end, if not NULL. Return -ERANGE on overflow, and -EINVAL on
>> + * other error.
>> + */
>> +int qemu_strtotime_ns(const char *nptr, const char **end, uint64_t *result)
>> +{
>> +    static const char *suffixes[] = { "ns", "us", "ms", "s" };
>> +
>> +    return do_strtomul(nptr, end, suffixes, 4, "ns", 1000, result);
> 
> Same as above[1].
> 
>>   }
>>   
>>   /**
>> -- 
>> 2.20.1
>>
> 


