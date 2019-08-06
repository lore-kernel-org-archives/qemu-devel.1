Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C882C31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 12:51:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 531D92064A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 12:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 531D92064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huywA-0003kf-Gl
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 08:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50726)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1huyvd-0003Fc-QH
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 08:51:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1huyvc-0004ZZ-9D
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 08:51:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55248)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1huyvc-0004ZD-1l; Tue, 06 Aug 2019 08:51:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0FF8EC05AA67;
 Tue,  6 Aug 2019 12:50:59 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F0DD608AB;
 Tue,  6 Aug 2019 12:50:57 +0000 (UTC)
Date: Tue, 6 Aug 2019 14:50:55 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Message-ID: <20190806145055.4f645f60@redhat.com>
In-Reply-To: <20190805071302.6260-1-tao3.xu@intel.com>
References: <20190805071302.6260-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 06 Aug 2019 12:50:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] numa: Introduce
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, ehabkost@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  5 Aug 2019 15:13:02 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> Add MachineClass::auto_enable_numa field. When it is true, a NUMA node
> is expected to be created implicitly.
> 
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
> 
> This patch has a dependency on
> https://patchwork.kernel.org/cover/11063235/
> ---
>  hw/core/numa.c      | 9 +++++++--
>  hw/ppc/spapr.c      | 9 +--------
>  include/hw/boards.h | 1 +
>  3 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index 75db35ac19..756d243d3f 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -580,9 +580,14 @@ void numa_complete_configuration(MachineState *ms)
>       *   guest tries to use it with that drivers.
>       *
>       * Enable NUMA implicitly by adding a new NUMA node automatically.
> +     *
> +     * Or if MachineClass::auto_enable_numa is true and no NUMA nodes,
> +     * assume there is just one node with whole RAM.
>       */
> -    if (ms->ram_slots > 0 && ms->numa_state->num_nodes == 0 &&
> -        mc->auto_enable_numa_with_memhp) {
> +    if (ms->numa_state->num_nodes == 0 &&
> +        ((ms->ram_slots > 0 &&
> +        mc->auto_enable_numa_with_memhp) ||
> +        mc->auto_enable_numa)) {
>              NumaNodeOptions node = { };
>              parse_numa_node(ms, &node, &error_abort);
>      }
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f607ca567b..e50343f326 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -400,14 +400,6 @@ static int spapr_populate_memory(SpaprMachineState *spapr, void *fdt)
>      hwaddr mem_start, node_size;
>      int i, nb_nodes = machine->numa_state->num_nodes;
>      NodeInfo *nodes = machine->numa_state->nodes;
> -    NodeInfo ramnode;
> -
> -    /* No NUMA nodes, assume there is just one node with whole RAM */
> -    if (!nb_nodes) {
> -        nb_nodes = 1;
> -        ramnode.node_mem = machine->ram_size;
> -        nodes = &ramnode;
> -    }
>  
>      for (i = 0, mem_start = 0; i < nb_nodes; ++i) {
>          if (!nodes[i].node_mem) {
> @@ -4369,6 +4361,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>       */
>      mc->numa_mem_align_shift = 28;
>      mc->numa_mem_supported = true;
> +    mc->auto_enable_numa = true;

this will always create a numa node (that will affect not only RAM but
also all other components that depends on numa state (like CPUs)),
where as spapr_populate_memory() was only faking numa node in DT for RAM.
It makes non-numa configuration impossible.
Seeing David's ACK on the patch it might be fine, but I believe
commit message should capture that and explain why the change in
behavior is fine.

>      smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_VSX] = SPAPR_CAP_ON;
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 2eb9a0b4e0..4a350b87d2 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -220,6 +220,7 @@ struct MachineClass {
>      bool smbus_no_migration_support;
>      bool nvdimm_supported;
>      bool numa_mem_supported;
> +    bool auto_enable_numa;
>  
>      HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
>                                             DeviceState *dev);


