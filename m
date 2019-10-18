Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0906ECA9EB3
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 01:01:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4D3A2064A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 01:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D3A2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLGeM-0003gq-QC
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 21:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iLGdg-0003Fi-AU
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 21:01:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iLGde-0007h7-Cy
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 21:01:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:34671)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iLGde-0007dr-5c
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 21:01:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Oct 2019 18:00:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,309,1566889200"; d="scan'208";a="347933114"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.130])
 ([10.239.196.130])
 by orsmga004.jf.intel.com with ESMTP; 17 Oct 2019 18:00:09 -0700
Subject: Re: [PATCH RESEND v6 1/2] x86/cpu: Add support for
 UMONITOR/UMWAIT/TPAUSE
From: Tao Xu <tao3.xu@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>
References: <20191011074103.30393-1-tao3.xu@intel.com>
 <20191011074103.30393-2-tao3.xu@intel.com>
 <1731d87f-f07a-916f-90a7-346b593d821e@intel.com>
Message-ID: <60857ac6-ec04-2197-235c-d20600001a02@intel.com>
Date: Fri, 18 Oct 2019 09:00:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1731d87f-f07a-916f-90a7-346b593d821e@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Liu,
 Jingqi" <jingqi.liu@intel.com>, "mtosatti@redhat.com" <mtosatti@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo,
Ping :)
On 10/11/2019 3:49 PM, Tao Xu wrote:
> On 10/11/2019 3:41 PM, Xu, Tao3 wrote:
> [...]
>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>> index 11b9c854b5..a465c893b5 100644
>> --- a/target/i386/kvm.c
>> +++ b/target/i386/kvm.c
>> @@ -401,6 +401,12 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState 
>> *s, uint32_t function,
>>           if (host_tsx_blacklisted()) {
>>               ret &= ~(CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_HLE);
>>           }
>> +    } else if (function == 7 && index == 0 && reg == R_ECX) {
>> +        if (enable_cpu_pm) {
>> +            ret |= CPUID_7_0_ECX_WAITPKG;
>> +        } else {
>> +            ret &= ~CPUID_7_0_ECX_WAITPKG;
>> +        }
> 
> Hi Paolo,
> 
> I am sorry because I realize in KVM side, I keep cpuid mask WAITPKG as 0:
> 
> F(CLDEMOTE) | F(MOVDIRI) | F(MOVDIR64B) | 0 /*WAITPKG*/;
> 
> Therefore in QEMU side, we need to add CPUID_7_0_ECX_WAITPKG when 
> enable_cpu_pm is on. Otherwise, QEMU can't get this CPUID.
> 
> Could you review this part again? Thank you very much!
> 
> Tao


