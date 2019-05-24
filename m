Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF06C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:42:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A76204EC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A76204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55697 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUBPH-0005eG-4d
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 10:42:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hUBN2-0003oM-G2
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:40:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hUBLu-0006Vy-HR
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:39:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>)
	id 1hUBLt-0006R9-3A; Fri, 24 May 2019 10:39:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E02A58110E;
	Fri, 24 May 2019 14:39:19 +0000 (UTC)
Received: from [10.40.205.56] (unknown [10.40.205.56])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CF09269287;
	Fri, 24 May 2019 14:39:15 +0000 (UTC)
To: Igor Mammedov <imammedo@redhat.com>
References: <20190524103521.13847-1-lvivier@redhat.com>
	<20190524161045.314fa2de@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <c1c017f2-84ed-bddf-abb9-7154d9edb372@redhat.com>
Date: Fri, 24 May 2019 16:39:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190524161045.314fa2de@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Fri, 24 May 2019 14:39:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3] numa: improve cpu hotplug error message
 with a wrong node-id
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/05/2019 16:10, Igor Mammedov wrote:
> On Fri, 24 May 2019 12:35:21 +0200
> Laurent Vivier <lvivier@redhat.com> wrote:
> 
>> On pseries, core-ids are strongly binded to a node-id by the command
>> line option. If an user tries to add a CPU to the wrong node, he has
>> an error but it is not really helpful:
>>
>>    qemu-system-ppc64 ... -smp 1,maxcpus=64,cores=1,threads=1,sockets=1 \
>>                          -numa node,nodeid=0 -numa node,nodeid=1 ...
>>
>>    (qemu) device_add power9_v2.0-spapr-cpu-core,core-id=30,node-id=1
>>    Error: node-id=1 must match numa node specified with -numa option
>>
>> This patch improves this error message by giving to the user the good
>> topology information (node-id, socket-id and thread-id if they are
>> available) to use with the core-id he's providing:
>>
>>    Error: node-id=1 must match numa node specified with -numa option 'node-id 0'
>>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>>
>> Notes:
>>      v3: only add the topology to the existing message
>>          As suggested by Igor replace
>>            Error: core-id 30 can only be plugged into node-id 0
>>          by
>>            Error: node-id=1 must match numa node specified with -numa option 'node-id 0'
>>      
>>      v2: display full topology in the error message
>>
>>   numa.c | 25 ++++++++++++++++++++++++-
>>   1 file changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/numa.c b/numa.c
>> index 3875e1efda3a..7882ec294be4 100644
>> --- a/numa.c
>> +++ b/numa.c
>> @@ -458,6 +458,27 @@ void qmp_set_numa_node(NumaOptions *cmd, Error **errp)
>>       set_numa_options(MACHINE(qdev_get_machine()), cmd, errp);
>>   }
>>   
>> +static char *cpu_topology_to_string(const CPUArchId *cpu)
>> +{
>> +    GString *s = g_string_new(NULL);
>> +    if (cpu->props.has_socket_id) {
>> +        g_string_append_printf(s, "socket-id %"PRId64, cpu->props.socket_id);
>> +    }
>> +    if (cpu->props.has_node_id) {
>> +        if (s->len) {
>> +            g_string_append_printf(s, ", ");
>> +        }
>> +        g_string_append_printf(s, "node-id %"PRId64, cpu->props.node_id);
>> +    }
>> +    if (cpu->props.has_thread_id) {
>> +        if (s->len) {
>> +            g_string_append_printf(s, ", ");
>> +        }
>> +        g_string_append_printf(s, "thread-id %"PRId64, cpu->props.thread_id);
>> +    }
>> +    return g_string_free(s, false);
>> +}
> 
> turns out we already have such helper: cpu_slot_to_string()

It doesn't display the node-id but the core-id. And node-id is what we 
need to know.

Thanks,
Laurent

