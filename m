Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81936C10F14
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 02:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45D4021736
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 02:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D4021736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50132 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHJAR-0007SI-K6
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 22:22:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hHJ9F-0006c8-27
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 22:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hHIzi-0008Oi-UI
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 22:11:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:19645)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hHIzf-0008L8-H9
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 22:11:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	18 Apr 2019 19:11:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,368,1549958400"; d="scan'208";a="162926890"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.248])
	([10.239.196.248])
	by fmsmga002.fm.intel.com with ESMTP; 18 Apr 2019 19:11:06 -0700
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190418064602.24558-1-tao3.xu@intel.com>
	<20190418064602.24558-2-tao3.xu@intel.com>
	<20190418142624.GH25134@habkost.net>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <a958c064-57d3-6d4a-f02a-3d27e3f33d8e@intel.com>
Date: Fri, 19 Apr 2019 10:11:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418142624.GH25134@habkost.net>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.20
Subject: Re: [Qemu-devel] [PATCH v2 1/3] numa: move numa global variable
 nb_numa_nodes into MachineState
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
Cc: imammedo@redhat.com, jingqi.liu@intel.com, qemu-devel@nongnu.org,
	pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190419021106.tZfmmXwp3dwIexva31zjHxhHKBM9hM4fxH-_As2Q6HU@z>

On 4/18/2019 10:26 PM, Eduardo Habkost wrote:
> On Thu, Apr 18, 2019 at 02:46:00PM +0800, Tao Xu wrote:
>> The aim of this patch is to add struct NumaState in MachineState
>> and move existing numa global nb_numa_nodes into NumaState.
>> And add variable numa_support into MachineClass to decide which
>> submachines support NUMA.
>>
>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> [...]
>> +    int nb_numa_nodes = ms->numa_state ? ms->numa_state->nb_numa_nodes : 0;
> 
> I see 17 occurrences of this same pattern in the patch, and I had
> to double-check the ones that didn't check if ms->numa_state is
> NULL.
> 
> I think a
>    int machine_num_numa_nodes(MachineState *ms)
> helper would be useful.
> 
> While at it, I suggest naming the nb_numa_nodes field "num_nodes"
> or "nr_nodes", because it's already inside a struct called
> NumaState.
> 
Thank you for your review, I will improve these in the next version of 
patch.


