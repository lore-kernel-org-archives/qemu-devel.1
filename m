Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78276C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:35:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D778208C0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D778208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51818 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZKe5-0001Fm-1l
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 15:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35947)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hZIpv-0002dg-Do
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 13:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hZIpt-0001pf-0j
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 13:39:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43180)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hZIpr-0001bM-A4
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 13:39:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1AE6530820EA
 for <qemu-devel@nongnu.org>; Fri,  7 Jun 2019 17:39:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 947018BE2F;
 Fri,  7 Jun 2019 17:39:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 265E411386A0; Fri,  7 Jun 2019 19:39:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
References: <1559205199-233510-1-git-send-email-imammedo@redhat.com>
 <1559205199-233510-2-git-send-email-imammedo@redhat.com>
Date: Fri, 07 Jun 2019 19:39:17 +0200
In-Reply-To: <1559205199-233510-2-git-send-email-imammedo@redhat.com> (Igor
 Mammedov's message of "Thu, 30 May 2019 10:33:17 +0200")
Message-ID: <87h8915m7u.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 07 Jun 2019 17:39:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 1/3] machine: show if CLI option '-numa
 node, mem' is supported in QAPI schema
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
Cc: libvir-list@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Igor Mammedov <imammedo@redhat.com> writes:

> Legacy '-numa node,mem' option has a number of issues and mgmt often
> defaults to it. Unfortunately it's no possible to replace it with
> an alternative '-numa memdev' without breaking migration compatibility.
> What's possible though is to deprecate it, keeping option working with
> old machine types only.
>
> In order to help users to find out if being deprecated CLI option
> '-numa node,mem' is still supported by particular machine type, add new
> "numa-mem-supported" property to MachineInfo description in QAPI schema.

Suggest s/to MachineInfo description in QAPI schema/to output of
query-machines/, because query-machines is the external interface people
know.

> "numa-mem-supported" is set to 'true' for machines that currently support
> NUMA, but it will be flipped to 'false' later on, once deprecation period
> expires and kept 'true' only for old machine types that used to support
> the legacy option so it won't break existing configuration that are using
> it.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>
> Notes:
>     v4:
>       * drop idea to use "qom-list-properties" and use MachineInfo instead
>         which could be inspected with 'query-machines'
>
>  include/hw/boards.h | 3 +++
>  hw/arm/virt.c       | 1 +
>  hw/i386/pc.c        | 1 +
>  hw/ppc/spapr.c      | 1 +
>  qapi/misc.json      | 5 ++++-
>  vl.c                | 1 +
>  6 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 6f7916f..86894b6 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -158,6 +158,8 @@ typedef struct {
>   * @kvm_type:
>   *    Return the type of KVM corresponding to the kvm-type string option or
>   *    computed based on other criteria such as the host kernel capabilities.
> + * @numa_mem_supported:
> + *    true if '--numa node.mem' option is supported and false otherwise
>   */
>  struct MachineClass {
>      /*< private >*/
> @@ -210,6 +212,7 @@ struct MachineClass {
>      bool ignore_boot_device_suffixes;
>      bool smbus_no_migration_support;
>      bool nvdimm_supported;
> +    bool numa_mem_supported;
>  
>      HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
>                                             DeviceState *dev);
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index bf54f10..481a603 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1943,6 +1943,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>      assert(!mc->get_hotplug_handler);
>      mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
>      hc->plug = virt_machine_device_plug_cb;
> +    mc->numa_mem_supported = true;
>  }
>  
>  static void virt_instance_init(Object *obj)
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 2632b73..05b8368 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2747,6 +2747,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>      nc->nmi_monitor_handler = x86_nmi;
>      mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
>      mc->nvdimm_supported = true;
> +    mc->numa_mem_supported = true;
>  
>      object_class_property_add(oc, PC_MACHINE_DEVMEM_REGION_SIZE, "int",
>          pc_machine_get_device_memory_region_size, NULL,
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 2ef3ce4..265ecfb 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4336,6 +4336,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>       * in which LMBs are represented and hot-added
>       */
>      mc->numa_mem_align_shift = 28;
> +    mc->numa_mem_supported = true;
>  
>      smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_VSX] = SPAPR_CAP_ON;

This is correct when the TYPE_VIRT_MACHINE, TYPE_PC_MACHINE and
TYPE_SPAPR_MACHINE are exactly the machines supporting NUMA.  How could
I check that?

> diff --git a/qapi/misc.json b/qapi/misc.json
> index 8b3ca4f..d0bdccb 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -2018,12 +2018,15 @@
>  #
>  # @hotpluggable-cpus: cpu hotplug via -device is supported (since 2.7.0)
>  #
> +# @numa-mem-supported: true if '-numa node,mem' option is supported by machine
> +#                      type and false otherwise (since 4.1)


"by the machine type", for consistency with @cpu-max.  Also, rather long
line.

> +#
>  # Since: 1.2.0
>  ##
>  { 'struct': 'MachineInfo',
>    'data': { 'name': 'str', '*alias': 'str',
>              '*is-default': 'bool', 'cpu-max': 'int',
> -            'hotpluggable-cpus': 'bool'} }
> +            'hotpluggable-cpus': 'bool', 'numa-mem-supported': 'bool'} }
>  
>  ##
>  # @query-machines:
> diff --git a/vl.c b/vl.c
> index 5550bd7..5bf17f5 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1520,6 +1520,7 @@ MachineInfoList *qmp_query_machines(Error **errp)
>          info->name = g_strdup(mc->name);
>          info->cpu_max = !mc->max_cpus ? 1 : mc->max_cpus;
>          info->hotpluggable_cpus = mc->has_hotpluggable_cpus;
> +        info->numa_mem_supported = mc->numa_mem_supported;
>  
>          entry = g_malloc0(sizeof(*entry));
>          entry->value = info;

