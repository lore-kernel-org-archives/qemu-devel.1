Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F32C2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 18:14:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EED720777
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 18:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EED720777
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHAYA-0000zQ-AY
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 14:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jHAXC-0000S4-CG
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 14:13:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jHAXB-0002bF-0M
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 14:13:46 -0400
Received: from 5.mo6.mail-out.ovh.net ([46.105.54.31]:44252)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jHAXA-0002Z0-QK
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 14:13:44 -0400
Received: from player732.ha.ovh.net (unknown [10.108.35.210])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id A0D2D205D52
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 19:13:42 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player732.ha.ovh.net (Postfix) with ESMTPSA id 7AABE10AC1B23;
 Wed, 25 Mar 2020 18:13:33 +0000 (UTC)
Date: Wed, 25 Mar 2020 19:13:32 +0100
From: Greg Kurz <groug@kaod.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 4/4] ppc/spapr: Don't kill the guest if a recovered
 FWNMI machine check delivery fails
Message-ID: <20200325191332.7da79231@bahia.lan>
In-Reply-To: <20200325142906.221248-5-npiggin@gmail.com>
References: <20200325142906.221248-1-npiggin@gmail.com>
 <20200325142906.221248-5-npiggin@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 11481364302928124355
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudehgedgkeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.54.31
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

On Thu, 26 Mar 2020 00:29:06 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> Try to be tolerant of FWNMI delivery errors if the machine check had been
> recovered by the host.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/ppc/spapr_events.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index c8964eb25d..b90ecb8afe 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -833,13 +833,25 @@ static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
>      /* get rtas addr from fdt */
>      rtas_addr = spapr_get_rtas_addr();
>      if (!rtas_addr) {
> -        error_report(
> +        if (!recovered) {
> +            error_report(
>  "FWNMI: Unable to deliver machine check to guest: rtas_addr not found.");
> -        qemu_system_guest_panicked(NULL);
> +            qemu_system_guest_panicked(NULL);
> +        } else {
> +            warn_report(
> +"FWNMI: Unable to deliver machine check to guest: rtas_addr not found. "
> +"Machine check recovered.");
> +        }
>          g_free(ext_elog);
>          return;
>      }
>  
> +    /*
> +     * Must not set interlock if the MCE does not get delivered to the guest
> +     * in the error case above.
> +     */

It is a bit confusing to read "must not set interlock" and to see the
interlock being set the line below IM-non-native-speaker-HO... also
a small clarification of the outcome of taking the interlock without
delivering the MCE could help people who aren't familiar with FWNMI
to avoid doing bad things.

What about something like the following ?

    /*
     * By taking the interlock, we assume that the MCE will be
     * delivered to the guest. CAUTION: don't add anything that
     * could prevent the MCE to be delivered after this line,
     * otherwise the guest won't be able to release the interlock
     * and ultimately hang/crash?
     */

> +    spapr->fwnmi_machine_check_interlock = cpu->vcpu_id;
> +

For improved paranoia, this could even be done just before calling
ppc_cpu_do_fwnmi_machine_check().

Anyway, the change is good enough so:

Reviewed-by: Greg Kurz <groug@kaod.org>

>      stq_be_phys(&address_space_memory, rtas_addr + RTAS_ERROR_LOG_OFFSET,
>                  env->gpr[3]);
>      cpu_physical_memory_write(rtas_addr + RTAS_ERROR_LOG_OFFSET +
> @@ -876,9 +888,15 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>           * that CPU called "ibm,nmi-interlock")
>           */
>          if (spapr->fwnmi_machine_check_interlock == cpu->vcpu_id) {
> -            error_report(
> +            if (!recovered) {
> +                error_report(
>  "FWNMI: Unable to deliver machine check to guest: nested machine check.");
> -            qemu_system_guest_panicked(NULL);
> +                qemu_system_guest_panicked(NULL);
> +            } else {
> +                warn_report(
> +"FWNMI: Unable to deliver machine check to guest: nested machine check. "
> +"Machine check recovered.");
> +            }
>              return;
>          }
>          qemu_cond_wait_iothread(&spapr->fwnmi_machine_check_interlock_cond);
> @@ -906,7 +924,6 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>          warn_report("Received a fwnmi while migration was in progress");
>      }
>  
> -    spapr->fwnmi_machine_check_interlock = cpu->vcpu_id;
>      spapr_mce_dispatch_elog(cpu, recovered);
>  }
>  


