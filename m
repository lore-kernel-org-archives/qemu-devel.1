Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3BDC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E2CC20735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2CC20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEBF3-0002VQ-FN
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 08:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jEBDg-0001PT-CO
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jEBDf-0004py-CS
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:21:16 -0400
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:35890)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jEBDf-0004fX-4D
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:21:15 -0400
Received: from player158.ha.ovh.net (unknown [10.108.54.209])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 994FD15E2A5
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 13:21:13 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player158.ha.ovh.net (Postfix) with ESMTPSA id 29F53107B3D07;
 Tue, 17 Mar 2020 12:20:58 +0000 (UTC)
Date: Tue, 17 Mar 2020 13:20:57 +0100
From: Greg Kurz <groug@kaod.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 3/5] ppc/spapr: Add FWNMI machine check delivery warnings
Message-ID: <20200317132057.37296abc@bahia.lan>
In-Reply-To: <20200317050215.159334-4-npiggin@gmail.com>
References: <20200317050215.159334-1-npiggin@gmail.com>
 <20200317050215.159334-4-npiggin@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 13887130928437107139
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudefhedgfeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhduheekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.56.76
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

On Tue, 17 Mar 2020 15:02:13 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> Add some messages which explain problems and guest misbehaviour that
> may be difficult to diagnose in rare cases of machine checks.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/ppc/spapr_events.c | 4 ++++
>  hw/ppc/spapr_rtas.c   | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 05337f0671..d35151eeb0 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -807,6 +807,8 @@ static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
>      /* get rtas addr from fdt */
>      rtas_addr = spapr_get_rtas_addr();
>      if (!rtas_addr) {
> +        warn_report("FWNMI: Unable to deliver machine check to guest: "
> +                    "rtas_addr not found.");

Why a warning and not an error ?

Also maybe change the string to fit on one line ?

>          qemu_system_guest_panicked(NULL);
>          g_free(ext_elog);
>          return;
> @@ -848,6 +850,8 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>           * that CPU called "ibm,nmi-interlock")
>           */
>          if (spapr->fwnmi_machine_check_interlock == cpu->vcpu_id) {
> +            warn_report("FWNMI: Unable to deliver machine check to guest: "
> +                        "nested machine check.");

Ditto.

>              qemu_system_guest_panicked(NULL);
>              return;
>          }
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 29abe66d01..12cd09701c 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -462,6 +462,10 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
>      }
>  
>      if (spapr->fwnmi_machine_check_addr == -1) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "FWNMI: ibm,nmi-interlock RTAS called with FWNMI not "
> +                       "registered.\n");

whitespace damage here   ^ best fixed by making the message a one liner.

> +
>          /* NMI register not called */
>          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>          return;


