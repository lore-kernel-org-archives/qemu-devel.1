Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A36C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 10:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BEF12070D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 10:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BEF12070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52001 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRE3p-0000TR-PM
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 06:56:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hRE2N-0007rX-TK
	for qemu-devel@nongnu.org; Thu, 16 May 2019 06:55:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hRE2M-0004FR-Ny
	for qemu-devel@nongnu.org; Thu, 16 May 2019 06:54:59 -0400
Received: from 5.mo5.mail-out.ovh.net ([87.98.173.103]:34440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hRE2M-0004DH-Gz
	for qemu-devel@nongnu.org; Thu, 16 May 2019 06:54:58 -0400
Received: from player714.ha.ovh.net (unknown [10.109.159.154])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 30689238251
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 12:54:54 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player714.ha.ovh.net (Postfix) with ESMTPSA id 9B88D5C26D61;
	Thu, 16 May 2019 10:54:46 +0000 (UTC)
Date: Thu, 16 May 2019 12:54:45 +0200
From: Greg Kurz <groug@kaod.org>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190516125445.79d0ba34@bahia.lan>
In-Reply-To: <155591662496.20338.3862565585716109724.stgit@aravinda>
References: <155591636364.20338.844048953355207313.stgit@aravinda>
	<155591662496.20338.3862565585716109724.stgit@aravinda>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 4718927985998797204
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddruddttddgfedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.173.103
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v8 6/6] migration: Block
 migration while handling machine check
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
Cc: aik@au1.ibm.com, qemu-devel@nongnu.org, paulus@ozlabs.org,
	qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 22 Apr 2019 12:33:45 +0530
Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:

> Block VM migration requests until the machine check
> error handling is complete as (i) these errors are
> specific to the source hardware and is irrelevant on
> the target hardware, (ii) these errors cause data
> corruption and should be handled before migration.
> 
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr_events.c  |   17 +++++++++++++++++
>  hw/ppc/spapr_rtas.c    |    4 ++++
>  include/hw/ppc/spapr.h |    3 +++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 4032db0..45b990c 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -41,6 +41,7 @@
>  #include "qemu/bcd.h"
>  #include "hw/ppc/spapr_ovec.h"
>  #include <libfdt.h>
> +#include "migration/blocker.h"
>  
>  #define RTAS_LOG_VERSION_MASK                   0xff000000
>  #define   RTAS_LOG_VERSION_6                    0x06000000
> @@ -864,6 +865,22 @@ static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
>  void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>  {
>      SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
> +    int ret;
> +    Error *local_err = NULL;
> +
> +    error_setg(&spapr->migration_blocker,
> +            "Live migration not supported during machine check handling");
> +    ret = migrate_add_blocker(spapr->migration_blocker, &local_err);

migrate_add_blocker() propagates the reason of the failure in local_err,
ie. because a migration is already in progress or --only-migratable was
passed on the QEMU command line, along with the error message passed in
the first argument. This means that...

> +    if (ret < 0) {
> +        /*
> +         * We don't want to abort and let the migration to continue. In a
> +         * rare case, the machine check handler will run on the target
> +         * hardware. Though this is not preferable, it is better than aborting
> +         * the migration or killing the VM.
> +         */
> +        error_free(spapr->migration_blocker);
> +        fprintf(stderr, "Warning: Machine check during VM migration\n");

... you should just do:

        error_report_err(local_err);

This also takes care of freeing local_err which would be leaked otherwise.

> +    }
>  
>      while (spapr->mc_status != -1) {
>          /*
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 997cf19..1229a0e 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -50,6 +50,7 @@
>  #include "target/ppc/mmu-hash64.h"
>  #include "target/ppc/mmu-book3s-v3.h"
>  #include "kvm_ppc.h"
> +#include "migration/blocker.h"
>  
>  static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineState *spapr,
>                                     uint32_t token, uint32_t nargs,
> @@ -396,6 +397,9 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
>          spapr->mc_status = -1;
>          qemu_cond_signal(&spapr->mc_delivery_cond);
>          rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> +        migrate_del_blocker(spapr->migration_blocker);
> +        error_free(spapr->migration_blocker);
> +        spapr->migration_blocker = NULL;
>      }
>  }
>  
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 9d16ad1..dda5fd2 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -10,6 +10,7 @@
>  #include "hw/ppc/spapr_irq.h"
>  #include "hw/ppc/spapr_xive.h"  /* For SpaprXive */
>  #include "hw/ppc/xics.h"        /* For ICSState */
> +#include "qapi/error.h"
>  
>  struct SpaprVioBus;
>  struct SpaprPhbState;
> @@ -213,6 +214,8 @@ struct SpaprMachineState {
>      SpaprCapabilities def, eff, mig;
>  
>      unsigned gpu_numa_id;
> +
> +    Error *migration_blocker;
>  };
>  
>  #define H_SUCCESS         0
> 
> 


