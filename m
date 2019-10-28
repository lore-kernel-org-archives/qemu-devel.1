Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D80DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 08:52:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E373820B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 08:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E373820B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP0lO-00025u-4y
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 04:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54720)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iP0jM-00079U-Vc
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 04:50:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iP0jK-0000M3-4F
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 04:50:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:6408)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iP0jJ-0000KU-T0
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 04:50:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Oct 2019 01:50:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,239,1569308400"; d="scan'208";a="400747207"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.179])
 ([10.239.196.179])
 by fmsmga006.fm.intel.com with ESMTP; 28 Oct 2019 01:50:19 -0700
Subject: Re: [PATCH v14 11/11] tests/bios-tables-test: add test cases for ACPI
 HMAT
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20191028075220.25673-1-tao3.xu@intel.com>
 <20191028075220.25673-12-tao3.xu@intel.com>
 <20191028043831-mutt-send-email-mst@kernel.org>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <85197795-679e-ddc6-112a-376fbcdb560d@intel.com>
Date: Mon, 28 Oct 2019 16:50:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191028043831-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.20
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
 "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Liu,
 Jingqi" <jingqi.liu@intel.com>, "Du, Fan" <fan.du@intel.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 Daniel Black <daniel@linux.ibm.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/28/2019 4:39 PM, Michael S. Tsirkin wrote:
> On Mon, Oct 28, 2019 at 03:52:20PM +0800, Tao Xu wrote:
>> ACPI table HMAT has been introduced, QEMU now builds HMAT tables for
>> Heterogeneous Memory with boot option '-numa node'.
>>
>> Add test cases on PC and Q35 machines with 2 numa nodes.
>> Because HMAT is generated when system enable numa, the
>> following tables need to be added for this test:
>>    tests/acpi-test-data/pc/*.acpihmat
>>    tests/acpi-test-data/pc/HMAT.*
>>    tests/acpi-test-data/q35/*.acpihmat
>>    tests/acpi-test-data/q35/HMAT.*
>>
>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>> Reviewed-by: Daniel Black <daniel@linux.ibm.com>
>> Reviewed-by: Jingqi Liu <Jingqi.liu@intel.com>
>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
>>
>> No changes in v14.
>>
>> Changes in v13:
>>      - Use decimal notation with appropriate suffix for cache size
> 
> As you have seen adding tests like this breaks CI.
> Pls see the comment at the beginning of tests/bios-tables-test.c
> for how to add tests without breaking CI.
> 

Thanks for reminding me.


