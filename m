Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC4BC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 06:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 549A720848
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 06:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549A720848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j28Pe-0000Ox-E6
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 01:55:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1j28P2-0008LN-UM
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 01:55:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1j28P1-0004h9-05
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 01:55:12 -0500
Received: from mga06.intel.com ([134.134.136.31]:58110)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1j28P0-0004f1-Oj
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 01:55:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Feb 2020 22:55:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,435,1574150400"; d="scan'208";a="234025136"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.249.194.198])
 ([10.249.194.198])
 by orsmga003.jf.intel.com with ESMTP; 12 Feb 2020 22:55:04 -0800
Subject: Re: [PATCH v3 4/4] target/i386: Add notes for versioned CPU models
To: Igor Mammedov <imammedo@redhat.com>
References: <20200212081328.7385-1-tao3.xu@intel.com>
 <20200212081328.7385-5-tao3.xu@intel.com>
 <20200212100007.08b5b221@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <95c242cc-db05-dd20-8887-359eace911aa@intel.com>
Date: Thu, 13 Feb 2020 14:55:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200212100007.08b5b221@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/12/2020 5:00 PM, Igor Mammedov wrote:
> On Wed, 12 Feb 2020 16:13:28 +0800
> Tao Xu <tao3.xu@intel.com> wrote:
> 
>> Add which features are added or removed in this version. Remove the
>> changed model-id in versioned CPU models, to keep the model name
>> unchanged at /proc/cpuinfo inside the VM.
>>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
>>
>> Changes in v2:
>>      - correct the note of Cascadelake v3 (Xiaoyao)
>> ---
>>   target/i386/cpu.c | 54 ++++++++++++++++++++++-------------------------
>>   1 file changed, 25 insertions(+), 29 deletions(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 81a039beb6..739ef4ce91 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
[...]
>> @@ -3142,6 +3130,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
>>           .versions = (X86CPUVersionDefinition[]) {
>>               { .version = 1 },
>>               { .version = 2,
>> +              .note = "ARCH_CAPABILITIES",
> 
> what's ARCH_CAPABILITIES?
> 

These are some features exposed by MSR_IA32_ARCH_CAPABILITIES. For 
Cascadelake, these are "rdctl-no" "ibrs-all" "skip-l1dfl-vmentry" "mds-no"

