Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A435C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 03:26:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECE902086D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 03:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE902086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIP64-0003bo-4K
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 23:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iIP5I-0003CE-5F
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 23:25:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iIP5F-0001fN-6p
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 23:25:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59326)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iIP5E-0001ew-Os
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 23:25:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8372918CB8E5;
 Thu, 10 Oct 2019 03:25:43 +0000 (UTC)
Received: from localhost (ovpn-116-5.gru2.redhat.com [10.97.116.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4FD3B5D6A5;
 Thu, 10 Oct 2019 03:25:39 +0000 (UTC)
Date: Thu, 10 Oct 2019 00:25:38 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Moger, Babu" <Babu.Moger@amd.com>
Subject: Re: [Qemu-devel] [RFC 2 PATCH 01/16] numa: Split the numa
 functionality
Message-ID: <20191010032538.GB21666@habkost.net>
References: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
 <156779710184.21957.13351592831416903368.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156779710184.21957.13351592831416903368.stgit@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Thu, 10 Oct 2019 03:25:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "mst@redhat.com" <mst@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "ssg.sos.staff" <ssg.sos.staff@amd.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

First of all, sorry for taking more than a month to start
reviewing this.

On Fri, Sep 06, 2019 at 07:11:43PM +0000, Moger, Babu wrote:
> To support new epyc mode, we need to know the number of numa nodes
> in advance to generate apic id correctly. [...]

This explains that we need to initialize numa_info earlier than
something...

>                                     [...] So, split the numa
> initialization into two. The function parse_numa initializes numa_info
> and updates nb_numa_nodes. And then parse_numa_node does the numa node
> initialization.

...but I miss what "something" is.

The sequence of events here will be:

* parse_numa_opts()
  * for each -numa option:
    * parse_numa()
      * set_numa_options()
        * parse_numa_info()
          * here ms->numa_state->num_nodes is incremented [1]
* parse_numa_node_opts()
  * for each -numa option:
    * parse_numa_node()
      * set_numa_node_options()
        * here are the operations that are being delayed by this
          patch [2]

What exactly makes it necessary for [2] to happen after [1] is
done for all NUMA nodes?

This needs to be clear in the code, otherwise somebody will try to refactor
this in the future and merge set_numa_node_options() and parse_numa_info()
again, not knowing why ordering between [1] and [2] is so important.

In addition to documenting it better, I suggest saving the CPU
index list in NodeInfo, instead of calling qemu_opts_foreach()
twice.  (Probably a good idea to document the new field as
internal, though.  We don't want machine-specific code to be
looking at the CPU index list.)

Also, would it work if the delayed initialization is done at
numa_complete_configuration() instead of a new
parse_numa_node_opts() function?  We already have 2 separate
steps in NUMA initialization (parse_numa_node() and
numa_complete_configuration()), so it would be nice to avoid
adding a 3rd one.

Putting all the suggestions together, the code would look like this:


static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
                            Error **errp)
{
    /* ... */
    numa_info[nodenr].cpu_indexes = QAPI_CLONE(node->cpus, uint16List);
    /* ... */
}

void numa_complete_configuration(MachineState *ms)
{
    /* ... */
    for (i = 0; i < ms->numa_state->num_nodes; i++) {
        /*
         * numa_node_complete_configuration() needs to be called after all
         * nodes were already parsed, because <insert reason here>,
         */
        numa_node_complete_configuration(numa_info[i]);
    }
}

void numa_node_complete_configuration(MachineState *ms, NodeInfo *node)
{
    for (cpu_index = node->cpu_indexes; cpu_index; cpu_index = cpu_index->next) {
        CpuInstanceProperties props;
        props = mc->cpu_index_to_instance_props(ms, cpu_index->value);
        props.node_id = nodenr;
        props.has_node_id = true;
        machine_set_cpu_numa_node(ms, &props, &err);
    }
}


> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  hw/core/numa.c        |  106 +++++++++++++++++++++++++++++++++++--------------
>  include/sysemu/numa.h |    2 +
>  vl.c                  |    2 +
>  3 files changed, 80 insertions(+), 30 deletions(-)
> 
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index a11431483c..27fa6b5e1d 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -55,14 +55,10 @@ bool have_numa_distance;
>  NodeInfo numa_info[MAX_NODES];
>  
>  
> -static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
> +static void parse_numa_info(MachineState *ms, NumaNodeOptions *node,
>                              Error **errp)
>  {
> -    Error *err = NULL;
>      uint16_t nodenr;
> -    uint16List *cpus = NULL;
> -    MachineClass *mc = MACHINE_GET_CLASS(ms);
> -    unsigned int max_cpus = ms->smp.max_cpus;
>  
>      if (node->has_nodeid) {
>          nodenr = node->nodeid;
> @@ -81,29 +77,6 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>          return;
>      }
>  
> -    if (!mc->cpu_index_to_instance_props || !mc->get_default_cpu_node_id) {
> -        error_setg(errp, "NUMA is not supported by this machine-type");
> -        return;
> -    }
> -    for (cpus = node->cpus; cpus; cpus = cpus->next) {
> -        CpuInstanceProperties props;
> -        if (cpus->value >= max_cpus) {
> -            error_setg(errp,
> -                       "CPU index (%" PRIu16 ")"
> -                       " should be smaller than maxcpus (%d)",
> -                       cpus->value, max_cpus);
> -            return;
> -        }
> -        props = mc->cpu_index_to_instance_props(ms, cpus->value);
> -        props.node_id = nodenr;
> -        props.has_node_id = true;
> -        machine_set_cpu_numa_node(ms, &props, &err);
> -        if (err) {
> -            error_propagate(errp, err);
> -            return;
> -        }
> -    }
> -
>      have_memdevs = have_memdevs ? : node->has_memdev;
>      have_mem = have_mem ? : node->has_mem;
>      if ((node->has_mem && have_memdevs) || (node->has_memdev && have_mem)) {
> @@ -177,7 +150,7 @@ void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
>  
>      switch (object->type) {
>      case NUMA_OPTIONS_TYPE_NODE:
> -        parse_numa_node(ms, &object->u.node, &err);
> +        parse_numa_info(ms, &object->u.node, &err);
>          if (err) {
>              goto end;
>          }
> @@ -242,6 +215,73 @@ end:
>      return 0;
>  }
>  
> +void set_numa_node_options(MachineState *ms, NumaOptions *object, Error **errp)
> +{
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +    NumaNodeOptions *node = &object->u.node;
> +    unsigned int max_cpus = ms->smp.max_cpus;
> +    uint16List *cpus = NULL;
> +    Error *err = NULL;
> +    uint16_t nodenr;
> +
> +    if (node->has_nodeid) {
> +        nodenr = node->nodeid;
> +    } else {
> +        error_setg(errp, "NUMA node information is not available");
> +    }
> +
> +    if (!mc->cpu_index_to_instance_props || !mc->get_default_cpu_node_id) {
> +        error_setg(errp, "NUMA is not supported by this machine-type");
> +        return;
> +    }
> +
> +    for (cpus = node->cpus; cpus; cpus = cpus->next) {
> +        CpuInstanceProperties props;
> +        if (cpus->value >= max_cpus) {
> +            error_setg(errp,
> +                       "CPU index (%" PRIu16 ")"
> +                       " should be smaller than maxcpus (%d)",
> +                       cpus->value, max_cpus);
> +            return;
> +         }
> +         props = mc->cpu_index_to_instance_props(ms, cpus->value);
> +         props.node_id = nodenr;
> +         props.has_node_id = true;
> +         machine_set_cpu_numa_node(ms, &props, &err);
> +         if (err) {
> +            error_propagate(errp, err);
> +            return;
> +         }
> +    }
> +}
> +
> +static int parse_numa_node(void *opaque, QemuOpts *opts, Error **errp)
> +{
> +    NumaOptions *object = NULL;
> +    MachineState *ms = MACHINE(opaque);
> +    Error *err = NULL;
> +    Visitor *v = opts_visitor_new(opts);
> +
> +    visit_type_NumaOptions(v, NULL, &object, &err);
> +    visit_free(v);
> +    if (err) {
> +        goto end;
> +    }
> +
> +    if (object->type == NUMA_OPTIONS_TYPE_NODE) {
> +        set_numa_node_options(ms, object, &err);
> +    }
> +
> +end:
> +    qapi_free_NumaOptions(object);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
>  /* If all node pair distances are symmetric, then only distances
>   * in one direction are enough. If there is even one asymmetric
>   * pair, though, then all distances must be provided. The
> @@ -368,7 +408,7 @@ void numa_complete_configuration(MachineState *ms)
>      if (ms->ram_slots > 0 && nb_numa_nodes == 0 &&
>          mc->auto_enable_numa_with_memhp) {
>              NumaNodeOptions node = { };
> -            parse_numa_node(ms, &node, &error_abort);
> +            parse_numa_info(ms, &node, &error_abort);
>      }
>  
>      assert(max_numa_nodeid <= MAX_NODES);
> @@ -448,6 +488,12 @@ void parse_numa_opts(MachineState *ms)
>      qemu_opts_foreach(qemu_find_opts("numa"), parse_numa, ms, &error_fatal);
>  }
>  
> +void parse_numa_node_opts(MachineState *ms)
> +{
> +    qemu_opts_foreach(qemu_find_opts("numa"), parse_numa_node,
> +                      ms, &error_fatal);
> +}
> +
>  void numa_cpu_pre_plug(const CPUArchId *slot, DeviceState *dev, Error **errp)
>  {
>      int node_id = object_property_get_int(OBJECT(dev), "node-id", &error_abort);
> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> index 01a263eba2..ca109adaa6 100644
> --- a/include/sysemu/numa.h
> +++ b/include/sysemu/numa.h
> @@ -24,7 +24,9 @@ struct NumaNodeMem {
>  extern NodeInfo numa_info[MAX_NODES];
>  
>  void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp);
> +void set_numa_node_options(MachineState *ms, NumaOptions *object, Error **errp);
>  void parse_numa_opts(MachineState *ms);
> +void parse_numa_node_opts(MachineState *ms);
>  void numa_complete_configuration(MachineState *ms);
>  void query_numa_node_mem(NumaNodeMem node_mem[]);
>  extern QemuOptsList qemu_numa_opts;
> diff --git a/vl.c b/vl.c
> index b426b32134..711d2ae5da 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4339,6 +4339,8 @@ int main(int argc, char **argv, char **envp)
>      }
>      parse_numa_opts(current_machine);
>  
> +    parse_numa_node_opts(current_machine);
> +
>      /* do monitor/qmp handling at preconfig state if requested */
>      main_loop();
>  
> 

-- 
Eduardo

