Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BITCOIN_SPAM_02,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BTC_ID,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACFEC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:59:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA5F22064B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+E8i3Cf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5F22064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idGxE-0005rk-Ng
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 11:59:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1idF8Z-0003CP-Qk
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:03:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1idF8X-0000Rb-TI
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:03:19 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28221
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1idF8X-0000QW-ML
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:03:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575644597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JJ7B0SC24IncW+n5CxgzDceBE7ovALGQMcIZSS7ECGo=;
 b=T+E8i3CfmpkngtmPfGGX8ZqfHfrB5EphpxPjxh5CG9cmYPYci557mEYfK+fo7XqFocDTSy
 Wq94jHteRjU744jtv4D6VzMJh0/DDtgA3VL1Y1WiTi+RIKbQSQRQCJOM3BtDuO/rLwXp7c
 B1qc/LPGDp2uAHcMdKqxWjA0/rpIeRk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-dgvRos_aOlSbWcU0Ub50VA-1; Fri, 06 Dec 2019 07:02:32 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D14891005502
 for <qemu-devel@nongnu.org>; Fri,  6 Dec 2019 12:02:31 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-235.ams2.redhat.com
 [10.36.116.235])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F2A8619C4F;
 Fri,  6 Dec 2019 12:02:25 +0000 (UTC)
Subject: Re: [PATCH for-5.0 8/8] acpi: cpuhp: spec: document procedure for
 enabling modern CPU hotplug
To: Igor Mammedov <imammedo@redhat.com>
References: <1575479147-6641-1-git-send-email-imammedo@redhat.com>
 <1575479147-6641-9-git-send-email-imammedo@redhat.com>
 <bb601078-db09-1915-1d12-350093887183@redhat.com>
 <20191206114034.68eacf25@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <22091869-b659-b869-5232-d658acb3ef15@redhat.com>
Date: Fri, 6 Dec 2019 13:02:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191206114034.68eacf25@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: dgvRos_aOlSbWcU0Ub50VA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: pbonzini@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/06/19 11:40, Igor Mammedov wrote:
> On Thu, 5 Dec 2019 15:07:53 +0100
> Laszlo Ersek <lersek@redhat.com> wrote:
> 
>> On 12/04/19 18:05, Igor Mammedov wrote:
>>> Describe how to enable and detect modern CPU hotplug interface.
>>> Detection part is based on new CPHP_GET_CPU_ID_CMD command,
>>> introduced by "acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command" patch.
>>>
>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>> ---
>>>  docs/specs/acpi_cpu_hotplug.txt | 22 ++++++++++++++++++++--
>>>  1 file changed, 20 insertions(+), 2 deletions(-)  
>>
>> Could we make this usecase / workflow independent of the new
>> CPHP_GET_CPU_ID_CMD command please?
>>
>> I'd like to suggest the following:
>>
>>> diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.txt
>>> index bb33144..667b264 100644
>>> --- a/docs/specs/acpi_cpu_hotplug.txt
>>> +++ b/docs/specs/acpi_cpu_hotplug.txt
>>> @@ -15,14 +15,14 @@ CPU present bitmap for:
>>>    PIIX-PM  (IO port 0xaf00-0xaf1f, 1-byte access)
>>>    One bit per CPU. Bit position reflects corresponding CPU APIC ID. Read-only.
>>>    The first DWORD in bitmap is used in write mode to switch from legacy
>>> -  to new CPU hotplug interface, write 0 into it to do switch.
>>> +  to modern CPU hotplug interface, write 0 into it to do switch.
>>>  ---------------------------------------------------------------
>>>  QEMU sets corresponding CPU bit on hot-add event and issues SCI
>>>  with GPE.2 event set. CPU present map is read by ACPI BIOS GPE.2 handler
>>>  to notify OS about CPU hot-add events. CPU hot-remove isn't supported.
>>>
>>>  =====================================
>>> -ACPI CPU hotplug interface registers:
>>> +Modern ACPI CPU hotplug interface registers:
>>>  -------------------------------------
>>>  Register block base address:
>>>      ICH9-LPC IO port 0x0cd8
>>> @@ -105,6 +105,24 @@ write access:
>>>                other values: reserved
>>>
>>>      Typical usecases:
>>> +        - (x86) Detecting and enabling modern CPU hotplug interface.  
>>
>> (1) I think we can drop the (x86) restriction. (Because, we don't need
>> to depend on APIC ID specifics; see below.)
>>
>>> +          QEMU starts with legacy CPU hotplug interface enabled. Detecting and
>>> +          switching to modern interface is based on the 2 legacy CPU hotplug features:
>>> +            1. Writes into CPU bitmap are ignored.
>>> +            2. CPU bitmap always has bit#0 set, corresponding to boot CPU.
>>> +
>>> +          Use following steps to detect and enable modern CPU hotplug interface:
>>> +            1. Store 0x0 to the 'CPU selector' register,
>>> +               attempting to switch to modern mode
>>> +            2. Store 0x0 to the 'CPU selector' register,
>>> +               to ensure valid selector value  
>>
>> OK thus far.
>>
>>> +            3. Store 0x3 to the 'Command field' register,
>>> +               sets the 'Command data 2' register into architecture specific
>>> +               CPU identifier mode  
>>
>> (2) Can we please store command 0 here
>> (CPHP_GET_NEXT_CPU_WITH_EVENT_CMD)?
> 
> that could work too, as far "Command data 2" is defined before
> we use it here.
> Point is to define "Command data 2" state with command 0 and leave our hands
> free when it comes to reserved (so it won't get in a way in the future
> if we need to 'unreserve' it in some context)
> 
>>
>> That might change the selector value, yes. (Even if that happens, the
>> new selector will be *valid*.)
>>
>> But the main point is that, with 0 stored to the command register, one
>> of the following *four* cases will hold, subsequently:
>>
>> (2a) if register block is totally missing:
>>
>> --> Offset#0 will read as all-bits-one (unassigned read)  
>>
>> (2b) if register block is legacy-only:
>>
>> --> Offset#0 will read as nonzero, due to CPU#0 being always present  
>>
>> (2c) if the modern register block is active, but the "Command data 2"
>> register is *not* yet described in the spec file:
>>
>> --> Offset#0 will read as zero, because it is *reserved*:  
>>
>>> read access:
>>>     offset:
>>>     [0x0-0x3] reserved <---- HERE  
>>
>> (2d) if the modern register block is active, and the "Command data 2"
>> register *is* described in the spec file:
>>
>> --> the "Command data 2" register (at offset#0) will read as zero,  
>> because:
>>
>>> read access:
>>>     offset:
>>>     [0x0-0x3] Command data 2: (DWORD access)
>>>               if last stored 'Command field' value:
>>>                   3: upper 32 bits of architecture specific identifying CPU value
>>>                      (n x86 case: 0x0)
>>>                   other values: reserved <------ HERE  
>>
>> and then step#4 applies just the same:
>>
>> On 12/04/19 18:05, Igor Mammedov wrote:
>>> +            4. Read the 'Command data 2' register.
>>> +               If read value is 0x0, the modern interface is enabled.
>>> +               Otherwise legacy or no CPU hotplug interface available
>>> +  
>>
>> because "read value is 0x0" corresponds to the *union* of cases (2c) and
>> (2d) -- namely, "the modern register block is active".
>>
>> My proposal above is what I implemented for OVMF in October:
>>
>>   [edk2-devel] [PATCH v2 3/3]
>>   OvmfPkg/PlatformPei: rewrite MaxCpuCountInitialization() for CPU hotplug
>>
>>   http://mid.mail-archive.com/20191022221554.14963-4-lersek@redhat.com
>>
>> and it works very well.
>>
>> So the benefits would be:
>>
>> - I wouldn't have to rewrite that (complex!) patch :) ,
>>
>> - the logic would not store the new CPHP_GET_CPU_ID_CMD command, only
>>   read offset#0,
>>
>> - the logic would not be x86 specific (it would not have to rely on the
>>   most significant 32 bits of the 64-bit arch-specific CPU identifier --
>>   here: the APIC ID -- being zero).
>>
>> Furthermore,
>>
>> (3) In step#4, I suggest replacing 'Command data 2' with "offset 0",
> Spec uses field names so I'd rather use 'Command data 2' here instead of
> direct offset to be consistent with the rest of the spec.
> 
>  
>> (4) finally, I'd suggest squashing this patch (updated as requested
>> above) into patch "acpi: cpuhp: spec: add typical usecases".
>>
>> Using my suggestion (2), you can define the "modern interface
>> enablement" workflow as well, without any dependency on
>> CPHP_GET_CPU_ID_CMD. The only thing that's necessary is the small update
>> from (3), and then you can describe all three important use cases in one
>> go, in patch#6.
> 
> I'd add extra patch that defines 'Command data 2' for command 0
> and after that it should be possible to squash detection usecase
> into 6/8.

Sounds good!

Thanks!
Laszlo

> 
>> And then you can introduce CPHP_GET_CPU_ID_CMD in the last patch
>> (patch#7), while staying compatible with the previously-documented
>> workflows.
>>
>> Pretty please? :)
>>
>> Thanks!
>> Laszlo
>>
>>>          - Get a cpu with pending event
>>>            1. Store 0x0 to the 'CPU selector' register.
>>>            2. Store 0x0 to the 'Command field' register.
>>>  
> 


