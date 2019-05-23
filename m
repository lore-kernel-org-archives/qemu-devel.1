Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472FBC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:24:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ABF12133D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ABF12133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36153 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTnhh-0002s1-7X
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:24:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hTnS4-0005z8-Hg
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:08:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hTnS0-0002TR-Ug
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:08:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hTnRy-0002IH-FC
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:08:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA3C075733;
	Thu, 23 May 2019 13:07:46 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E80995D705;
	Thu, 23 May 2019 13:07:42 +0000 (UTC)
Date: Thu, 23 May 2019 15:07:42 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Message-ID: <20190523150742.159efed1@redhat.com>
In-Reply-To: <20190508061726.27631-3-tao3.xu@intel.com>
References: <20190508061726.27631-1-tao3.xu@intel.com>
	<20190508061726.27631-3-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Thu, 23 May 2019 13:07:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 02/11] numa: move numa global variable
 have_numa_distance into MachineState
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
Cc: xiaoguangrong.eric@gmail.com, mst@redhat.com, jingqi.liu@intel.com,
	qemu-devel@nongnu.org, ehabkost@redhat.com, pbonzini@redhat.com,
	rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed,  8 May 2019 14:17:17 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> The aim of this patch is to move existing numa global have_numa_distance
> into NumaState.

s/The aim of this patch is to//

> Reviewed-by: Liu Jingqi <jingqi.liu@intel.com>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> Changes in v4 -> v3:
>     - send the patch together with HMAT patches
> ---
>  hw/arm/virt-acpi-build.c | 2 +-
>  hw/arm/virt.c            | 2 +-
>  hw/i386/acpi-build.c     | 2 +-
>  include/hw/boards.h      | 2 ++
>  include/sysemu/numa.h    | 2 --
>  numa.c                   | 5 ++---
>  6 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 6805b4de51..65f070843c 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -815,7 +815,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      if (nb_numa_nodes > 0) {
>          acpi_add_table(table_offsets, tables_blob);
>          build_srat(tables_blob, tables->linker, vms);
> -        if (have_numa_distance) {
> +        if (ms->numa_state->have_numa_distance) {
>              acpi_add_table(table_offsets, tables_blob);
>              build_slit(tables_blob, tables->linker, ms);
>          }
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 70954b658d..f0818ef597 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -228,7 +228,7 @@ static void create_fdt(VirtMachineState *vms)
>                                  "clk24mhz");
>      qemu_fdt_setprop_cell(fdt, "/apb-pclk", "phandle", vms->clock_phandle);
>  
> -    if (have_numa_distance) {
> +    if (nb_numa_nodes > 0 && ms->numa_state->have_numa_distance) {
>          int size = nb_numa_nodes * nb_numa_nodes * 3 * sizeof(uint32_t);
>          uint32_t *matrix = g_malloc0(size);
>          int idx, i, j;
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 7d9bc88ac9..43a807c483 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2685,7 +2685,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>      if (pcms->numa_nodes) {
>          acpi_add_table(table_offsets, tables_blob);
>          build_srat(tables_blob, tables->linker, machine);
> -        if (have_numa_distance) {
> +        if (machine->numa_state->have_numa_distance) {
>              acpi_add_table(table_offsets, tables_blob);
>              build_slit(tables_blob, tables->linker, machine);
>          }
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 5f102e3075..c3c678b7ff 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -237,6 +237,8 @@ typedef struct NumaState {
>      /* Number of NUMA nodes */
>      int num_nodes;
>  
> +    /* Allow setting NUMA distance for different NUMA nodes */
> +    bool have_numa_distance;
>  } NumaState;
>  
>  /**
> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> index a55e2be563..1a29408db9 100644
> --- a/include/sysemu/numa.h
> +++ b/include/sysemu/numa.h
> @@ -6,8 +6,6 @@
>  #include "sysemu/hostmem.h"
>  #include "hw/boards.h"
>  
> -extern bool have_numa_distance;
> -
>  struct NodeInfo {
>      uint64_t node_mem;
>      struct HostMemoryBackend *node_memdev;
> diff --git a/numa.c b/numa.c
> index 343fcaf13f..d4f5ff5193 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -52,7 +52,6 @@ static int have_memdevs = -1;
>  static int max_numa_nodeid; /* Highest specified NUMA node ID, plus one.
>                               * For all nodes, nodeid < max_numa_nodeid
>                               */
> -bool have_numa_distance;
>  NodeInfo numa_info[MAX_NODES];
>  
>  
> @@ -171,7 +170,7 @@ void parse_numa_distance(MachineState *ms, NumaDistOptions *dist, Error **errp)
>      }
>  
>      numa_info[src].distance[dst] = val;
> -    have_numa_distance = true;
> +    ms->numa_state->have_numa_distance = true;
>  }
>  
>  static
> @@ -442,7 +441,7 @@ void numa_complete_configuration(MachineState *ms)
>           * asymmetric. In this case, the distances for both directions
>           * of all node pairs are required.
>           */
> -        if (have_numa_distance) {
> +        if (ms->numa_state->have_numa_distance) {
>              /* Validate enough NUMA distance information was provided. */
>              validate_numa_distance(ms);
>  


