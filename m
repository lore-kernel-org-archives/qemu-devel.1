Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F71C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 08:57:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DEA02231B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 08:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DEA02231B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibhW4-0004Jj-HN
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 03:57:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50153)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ibhV5-0003Di-40
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 03:56:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ibhV3-0003CM-Ph
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 03:56:11 -0500
Received: from 8.mo178.mail-out.ovh.net ([46.105.74.227]:46744)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ibhV3-0003BY-Jq
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 03:56:09 -0500
Received: from player735.ha.ovh.net (unknown [10.108.1.162])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id A012084424
 for <qemu-devel@nongnu.org>; Mon,  2 Dec 2019 09:56:06 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player735.ha.ovh.net (Postfix) with ESMTPSA id 77131CB35FA3;
 Mon,  2 Dec 2019 08:55:57 +0000 (UTC)
Date: Mon, 2 Dec 2019 09:55:51 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [for-5.0 1/4] spapr,ppc: Simplify signature of kvmppc_rma_size()
Message-ID: <20191202095551.2ca7beb7@bahia.w3ibm.bluemix.net>
In-Reply-To: <20191129013504.145455-2-david@gibson.dropbear.id.au>
References: <20191129013504.145455-1-david@gibson.dropbear.id.au>
 <20191129013504.145455-2-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 15106762001723529702
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudejgedguddvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.74.227
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
Cc: aik@ozlabs.ru, lvivier@redhat.com, qemu-ppc@nongnu.org, clg@kaod.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 Nov 2019 12:35:01 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> This function calculates the maximum size of the RMA as implied by the
> host's page size of structure of the VRMA (there are a number of other
> constraints on the RMA size which will supersede this one in many
> circumstances).
> 
> The current interface takes the current RMA size estimate, and clamps it
> to the VRMA derived size.  The only current caller passes in an arguably
> wrong value (it will match the current RMA estimate in some but not all
> cases).
> 
> We want to fix that, but for now just keep concerns separated by having the
> KVM helper function just return the VRMA derived limit, and let the caller
> combine it with other constraints.  We call the new function
> kvmppc_vrma_limit() to more clearly indicate its limited responsibility.
> 
> The helper should only ever be called in the KVM enabled case, so replace
> its !CONFIG_KVM stub with an assert() rather than a dummy value.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c       | 5 +++--
>  target/ppc/kvm.c     | 5 ++---
>  target/ppc/kvm_ppc.h | 7 +++----
>  3 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index d9c9a2bcee..069bd04a8d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1635,8 +1635,9 @@ void spapr_setup_hpt_and_vrma(SpaprMachineState *spapr)
>      spapr_reallocate_hpt(spapr, hpt_shift, &error_fatal);
>  
>      if (spapr->vrma_adjust) {
> -        spapr->rma_size = kvmppc_rma_size(spapr_node0_size(MACHINE(spapr)),
> -                                          spapr->htab_shift);
> +        hwaddr vrma_limit = kvmppc_vrma_limit(spapr->htab_shift);
> +
> +        spapr->rma_size = MIN(spapr_node0_size(MACHINE(spapr)), vrma_limit);
>      }
>  }
>  
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index c77f9848ec..09b3bd6443 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2101,7 +2101,7 @@ void kvmppc_hint_smt_possible(Error **errp)
>  
>  
>  #ifdef TARGET_PPC64
> -uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shift)
> +uint64_t kvmppc_vrma_limit(unsigned int hash_shift)
>  {
>      struct kvm_ppc_smmu_info info;
>      long rampagesize, best_page_shift;
> @@ -2128,8 +2128,7 @@ uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shift)
>          }
>      }
>  
> -    return MIN(current_size,
> -               1ULL << (best_page_shift + hash_shift - 7));
> +    return 1ULL << (best_page_shift + hash_shift - 7));
>  }
>  #endif
>  
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 98bd7d5da6..4f0eec4c1b 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -45,7 +45,7 @@ void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t page_shift,
>                                int *pfd, bool need_vfio);
>  int kvmppc_remove_spapr_tce(void *table, int pfd, uint32_t window_size);
>  int kvmppc_reset_htab(int shift_hint);
> -uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shift);
> +uint64_t kvmppc_vrma_limit(unsigned int hash_shift);
>  bool kvmppc_has_cap_spapr_vfio(void);
>  #endif /* !CONFIG_USER_ONLY */
>  bool kvmppc_has_cap_epr(void);
> @@ -241,10 +241,9 @@ static inline int kvmppc_reset_htab(int shift_hint)
>      return 0;
>  }
>  
> -static inline uint64_t kvmppc_rma_size(uint64_t current_size,
> -                                       unsigned int hash_shift)
> +static inline uint64_t kvmppc_vrma_limit(unsigned int hash_shift)
>  {
> -    return ram_size;
> +    g_assert_not_reached();
>  }
>  
>  static inline bool kvmppc_hpt_needs_host_contiguous_pages(void)


