Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACD2C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 02:46:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04389206F4
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 02:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04389206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ie948-0006NA-3c
	for qemu-devel@archiver.kernel.org; Sun, 08 Dec 2019 21:46:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1ie920-0005fn-GZ
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 21:44:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1ie91t-00034j-Md
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 21:44:15 -0500
Received: from mga06.intel.com ([134.134.136.31]:57300)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1ie91t-0002V0-An
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 21:44:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Dec 2019 18:43:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,294,1571727600"; d="scan'208";a="237601659"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.197.115])
 ([10.239.197.115])
 by fmsmga004.fm.intel.com with ESMTP; 08 Dec 2019 18:43:56 -0800
Subject: Re: [PATCH RESEND 0/4] Add extra information to versioned CPU models
To: Xiaoyao Li <xiaoyao.li@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20191202063233.28523-1-tao3.xu@intel.com>
 <e322418d-1b5e-cc79-e76b-f71c234165bb@intel.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <1dd17b0e-a2de-2711-b1dd-765ee7271a3d@intel.com>
Date: Mon, 9 Dec 2019 10:43:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <e322418d-1b5e-cc79-e76b-f71c234165bb@intel.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/2019 4:55 PM, Xiaoyao Li wrote:
> On 12/2/2019 2:32 PM, Tao Xu wrote:
>> This series of patches will remove MPX from Denverton, remove Remove
>> monitor from some CPU models. Add additional information for -cpu help
>> to indicate the changes in this version of CPU model.
>>
>> The output is as follows:
>> x86_64-softmmu/qemu-system-x86_64 -cpu help | grep "\["
>> x86 Broadwell-v2          Intel Core Processor (Broadwell) [no TSX]
>> x86 Broadwell-v3          Intel Core Processor (Broadwell) [IBRS]
>> x86 Broadwell-v4          Intel Core Processor (Broadwell) [no TSX, IBRS]
> 
> Above the changes of each Broadwell-v{2,3,4} are based on Broadwell-v1.
> 
>> x86 Cascadelake-Server-v2  Intel Xeon Processor (Cascadelake) [ARCH_CAPABILITIES]
>> x86 Cascadelake-Server-v3  Intel Xeon Processor (Cascadelake) [no TSX]
> 
> But in the code, Cascadelake-Server-v3 inherits all the features in
> Cascadelake-Server-v2 and removes TSX related hle & rtm.
> 
> So if we keep the same rule based on v1, it should be
> 
>    x86 Cascadelake-Server-v3  Intel Xeon Processor (Cascadelake)
> [ARCH_CAPABILITIES, no TSX]

Thank you for your suggestion. I will correct this.


