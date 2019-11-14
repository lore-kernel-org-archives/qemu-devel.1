Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7E2C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 00:59:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70DB2206EC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 00:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70DB2206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV3TT-00057w-EM
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 19:59:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iV3Mn-0003EL-PL
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 19:52:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iV3Mi-0006xq-8Y
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 19:52:06 -0500
Received: from mga18.intel.com ([134.134.136.126]:7558)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iV3Mh-0006KL-UI
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 19:52:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Nov 2019 16:51:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,302,1569308400"; d="scan'208";a="235481398"
Received: from unknown (HELO [10.239.196.128]) ([10.239.196.128])
 by fmsmga002.fm.intel.com with ESMTP; 13 Nov 2019 16:51:52 -0800
Subject: Re: [PATCH v14 03/11] tests: Add test for QAPI builtin type time
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20191028075220.25673-1-tao3.xu@intel.com>
 <20191028075220.25673-4-tao3.xu@intel.com>
 <20191106205359.GR3812@habkost.net>
 <1f2fa942-0993-548b-1f5c-8345d564bf29@intel.com>
 <20191107133112.GS3812@habkost.net>
 <9ecafb7f-69b9-870b-b109-939fef47acde@intel.com>
 <87lfsqbxnj.fsf@dusky.pond.sub.org> <20191112201558.GG3812@habkost.net>
 <8d8f7a45-b337-2ec8-d83d-4baec1efdaec@intel.com>
 <20191113220636.GK3812@habkost.net>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <c8a90967-cc71-829e-c5ec-8ca06bba3650@intel.com>
Date: Thu, 14 Nov 2019 08:51:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191113220636.GK3812@habkost.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
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
 Markus Armbruster <armbru@redhat.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/14/2019 6:06 AM, Eduardo Habkost wrote:
> On Wed, Nov 13, 2019 at 09:01:29AM +0800, Tao Xu wrote:
>> On 11/13/2019 4:15 AM, Eduardo Habkost wrote:
>>> On Fri, Nov 08, 2019 at 09:05:52AM +0100, Markus Armbruster wrote:
>>>> Tao Xu <tao3.xu@intel.com> writes:
>>>>
>>>>> On 11/7/2019 9:31 PM, Eduardo Habkost wrote:
>>>>>> On Thu, Nov 07, 2019 at 02:24:52PM +0800, Tao Xu wrote:
>>>>>>> On 11/7/2019 4:53 AM, Eduardo Habkost wrote:
>>>>>>>> On Mon, Oct 28, 2019 at 03:52:12PM +0800, Tao Xu wrote:
>>>>>>>>> Add tests for time input such as zero, around limit of precision,
>>>>>>>>> signed upper limit, actual upper limit, beyond limits, time suffixes,
>>>>>>>>> and etc.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>>>>>>>>> ---
>>>>>>>> [...]
>>>>>>>>> +    /* Close to signed upper limit 0x7ffffffffffffc00 (53 msbs set) */
>>>>>>>>> +    qdict = keyval_parse("time1=9223372036854774784," /* 7ffffffffffffc00 */
>>>>>>>>> +                         "time2=9223372036854775295", /* 7ffffffffffffdff */
>>>>>>>>> +                         NULL, &error_abort);
>>>>>>>>> +    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
>>>>>>>>> +    qobject_unref(qdict);
>>>>>>>>> +    visit_start_struct(v, NULL, NULL, 0, &error_abort);
>>>>>>>>> +    visit_type_time(v, "time1", &time, &error_abort);
>>>>>>>>> +    g_assert_cmphex(time, ==, 0x7ffffffffffffc00);
>>>>>>>>> +    visit_type_time(v, "time2", &time, &error_abort);
>>>>>>>>> +    g_assert_cmphex(time, ==, 0x7ffffffffffffc00);
>>>>>>>>
>>>>>>>> I'm confused by this test case and the one below[1].  Are these
>>>>>>>> known bugs?  Shouldn't we document them as known bugs?
>>>>>>>
>>>>>>> Because do_strtosz() or do_strtomul() actually parse with strtod(), so the
>>>>>>> precision is 53 bits, so in these cases, 7ffffffffffffdff and
>>>>>>> fffffffffffffbff are rounded.
>>>>>>
>>>>>> My questions remain: why isn't this being treated like a bug?
>>>>>>
>>>>> Hi Markus,
>>>>>
>>>>> I am confused about the code here too. Because in do_strtosz(), the
>>>>> upper limit is
>>>>>
>>>>> val * mul >= 0xfffffffffffffc00
>>>>>
>>>>> So some data near 53 bit may be rounded. Is there a bug?
>>>>
>>>> No, but the design is surprising, and the functions lack written
>>>> contracts, except for the do_strtosz() helper, which has one that sucks.
>>>>
>>>> qemu_strtosz() & friends are designed to accept fraction * unit
>>>> multiplier.  Example: 1.5M means 1.5 * 1024 * 1024 with qemu_strtosz()
>>>> and qemu_strtosz_MiB(), and 1.5 * 1000 * 1000 with
>>>> qemu_strtosz_metric().  Whether supporting fractions is a good idea is
>>>> debatable, but it's what we've got.
>>>>
>>>> The implementation limits the numeric part to the precision of double,
>>>> i.e. 53 bits.  "8PiB should be enough for anybody."
>>>>
>>>> Switching it from double to long double raises the limit to the
>>>> precision of long double.  At least 64 bit on common hosts, but hosts
>>>> exist where it's the same 53 bits.  Do we support any such hosts?  If
>>>> yes, then we'd make the precision depend on the host, which feels like a
>>>> bad idea.
>>>>
>>>> A possible alternative is to parse the numeric part both as a double and
>>>> as a 64 bit unsigned integer, then use whatever consumes more
>>>> characters.  This enables providing full 64 bits unless you actually use
>>>> a fraction.
>>>>
>>>
>>> This sounds like the right thing to do, if user input is an
>>> integer and the code in the other end is consuming an integer.
>>>
>>>
>>>> As far as I remember, the only problem we've ever had with the 53 bits
>>>> limit is developer confusion :)
>>>>
>>>
>>> Developer confusion, I can deal with.  However, exposing this
>>> behavior on external interfaces is a bug to me.
>>>
>>> I don't know how serious the bug is because I don't know which
>>> interfaces are affected by it.  Do we have a list?
>>>
>>>> Patches welcome.
>>>
>>> My first goal is to get the maintainers of that code to recognize
>>> it as a bug.  Then I hope this will motivate somebody else to fix
>>> it.  :)
>>>
>>
>> Hi Eduardo,
>>
>> If it is a bug, could the fix patch merged during rc1-rc3? Because I made 2
>> patches, and I want to submit before HMAT (HMAT patches is big, so submit
>> together may be slow).
> 
> Even if I convince other maintainers it is a bug, I don't think
> it is serious enough to require a fix in QEMU 4.2.  I suggest
> finishing the ongoing HMAT work first, and worry about this issue
> later.
> 
> Or, if you really prefer to address it before HMAT, it's OK to
> make the next version of the HMAT series depend on a series
> that's not merged yet.  Just make this explicit in the series
> cover letter (publishing a git branch to help review and testing
> is also appreciated).
> 
OK I will submit them together.

