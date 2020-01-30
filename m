Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AB4C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 08:49:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FFC3206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 08:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FFC3206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix5WJ-0000oX-MN
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 03:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ix5Vh-0008VT-4v
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 03:49:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ix5Vf-0001Il-Gg
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 03:49:12 -0500
Received: from 1.mo1.mail-out.ovh.net ([178.32.127.22]:33938)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ix5Vf-0001IG-9z
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 03:49:11 -0500
Received: from player786.ha.ovh.net (unknown [10.110.171.131])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id AC5DE1A948E
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 09:49:08 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player786.ha.ovh.net (Postfix) with ESMTPSA id B3323EF40310;
 Thu, 30 Jan 2020 08:48:55 +0000 (UTC)
Date: Thu, 30 Jan 2020 09:48:49 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] spapr: Enable DD2.3 accelerated count cache flush in
 pseries-5.0 machine
Message-ID: <20200130094849.03194668@bahia.lan>
In-Reply-To: <20200130012622.8564-1-david@gibson.dropbear.id.au>
References: <20200130012622.8564-1-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 10989908993951570406
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrfeejgdduvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejfedtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.127.22
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, mpe@ellerman.id.au,
 qemu-devel@nongnu.org, paulus@ozlabs.org, qemu-ppc@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Jan 2020 12:26:22 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> For POWER9 DD2.2 cpus, the best current Spectre v2 indirect branch
> mitigation is "count cache disabled", which is configured with:
>     -machine cap-ibs=fixed-ccd
> However, this option isn't available on DD2.3 CPUs with KVM, because they
> don't have the count cache disabled.
> 
> For POWER9 DD2.3 cpus, it is "count cache flush with assist", configured
> with:
>     -machine cap-ibs=workaround,cap-ccf-assist=on
> However this option isn't available on DD2.2 CPUs with KVM, because they
> don't have the special CCF assist instruction this relies on.
> 
> On current machine types, we default to "count cache flush w/o assist",
> that is:
>     -machine cap-ibs=workaround,cap-ccf-assist=off
> This runs, with mitigation on both DD2.2 and DD2.3 host cpus, but has a
> fairly significant performance impact.
> 
> It turns out we can do better.  The special instruction that CCF assist
> uses to trigger a count cache flush is a no-op on earlier CPUs, rather than
> trapping or causing other badness.  It doesn't, of itself, implement the
> mitigation, but *if* we have count-cache-disabled, then the count cache
> flush is unnecessary, and so using the count cache flush mitigation is
> harmless.
> 
> Therefore for the new pseries-5.0 machine type, enable cap-ccf-assist by
> default.  Along with that, suppress throwing an error if cap-ccf-assist
> is selected but KVM doesn't support it, as long as KVM *is* giving us
> count-cache-disabled.  To allow TCG to work out of the box, even though it
> doesn't implement the ccf flush assist, downgrade the error in that case to
> a warning.  This matches several Spectre mitigations where we allow TCG
> to operate for debugging, since we don't really make guarantees about TCG
> security properties anyway.
> 
> While we're there, make the TCG warning for this case match that for other
> mitigations.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c      |  5 ++++-
>  hw/ppc/spapr_caps.c | 26 ++++++++++++++++++++++----
>  2 files changed, 26 insertions(+), 5 deletions(-)
> 
> I have put this into my ppc-for-5.0 tree already, and hope to send a
> pull request tomorrow (Jan 31).
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 02cf53fc5b..deaa44f1ab 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4397,7 +4397,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>      smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] = 16; /* 64kiB */
>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
> -    smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_OFF;
> +    smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_ON;
>      spapr_caps_add_properties(smc, &error_abort);
>      smc->irq = &spapr_irq_dual;
>      smc->dr_phb_enabled = true;
> @@ -4465,8 +4465,11 @@ DEFINE_SPAPR_MACHINE(5_0, "5.0", true);
>   */
>  static void spapr_machine_4_2_class_options(MachineClass *mc)
>  {
> +    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
> +
>      spapr_machine_5_0_class_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
> +    smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_OFF;
>  }
>  
>  DEFINE_SPAPR_MACHINE(4_2, "4.2", false);
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 481dfd2a27..d0d4b32a40 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -482,18 +482,36 @@ static void cap_large_decr_cpu_apply(SpaprMachineState *spapr,
>  static void cap_ccf_assist_apply(SpaprMachineState *spapr, uint8_t val,
>                                   Error **errp)
>  {
> +    Error *local_err = NULL;
>      uint8_t kvm_val = kvmppc_get_cap_count_cache_flush_assist();
>  
>      if (tcg_enabled() && val) {
> -        /* TODO - for now only allow broken for TCG */
> -        error_setg(errp,
> -"Requested count cache flush assist capability level not supported by tcg,"
> -                   " try appending -machine cap-ccf-assist=off");
> +        /* TCG doesn't implement anything here, but allow with a warning */
> +        error_setg(&local_err,
> +                   "TCG doesn't support requested feature, cap-ccf-assist=on");

The only user for local_err is warn_report_err() below. It would be simpler to
simply call warn_report() here.

>      } else if (kvm_enabled() && (val > kvm_val)) {
> +        uint8_t kvm_ibs = kvmppc_get_cap_safe_indirect_branch();
> +
> +        if (kvm_ibs == SPAPR_CAP_FIXED_CCD) {
> +            /*
> +             * If we don't have CCF assist on the host, the assist
> +             * instruction is a harmless no-op.  It won't correctly
> +             * implement the cache count flush *but* if we have
> +             * count-cache-disabled in the host, that flush is
> +             * unnnecessary.  So, specifically allow this case.  This
> +             * allows us to have better performance on POWER9 DD2.3,
> +             * while still working on POWER9 DD2.2 and POWER8 host
> +             * cpus.
> +             */
> +            return;
> +        }
>          error_setg(errp,
>  "Requested count cache flush assist capability level not supported by kvm,"
>                     " try appending -machine cap-ccf-assist=off");
>      }
> +
> +    if (local_err != NULL)
> +        warn_report_err(local_err);
>  }
>  
>  SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {


