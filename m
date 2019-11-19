Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629AAC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 03:15:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38AAF219F6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 03:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38AAF219F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWtyl-0001tt-7V
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 22:14:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iWtvY-0006Qz-PA
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 22:11:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iWtvX-00089T-3V
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 22:11:40 -0500
Received: from mga04.intel.com ([192.55.52.120]:22050)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iWtvW-00085z-Q6
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 22:11:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Nov 2019 19:11:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,322,1569308400"; d="scan'208";a="237174200"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.197.13])
 ([10.239.197.13])
 by fmsmga002.fm.intel.com with ESMTP; 18 Nov 2019 19:11:34 -0800
Subject: Re: [PATCH] target/i386: Remove monitor from some CPU model
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20191115083345.22638-1-tao3.xu@intel.com>
 <20191118221030.GG3812@habkost.net>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <9c228e08-c95d-259a-1af3-96093d692b35@intel.com>
Date: Tue, 19 Nov 2019 11:11:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191118221030.GG3812@habkost.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/19/2019 6:10 AM, Eduardo Habkost wrote:
> On Fri, Nov 15, 2019 at 04:33:45PM +0800, Tao Xu wrote:
>> Add new version of Snowridge, Denverton, Opteron_G3, EPYC, and Dhyana
>> CPU model to remove MONITOR/MWAIT feature.
>>
>> After QEMU/KVM use "-overcommit cpu-pm=on" to expose MONITOR/MWAIT
>> (commit id 6f131f13e68d648a8e4f083c667ab1acd88ce4cd), the MONITOR/MWAIT
>> feature in these CPU model is unused.
>>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
>>   target/i386/cpu.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 58 insertions(+)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index a624163ac2..7c5f1e8fe0 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -2770,6 +2770,19 @@ static X86CPUDefinition builtin_x86_defs[] = {
>>               MSR_ARCH_CAP_RDCL_NO | MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY,
>>           .xlevel = 0x80000008,
>>           .model_id = "Intel Atom Processor (Denverton)",
>> +        .versions = (X86CPUVersionDefinition[]) {
>> +            { .version = 1 },
>> +            {
>> +                .version = 2,
>> +                .props = (PropValue[]) {
>> +                    { "monitor", "off" },
>> +                    { "model-id",
>> +                      "Intel Atom Processor (Denverton, no MONITOR)" },
> 
> We never changed model-id when adding/removing features in
> machine-type code, and I don't see why we should start doing that
> now.  This info might be helpful on "-cpu help", but probably
> confusing for people looking at /proc/cpuinfo inside the VM.
> 
> If you think it is important to add extra info to "-cpu help", I
> suggest you send a patch adding a separate field instead of
> changing model ID on CPUID.
> 

OK I will add a new info to do this.

