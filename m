Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A03C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:20:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A39B20735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A39B20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEBDL-0000xN-FD
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 08:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jEB9v-0004xs-0O
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:17:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jEB9t-0003Pa-MB
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:17:22 -0400
Received: from 3.mo178.mail-out.ovh.net ([46.105.44.197]:59374)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jEB9t-0003L8-F4
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:17:21 -0400
Received: from player798.ha.ovh.net (unknown [10.110.208.168])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 5C17795046
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 13:17:19 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player798.ha.ovh.net (Postfix) with ESMTPSA id A44A5109DE53E;
 Tue, 17 Mar 2020 12:17:02 +0000 (UTC)
Date: Tue, 17 Mar 2020 13:16:55 +0100
From: Greg Kurz <groug@kaod.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/5] ppc/spapr: Improve FWNMI machine check delivery
 corner case comments
Message-ID: <20200317125420.79fe2432@bahia.lan>
In-Reply-To: <20200317050215.159334-3-npiggin@gmail.com>
References: <20200317050215.159334-1-npiggin@gmail.com>
 <20200317050215.159334-3-npiggin@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 13821265783635220931
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudefhedgfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.44.197
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
 Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@fr.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Mar 2020 15:02:12 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> Some of the conditions are not as clearly documented as they could be.
> Also the non-FWNMI case does not need a large comment.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

LGTM

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_events.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 323fcef4aa..05337f0671 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -834,17 +834,13 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>      Error *local_err = NULL;
>  
>      if (spapr->fwnmi_machine_check_addr == -1) {
> -        /*
> -         * This implies that we have hit a machine check either when the
> -         * guest has not registered FWNMI (i.e., "ibm,nmi-register" not
> -         * called) or between system reset and "ibm,nmi-register".
> -         * Fall back to the old machine check behavior in such cases.
> -         */
> +        /* Non-FWNMI case, deliver it like an architected CPU interrupt. */
>          cs->exception_index = POWERPC_EXCP_MCHECK;
>          ppc_cpu_do_interrupt(cs);
>          return;
>      }
>  
> +    /* Wait for FWNMI interlock. */
>      while (spapr->fwnmi_machine_check_interlock != -1) {
>          /*
>           * Check whether the same CPU got machine check error
> @@ -856,8 +852,13 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>              return;
>          }
>          qemu_cond_wait_iothread(&spapr->fwnmi_machine_check_interlock_cond);
> -        /* Meanwhile if the system is reset, then just return */
>          if (spapr->fwnmi_machine_check_addr == -1) {
> +            /*
> +             * If the machine was reset while waiting for the interlock,
> +             * abort the delivery. The machine check applies to a context
> +             * that no longer exists, so it wouldn't make sense to deliver
> +             * it now.
> +             */
>              return;
>          }
>      }
> @@ -868,7 +869,9 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>           * We don't want to abort so we let the migration to continue.
>           * In a rare case, the machine check handler will run on the target.
>           * Though this is not preferable, it is better than aborting
> -         * the migration or killing the VM.
> +         * the migration or killing the VM. It is okay to call
> +         * migrate_del_blocker on a blocker that was not added (which the
> +         * nmi-interlock handler would do when it's called after this).
>           */
>          warn_report("Received a fwnmi while migration was in progress");
>      }


