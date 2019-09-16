Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9892DC4CEC4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 02:05:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67BC92067D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 02:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67BC92067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9gNw-0005Iv-Ib
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 22:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1i9gMr-0004Nz-U9
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 22:03:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1i9gMq-0003GZ-Oa
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 22:03:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:3080)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>)
 id 1i9gMo-0003EP-3H; Sun, 15 Sep 2019 22:03:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Sep 2019 19:03:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,510,1559545200"; d="scan'208";a="216052988"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.197.66])
 ([10.239.197.66])
 by fmsmga002.fm.intel.com with ESMTP; 15 Sep 2019 19:03:45 -0700
To: "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
References: <20190905083238.1799-1-tao3.xu@intel.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <db1adc5e-a491-98d0-841b-6de7958d6777@intel.com>
Date: Mon, 16 Sep 2019 10:03:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905083238.1799-1-tao3.xu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
Subject: Re: [Qemu-devel] [PATCH v2] numa: Introduce
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gentle ping.

On 9/5/2019 4:32 PM, Xu, Tao3 wrote:
> Add MachineClass::auto_enable_numa field. When it is true, a NUMA node
> is expected to be created implicitly.
> 
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
> 
> Note: Parameter -numa node,mem is deprecated too. So I set
> "numa_info[0].node_mem = ram_size" instead of
> "NumaNodeOptions node = { .mem = ram_size }".
> 
> Changes in v2:
>      - Fix the qtest error, avoid using numa_auto_assign_ram.
> ---
>   hw/core/numa.c      | 10 ++++++++--
>   hw/ppc/spapr.c      |  9 +--------
>   include/hw/boards.h |  1 +
>   3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index 4dfec5c95b..038c96d4ab 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -378,11 +378,17 @@ void numa_complete_configuration(MachineState *ms)
>        *   guest tries to use it with that drivers.
>        *
>        * Enable NUMA implicitly by adding a new NUMA node automatically.
> +     *
> +     * Or if MachineClass::auto_enable_numa is true and no NUMA nodes,
> +     * assume there is just one node with whole RAM.
>        */
> -    if (ms->ram_slots > 0 && ms->numa_state->num_nodes == 0 &&
> -        mc->auto_enable_numa_with_memhp) {
> +    if (ms->numa_state->num_nodes == 0 &&
> +        ((ms->ram_slots > 0 &&
> +        mc->auto_enable_numa_with_memhp) ||
> +        mc->auto_enable_numa)) {
>               NumaNodeOptions node = { };
>               parse_numa_node(ms, &node, &error_abort);
> +            numa_info[0].node_mem = ram_size;
>       }
>   
>       assert(max_numa_nodeid <= MAX_NODES);
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 222a325056..f760e0f5d7 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -405,14 +405,6 @@ static int spapr_populate_memory(SpaprMachineState *spapr, void *fdt)
>       hwaddr mem_start, node_size;
>       int i, nb_nodes = machine->numa_state->num_nodes;
>       NodeInfo *nodes = machine->numa_state->nodes;
> -    NodeInfo ramnode;
> -
> -    /* No NUMA nodes, assume there is just one node with whole RAM */
> -    if (!nb_nodes) {
> -        nb_nodes = 1;
> -        ramnode.node_mem = machine->ram_size;
> -        nodes = &ramnode;
> -    }
>   
>       for (i = 0, mem_start = 0; i < nb_nodes; ++i) {
>           if (!nodes[i].node_mem) {
> @@ -4477,6 +4469,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>        */
>       mc->numa_mem_align_shift = 28;
>       mc->numa_mem_supported = true;
> +    mc->auto_enable_numa = true;
>   
>       smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
>       smc->default_caps.caps[SPAPR_CAP_VSX] = SPAPR_CAP_ON;
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 2289536e48..481e69388e 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -221,6 +221,7 @@ struct MachineClass {
>       bool smbus_no_migration_support;
>       bool nvdimm_supported;
>       bool numa_mem_supported;
> +    bool auto_enable_numa;
>   
>       HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
>                                              DeviceState *dev);
> 


