Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB75AC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 03:21:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACACE21736
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 03:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACACE21736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaWqe-0004W3-Pm
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 22:21:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iaWnQ-0003dg-RW
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 22:18:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iaWnF-0007J5-SR
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 22:18:08 -0500
Received: from mga09.intel.com ([134.134.136.24]:32171)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iaWnF-0006MS-JO
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 22:18:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Nov 2019 19:17:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,255,1571727600"; d="scan'208";a="199682105"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.197.115])
 ([10.239.197.115])
 by orsmga007.jf.intel.com with ESMTP; 28 Nov 2019 19:17:45 -0800
Subject: Re: [PATCH v19 7/8] tests/numa: Add case for QMP build HMAT
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20191128082109.30081-1-tao3.xu@intel.com>
 <20191128082109.30081-8-tao3.xu@intel.com>
 <87pnhcnru9.fsf@dusky.pond.sub.org>
 <09bb1d3f-222a-e84e-ab6a-55496bba1d9a@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <0ad066d9-c5cc-1ec3-4f03-175977536caf@intel.com>
Date: Fri, 29 Nov 2019 11:17:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <09bb1d3f-222a-e84e-ab6a-55496bba1d9a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "sw@weilnetz.de" <sw@weilnetz.de>, "Du, Fan" <fan.du@intel.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Liu,
 Jingqi" <jingqi.liu@intel.com>, "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/28/2019 7:53 PM, Thomas Huth wrote:
> On 28/11/2019 12.49, Markus Armbruster wrote:
>> Tao Xu <tao3.xu@intel.com> writes:
>>
>>> Check configuring HMAT usecase
>>>
>>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>>> ---
>>>
>>> Changes in v19:
>>>       - Add some fail cases for hmat-cache when level=0
>>>
>>> Changes in v18:
>>>       - Rewrite the lines over 80 characters
>>>
>>> Chenges in v17:
>>>       - Add some fail test cases (Igor)
>>> ---
>>>    tests/numa-test.c | 213 ++++++++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 213 insertions(+)
>>>
>>> diff --git a/tests/numa-test.c b/tests/numa-test.c
>>> index 8de8581231..aed7b2f31b 100644
>>> --- a/tests/numa-test.c
>>> +++ b/tests/numa-test.c
>>> @@ -327,6 +327,216 @@ static void pc_dynamic_cpu_cfg(const void *data)
>>>        qtest_quit(qs);
>>>    }
>>>    
>>> +static void pc_hmat_build_cfg(const void *data)
>>> +{
>>> +    QTestState *qs = qtest_initf("%s -nodefaults --preconfig -machine hmat=on "
>>> +                     "-smp 2,sockets=2 "
>>> +                     "-m 128M,slots=2,maxmem=1G "
>>> +                     "-object memory-backend-ram,size=64M,id=m0 "
>>> +                     "-object memory-backend-ram,size=64M,id=m1 "
>>> +                     "-numa node,nodeid=0,memdev=m0 "
>>> +                     "-numa node,nodeid=1,memdev=m1,initiator=0 "
>>> +                     "-numa cpu,node-id=0,socket-id=0 "
>>> +                     "-numa cpu,node-id=0,socket-id=1",
>>> +                     data ? (char *)data : "");
>>> +
>>> +    /* Fail: Initiator should be less than the number of nodes */
>>> +    g_assert(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
>>> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 2, 'target': 0,"
>>> +        " 'hierarchy': \"memory\", 'data-type': \"access-latency\" } }")));
>>
>> Code smell: side effect within assert().
>>
>> Harmless here, because compiling tests with NDEBUG is pointless.  Still,
>> it sets a bad example.  Not your idea, the pattern seems to go back to
>> commit c35665e1ee3 and fb1e58f72ba.
> 
> ... maybe best to use g_assert_true() which can't be disabled and thus
> should be used in tests. See:
> 
>    https://developer.gnome.org/glib/unstable/glib-Testing.html#g-assert-true
> 
>    Thomas
> 
Thank you for your suggestion. I will use g_assert_true and 
g_assert_false to replace g_assert

