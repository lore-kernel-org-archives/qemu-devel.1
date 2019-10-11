Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B497ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 04:11:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEA5220B7C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 04:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA5220B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iImHS-0002mb-9N
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 00:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iImGf-00025D-Rb
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 00:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iImGd-0005Y5-KL
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 00:11:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36938)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iImGd-0005WF-Bk
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 00:11:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1812A3B72D;
 Fri, 11 Oct 2019 04:11:02 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2EC595C1B2;
 Fri, 11 Oct 2019 04:10:59 +0000 (UTC)
Date: Fri, 11 Oct 2019 01:10:57 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Moger, Babu" <Babu.Moger@amd.com>
Subject: Re: [Qemu-devel] [RFC 2 PATCH 16/16] hw/core: Fix up the
 machine_set_cpu_numa_node for epyc
Message-ID: <20191011041057.GJ29387@habkost.net>
References: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
 <156779720803.21957.8389712174989601936.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156779720803.21957.8389712174989601936.stgit@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 11 Oct 2019 04:11:02 +0000 (UTC)
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

On Fri, Sep 06, 2019 at 07:13:29PM +0000, Moger, Babu wrote:
> Current topology id match will not work for epyc mode when setting
> the node id. In epyc mode, ids like smt_id, thread_id, core_id,
> ccx_id, socket_id can be same for more than one CPUs with across
> two numa nodes.
> 
> For example, we can have two CPUs with following ids on two different node.
> 1. smt_id=0, thread_id=0, core_id=0, ccx_id=0, socket_id=0, node_id=0
> 2. smt_id=0, thread_id=0, core_id=0, ccx_id=0, socket_id=0, node_id=1

I don't understand how that could happen.  If all IDs are the
same, how is it possible that those two cases should match two
different CPUs?

cpu_index_to_instance_props() must always return an unique
identifier for a single CPU.

> 
> The function machine_set_cpu_numa_node will fail to find a match to assign
> the node. Added new function machine_set_cpu_numa_node_epyc to set the node_id
> directly in epyc mode.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  hw/core/machine.c   |   24 ++++++++++++++++++++++++
>  hw/core/numa.c      |    6 +++++-
>  include/hw/boards.h |    4 ++++
>  3 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 9a8586cf30..6bceefc6f3 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -741,6 +741,30 @@ void machine_set_cpu_numa_node(MachineState *machine,
>      }
>  }
>  
> +void machine_set_cpu_numa_node_epyc(MachineState *machine,
> +                                    const CpuInstanceProperties *props,
> +                                    unsigned index,
> +                                    Error **errp)
> +{
> +    MachineClass *mc = MACHINE_GET_CLASS(machine);
> +    CPUArchId *slot;
> +
> +    if (!mc->possible_cpu_arch_ids) {
> +        error_setg(errp, "mapping of CPUs to NUMA node is not supported");
> +        return;
> +    }
> +
> +    /* disabling node mapping is not supported, forbid it */
> +    assert(props->has_node_id);
> +
> +    /* force board to initialize possible_cpus if it hasn't been done yet */
> +    mc->possible_cpu_arch_ids(machine);
> +
> +    slot = &machine->possible_cpus->cpus[index];
> +    slot->props.node_id = props->node_id;
> +    slot->props.has_node_id = props->has_node_id;
> +}
> +
>  static void smp_parse(MachineState *ms, QemuOpts *opts)
>  {
>      if (opts) {
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index 27fa6b5e1d..a9e835aea6 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -247,7 +247,11 @@ void set_numa_node_options(MachineState *ms, NumaOptions *object, Error **errp)
>           props = mc->cpu_index_to_instance_props(ms, cpus->value);
>           props.node_id = nodenr;
>           props.has_node_id = true;
> -         machine_set_cpu_numa_node(ms, &props, &err);
> +         if (ms->epyc) {
> +             machine_set_cpu_numa_node_epyc(ms, &props, cpus->value, &err);
> +         } else {
> +             machine_set_cpu_numa_node(ms, &props, &err);
> +         }
>           if (err) {
>              error_propagate(errp, err);
>              return;
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 0001d42e50..ec1b1c5a85 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -74,6 +74,10 @@ HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine);
>  void machine_set_cpu_numa_node(MachineState *machine,
>                                 const CpuInstanceProperties *props,
>                                 Error **errp);
> +void machine_set_cpu_numa_node_epyc(MachineState *machine,
> +                                    const CpuInstanceProperties *props,
> +                                    unsigned index,
> +                                    Error **errp);
>  
>  void machine_class_allow_dynamic_sysbus_dev(MachineClass *mc, const char *type);
>  
> 

-- 
Eduardo

