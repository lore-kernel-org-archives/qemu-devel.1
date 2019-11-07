Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97AEFC6194
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 01:52:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A91152178F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 01:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91152178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSWym-0001Ea-Qh
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 20:52:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37115)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iSWxd-0000bx-HP
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 20:51:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iSWxc-0005kG-6w
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 20:51:45 -0500
Received: from mga11.intel.com ([192.55.52.93]:16859)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iSWxb-0005k0-VS
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 20:51:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Nov 2019 17:51:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,276,1569308400"; d="scan'208";a="206018611"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.161])
 ([10.239.196.161])
 by orsmga006.jf.intel.com with ESMTP; 06 Nov 2019 17:51:39 -0800
Subject: Re: [PATCH v14 04/11] numa: Extend CLI to provide initiator
 information for numa nodes
To: Eric Blake <eblake@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>
References: <20191028075220.25673-1-tao3.xu@intel.com>
 <20191028075220.25673-5-tao3.xu@intel.com>
 <3c0b4ebc-3d0e-87b0-b290-cab4f833cfcf@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <6b6627c4-e134-3365-c2e1-540651fc30e0@intel.com>
Date: Thu, 7 Nov 2019 09:51:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3c0b4ebc-3d0e-87b0-b290-cab4f833cfcf@redhat.com>
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
Cc: "Liu, Jingqi" <jingqi.liu@intel.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>, "Du, Fan" <fan.du@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/7/2019 4:29 AM, Eric Blake wrote:
> On 10/28/19 2:52 AM, Tao Xu wrote:
>> In ACPI 6.3 chapter 5.2.27 Heterogeneous Memory Attribute Table (HMAT),
>> The initiator represents processor which access to memory. And in 5.2.27.3
>> Memory Proximity Domain Attributes Structure, the attached initiator is
>> defined as where the memory controller responsible for a memory proximity
>> domain. With attached initiator information, the topology of heterogeneous
>> memory can be described.
>>
>> Extend CLI of "-numa node" option to indicate the initiator numa node-id.
>> In the linux kernel, the codes in drivers/acpi/hmat/hmat.c parse and report
>> the platform's HMAT tables.
>>
>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>> Reviewed-by: Jingqi Liu <jingqi.liu@intel.com>
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
>>
> 
>> +++ b/qapi/machine.json
>> @@ -463,6 +463,13 @@
>>    # @memdev: memory backend object.  If specified for one node,
>>    #          it must be specified for all nodes.
>>    #
>> +# @initiator: defined in ACPI 6.3 Chapter 5.2.27.3 Table 5-145,
>> +#             points to the nodeid which has the memory controller
>> +#             responsible for this NUMA node. This field provides
>> +#             additional information as to the initiator node that
>> +#             is closest (as in directly attached) to this node, and
>> +#             therefore has the best performance (since 4.2)
>> +#
> 
> I'm sad to say, but we've now missed soft freeze for 4.2.  This feels
> like enough of a feature that we'll probably have to defer the series to
> the 5.0 release, which will have ripple effects to your patches.
> 
OK, I will change the version flag.

