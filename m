Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD797C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 09:59:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75D6C2147A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 09:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D6C2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45782 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdtqQ-0001fc-HX
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 05:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55540)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hdtnj-0008Uo-T5
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 05:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hdtnf-0005KY-8a
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 05:56:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48868)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hdtne-0005IN-VL
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 05:56:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DEED836807;
 Thu, 20 Jun 2019 09:56:09 +0000 (UTC)
Received: from work-vm (ovpn-117-203.ams2.redhat.com [10.36.117.203])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D8CE05D9C6;
 Thu, 20 Jun 2019 09:56:07 +0000 (UTC)
Date: Thu, 20 Jun 2019 10:56:05 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190620095604.GE2907@work-vm>
References: <20190619201050.19040-1-armbru@redhat.com>
 <20190619201050.19040-12-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619201050.19040-12-armbru@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 20 Jun 2019 09:56:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 11/17] hw/core: Collect HMP command
 handlers in hw/core/
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Markus Armbruster (armbru@redhat.com) wrote:
> Move the HMP handlers related to qapi/machine.json to
> hw/core/machine-hmp-cmds.c, where they are covered by MAINTAINERS
> section "Machine core", just like qapi/machine.json.
> 
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  hw/core/Makefile.objs      |   1 +
>  hw/core/machine-hmp-cmds.c | 164 +++++++++++++++++++++++++++++++++++++
>  include/monitor/hmp.h      |   1 +
>  monitor/hmp-cmds.c         | 111 -------------------------
>  monitor/misc.c             |  32 +-------
>  5 files changed, 168 insertions(+), 141 deletions(-)
>  create mode 100644 hw/core/machine-hmp-cmds.c
> 
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index 99e7abe982..585b734358 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -25,3 +25,4 @@ common-obj-$(CONFIG_SOFTMMU) += null-machine.o
>  
>  obj-$(CONFIG_SOFTMMU) += machine-qmp-cmds.o
>  obj-$(CONFIG_SOFTMMU) += numa.o
> +common-obj-$(CONFIG_SOFTMMU) += machine-hmp-cmds.o
> diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
> new file mode 100644
> index 0000000000..7fa6075f1e
> --- /dev/null
> +++ b/hw/core/machine-hmp-cmds.c
> @@ -0,0 +1,164 @@
> +/*
> + * HMP commands related to machines and CPUs
> + *
> + * Copyright IBM, Corp. 2011
> + *
> + * Authors:
> + *  Anthony Liguori   <aliguori@us.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + *
> + * Contributions after 2012-01-13 are licensed under the terms of the
> + * GNU GPL, version 2 or (at your option) any later version.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "monitor/hmp.h"
> +#include "monitor/monitor.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-builtin-visit.h"
> +#include "qapi/qapi-commands-machine.h"
> +#include "qapi/qmp/qdict.h"
> +#include "qapi/string-output-visitor.h"
> +#include "qemu/error-report.h"
> +#include "sysemu/numa.h"
> +
> +void hmp_info_cpus(Monitor *mon, const QDict *qdict)
> +{
> +    CpuInfoFastList *cpu_list, *cpu;
> +
> +    cpu_list = qmp_query_cpus_fast(NULL);
> +
> +    for (cpu = cpu_list; cpu; cpu = cpu->next) {
> +        int active = ' ';
> +
> +        if (cpu->value->cpu_index == monitor_get_cpu_index()) {
> +            active = '*';
> +        }
> +
> +        monitor_printf(mon, "%c CPU #%" PRId64 ":", active,
> +                       cpu->value->cpu_index);
> +        monitor_printf(mon, " thread_id=%" PRId64 "\n", cpu->value->thread_id);
> +    }
> +
> +    qapi_free_CpuInfoFastList(cpu_list);
> +}
> +
> +void hmp_cpu_add(Monitor *mon, const QDict *qdict)
> +{
> +    int cpuid;
> +    Error *err = NULL;
> +
> +    error_report("cpu_add is deprecated, please use device_add instead");
> +
> +    cpuid = qdict_get_int(qdict, "id");
> +    qmp_cpu_add(cpuid, &err);
> +    hmp_handle_error(mon, &err);
> +}
> +
> +void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict)
> +{
> +    Error *err = NULL;
> +    HotpluggableCPUList *l = qmp_query_hotpluggable_cpus(&err);
> +    HotpluggableCPUList *saved = l;
> +    CpuInstanceProperties *c;
> +
> +    if (err != NULL) {
> +        hmp_handle_error(mon, &err);
> +        return;
> +    }
> +
> +    monitor_printf(mon, "Hotpluggable CPUs:\n");
> +    while (l) {
> +        monitor_printf(mon, "  type: \"%s\"\n", l->value->type);
> +        monitor_printf(mon, "  vcpus_count: \"%" PRIu64 "\"\n",
> +                       l->value->vcpus_count);
> +        if (l->value->has_qom_path) {
> +            monitor_printf(mon, "  qom_path: \"%s\"\n", l->value->qom_path);
> +        }
> +
> +        c = l->value->props;
> +        monitor_printf(mon, "  CPUInstance Properties:\n");
> +        if (c->has_node_id) {
> +            monitor_printf(mon, "    node-id: \"%" PRIu64 "\"\n", c->node_id);
> +        }
> +        if (c->has_socket_id) {
> +            monitor_printf(mon, "    socket-id: \"%" PRIu64 "\"\n", c->socket_id);
> +        }
> +        if (c->has_core_id) {
> +            monitor_printf(mon, "    core-id: \"%" PRIu64 "\"\n", c->core_id);
> +        }
> +        if (c->has_thread_id) {
> +            monitor_printf(mon, "    thread-id: \"%" PRIu64 "\"\n", c->thread_id);
> +        }
> +
> +        l = l->next;
> +    }
> +
> +    qapi_free_HotpluggableCPUList(saved);
> +}
> +
> +void hmp_info_memdev(Monitor *mon, const QDict *qdict)
> +{
> +    Error *err = NULL;
> +    MemdevList *memdev_list = qmp_query_memdev(&err);
> +    MemdevList *m = memdev_list;
> +    Visitor *v;
> +    char *str;
> +
> +    while (m) {
> +        v = string_output_visitor_new(false, &str);
> +        visit_type_uint16List(v, NULL, &m->value->host_nodes, NULL);
> +        monitor_printf(mon, "memory backend: %s\n", m->value->id);
> +        monitor_printf(mon, "  size:  %" PRId64 "\n", m->value->size);
> +        monitor_printf(mon, "  merge: %s\n",
> +                       m->value->merge ? "true" : "false");
> +        monitor_printf(mon, "  dump: %s\n",
> +                       m->value->dump ? "true" : "false");
> +        monitor_printf(mon, "  prealloc: %s\n",
> +                       m->value->prealloc ? "true" : "false");
> +        monitor_printf(mon, "  policy: %s\n",
> +                       HostMemPolicy_str(m->value->policy));
> +        visit_complete(v, &str);
> +        monitor_printf(mon, "  host nodes: %s\n", str);
> +
> +        g_free(str);
> +        visit_free(v);
> +        m = m->next;
> +    }
> +
> +    monitor_printf(mon, "\n");
> +
> +    qapi_free_MemdevList(memdev_list);
> +    hmp_handle_error(mon, &err);
> +}
> +
> +void hmp_info_numa(Monitor *mon, const QDict *qdict)
> +{
> +    int i;
> +    NumaNodeMem *node_mem;
> +    CpuInfoList *cpu_list, *cpu;
> +
> +    cpu_list = qmp_query_cpus(&error_abort);
> +    node_mem = g_new0(NumaNodeMem, nb_numa_nodes);
> +
> +    query_numa_node_mem(node_mem);
> +    monitor_printf(mon, "%d nodes\n", nb_numa_nodes);
> +    for (i = 0; i < nb_numa_nodes; i++) {
> +        monitor_printf(mon, "node %d cpus:", i);
> +        for (cpu = cpu_list; cpu; cpu = cpu->next) {
> +            if (cpu->value->has_props && cpu->value->props->has_node_id &&
> +                cpu->value->props->node_id == i) {
> +                monitor_printf(mon, " %" PRIi64, cpu->value->CPU);
> +            }
> +        }
> +        monitor_printf(mon, "\n");
> +        monitor_printf(mon, "node %d size: %" PRId64 " MB\n", i,
> +                       node_mem[i].node_mem >> 20);
> +        monitor_printf(mon, "node %d plugged: %" PRId64 " MB\n", i,
> +                       node_mem[i].node_plugged_mem >> 20);
> +    }
> +    qapi_free_CpuInfoList(cpu_list);
> +    g_free(node_mem);
> +}
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index f46ccdaa35..9d558e9d78 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -117,6 +117,7 @@ void hmp_cpu_add(Monitor *mon, const QDict *qdict);
>  void hmp_object_add(Monitor *mon, const QDict *qdict);
>  void hmp_object_del(Monitor *mon, const QDict *qdict);
>  void hmp_info_memdev(Monitor *mon, const QDict *qdict);
> +void hmp_info_numa(Monitor *mon, const QDict *qdict);
>  void hmp_info_memory_devices(Monitor *mon, const QDict *qdict);
>  void hmp_qom_list(Monitor *mon, const QDict *qdict);
>  void hmp_qom_set(Monitor *mon, const QDict *qdict);
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 789f763938..ea8ae2966e 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -31,7 +31,6 @@
>  #include "qapi/qapi-builtin-visit.h"
>  #include "qapi/qapi-commands-block.h"
>  #include "qapi/qapi-commands-char.h"
> -#include "qapi/qapi-commands-machine.h"
>  #include "qapi/qapi-commands-migration.h"
>  #include "qapi/qapi-commands-misc.h"
>  #include "qapi/qapi-commands-net.h"
> @@ -457,27 +456,6 @@ void hmp_info_migrate_cache_size(Monitor *mon, const QDict *qdict)
>                     qmp_query_migrate_cache_size(NULL) >> 10);
>  }
>  
> -void hmp_info_cpus(Monitor *mon, const QDict *qdict)
> -{
> -    CpuInfoFastList *cpu_list, *cpu;
> -
> -    cpu_list = qmp_query_cpus_fast(NULL);
> -
> -    for (cpu = cpu_list; cpu; cpu = cpu->next) {
> -        int active = ' ';
> -
> -        if (cpu->value->cpu_index == monitor_get_cpu_index()) {
> -            active = '*';
> -        }
> -
> -        monitor_printf(mon, "%c CPU #%" PRId64 ":", active,
> -                       cpu->value->cpu_index);
> -        monitor_printf(mon, " thread_id=%" PRId64 "\n", cpu->value->thread_id);
> -    }
> -
> -    qapi_free_CpuInfoFastList(cpu_list);
> -}
> -
>  static void print_block_info(Monitor *mon, BlockInfo *info,
>                               BlockDeviceInfo *inserted, bool verbose)
>  {
> @@ -2472,18 +2450,6 @@ void hmp_nbd_server_stop(Monitor *mon, const QDict *qdict)
>      hmp_handle_error(mon, &err);
>  }
>  
> -void hmp_cpu_add(Monitor *mon, const QDict *qdict)
> -{
> -    int cpuid;
> -    Error *err = NULL;
> -
> -    error_report("cpu_add is deprecated, please use device_add instead");
> -
> -    cpuid = qdict_get_int(qdict, "id");
> -    qmp_cpu_add(cpuid, &err);
> -    hmp_handle_error(mon, &err);
> -}
> -
>  void hmp_chardev_add(Monitor *mon, const QDict *qdict)
>  {
>      const char *args = qdict_get_str(qdict, "args");
> @@ -2615,41 +2581,6 @@ void hmp_object_del(Monitor *mon, const QDict *qdict)
>      hmp_handle_error(mon, &err);
>  }
>  
> -void hmp_info_memdev(Monitor *mon, const QDict *qdict)
> -{
> -    Error *err = NULL;
> -    MemdevList *memdev_list = qmp_query_memdev(&err);
> -    MemdevList *m = memdev_list;
> -    Visitor *v;
> -    char *str;
> -
> -    while (m) {
> -        v = string_output_visitor_new(false, &str);
> -        visit_type_uint16List(v, NULL, &m->value->host_nodes, NULL);
> -        monitor_printf(mon, "memory backend: %s\n", m->value->id);
> -        monitor_printf(mon, "  size:  %" PRId64 "\n", m->value->size);
> -        monitor_printf(mon, "  merge: %s\n",
> -                       m->value->merge ? "true" : "false");
> -        monitor_printf(mon, "  dump: %s\n",
> -                       m->value->dump ? "true" : "false");
> -        monitor_printf(mon, "  prealloc: %s\n",
> -                       m->value->prealloc ? "true" : "false");
> -        monitor_printf(mon, "  policy: %s\n",
> -                       HostMemPolicy_str(m->value->policy));
> -        visit_complete(v, &str);
> -        monitor_printf(mon, "  host nodes: %s\n", str);
> -
> -        g_free(str);
> -        visit_free(v);
> -        m = m->next;
> -    }
> -
> -    monitor_printf(mon, "\n");
> -
> -    qapi_free_MemdevList(memdev_list);
> -    hmp_handle_error(mon, &err);
> -}
> -
>  void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
>  {
>      Error *err = NULL;
> @@ -3039,48 +2970,6 @@ void hmp_info_ramblock(Monitor *mon, const QDict *qdict)
>      ram_block_dump(mon);
>  }
>  
> -void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict)
> -{
> -    Error *err = NULL;
> -    HotpluggableCPUList *l = qmp_query_hotpluggable_cpus(&err);
> -    HotpluggableCPUList *saved = l;
> -    CpuInstanceProperties *c;
> -
> -    if (err != NULL) {
> -        hmp_handle_error(mon, &err);
> -        return;
> -    }
> -
> -    monitor_printf(mon, "Hotpluggable CPUs:\n");
> -    while (l) {
> -        monitor_printf(mon, "  type: \"%s\"\n", l->value->type);
> -        monitor_printf(mon, "  vcpus_count: \"%" PRIu64 "\"\n",
> -                       l->value->vcpus_count);
> -        if (l->value->has_qom_path) {
> -            monitor_printf(mon, "  qom_path: \"%s\"\n", l->value->qom_path);
> -        }
> -
> -        c = l->value->props;
> -        monitor_printf(mon, "  CPUInstance Properties:\n");
> -        if (c->has_node_id) {
> -            monitor_printf(mon, "    node-id: \"%" PRIu64 "\"\n", c->node_id);
> -        }
> -        if (c->has_socket_id) {
> -            monitor_printf(mon, "    socket-id: \"%" PRIu64 "\"\n", c->socket_id);
> -        }
> -        if (c->has_core_id) {
> -            monitor_printf(mon, "    core-id: \"%" PRIu64 "\"\n", c->core_id);
> -        }
> -        if (c->has_thread_id) {
> -            monitor_printf(mon, "    thread-id: \"%" PRIu64 "\"\n", c->thread_id);
> -        }
> -
> -        l = l->next;
> -    }
> -
> -    qapi_free_HotpluggableCPUList(saved);
> -}
> -
>  void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict)
>  {
>      Error *err = NULL;
> diff --git a/monitor/misc.c b/monitor/misc.c
> index 45f3f55a4d..00338c002a 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -36,7 +36,6 @@
>  #include "net/slirp.h"
>  #include "chardev/char-mux.h"
>  #include "ui/qemu-spice.h"
> -#include "sysemu/numa.h"
>  #include "qemu/config-file.h"
>  #include "qemu/ctype.h"
>  #include "ui/console.h"
> @@ -48,6 +47,8 @@
>  #include "sysemu/hw_accel.h"
>  #include "authz/list.h"
>  #include "qapi/util.h"
> +#include "sysemu/blockdev.h"
> +#include "sysemu/sysemu.h"
>  #include "sysemu/tcg.h"
>  #include "sysemu/tpm.h"
>  #include "qapi/qmp/qdict.h"
> @@ -1081,35 +1082,6 @@ static void hmp_info_mtree(Monitor *mon, const QDict *qdict)
>      mtree_info(flatview, dispatch_tree, owner);
>  }
>  
> -static void hmp_info_numa(Monitor *mon, const QDict *qdict)
> -{
> -    int i;
> -    NumaNodeMem *node_mem;
> -    CpuInfoList *cpu_list, *cpu;
> -
> -    cpu_list = qmp_query_cpus(&error_abort);
> -    node_mem = g_new0(NumaNodeMem, nb_numa_nodes);
> -
> -    query_numa_node_mem(node_mem);
> -    monitor_printf(mon, "%d nodes\n", nb_numa_nodes);
> -    for (i = 0; i < nb_numa_nodes; i++) {
> -        monitor_printf(mon, "node %d cpus:", i);
> -        for (cpu = cpu_list; cpu; cpu = cpu->next) {
> -            if (cpu->value->has_props && cpu->value->props->has_node_id &&
> -                cpu->value->props->node_id == i) {
> -                monitor_printf(mon, " %" PRIi64, cpu->value->CPU);
> -            }
> -        }
> -        monitor_printf(mon, "\n");
> -        monitor_printf(mon, "node %d size: %" PRId64 " MB\n", i,
> -                       node_mem[i].node_mem >> 20);
> -        monitor_printf(mon, "node %d plugged: %" PRId64 " MB\n", i,
> -                       node_mem[i].node_plugged_mem >> 20);
> -    }
> -    qapi_free_CpuInfoList(cpu_list);
> -    g_free(node_mem);
> -}
> -
>  #ifdef CONFIG_PROFILER
>  
>  int64_t dev_time;
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

