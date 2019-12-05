Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE6DC2D0BF
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 08:56:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 280CF206DB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 08:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280CF206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icmwT-0000gE-Cg
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 03:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xiaoyao.li@intel.com>) id 1icmvZ-0000Db-48
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 03:56:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xiaoyao.li@intel.com>) id 1icmvX-0003yG-I4
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 03:56:00 -0500
Received: from mga12.intel.com ([192.55.52.136]:31989)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xiaoyao.li@intel.com>)
 id 1icmvX-0003jm-62
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 03:55:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Dec 2019 00:55:55 -0800
X-IronPort-AV: E=Sophos;i="5.69,280,1571727600"; d="scan'208";a="205705803"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.239.13.123])
 ([10.239.13.123])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-SHA;
 05 Dec 2019 00:55:54 -0800
Subject: Re: [PATCH RESEND 0/4] Add extra information to versioned CPU models
To: qemu-devel@nongnu.org
References: <20191202063233.28523-1-tao3.xu@intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <e322418d-1b5e-cc79-e76b-f71c234165bb@intel.com>
Date: Thu, 5 Dec 2019 16:55:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191202063233.28523-1-tao3.xu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
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

On 12/2/2019 2:32 PM, Tao Xu wrote:
> This series of patches will remove MPX from Denverton, remove Remove
> monitor from some CPU models. Add additional information for -cpu help
> to indicate the changes in this version of CPU model.
> 
> The output is as follows:
> x86_64-softmmu/qemu-system-x86_64 -cpu help | grep "\["
> x86 Broadwell-v2          Intel Core Processor (Broadwell) [no TSX]
> x86 Broadwell-v3          Intel Core Processor (Broadwell) [IBRS]
> x86 Broadwell-v4          Intel Core Processor (Broadwell) [no TSX, IBRS]

Above the changes of each Broadwell-v{2,3,4} are based on Broadwell-v1.

> x86 Cascadelake-Server-v2  Intel Xeon Processor (Cascadelake) [ARCH_CAPABILITIES]
> x86 Cascadelake-Server-v3  Intel Xeon Processor (Cascadelake) [no TSX]

But in the code, Cascadelake-Server-v3 inherits all the features in 
Cascadelake-Server-v2 and removes TSX related hle & rtm.

So if we keep the same rule based on v1, it should be

  x86 Cascadelake-Server-v3  Intel Xeon Processor (Cascadelake) 
[ARCH_CAPABILITIES, no TSX]

> x86 Denverton-v2          Intel Atom Processor (Denverton) [no MPX, no MONITOR]
> x86 Dhyana-v2             Hygon Dhyana Processor [no MONITOR]
> x86 EPYC-v2               AMD EPYC Processor [IBPB]
> x86 EPYC-v3               AMD EPYC Processor [IBPB, no MONITOR]
> x86 Haswell-v2            Intel Core Processor (Haswell) [no TSX]
> x86 Haswell-v3            Intel Core Processor (Haswell) [IBRS]
> x86 Haswell-v4            Intel Core Processor (Haswell) [no TSX, IBRS]
> x86 Icelake-Client-v2     Intel Core Processor (Icelake) [no TSX]
> x86 Icelake-Server-v2     Intel Xeon Processor (Icelake) [no TSX]
> x86 IvyBridge-v2          Intel Xeon E3-12xx v2 (Ivy Bridge) [IBRS]
> x86 Nehalem-v2            Intel Core i7 9xx (Nehalem Class Core i7) [IBRS]
> x86 Opteron_G3-v2         AMD Opteron 23xx (Gen 3 Class Opteron) [no MONITOR]
> x86 SandyBridge-v2        Intel Xeon E312xx (Sandy Bridge) [IBRS]
> x86 Skylake-Client-v2     Intel Core Processor (Skylake) [IBRS]
> x86 Skylake-Client-v3     Intel Core Processor (Skylake) [no TSX, IBRS]
> x86 Skylake-Server-v2     Intel Xeon Processor (Skylake) [IBRS]
> x86 Skylake-Server-v3     Intel Xeon Processor (Skylake) [no TSX, IBRS]
> x86 Snowridge-v2          Intel Atom Processor (SnowRidge) [no MPX]
> x86 Snowridge-v3          Intel Atom Processor (SnowRidge) [no MPX, no MONITOR]
> x86 Westmere-v2           Westmere E56xx/L56xx/X56xx (Nehalem-C) [IBRS]
> 
> Tao Xu (4):
>    target/i386: Add Denverton-v2 (no MPX) CPU model
>    target/i386: Remove monitor from some CPU models
>    target/i386: Add new property note to versioned CPU models
>    target/i386: Add notes for versioned CPU models
> 
>   target/i386/cpu.c | 112 +++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 85 insertions(+), 27 deletions(-)
> 


