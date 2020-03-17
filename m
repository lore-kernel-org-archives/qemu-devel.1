Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CA1C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:58:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64BE620724
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64BE620724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEFYI-0004mY-GG
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jEFXE-0003GY-Sg
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:57:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jEFXD-0001Ck-H5
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:57:44 -0400
Received: from 13.mo1.mail-out.ovh.net ([178.33.253.128]:41147)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jEFXD-0000fz-8B
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:57:43 -0400
Received: from player159.ha.ovh.net (unknown [10.110.103.177])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id A899C1B5B75
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 17:57:40 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player159.ha.ovh.net (Postfix) with ESMTPSA id F3B5910815BC9;
 Tue, 17 Mar 2020 16:57:30 +0000 (UTC)
Date: Tue, 17 Mar 2020 17:57:24 +0100
From: Greg Kurz <groug@kaod.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 4/5] ppc/spapr: Don't kill the guest if a recovered
 FWNMI machine check delivery fails
Message-ID: <20200317175724.711884d5@bahia.lan>
In-Reply-To: <20200317050215.159334-5-npiggin@gmail.com>
References: <20200317050215.159334-1-npiggin@gmail.com>
 <20200317050215.159334-5-npiggin@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 109212294222617027
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudefhedgledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhduheelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.253.128
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@fr.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Mar 2020 15:02:14 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> Try to be tolerant of errors if the machine check had been recovered
> by the host.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Same comment as previous patch on multi-line error strings and
warn_report() in the !recovered case.

>  hw/ppc/spapr_events.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index d35151eeb0..3f524cb0ca 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -807,13 +807,20 @@ static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
>      /* get rtas addr from fdt */
>      rtas_addr = spapr_get_rtas_addr();
>      if (!rtas_addr) {
> -        warn_report("FWNMI: Unable to deliver machine check to guest: "
> -                    "rtas_addr not found.");
> -        qemu_system_guest_panicked(NULL);
> +        if (!recovered) {
> +            warn_report("FWNMI: Unable to deliver machine check to guest: "
> +                        "rtas_addr not found.");
> +            qemu_system_guest_panicked(NULL);
> +        } else {
> +            warn_report("FWNMI: Unable to deliver machine check to guest: "
> +                        "rtas_addr not found. Machine check recovered.");
> +        }
>          g_free(ext_elog);
>          return;
>      }
>  
> +    spapr->fwnmi_machine_check_interlock = cpu->vcpu_id;
> +

I don't understand this change.

>      stq_be_phys(&address_space_memory, rtas_addr + RTAS_ERROR_LOG_OFFSET,
>                  env->gpr[3]);
>      cpu_physical_memory_write(rtas_addr + RTAS_ERROR_LOG_OFFSET +
> @@ -850,9 +857,14 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>           * that CPU called "ibm,nmi-interlock")
>           */
>          if (spapr->fwnmi_machine_check_interlock == cpu->vcpu_id) {
> -            warn_report("FWNMI: Unable to deliver machine check to guest: "
> -                        "nested machine check.");
> -            qemu_system_guest_panicked(NULL);
> +            if (!recovered) {
> +                warn_report("FWNMI: Unable to deliver machine check to guest: "
> +                            "nested machine check.");
> +                qemu_system_guest_panicked(NULL);
> +            } else {
> +                warn_report("FWNMI: Unable to deliver machine check to guest: "
> +                            "nested machine check. Machine check recovered.");
> +            }
>              return;
>          }
>          qemu_cond_wait_iothread(&spapr->fwnmi_machine_check_interlock_cond);
> @@ -880,7 +892,6 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>          warn_report("Received a fwnmi while migration was in progress");
>      }
>  
> -    spapr->fwnmi_machine_check_interlock = cpu->vcpu_id;
>      spapr_mce_dispatch_elog(cpu, recovered);
>  }
>  


