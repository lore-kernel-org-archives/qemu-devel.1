Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E26C3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 08:58:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D432520842
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 08:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D432520842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j93O9-0005Zf-UT
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 03:58:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j93NX-00054z-Gb
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 03:58:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j93NW-0005CF-85
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 03:58:15 -0500
Received: from 10.mo69.mail-out.ovh.net ([46.105.73.241]:52320)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j93NW-0005Be-1Z
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 03:58:14 -0500
Received: from player693.ha.ovh.net (unknown [10.110.171.215])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 9D95D86A16
 for <qemu-devel@nongnu.org>; Tue,  3 Mar 2020 09:58:11 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player693.ha.ovh.net (Postfix) with ESMTPSA id 5DDE0FF30B25;
 Tue,  3 Mar 2020 08:57:51 +0000 (UTC)
Date: Tue, 3 Mar 2020 09:57:43 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v7 10/17] target/ppc: Only calculate RMLS derived RMA
 limit on demand
Message-ID: <20200303095743.2cf29937@bahia.home>
In-Reply-To: <20200303034351.333043-11-david@gibson.dropbear.id.au>
References: <20200303034351.333043-1-david@gibson.dropbear.id.au>
 <20200303034351.333043-11-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 2027464261083896294
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedruddthedguddvgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelfedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.73.241
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>, farosas@linux.ibm.com,
 aik@ozlabs.ru, "Michael S.
 Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, clg@kaod.org, Igor Mammedov <imammedo@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  3 Mar 2020 14:43:44 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> When the LPCR is written, we update the env->rmls field with the RMA limit
> it implies.  Simplify things by just calculating the value directly from
> the LPCR value when we need it.
> 
> It's possible this is a little slower, but it's unlikely to be significant,
> since this is only for real mode accesses in a translation configuration
> that's not used very often, and the whole thing is behind the qemu TLB
> anyway.  Therefore, keeping the number of state variables down and not
> having to worry about making sure it's always in sync seems the better
> option.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  target/ppc/cpu.h        | 1 -
>  target/ppc/mmu-hash64.c | 9 ++++++---
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 8077fdb068..f9871b1233 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1046,7 +1046,6 @@ struct CPUPPCState {
>      uint64_t insns_flags2;
>  #if defined(TARGET_PPC64)
>      ppc_slb_t vrma_slb;
> -    target_ulong rmls;
>  #endif
>  
>      int error_code;
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index fcccaabb88..4fd7b7ee74 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -837,8 +837,10 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr,
>  
>              goto skip_slb_search;
>          } else {
> +            target_ulong limit = rmls_limit(cpu);
> +
>              /* Emulated old-style RMO mode, bounds check against RMLS */
> -            if (raddr >= env->rmls) {
> +            if (raddr >= limit) {
>                  if (rwx == 2) {
>                      ppc_hash64_set_isi(cs, SRR1_PROTFAULT);
>                  } else {
> @@ -1000,8 +1002,10 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong addr)
>                  return -1;
>              }
>          } else {
> +            target_ulong limit = rmls_limit(cpu);
> +
>              /* Emulated old-style RMO mode, bounds check against RMLS */
> -            if (raddr >= env->rmls) {
> +            if (raddr >= limit) {
>                  return -1;
>              }
>              return raddr | env->spr[SPR_RMOR];
> @@ -1091,7 +1095,6 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val)
>      CPUPPCState *env = &cpu->env;
>  
>      env->spr[SPR_LPCR] = val & pcc->lpcr_mask;
> -    env->rmls = rmls_limit(cpu);
>      ppc_hash64_update_vrma(cpu);
>  }
>  


