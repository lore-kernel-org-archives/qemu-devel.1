Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5211DC04AB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 02:28:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A04220823
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 02:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A04220823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55960 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVRqy-0001HO-5O
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 22:28:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hVRqA-0000xs-Cy
	for qemu-devel@nongnu.org; Mon, 27 May 2019 22:27:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hVRq9-0005hh-8y
	for qemu-devel@nongnu.org; Mon, 27 May 2019 22:27:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:10272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
	id 1hVRq8-0005hA-Hz
	for qemu-devel@nongnu.org; Mon, 27 May 2019 22:27:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	27 May 2019 19:27:44 -0700
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.239.196.162])
	([10.239.196.162])
	by orsmga002-auth.jf.intel.com with ESMTP/TLS/AES256-SHA;
	27 May 2019 19:27:38 -0700
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20190520165056.175475-1-like.xu@linux.intel.com>
	<20190520165056.175475-3-like.xu@linux.intel.com>
	<20190521171229.GD2824@work-vm>
From: Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <4c6d8194-17a2-375e-1987-af481801fbdb@linux.intel.com>
Date: Tue, 28 May 2019 10:27:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190521171229.GD2824@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.31
Subject: Re: [Qemu-devel] [PATCH v2 2/5] i386/cpu: Consolidate die-id
 validity in smp context
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
Cc: Andrew Jones <drjones@redhat.com>,
	=?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Peter Crosthwaite <crosthwaite.peter@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
	Brice Goglin <Brice.Goglin@inria.fr>, Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019/5/22 1:12, Dr. David Alan Gilbert wrote:
> * Like Xu (like.xu@linux.intel.com) wrote:
>> Following the legacy smp check rules, the die_id validity is added to
>> the same contexts as leagcy smp variables such as hmp_hotpluggable_cpus(),
>> machine_set_cpu_numa_node(), cpu_slot_to_string() and pc_cpu_pre_plug().
>>
>> Signed-off-by: Like Xu <like.xu@linux.intel.com>
>> ---
>>   hmp.c             |  3 +++
>>   hw/core/machine.c | 12 ++++++++++++
>>   hw/i386/pc.c      | 11 +++++++++++
>>   3 files changed, 26 insertions(+)
>>
>> diff --git a/hmp.c b/hmp.c
>> index 56a3ed7375..7deb7b7226 100644
>> --- a/hmp.c
>> +++ b/hmp.c
>> @@ -3112,6 +3112,9 @@ void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict)
>>           if (c->has_socket_id) {
>>               monitor_printf(mon, "    socket-id: \"%" PRIu64 "\"\n", c->socket_id);
>>           }
>> +        if (c->has_die_id) {
>> +            monitor_printf(mon, "    die-id: \"%" PRIu64 "\"\n", c->die_id);
>> +        }
>>           if (c->has_core_id) {
>>               monitor_printf(mon, "    core-id: \"%" PRIu64 "\"\n", c->core_id);
>>           }
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 5d046a43e3..5116429732 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -659,6 +659,11 @@ void machine_set_cpu_numa_node(MachineState *machine,
>>               return;
>>           }
>>   
>> +        if (props->has_die_id && !slot->props.has_die_id) {
>> +            error_setg(errp, "die-id is not supported");
>> +            return;
>> +        }
>> +
>>           /* skip slots with explicit mismatch */
>>           if (props->has_thread_id && props->thread_id != slot->props.thread_id) {
>>                   continue;
>> @@ -668,6 +673,10 @@ void machine_set_cpu_numa_node(MachineState *machine,
>>                   continue;
>>           }
>>   
>> +        if (props->has_die_id && props->die_id != slot->props.die_id) {
>> +                continue;
>> +        }
>> +
>>           if (props->has_socket_id && props->socket_id != slot->props.socket_id) {
>>                   continue;
>>           }
>> @@ -925,6 +934,9 @@ static char *cpu_slot_to_string(const CPUArchId *cpu)
>>       if (cpu->props.has_socket_id) {
>>           g_string_append_printf(s, "socket-id: %"PRId64, cpu->props.socket_id);
>>       }
>> +    if (cpu->props.has_die_id) {
>> +        g_string_append_printf(s, "die-id: %"PRId64, cpu->props.die_id);
>> +    }
>>       if (cpu->props.has_core_id) {
>>           if (s->len) {
>>               g_string_append_printf(s, ", ");
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 83ab53c814..00be2463af 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -2321,6 +2321,10 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>               error_setg(errp, "Invalid CPU socket-id: %u must be in range 0:%u",
>>                          cpu->socket_id, max_socket);
>>               return;
>> +        } else if (cpu->die_id > max_socket) {
>> +            error_setg(errp, "Invalid CPU die-id: %u must be in range 0:%u",
>> +                       cpu->die_id, max_socket);
>> +            return;
> 
> Can you explain why the die_id is related to max_socket?
> I'd assumed you could have a 2 socket system where each socket has 4
> dies.

Dr David,thanks for your comments and sorry for the slow reply.

You're right about this and the check rule for cpu->die_id in 
pc_cpu_pre_plug() should be:

	"else if (cpu->die_id > (pcms->smp_dies - 1))"

> 
> However, for the HMP side of it:
> 
> 
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
>>           }
>>           if (cpu->core_id < 0) {
>>               error_setg(errp, "CPU core-id is not set");
>> @@ -2378,6 +2382,13 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>       }
>>       cpu->socket_id = topo.pkg_id;
>>   
>> +    if (cpu->die_id != -1 && cpu->die_id != topo.die_id) {
>> +        error_setg(errp, "property die-id: %u doesn't match set apic-id:"
>> +            " 0x%x (die-id: %u)", cpu->die_id, cpu->apic_id, topo.die_id);
>> +        return;
>> +    }
>> +    cpu->die_id = topo.die_id;
>> +
>>       if (cpu->core_id != -1 && cpu->core_id != topo.core_id) {
>>           error_setg(errp, "property core-id: %u doesn't match set apic-id:"
>>               " 0x%x (core-id: %u)", cpu->core_id, cpu->apic_id, topo.core_id);
>> -- 
>> 2.21.0
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> 


