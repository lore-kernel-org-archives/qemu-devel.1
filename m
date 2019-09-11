Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1404DECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:26:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5B8D2089F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B8D2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7x1m-0001Nb-1o
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 03:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1i7x15-0000pV-Qq
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1i7x14-00061M-BM
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:26:15 -0400
Received: from 4.mo1.mail-out.ovh.net ([46.105.76.26]:38349)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1i7x14-00060n-4l
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:26:14 -0400
Received: from player714.ha.ovh.net (unknown [10.109.159.191])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id CD59418EA9B
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 09:26:11 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player714.ha.ovh.net (Postfix) with ESMTPSA id C7CE499C7DD8;
 Wed, 11 Sep 2019 07:26:04 +0000 (UTC)
Date: Wed, 11 Sep 2019 09:26:03 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190911092603.0a3a4d7a@bahia.lan>
In-Reply-To: <20190911040452.8341-2-david@gibson.dropbear.id.au>
References: <20190911040452.8341-1-david@gibson.dropbear.id.au>
 <20190911040452.8341-2-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 11642649465367140838
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrtddugdduvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.76.26
Subject: Re: [Qemu-devel] [PATCH 1/7] spapr: Simplify handling of pre ISA
 3.0 guest workaround handling
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

On Wed, 11 Sep 2019 14:04:46 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> Certain old guest versions don't understand the radix MMU introduced with
> POWER ISA 3.0, but incorrectly select it if presented with the option at
> CAS time.  We workaround this in qemu by explicitly excluding the radix
> (and other ISA 3.0 linked) options if the guest doesn't explicitly note
> support for ISA 3.0.
> 
> This is handled by the 'cas_legacy_guest_workaround' flag, which is pretty
> vague.  Rename it to 'cas_pre_isa3_guest' to be clearer about what it's for.
> 
> In addition, we unnecessarily call spapr_populate_pa_features() with
> different options when initially constructing the device tree and when
> adjusting it at CAS time.  At the initial construct time cas_pre_isa3_guest
> is already false, so we can still use the flag, rather than explicitly
> overriding it to be false at the callsite.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c         | 10 ++++------
>  hw/ppc/spapr_hcall.c   |  3 +--
>  include/hw/ppc/spapr.h |  2 +-
>  3 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 7124053b43..c551001f86 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -218,8 +218,7 @@ static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, PowerPCCPU *cpu)
>  /* Populate the "ibm,pa-features" property */
>  static void spapr_populate_pa_features(SpaprMachineState *spapr,
>                                         PowerPCCPU *cpu,
> -                                       void *fdt, int offset,
> -                                       bool legacy_guest)
> +                                       void *fdt, int offset)
>  {
>      uint8_t pa_features_206[] = { 6, 0,
>          0xf6, 0x1f, 0xc7, 0x00, 0x80, 0xc0 };
> @@ -285,7 +284,7 @@ static void spapr_populate_pa_features(SpaprMachineState *spapr,
>      if ((spapr_get_cap(spapr, SPAPR_CAP_HTM) != 0) && pa_size > 24) {
>          pa_features[24] |= 0x80;    /* Transactional memory support */
>      }
> -    if (legacy_guest && pa_size > 40) {
> +    if (spapr->cas_pre_isa3_guest && pa_size > 40) {
>          /* Workaround for broken kernels that attempt (guest) radix
>           * mode when they can't handle it, if they see the radix bit set
>           * in pa-features. So hide it from them. */
> @@ -348,8 +347,7 @@ static int spapr_fixup_cpu_dt(void *fdt, SpaprMachineState *spapr)
>              return ret;
>          }
>  
> -        spapr_populate_pa_features(spapr, cpu, fdt, offset,
> -                                   spapr->cas_legacy_guest_workaround);
> +        spapr_populate_pa_features(spapr, cpu, fdt, offset);
>      }
>      return ret;
>  }
> @@ -551,7 +549,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
>                            page_sizes_prop, page_sizes_prop_size)));
>      }
>  
> -    spapr_populate_pa_features(spapr, cpu, fdt, offset, false);
> +    spapr_populate_pa_features(spapr, cpu, fdt, offset);
>  
>      _FDT((fdt_setprop_cell(fdt, offset, "ibm,chip-id",
>                             cs->cpu_index / vcpus_per_socket)));
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 23e4bdb829..3d3a67149a 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1765,8 +1765,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>              exit(EXIT_FAILURE);
>          }
>      }
> -    spapr->cas_legacy_guest_workaround = !spapr_ovec_test(ov1_guest,
> -                                                          OV1_PPC_3_00);
> +    spapr->cas_pre_isa3_guest = !spapr_ovec_test(ov1_guest, OV1_PPC_3_00);
>      spapr_ovec_cleanup(ov1_guest);
>      if (!spapr->cas_reboot) {
>          /* If spapr_machine_reset() did not set up a HPT but one is necessary
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 03111fd55b..dfec8e8e76 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -175,7 +175,7 @@ struct SpaprMachineState {
>  
>      /* ibm,client-architecture-support option negotiation */
>      bool cas_reboot;
> -    bool cas_legacy_guest_workaround;
> +    bool cas_pre_isa3_guest;
>      SpaprOptionVector *ov5;         /* QEMU-supported option vectors */
>      SpaprOptionVector *ov5_cas;     /* negotiated (via CAS) option vectors */
>      uint32_t max_compat_pvr;


