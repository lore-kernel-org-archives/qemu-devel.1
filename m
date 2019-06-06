Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A3AC28CC5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 01:31:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51C3B2083E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 01:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C3B2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52621 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYhFj-0005tI-Aa
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 21:31:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hYhEr-0005Ps-0P
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 21:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hYhEp-0008Tj-78
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 21:30:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:11076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hYhEn-0008Jc-Cq
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 21:30:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	05 Jun 2019 18:30:35 -0700
X-ExtLoop1: 1
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.163])
	([10.239.196.163])
	by orsmga004.jf.intel.com with ESMTP; 05 Jun 2019 18:30:33 -0700
To: Cornelia Huck <cohuck@redhat.com>
References: <20190524081839.6228-1-tao3.xu@intel.com>
	<20190524081839.6228-2-tao3.xu@intel.com>
	<20190604163430.0375fe01.cohuck@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <b01f8565-1153-482d-ae03-12cf125ea2ad@intel.com>
Date: Thu, 6 Jun 2019 09:30:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604163430.0375fe01.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.126
Subject: Re: [Qemu-devel] [PATCH v2 1/2] x86/cpu: Add support for
 UMONITOR/UMWAIT/TPAUSE
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"mst@redhat.com" <mst@redhat.com>, "Liu, Jingqi" <jingqi.liu@intel.com>,
	"mtosatti@redhat.com" <mtosatti@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/2019 10:34 PM, Cornelia Huck wrote:
> On Fri, 24 May 2019 16:18:38 +0800
> Tao Xu <tao3.xu@intel.com> wrote:
> 
>> UMONITOR, UMWAIT and TPAUSE are a set of user wait instructions.
>> Availability of the user wait instructions is indicated by the presence
>> of the CPUID feature flag WAITPKG CPUID.0x07.0x0:ECX[5].
>>
>> The patch enable the umonitor, umwait and tpause features in KVM.
>> Because umwait and tpause can put a (psysical) CPU into a power saving
>> state, by default we dont't expose it in kvm and provide a capability to
>> enable it. Use kvm capability to enable UMONITOR, UMWAIT and TPAUSE when
>> QEMU use "-overcommit cpu-pm=on, a VM can use UMONITOR, UMWAIT and TPAUSE
>> instructions. If the instruction causes a delay, the amount of time
>> delayed is called here the physical delay. The physical delay is first
>> computed by determining the virtual delay (the time to delay relative to
>> the VM’s timestamp counter). Otherwise, UMONITOR, UMWAIT and TPAUSE cause
>> an invalid-opcode exception(#UD).
>>
>> The release document ref below link:
>> https://software.intel.com/sites/default/files/\
>> managed/39/c5/325462-sdm-vol-1-2abcd-3abcd.pdf
>>
>> Co-developed-by: Jingqi Liu <jingqi.liu@intel.com>
>> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
>>   linux-headers/linux/kvm.h |  1 +
>>   target/i386/cpu.c         |  3 ++-
>>   target/i386/cpu.h         |  1 +
>>   target/i386/kvm.c         | 13 +++++++++++++
>>   4 files changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
>> index c8423e760c..86cc2dbdd0 100644
>> --- a/linux-headers/linux/kvm.h
>> +++ b/linux-headers/linux/kvm.h
>> @@ -993,6 +993,7 @@ struct kvm_ppc_resize_hpt {
>>   #define KVM_CAP_ARM_SVE 170
>>   #define KVM_CAP_ARM_PTRAUTH_ADDRESS 171
>>   #define KVM_CAP_ARM_PTRAUTH_GENERIC 172
>> +#define KVM_CAP_ENABLE_USR_WAIT_PAUSE 173
>>   
>>   #ifdef KVM_CAP_IRQ_ROUTING
>>   
> 
> No comment on the actual change, but please split out any linux-header
> changes so they can be replaced with a proper headers update when the
> code is merged.
> 
Thank you for your review, I will update this patch when the kvm patch 
change a lot.

