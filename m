Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AECC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 07:42:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA4DD20835
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 07:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4DD20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40825 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLNPK-0004SQ-Vb
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 03:42:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hLNF0-0004Ew-2J
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hLNEw-0004MO-VD
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:31:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:59079)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
	id 1hLNEu-0003Tt-4X; Tue, 30 Apr 2019 03:31:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	30 Apr 2019 00:30:36 -0700
X-IronPort-AV: E=Sophos;i="5.60,412,1549958400"; d="scan'208";a="138643799"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.239.196.97])
	([10.239.196.97])
	by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES128-SHA;
	30 Apr 2019 00:30:33 -0700
To: Igor Mammedov <imammedo@redhat.com>
References: <1553849325-44201-1-git-send-email-like.xu@linux.intel.com>
	<1553849325-44201-3-git-send-email-like.xu@linux.intel.com>
	<20190404162555.0a2267ee@redhat.com>
From: Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <a765e3ac-45e6-310e-aa66-7036b5717a26@linux.intel.com>
Date: Tue, 30 Apr 2019 15:30:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404162555.0a2267ee@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.136
Subject: Re: [Qemu-devel] [PATCH 2/9] cpu/topology: add general support for
 machine properties
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	qemu-devel@nongnu.org, like.xu@intel.com,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430073031.aU3xkZWN3GH9ZbncSf9imNBVk3XmBQC5s7SF7WDc8io@z>

On 2019/4/4 22:25, Igor Mammedov wrote:
> On Fri, 29 Mar 2019 16:48:38 +0800
> Like Xu <like.xu@linux.intel.com> wrote:
> 

<snipp>
> 
>> diff --git a/cpus.c b/cpus.c
>> index e83f72b..834a697 100644
>> --- a/cpus.c
>> +++ b/cpus.c
>> @@ -2067,6 +2067,10 @@ static void qemu_dummy_start_vcpu(CPUState *cpu)
>>   
>>   void qemu_init_vcpu(CPUState *cpu)
>>   {
>> +    MachineState *ms = MACHINE(qdev_get_machine());
>> +    unsigned int smp_cores = ms->topo.smp_cores;
>> +    unsigned int smp_threads = ms->topo.smp_threads;
> 
> (***)
> for once it probably will crash *-user builds
> and secondly the purpose of getting rid of smp_foo globals
> is disentangle layer violations and not replace it with another global
> (qdev_get_machine()).

I am happy to follow this rule on cpu-topo refactoring work, but 
sometimes calling qdev_get_machine() is inevitable.

> 
> What should be done is to make a properties of nr_cores/nr_threads and set
> them from the parent object that creates CPUs. The point is CPUs shouldn't
> reach out outside itself to fish out data bits it needs, it's responsibility
> of creator to feed to being create CPU needed properties.
> 
> This kind of refactoring probably deserves its own series and should precede
> -smp refactoring as it doesn't depend on CpuTopology at all.
> 

The division of responsibility for this case (refactoring 
qemu_init_vcpu) seems to be a poisonous apple.

The prerequisite for setting cpu-> nr_cores / nr_threads from the parent 
is that the CPU has been created, so if any process during 
initialization needs this topo information, it will use the default 
values form cpu_common_initfn() instead of user-configured parameters.

We may not want to repeat those assignment operations using the new 
values and what do you think, Igor?

<snipp>

