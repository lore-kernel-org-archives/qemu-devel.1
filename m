Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7804DC7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 16:29:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43F3F206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 16:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F3F206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnQKF-0000xi-Hp
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 12:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52229)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hnQK3-0000VK-W9
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:29:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hnQK2-0000xB-NN
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:28:59 -0400
Received: from 5.mo178.mail-out.ovh.net ([46.105.51.53]:35677)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hnQK2-0000rA-Fx
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:28:58 -0400
Received: from player760.ha.ovh.net (unknown [10.108.42.176])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 2307A6D27C
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 18:28:48 +0200 (CEST)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: groug@kaod.org)
 by player760.ha.ovh.net (Postfix) with ESMTPSA id 966CB8035276;
 Tue, 16 Jul 2019 16:28:44 +0000 (UTC)
Date: Tue, 16 Jul 2019 18:28:42 +0200
From: Greg Kurz <groug@kaod.org>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Message-ID: <20190716182842.0874b2bf@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <156326547324.51324.17260886524634041718.stgit@lep8c.aus.stglabs.ibm.com>
References: <156326547324.51324.17260886524634041718.stgit@lep8c.aus.stglabs.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 18104470503767120213
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddriedtgddutdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.51.53
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] ppc: Fix some memory leaks
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jul 2019 03:24:57 -0500
Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:

> valgrind showed some memory leaks while running qemu-system-ppc64.
> Fixing them in this patch.
> 

Since this covers many unrelated code paths, I think it would be better to
make this a series of separate patches, rather than one patch.

> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> ---
>  hw/ppc/spapr_caps.c  |    2 ++
>  hw/ppc/spapr_drc.c   |    5 ++++-
>  hw/ppc/spapr_hcall.c |    2 ++
>  target/ppc/kvm.c     |    3 ++-
>  4 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index bbb001f84a..8e3350f777 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -786,11 +786,13 @@ void spapr_caps_add_properties(SpaprMachineClass *smc, Error **errp)
>                                    NULL, cap, &local_err);
>          if (local_err) {
>              error_propagate(errp, local_err);
> +            g_free((char *)name);

Like Richard indicated in another mail, this is wrong : 'const char *'
means that the string is constant forever. If you have to free it, then
it shouldn't be const in the first place.

>              return;
>          }
>  
>          desc = g_strdup_printf("%s", cap->description);
>          object_class_property_set_description(klass, name, desc, &local_err);
> +        g_free((char *)name);
>          g_free(desc);
>          if (local_err) {
>              error_propagate(errp, local_err);
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index bacadfcac5..37fbfe6900 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -827,6 +827,7 @@ int spapr_dt_drc(void *fdt, int offset, Object *owner, uint32_t drc_type_mask)
>          Object *obj;
>          SpaprDrc *drc;
>          SpaprDrcClass *drck;
> +        const char *drc_name = NULL;

Same here.

>          uint32_t drc_index, drc_power_domain;
>  
>          if (!strstart(prop->type, "link<", NULL)) {
> @@ -856,8 +857,10 @@ int spapr_dt_drc(void *fdt, int offset, Object *owner, uint32_t drc_type_mask)
>          g_array_append_val(drc_power_domains, drc_power_domain);
>  
>          /* ibm,drc-names */
> -        drc_names = g_string_append(drc_names, spapr_drc_name(drc));
> +        drc_name = spapr_drc_name(drc);
> +        drc_names = g_string_append(drc_names, drc_name);
>          drc_names = g_string_insert_len(drc_names, -1, "\0", 1);
> +        g_free((char *)drc_name);
>  
>          /* ibm,drc-types */
>          drc_types = g_string_append(drc_types, drck->typename);
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 6808d4cda8..0fc58156a0 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1612,6 +1612,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>      ov5_updates = spapr_ovec_new();
>      spapr->cas_reboot = spapr_ovec_diff(ov5_updates,
>                                          ov5_cas_old, spapr->ov5_cas);
> +    spapr_ovec_cleanup(ov5_cas_old);
>      /* Now that processing is finished, set the radix/hash bit for the
>       * guest if it requested a valid mode; otherwise terminate the boot. */
>      if (guest_radix) {
> @@ -1640,6 +1641,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>              (spapr_h_cas_compose_response(spapr, args[1], args[2],
>                                            ov5_updates) != 0);
>      }
> +    spapr_ovec_cleanup(ov1_guest);
>  

Maybe a few lines ealier, just after its last user:

    spapr->cas_legacy_guest_workaround = !spapr_ovec_test(ov1_guest,
                                                          OV1_PPC_3_00);

>      /*
>       * Ensure the guest asks for an interrupt mode we support; otherwise
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 8a06d3171e..498ca6d53b 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -491,7 +491,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          return ret;
>      }
>  
> -    idle_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, kvm_kick_cpu, cpu);
> +    if (!idle_timer)
> +        idle_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, kvm_kick_cpu, cpu);
>  

Yikes... idle_timer is a static but it is used by all vcpus... it looks
like it's a bug.

>      switch (cenv->mmu_model) {
>      case POWERPC_MMU_BOOKE206:
> 
> 


