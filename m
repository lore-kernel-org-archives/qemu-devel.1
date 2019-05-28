Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F18C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 13:59:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 216C92133F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 13:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216C92133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35468 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVcdH-0005Gx-VU
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 09:59:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hVcc0-0004UB-NG
	for qemu-devel@nongnu.org; Tue, 28 May 2019 09:57:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hVcbz-0005Av-79
	for qemu-devel@nongnu.org; Tue, 28 May 2019 09:57:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21099)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>)
	id 1hVcbr-00053s-C7; Tue, 28 May 2019 09:57:48 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4271AC09AD1A;
	Tue, 28 May 2019 13:57:27 +0000 (UTC)
Received: from [10.40.204.169] (ovpn-204-169.brq.redhat.com [10.40.204.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E37BF2DE6D;
	Tue, 28 May 2019 13:57:21 +0000 (UTC)
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190524103521.13847-1-lvivier@redhat.com>
	<20190524161045.314fa2de@redhat.com>
	<c1c017f2-84ed-bddf-abb9-7154d9edb372@redhat.com>
	<20190524201432.GP10764@habkost.net>
	<a3f324cc-8226-57e9-2bf3-347d84cf189a@redhat.com>
	<20190527145052.258825fb@redhat.com>
	<b3d08eb9-4727-ce2a-bc8e-57b7760b23f4@redhat.com>
	<20190528134408.GE22103@habkost.net>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <90f6524d-bb2f-7b3d-df0f-2920c034e3a2@redhat.com>
Date: Tue, 28 May 2019 15:57:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190528134408.GE22103@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Tue, 28 May 2019 13:57:33 +0000 (UTC)
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
	Igor Mammedov <imammedo@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/05/2019 15:44, Eduardo Habkost wrote:
> On Mon, May 27, 2019 at 03:52:30PM +0200, Laurent Vivier wrote:
>> On 27/05/2019 14:50, Igor Mammedov wrote:
>>> On Mon, 27 May 2019 08:55:49 +0200
>>> Laurent Vivier <lvivier@redhat.com> wrote:
>>>
>>>> On 24/05/2019 22:14, Eduardo Habkost wrote:
>>>>> On Fri, May 24, 2019 at 04:39:12PM +0200, Laurent Vivier wrote:
>>>>>> On 24/05/2019 16:10, Igor Mammedov wrote:
>>>>>>> On Fri, 24 May 2019 12:35:21 +0200
>>>>>>> Laurent Vivier <lvivier@redhat.com> wrote:
>>>>>>>    
>>>>>>>> On pseries, core-ids are strongly binded to a node-id by the command
>>>>>>>> line option. If an user tries to add a CPU to the wrong node, he has
>>>>>>>> an error but it is not really helpful:
>>>>>>>>
>>>>>>>>       qemu-system-ppc64 ... -smp 1,maxcpus=64,cores=1,threads=1,sockets=1 \
>>>>>>>>                             -numa node,nodeid=0 -numa node,nodeid=1 ...
>>>>>>>>
>>>>>>>>       (qemu) device_add power9_v2.0-spapr-cpu-core,core-id=30,node-id=1
>>>>>>>>       Error: node-id=1 must match numa node specified with -numa option
>>>>>>>>
>>>>>>>> This patch improves this error message by giving to the user the good
>>>>>>>> topology information (node-id, socket-id and thread-id if they are
>>>>>>>> available) to use with the core-id he's providing:
>>>>>>>>
>>>>>>>>       Error: node-id=1 must match numa node specified with -numa option 'node-id 0'
>>>>>>>>
>>>>>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>>>>>>> ---
>>>>>>>>
>>>>>>>> Notes:
>>>>>>>>         v3: only add the topology to the existing message
>>>>>>>>             As suggested by Igor replace
>>>>>>>>               Error: core-id 30 can only be plugged into node-id 0
>>>>>>>>             by
>>>>>>>>               Error: node-id=1 must match numa node specified with -numa option 'node-id 0'
>>>>>>>>         v2: display full topology in the error message
>>>>>>>>>>>      numa.c | 25 ++++++++++++++++++++++++-
>>>>>>>>      1 file changed, 24 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/numa.c b/numa.c
>>>>>>>> index 3875e1efda3a..7882ec294be4 100644
>>>>>>>> --- a/numa.c
>>>>>>>> +++ b/numa.c
>>>>>>>> @@ -458,6 +458,27 @@ void qmp_set_numa_node(NumaOptions *cmd, Error **errp)
>>>>>>>>          set_numa_options(MACHINE(qdev_get_machine()), cmd, errp);
>>>>>>>>      }
>>>>>>>> +static char *cpu_topology_to_string(const CPUArchId *cpu)
>>>>>>>> +{
>>>>>>>> +    GString *s = g_string_new(NULL);
>>>>>>>> +    if (cpu->props.has_socket_id) {
>>>>>>>> +        g_string_append_printf(s, "socket-id %"PRId64, cpu->props.socket_id);
>>>>>>>> +    }
>>>>>>>> +    if (cpu->props.has_node_id) {
>>>>>>>> +        if (s->len) {
>>>>>>>> +            g_string_append_printf(s, ", ");
>>>>>>>> +        }
>>>>>>>> +        g_string_append_printf(s, "node-id %"PRId64, cpu->props.node_id);
>>>>>>>> +    }
>>>>>>>> +    if (cpu->props.has_thread_id) {
>>>>>>>> +        if (s->len) {
>>>>>>>> +            g_string_append_printf(s, ", ");
>>>>>>>> +        }
>>>>>>>> +        g_string_append_printf(s, "thread-id %"PRId64, cpu->props.thread_id);
>>>>>>>> +    }
>>>>>>>> +    return g_string_free(s, false);
>>>>>>>> +}
>>>>>>>
>>>>>>> turns out we already have such helper: cpu_slot_to_string()
>>>>>>
>>>>>> It doesn't display the node-id but the core-id. And node-id is what we need
>>>>>> to know.
>>>>>
>>>>> I'm confused about what you are trying to do here.
>>>>>
>>>>> On v1, the message looked like:
>>>>>      Error: core-id 30 can only be plugged into node-id 0
>>>>>
>>>>> which is probably good for spapr.
>>>>>
>>>>>
>>>>> Then I suggested you added the other cpu->props fields.  e.g. on
>>>>> PC the message would look like:
>>>>>      Error: socket-id 20, core-id 30, thread-id 40 can only be plugged into node-id 0
>>>>>
>>>>>
>>>>> But you sent a v2 patch that would print this on PC:
>>>>>      Error: core-id 30 can only be plugged into socket-id 20, node-id 0, thread-id 40
>>>>>
>>>>> which doesn't make sense to me.
>>>>>
>>>>>
>>>>> Then in a reply to v2, Igor suggested:
>>>>>
>>>>>     error_setg(errp, "node-id=%d must match numa node specified "
>>>>>                       "with -numa option '%s'", node_id, topology);
>>>>>
>>>>>
>>>>> Igor suggest would address the problem above.  I expected it to become:
>>>>>      node-id=0 must match numa node specified with -numa option core-id=30
>>>>> and on PC:
>>>>>      node-id=0 must match numa node specified with -numa option socket-id=20,core-id=30,thread-id=40
>>>>>
>>>>> Or maybe it could include the input node-id too:
>>>>>      node-id=0 must match numa node specified with -numa option node-id=1,core-id=30
>>>>> and on PC:
>>>>>      node-id=0 must match numa node specified with -numa option node-id=1,socket-id=20,core-id=30,thread-id=40
>>>>>
>>>>> Both options would work.
>>>>>
>>>>>
>>>>> But you implemented code that would print:
>>>>>      Error: node-id=0 must match numa node specified with -numa option 'node-id 1'
>>>>> and on PC it would print:
>>>>>      Error: node-id=0 must match numa node specified with -numa option 'socket-id 20 node-id 1 thread-id=40'
>>>>>
>>>>> which doesn't make sense to me.
>>>>>
>>>>>
>>>>> I was expecting something like:
>>>>>      Error: CPU slot core-id=30 is bound to node-id 0, but node-id 1 was specified
>>>>> and on PC:
>>>>>      Error: CPU slot socket-id=20,core-id=30,thread-id=40 is bound to node-id 0, but node-id 1 was specified
>>>>>
>>>>>     
>>>>
>>>> The idea is to provide the information to the user to help him to know
>>>> where the cpu can be plugged when it cannot on the node-id he originally
>>>> provided.
>>>>
>>>> So all the solutions you propose sounds good to me.
>>>>
>>>> I only need you and Igor agree on the same one.
>>>
>>> We with Eduardo basically agree on contents/set of properties to print,
>>> it is only different phrasing (Eduardo's suggestion is better than what we have now).
>>> But lets get to what problem you are going to fix/improve. SO I've went ahead and tried
>>> with following CLI:
>>>
>>>      qemu-system-x86_64 -smp 1,maxcpus=4 -numa node,cpus=0-1 -numa node,cpus=2-3 -monitor stdio -device qemu64-x86_64-cpu,socket-id=1,core-id=0,thread-id=0,node-id=1
>>>
>>> end it errored out with:
>>>
>>>     qemu-system-x86_64: -device qemu64-x86_64-cpu,socket-id=1,core-id=0,thread-id=0,node-id=1: node-id=1 must match numa node specified with -numa option
>>>
>>> As you see we already have all user provide properties for cpu (including invalid ones) reported,
>>> what we are missing is suggestion for valid node-id. How about following error message:
>>>
>>> qemu-system-x86_64: -device qemu64-x86_64-cpu,socket-id=1,core-id=0,thread-id=0,node-id=1: invalid node-id, must be 0
>>
>> The case I'm worrying about is when the cpu is hotplugged: we don't have the "-device ..." information.
>>
>>    $ qemu-system-ppc64 -nodefaults -nographic -monitor stdio -m 1G -smp 1,maxcpus=64,cores=1,threads=1,sockets=1 -numa node,nodeid=0 -numa node,nodeid=1
>>    QEMU 3.0.1 monitor - type 'help' for more information
>>    (qemu) device_add power8_v2.0-spapr-cpu-core,core-id=30,node-id=1
>>    node-id=1 must match numa node specified with -numa option
>>
>> So you can see the needed information is missing.
> 
> What kind of essential information would be missing if we
> followed Igor's suggestion?
> 
>     (qemu) device_add power8_v2.0-spapr-cpu-core,core-id=30,node-id=1
>     invalid node-id, must be 0
> 

"invalid node-id, must be 0" is perfect for me. I update the patch.

Thank you,
Laurent


