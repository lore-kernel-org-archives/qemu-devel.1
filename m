Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A2BC0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 09:11:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2442C20665
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 09:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2442C20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsOAk-0003dt-Fs
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 05:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59257)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hsOAL-0003CS-Hd
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 05:11:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hsOAK-0004oT-As
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 05:11:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36732)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1hsOAK-0004oD-2f; Tue, 30 Jul 2019 05:11:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BE8062BF7B;
 Tue, 30 Jul 2019 09:11:25 +0000 (UTC)
Received: from Igors-MacBook-Pro (ovpn-204-67.brq.redhat.com [10.40.204.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0DA115C1A1;
 Tue, 30 Jul 2019 09:11:22 +0000 (UTC)
Date: Tue, 30 Jul 2019 11:11:20 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Message-ID: <20190730111120.63de67ae@Igors-MacBook-Pro>
In-Reply-To: <04ce7f87-815c-924b-e1df-6a4028750926@intel.com>
References: <20190729063127.2801-1-tao3.xu@intel.com>
 <20190729063127.2801-3-tao3.xu@intel.com>
 <20190729150957.157a7c03@redhat.com>
 <04ce7f87-815c-924b-e1df-6a4028750926@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 30 Jul 2019 09:11:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v8 02/11] numa: move numa global variable
 nb_numa_nodes into MachineState
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
Cc: ehabkost@redhat.com, aik@ozlabs.ru, jingqi.liu@intel.com, fan.du@intel.com,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, jonathan.cameron@huawei.com,
 David Gibson <dgibson@redhat.com>, dan.j.williams@intel.com, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jul 2019 08:53:36 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> On 7/29/2019 9:09 PM, Igor Mammedov wrote:
> > On Mon, 29 Jul 2019 14:31:18 +0800
> > Tao Xu <tao3.xu@intel.com> wrote:
> > 
> >> Add struct NumaState in MachineState and move existing numa global
> >> nb_numa_nodes(renamed as "num_nodes") into NumaState. And add variable
> >> numa_support into MachineClass to decide which submachines support NUMA.
> >>
> >> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> >> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> >> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> >> ---
> >>
> >> Changes in v8:
> >>      - Add check if numa->numa_state is NULL in pxb_dev_realize_common
> >>      - Use nb_nodes in spapr_populate_memory() (Igor)
> >> ---
> > [...]
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index 821f0d4a49..1c7c12c415 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -331,7 +331,7 @@ static int spapr_fixup_cpu_dt(void *fdt, SpaprMachineState *spapr)
> >>               return ret;
> >>           }
> >>   
> >> -        if (nb_numa_nodes > 1) {
> >> +        if (ms->numa_state->num_nodes > 1) {
> >>               ret = spapr_fixup_cpu_numa_dt(fdt, offset, cpu);
> >>               if (ret < 0) {
> >>                   return ret;
> >> @@ -351,9 +351,9 @@ static int spapr_fixup_cpu_dt(void *fdt, SpaprMachineState *spapr)
> >>   
> >>   static hwaddr spapr_node0_size(MachineState *machine)
> >>   {
> >> -    if (nb_numa_nodes) {
> >> +    if (machine->numa_state->num_nodes) {
> >>           int i;
> >> -        for (i = 0; i < nb_numa_nodes; ++i) {
> >> +        for (i = 0; i < machine->numa_state->num_nodes; ++i) {
> >>               if (numa_info[i].node_mem) {
> >>                   return MIN(pow2floor(numa_info[i].node_mem),
> >>                              machine->ram_size);
> >> @@ -398,13 +398,14 @@ static int spapr_populate_memory(SpaprMachineState *spapr, void *fdt)
> >>   {
> >>       MachineState *machine = MACHINE(spapr);
> >>       hwaddr mem_start, node_size;
> >> -    int i, nb_nodes = nb_numa_nodes;
> >> +    int i, nb_nodes = machine->numa_state->num_nodes;
> >>       NodeInfo *nodes = numa_info;
> >>       NodeInfo ramnode;
> >>   
> >>       /* No NUMA nodes, assume there is just one node with whole RAM */
> >> -    if (!nb_numa_nodes) {
> >> +    if (!nb_nodes) {
> >>           nb_nodes = 1;
> >> +        machine->numa_state->num_nodes = nb_nodes;
> > You've not addressed a v7 comment
> > On Tue, 23 Jul 2019 16:56:41 +0200
> > Igor Mammedov <imammedo@redhat.com> wrote:
> > 
> >> I don't like user fixing up generic machine data that came from CLI
> >> (or luck of such)
> > [...]
> >> I'd keep fixup local (i.e. using nb_nodes)
> > 
> > i.e. do not modify machine->numa_state->num_nodes and just use value local
> > like current code does.
> 
> But modify machine->numa_state->num_nodes can fix the issue:
> spapr_populate_memory() creates a implicit node and info
> temporarily but then spapr_validate_node_memory() will use
> global nb_numa_nodes which is 0 and skip check.

it's not related though, there is nothing wrong with fixing a bug
but it's typically done by separate patch with proper description.
(try not to mix unrelated things in one patch)

But otherwise as you noticed, it might be bug or feature in existing spapr impl,
and should be fixed by separate patch if necessary, CCing PPC folks.

PS:
we already have an implicit node creation in generic numa code (when memory hotplug
is enabled), so we probably could reuse that and a node should be created from there
instead of fixing up from the code deep within the board.

> Or if I should modify the check part, i.e.
> static void spapr_validate_node_memory(MachineState *machine, Error **errp)
> {
> [...]
>      for (i = 0; machine->numa_state->nodes[i] == NULL; i++) {
>          if (machine->numa_state->nodes[i].node_mem % 
> SPAPR_MEMORY_BLOCK_SIZE) {
>              error_setg(errp,
>                         "Node %d memory size 0x%" PRIx64
>                         " is not aligned to %" PRIu64 " MiB",
>                         i, machine->numa_state->nodes[i].node_mem,
>                         SPAPR_MEMORY_BLOCK_SIZE / MiB);)
> 
> > 
> >>           ramnode.node_mem = machine->ram_size;
> >>           nodes = &ramnode;
> >>       }
> > [...]
> > 
> 
> 


