Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD86C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:18:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0531320801
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0531320801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iculy-0008F2-Bw
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 12:18:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1icuio-0005vr-Bt
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:15:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1icuim-0000SF-Vq
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:15:22 -0500
Received: from 5.mo3.mail-out.ovh.net ([87.98.178.36]:43035)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1icuim-0000IJ-Jv
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:15:20 -0500
Received: from player697.ha.ovh.net (unknown [10.108.54.34])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 2C19123128B
 for <qemu-devel@nongnu.org>; Thu,  5 Dec 2019 18:15:17 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player697.ha.ovh.net (Postfix) with ESMTPSA id C2B40CF94B30;
 Thu,  5 Dec 2019 17:15:09 +0000 (UTC)
Date: Thu, 5 Dec 2019 18:15:08 +0100
From: Greg Kurz <groug@kaod.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v7 07/21] ppc: well form kvmppc_hint_smt_possible error
 hint helper
Message-ID: <20191205181508.4c12927f@bahia.w3ibm.bluemix.net>
In-Reply-To: <20191205152019.8454-8-vsementsov@virtuozzo.com>
References: <20191205152019.8454-1-vsementsov@virtuozzo.com>
 <20191205152019.8454-8-vsementsov@virtuozzo.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 4261812626619865427
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudekuddguddttdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.178.36
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  5 Dec 2019 18:20:05 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> Make kvmppc_hint_smt_possible hint append helper well formed:
> rename errp to errp_in, as it is IN-parameter here (which is unusual
> for errp), rename function to be kvmppc_error_append_*_hint.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

The changelog needs to be amended. Apart from that:

Reviewed-by: Greg Kurz <groug@kaod.org>

>  target/ppc/kvm_ppc.h | 4 ++--
>  hw/ppc/spapr.c       | 2 +-
>  target/ppc/kvm.c     | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 98bd7d5da6..f22daabf51 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -28,7 +28,7 @@ void kvmppc_set_papr(PowerPCCPU *cpu);
>  int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
>  void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
>  int kvmppc_smt_threads(void);
> -void kvmppc_hint_smt_possible(Error **errp);
> +void kvmppc_error_append_smt_possible_hint(Error *const *errp);
>  int kvmppc_set_smt_threads(int smt);
>  int kvmppc_clear_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits);
>  int kvmppc_or_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits);
> @@ -164,7 +164,7 @@ static inline int kvmppc_smt_threads(void)
>      return 1;
>  }
>  
> -static inline void kvmppc_hint_smt_possible(Error **errp)
> +static inline void kvmppc_error_append_smt_possible_hint(Error *const *errp)
>  {
>      return;
>  }
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e076f6023c..1b87eb0ffd 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2564,7 +2564,7 @@ static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
>                                        " requires the use of VSMT mode %d.\n",
>                                        smp_threads, kvm_smt, spapr->vsmt);
>                  }
> -                kvmppc_hint_smt_possible(&local_err);
> +                kvmppc_error_append_smt_possible_hint(&local_err);
>                  goto out;
>              }
>          }
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index c77f9848ec..27ea3ce535 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2076,7 +2076,7 @@ int kvmppc_set_smt_threads(int smt)
>      return ret;
>  }
>  
> -void kvmppc_hint_smt_possible(Error **errp)
> +void kvmppc_error_append_smt_possible_hint(Error *const *errp)
>  {
>      int i;
>      GString *g;


