Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C86C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 12:52:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79A992075C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 12:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A992075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45497 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVF7S-0003ko-G5
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 08:52:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hVF5l-0002hc-JS
	for qemu-devel@nongnu.org; Mon, 27 May 2019 08:51:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hVF5k-00021C-Ap
	for qemu-devel@nongnu.org; Mon, 27 May 2019 08:51:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hVF5g-0001yW-Ba; Mon, 27 May 2019 08:51:00 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DF2137FDFB;
	Mon, 27 May 2019 12:50:58 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E1C5E10027CA;
	Mon, 27 May 2019 12:50:56 +0000 (UTC)
Date: Mon, 27 May 2019 14:50:52 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Message-ID: <20190527145052.258825fb@redhat.com>
In-Reply-To: <a3f324cc-8226-57e9-2bf3-347d84cf189a@redhat.com>
References: <20190524103521.13847-1-lvivier@redhat.com>
	<20190524161045.314fa2de@redhat.com>
	<c1c017f2-84ed-bddf-abb9-7154d9edb372@redhat.com>
	<20190524201432.GP10764@habkost.net>
	<a3f324cc-8226-57e9-2bf3-347d84cf189a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Mon, 27 May 2019 12:50:59 +0000 (UTC)
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

On Mon, 27 May 2019 08:55:49 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> On 24/05/2019 22:14, Eduardo Habkost wrote:
> > On Fri, May 24, 2019 at 04:39:12PM +0200, Laurent Vivier wrote:  
> >> On 24/05/2019 16:10, Igor Mammedov wrote:  
> >>> On Fri, 24 May 2019 12:35:21 +0200
> >>> Laurent Vivier <lvivier@redhat.com> wrote:
> >>>  
> >>>> On pseries, core-ids are strongly binded to a node-id by the command
> >>>> line option. If an user tries to add a CPU to the wrong node, he has
> >>>> an error but it is not really helpful:
> >>>>
> >>>>     qemu-system-ppc64 ... -smp 1,maxcpus=64,cores=1,threads=1,sockets=1 \
> >>>>                           -numa node,nodeid=0 -numa node,nodeid=1 ...
> >>>>
> >>>>     (qemu) device_add power9_v2.0-spapr-cpu-core,core-id=30,node-id=1
> >>>>     Error: node-id=1 must match numa node specified with -numa option
> >>>>
> >>>> This patch improves this error message by giving to the user the good
> >>>> topology information (node-id, socket-id and thread-id if they are
> >>>> available) to use with the core-id he's providing:
> >>>>
> >>>>     Error: node-id=1 must match numa node specified with -numa option 'node-id 0'
> >>>>
> >>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> >>>> ---
> >>>>
> >>>> Notes:
> >>>>       v3: only add the topology to the existing message
> >>>>           As suggested by Igor replace
> >>>>             Error: core-id 30 can only be plugged into node-id 0
> >>>>           by
> >>>>             Error: node-id=1 must match numa node specified with -numa option 'node-id 0'
> >>>>       v2: display full topology in the error message  
> >>>>>>>    numa.c | 25 ++++++++++++++++++++++++-  
> >>>>    1 file changed, 24 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/numa.c b/numa.c
> >>>> index 3875e1efda3a..7882ec294be4 100644
> >>>> --- a/numa.c
> >>>> +++ b/numa.c
> >>>> @@ -458,6 +458,27 @@ void qmp_set_numa_node(NumaOptions *cmd, Error **errp)
> >>>>        set_numa_options(MACHINE(qdev_get_machine()), cmd, errp);
> >>>>    }
> >>>> +static char *cpu_topology_to_string(const CPUArchId *cpu)
> >>>> +{
> >>>> +    GString *s = g_string_new(NULL);
> >>>> +    if (cpu->props.has_socket_id) {
> >>>> +        g_string_append_printf(s, "socket-id %"PRId64, cpu->props.socket_id);
> >>>> +    }
> >>>> +    if (cpu->props.has_node_id) {
> >>>> +        if (s->len) {
> >>>> +            g_string_append_printf(s, ", ");
> >>>> +        }
> >>>> +        g_string_append_printf(s, "node-id %"PRId64, cpu->props.node_id);
> >>>> +    }
> >>>> +    if (cpu->props.has_thread_id) {
> >>>> +        if (s->len) {
> >>>> +            g_string_append_printf(s, ", ");
> >>>> +        }
> >>>> +        g_string_append_printf(s, "thread-id %"PRId64, cpu->props.thread_id);
> >>>> +    }
> >>>> +    return g_string_free(s, false);
> >>>> +}  
> >>>
> >>> turns out we already have such helper: cpu_slot_to_string()  
> >>
> >> It doesn't display the node-id but the core-id. And node-id is what we need
> >> to know.  
> > 
> > I'm confused about what you are trying to do here.
> > 
> > On v1, the message looked like:
> >    Error: core-id 30 can only be plugged into node-id 0
> > 
> > which is probably good for spapr.
> > 
> > 
> > Then I suggested you added the other cpu->props fields.  e.g. on
> > PC the message would look like:
> >    Error: socket-id 20, core-id 30, thread-id 40 can only be plugged into node-id 0
> > 
> > 
> > But you sent a v2 patch that would print this on PC:
> >    Error: core-id 30 can only be plugged into socket-id 20, node-id 0, thread-id 40
> > 
> > which doesn't make sense to me.
> > 
> > 
> > Then in a reply to v2, Igor suggested:
> > 
> >   error_setg(errp, "node-id=%d must match numa node specified "
> >                     "with -numa option '%s'", node_id, topology);
> > 
> > 
> > Igor suggest would address the problem above.  I expected it to become:
> >    node-id=0 must match numa node specified with -numa option core-id=30
> > and on PC:
> >    node-id=0 must match numa node specified with -numa option socket-id=20,core-id=30,thread-id=40
> > 
> > Or maybe it could include the input node-id too:
> >    node-id=0 must match numa node specified with -numa option node-id=1,core-id=30
> > and on PC:
> >    node-id=0 must match numa node specified with -numa option node-id=1,socket-id=20,core-id=30,thread-id=40
> > 
> > Both options would work.
> > 
> > 
> > But you implemented code that would print:
> >    Error: node-id=0 must match numa node specified with -numa option 'node-id 1'
> > and on PC it would print:
> >    Error: node-id=0 must match numa node specified with -numa option 'socket-id 20 node-id 1 thread-id=40'
> > 
> > which doesn't make sense to me.
> > 
> > 
> > I was expecting something like:
> >    Error: CPU slot core-id=30 is bound to node-id 0, but node-id 1 was specified
> > and on PC:
> >    Error: CPU slot socket-id=20,core-id=30,thread-id=40 is bound to node-id 0, but node-id 1 was specified
> > 
> >   
> 
> The idea is to provide the information to the user to help him to know 
> where the cpu can be plugged when it cannot on the node-id he originally 
> provided.
> 
> So all the solutions you propose sounds good to me.
> 
> I only need you and Igor agree on the same one.

We with Eduardo basically agree on contents/set of properties to print,
it is only different phrasing (Eduardo's suggestion is better than what we have now).
But lets get to what problem you are going to fix/improve. SO I've went ahead and tried
with following CLI:

   qemu-system-x86_64 -smp 1,maxcpus=4 -numa node,cpus=0-1 -numa node,cpus=2-3 -monitor stdio -device qemu64-x86_64-cpu,socket-id=1,core-id=0,thread-id=0,node-id=1

end it errored out with:

  qemu-system-x86_64: -device qemu64-x86_64-cpu,socket-id=1,core-id=0,thread-id=0,node-id=1: node-id=1 must match numa node specified with -numa option

As you see we already have all user provide properties for cpu (including invalid ones) reported,
what we are missing is suggestion for valid node-id. How about following error message:

qemu-system-x86_64: -device qemu64-x86_64-cpu,socket-id=1,core-id=0,thread-id=0,node-id=1: invalid node-id, must be 0

> 
> Thanks,
> Laurent


