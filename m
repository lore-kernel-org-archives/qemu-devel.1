Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA214ECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:34:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F81D208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F81D208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7x9G-0005Kb-Qq
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 03:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1i7x8b-0004q4-En
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:34:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1i7x8a-0000up-6S
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:34:01 -0400
Received: from 5.mo3.mail-out.ovh.net ([87.98.178.36]:47774)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1i7x8a-0000ty-1R
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:34:00 -0400
Received: from player789.ha.ovh.net (unknown [10.108.42.82])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 33D9322192E
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 09:33:57 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player789.ha.ovh.net (Postfix) with ESMTPSA id 106879A19CE2;
 Wed, 11 Sep 2019 07:33:50 +0000 (UTC)
Date: Wed, 11 Sep 2019 09:33:48 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190911093348.38381e49@bahia.lan>
In-Reply-To: <20190911040452.8341-3-david@gibson.dropbear.id.au>
References: <20190911040452.8341-1-david@gibson.dropbear.id.au>
 <20190911040452.8341-3-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 11773816804305705446
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrtddugdduvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.178.36
Subject: Re: [Qemu-devel] [PATCH 2/7] spapr: Move handling of special NVLink
 numa node from reset to init
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, clg@kaod.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Sep 2019 14:04:47 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> The number of NUMA nodes in the system is fixed from the command line.
> Therefore, there's no need to recalculate it at reset time, and we can
> determine the special gpu_numa_id value used for NVLink2 devices at init
> time.
> 
> This simplifies the reset path a bit which will make further improvements
> easier.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index c551001f86..e03e874d94 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1737,16 +1737,6 @@ static void spapr_machine_reset(MachineState *machine)
>          spapr_setup_hpt_and_vrma(spapr);
>      }
>  
> -    /*
> -     * NVLink2-connected GPU RAM needs to be placed on a separate NUMA node.
> -     * We assign a new numa ID per GPU in spapr_pci_collect_nvgpu() which is
> -     * called from vPHB reset handler so we initialize the counter here.
> -     * If no NUMA is configured from the QEMU side, we start from 1 as GPU RAM
> -     * must be equally distant from any other node.
> -     * The final value of spapr->gpu_numa_id is going to be written to
> -     * max-associativity-domains in spapr_build_fdt().
> -     */
> -    spapr->gpu_numa_id = MAX(1, machine->numa_state->num_nodes);
>      qemu_devices_reset();
>  
>      /*
> @@ -2885,6 +2875,17 @@ static void spapr_machine_init(MachineState *machine)
>  
>      }
>  
> +    /*
> +     * NVLink2-connected GPU RAM needs to be placed on a separate NUMA node.
> +     * We assign a new numa ID per GPU in spapr_pci_collect_nvgpu() which is
> +     * called from vPHB reset handler so we initialize the counter here.
> +     * If no NUMA is configured from the QEMU side, we start from 1 as GPU RAM
> +     * must be equally distant from any other node.
> +     * The final value of spapr->gpu_numa_id is going to be written to
> +     * max-associativity-domains in spapr_build_fdt().
> +     */
> +    spapr->gpu_numa_id = MAX(1, machine->numa_state->num_nodes);
> +
>      if ((!kvm_enabled() || kvmppc_has_cap_mmu_radix()) &&
>          ppc_type_check_compat(machine->cpu_type, CPU_POWERPC_LOGICAL_3_00, 0,
>                                spapr->max_compat_pvr)) {


