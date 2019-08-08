Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0527C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 08:18:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 984552187F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 08:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984552187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvdd2-0003Yt-JQ
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 04:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36015)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tao3.xu@intel.com>) id 1hvdcd-00034B-Qa
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 04:18:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1hvdcc-0004KO-QJ
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 04:18:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:40827)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>)
 id 1hvdca-00048A-CA; Thu, 08 Aug 2019 04:18:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Aug 2019 01:17:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,360,1559545200"; d="scan'208";a="179768874"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.241])
 ([10.239.196.241])
 by orsmga006.jf.intel.com with ESMTP; 08 Aug 2019 01:17:54 -0700
To: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <20190805071302.6260-1-tao3.xu@intel.com>
 <20190806145055.4f645f60@redhat.com> <20190807175256.GD4669@habkost.net>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <f8d899e1-b275-18e8-f555-e33cf05f6fb0@intel.com>
Date: Thu, 8 Aug 2019 16:17:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807175256.GD4669@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
Subject: Re: [Qemu-devel] [PATCH] numa: Introduce
 MachineClass::auto_enable_numa for implicit NUMA node
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/8/2019 1:52 AM, Eduardo Habkost wrote:
> On Tue, Aug 06, 2019 at 02:50:55PM +0200, Igor Mammedov wrote:
>> On Mon,  5 Aug 2019 15:13:02 +0800
>> Tao Xu <tao3.xu@intel.com> wrote:
>>
>>> Add MachineClass::auto_enable_numa field. When it is true, a NUMA node
>>> is expected to be created implicitly.
>>>
>>> Acked-by: David Gibson <david@gibson.dropbear.id.au>
>>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>>> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
>>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> [...]
>>> +    mc->auto_enable_numa = true;
>>
>> this will always create a numa node (that will affect not only RAM but
>> also all other components that depends on numa state (like CPUs)),
>> where as spapr_populate_memory() was only faking numa node in DT for RAM.
>> It makes non-numa configuration impossible.
>> Seeing David's ACK on the patch it might be fine, but I believe
>> commit message should capture that and explain why the change in
>> behavior is fine.
> 
> After a quick look, all spapr code seems to have the same
> behavior when nb_numa_nodes==0 and nb_numa_nodes==1, but I'd like
> to be sure.
> 
> David and/or Tao Xu: do you confirm there's no ABI change at all
> on spapr after implicitly creating a NUMA node?
> 
Even without this patch and HMAT patch, if without numa configuration, 
global nb_numa_nodes is always existing and default is 0, so nb_nodes 
will be auto set to 1, so from my point of view, this patch will not 
change ABI.

And I would also want to listen David's opinion.
>>
>>>       smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
>>>       smc->default_caps.caps[SPAPR_CAP_VSX] = SPAPR_CAP_ON;
>>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>>> index 2eb9a0b4e0..4a350b87d2 100644
>>> --- a/include/hw/boards.h
>>> +++ b/include/hw/boards.h
>>> @@ -220,6 +220,7 @@ struct MachineClass {
>>>       bool smbus_no_migration_support;
>>>       bool nvdimm_supported;
>>>       bool numa_mem_supported;
>>> +    bool auto_enable_numa;
>>>   
>>>       HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
>>>                                              DeviceState *dev);
>>
> 


