Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CF7C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 05:27:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81AFD214DB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 05:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81AFD214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSwne-00079H-Kp
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 00:27:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iSwmG-0006Tw-UG
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 00:25:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iSwmF-0000G8-1a
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 00:25:44 -0500
Received: from mga09.intel.com ([134.134.136.24]:13974)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iSwmE-0000EL-Q0
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 00:25:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Nov 2019 21:25:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,280,1569308400"; d="scan'208";a="402979336"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.160])
 ([10.239.196.160])
 by fmsmga005.fm.intel.com with ESMTP; 07 Nov 2019 21:25:34 -0800
Subject: Re: [PATCH v14 03/11] tests: Add test for QAPI builtin type time
To: Eduardo Habkost <ehabkost@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>
References: <20191028075220.25673-1-tao3.xu@intel.com>
 <20191028075220.25673-4-tao3.xu@intel.com>
 <20191106205359.GR3812@habkost.net>
 <1f2fa942-0993-548b-1f5c-8345d564bf29@intel.com>
 <20191107133112.GS3812@habkost.net>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <9ecafb7f-69b9-870b-b109-939fef47acde@intel.com>
Date: Fri, 8 Nov 2019 13:25:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191107133112.GS3812@habkost.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
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
 "thuth@redhat.com" <thuth@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "Liu,
 Jingqi" <jingqi.liu@intel.com>, "Du, Fan" <fan.du@intel.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/7/2019 9:31 PM, Eduardo Habkost wrote:
> On Thu, Nov 07, 2019 at 02:24:52PM +0800, Tao Xu wrote:
>> On 11/7/2019 4:53 AM, Eduardo Habkost wrote:
>>> On Mon, Oct 28, 2019 at 03:52:12PM +0800, Tao Xu wrote:
>>>> Add tests for time input such as zero, around limit of precision,
>>>> signed upper limit, actual upper limit, beyond limits, time suffixes,
>>>> and etc.
>>>>
>>>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>>>> ---
>>> [...]
>>>> +    /* Close to signed upper limit 0x7ffffffffffffc00 (53 msbs set) */
>>>> +    qdict = keyval_parse("time1=9223372036854774784," /* 7ffffffffffffc00 */
>>>> +                         "time2=9223372036854775295", /* 7ffffffffffffdff */
>>>> +                         NULL, &error_abort);
>>>> +    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
>>>> +    qobject_unref(qdict);
>>>> +    visit_start_struct(v, NULL, NULL, 0, &error_abort);
>>>> +    visit_type_time(v, "time1", &time, &error_abort);
>>>> +    g_assert_cmphex(time, ==, 0x7ffffffffffffc00);
>>>> +    visit_type_time(v, "time2", &time, &error_abort);
>>>> +    g_assert_cmphex(time, ==, 0x7ffffffffffffc00);
>>>
>>> I'm confused by this test case and the one below[1].  Are these
>>> known bugs?  Shouldn't we document them as known bugs?
>>
>> Because do_strtosz() or do_strtomul() actually parse with strtod(), so the
>> precision is 53 bits, so in these cases, 7ffffffffffffdff and
>> fffffffffffffbff are rounded.
> 
> My questions remain: why isn't this being treated like a bug?
> 
Hi Markus,

I am confused about the code here too. Because in do_strtosz(), the 
upper limit is

val * mul >= 0xfffffffffffffc00

So some data near 53 bit may be rounded. Is there a bug?

