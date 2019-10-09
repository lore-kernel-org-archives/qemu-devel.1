Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7B9ECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:08:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75A8120B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A8120B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIFRS-0002sz-4v
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 13:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iI5db-0004YD-9J
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 02:39:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iI5dZ-0001IK-GN
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 02:39:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:26032)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iI5dZ-0001FI-8G
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 02:39:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Oct 2019 23:39:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,273,1566889200"; d="scan'208";a="205657378"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.191])
 ([10.239.196.191])
 by orsmga002.jf.intel.com with ESMTP; 08 Oct 2019 23:39:47 -0700
Subject: Re: [PATCH v12 06/11] numa: Extend CLI to provide memory latency and
 bandwidth information
To: Igor Mammedov <imammedo@redhat.com>
References: <20190920074349.2616-1-tao3.xu@intel.com>
 <20190920074349.2616-7-tao3.xu@intel.com>
 <20191002171619.04a11347@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <5bfe9d25-89a1-90a6-75fb-a6aecf4844c0@intel.com>
Date: Wed, 9 Oct 2019 14:39:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191002171619.04a11347@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "Liu,
 Jingqi" <jingqi.liu@intel.com>, "Du, Fan" <fan.du@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/2/2019 11:16 PM, Igor Mammedov wrote:
> On Fri, 20 Sep 2019 15:43:44 +0800
> Tao Xu <tao3.xu@intel.com> wrote:
> 
[...]
>> +struct HMAT_LB_Info {
>> +    /* Indicates it's memory or the specified level memory side cache. */
>> +    uint8_t     hierarchy;
>> +
>> +    /* Present the type of data, access/read/write latency or bandwidth. */
>> +    uint8_t     data_type;
>> +
>> +    /* Array to store the latencies */
> specify units it's stored in
> 
>> +    uint64_t    *latency;
>> +
>> +    /* Array to store the bandwidthes */
> ditto
> 
>> +    uint64_t    *bandwidth;
> btw:
> 
> what was the reason for picking uint64_t for storing above values?
> 
> it seems in this patch you dumb down bandwidth to MB/s above but
> store latency as is.

Because I want to store the bandwidth or latency value (minimum unit) 
that user input. In HMAT, the minimum unit of bandwidth is MB/s, but in 
QAPI, the minimum unit of size is Byte. So I convert size into MB/s and 
time unit is "ps", need not convert.
> 
> and then in 9/11 build_hmat_lb you divide that on 'base' units,
> where are guaranties that value stored here will fit into 2 bytes
> used in HMAT to store it in the table?
> 
For HMAT spec, for a matrix of bandwidth or latency, there is only one 
base (in order to save ACPI tables space). We need to extract base for a 
matrix, but user input bandwidth or latency line by line. So after all 
data input, we can extract the base (as in 9/11).

There is another benefit. If user input different but similar units, 
such as "10ns" and "100ps", we can also store them. Only If user input 
big gap units, such as "1ps" and "1000ms". we can't store them and raise 
error.

> if this structure should store values in terms on HMAT table it should
> probably use uint16_t and check that user provided value won't overflow
> at the time of CLI parsing.
> 


