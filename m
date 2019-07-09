Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712D8C606CF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 00:52:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C1572166E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 00:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1572166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkeMs-0004c4-HL
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 20:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51239)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tao3.xu@intel.com>) id 1hkeHs-0002Uo-0Y
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 20:47:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1hkeHq-00078S-Oc
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 20:47:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:28137)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hkeHq-0006wG-FI
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 20:47:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Jul 2019 17:46:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,468,1557212400"; d="scan'208";a="167270075"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.197])
 ([10.239.196.197])
 by fmsmga007.fm.intel.com with ESMTP; 08 Jul 2019 17:46:42 -0700
To: Eric Blake <eblake@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "ehabkost@redhat.com" <ehabkost@redhat.com>
References: <20190707142958.31316-1-tao3.xu@intel.com>
 <20190707142958.31316-6-tao3.xu@intel.com>
 <69280ef3-ed37-6ed0-3e95-17084c2e1d48@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <24d1ab2b-1838-bce8-c8f2-601a8b19f4ab@intel.com>
Date: Tue, 9 Jul 2019 08:46:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <69280ef3-ed37-6ed0-3e95-17084c2e1d48@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
Subject: Re: [Qemu-devel] [PATCH v6 05/14] numa: Extend CLI to provide
 initiator information for numa nodes
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
Cc: "Liu, Jingqi" <jingqi.liu@intel.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>, "Du, Fan" <fan.du@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/8/2019 9:20 PM, Eric Blake wrote:
> On 7/7/19 9:29 AM, Tao Xu wrote:
>> In ACPI 6.3 chapter 5.2.27 Heterogeneous Memory Attribute Table (HMAT),
>> The initiator represents processor which access to memory. And in 5.2.27.3
>> Memory Proximity Domain Attributes Structure, the attached initiator is
>> defined as where the memory controller responsible for a memory proximity
>> domain. With attached initiator information, the topology of heterogeneous
>> memory can be described.
>>
>> Extend CLI of "-numa node" option to indicate the initiator numa
>> node-id.
>>
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
> 
>> +++ b/qapi/misc.json
>> @@ -2572,6 +2572,9 @@
>>   # @memdev: memory backend object.  If specified for one node,
>>   #          it must be specified for all nodes.
>>   #
>> +# @initiator: the initiator numa nodeid that is closest (as in directly
>> +#             attached) to this numa node.
> 
> Missing a '(since 4.2)' designator. We've already missed softfreeze for
> 4.1, and this is a new feature, so probably does have to slip into 4.2.
> 
thanks, and I see the numa.c has been moved, i will rebase my patch and 
change the version flag

