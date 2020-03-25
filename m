Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B9DC1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:25:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 318BF20772
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318BF20772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH9mv-0002B1-Ck
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 13:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jH9m1-0000ng-GL
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:25:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jH9m0-0003s9-C5
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:25:01 -0400
Received: from 3.mo3.mail-out.ovh.net ([46.105.44.175]:51181)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jH9lz-0003oK-0o
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:25:00 -0400
Received: from player731.ha.ovh.net (unknown [10.108.57.72])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id AF1D8248107
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 18:24:55 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player731.ha.ovh.net (Postfix) with ESMTPSA id 5F8251096C31A;
 Wed, 25 Mar 2020 17:24:45 +0000 (UTC)
Date: Wed, 25 Mar 2020 18:24:44 +0100
From: Greg Kurz <groug@kaod.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 3/4] ppc/spapr: Add FWNMI machine check delivery
 warnings
Message-ID: <20200325182444.4785d131@bahia.lan>
In-Reply-To: <20200325142906.221248-4-npiggin@gmail.com>
References: <20200325142906.221248-1-npiggin@gmail.com>
 <20200325142906.221248-4-npiggin@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 10657487044611971523
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudehgedgjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfedurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.44.175
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

On Thu, 26 Mar 2020 00:29:05 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> Add some messages which explain problems and guest misbehaviour that
> may be difficult to diagnose in rare cases of machine checks.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_events.c | 4 ++++
>  hw/ppc/spapr_rtas.c   | 3 +++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index a908c5d0e9..c8964eb25d 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -833,6 +833,8 @@ static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
>      /* get rtas addr from fdt */
>      rtas_addr = spapr_get_rtas_addr();
>      if (!rtas_addr) {
> +        error_report(
> +"FWNMI: Unable to deliver machine check to guest: rtas_addr not found.");
>          qemu_system_guest_panicked(NULL);
>          g_free(ext_elog);
>          return;
> @@ -874,6 +876,8 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>           * that CPU called "ibm,nmi-interlock")
>           */
>          if (spapr->fwnmi_machine_check_interlock == cpu->vcpu_id) {
> +            error_report(
> +"FWNMI: Unable to deliver machine check to guest: nested machine check.");
>              qemu_system_guest_panicked(NULL);
>              return;
>          }
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 29abe66d01..bcac0d00e7 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -462,6 +462,9 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
>      }
>  
>      if (spapr->fwnmi_machine_check_addr == -1) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +"FWNMI: ibm,nmi-interlock RTAS called with FWNMI not registered.\n");
> +
>          /* NMI register not called */
>          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>          return;


