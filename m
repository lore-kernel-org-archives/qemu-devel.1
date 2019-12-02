Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5045C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 07:07:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91A6F2146E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 07:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A6F2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibfnf-0003hR-IJ
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 02:07:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35319)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ibfkl-0002Aa-9r
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 02:04:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ibfkj-0000Yt-EO
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 02:04:14 -0500
Received: from 10.mo69.mail-out.ovh.net ([46.105.73.241]:50158)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ibfkj-0000X6-7p
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 02:04:13 -0500
Received: from player157.ha.ovh.net (unknown [10.108.54.217])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 500B273065
 for <qemu-devel@nongnu.org>; Mon,  2 Dec 2019 08:04:09 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id D8C78CB3DBD0;
 Mon,  2 Dec 2019 07:04:01 +0000 (UTC)
Subject: Re: [for-5.0 4/4] spapr: Simplify ovec diff
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org
References: <20191129053356.232413-1-david@gibson.dropbear.id.au>
 <20191129053356.232413-5-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <28252087-426e-9986-1ffc-edf772f6050d@kaod.org>
Date: Mon, 2 Dec 2019 08:04:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191129053356.232413-5-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 13215813110076312384
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudejgedguddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrudehjedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: lvivier@redhat.com, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/11/2019 06:33, David Gibson wrote:
> spapr_ovec_diff(ov, old, new) has somewhat complex semantics.  ov is set
> to those bits which are in new but not old, and it returns as a boolean
> whether or not there are any bits in old but not new.
> 
> It turns out that both callers only care about the second, not the first.
> This is basically equivalent to a bitmap subset operation, which is easier
> to understand and implement.  So replace spapr_ovec_diff() with
> spapr_ovec_subset().
> 
> Cc: Mike Roth <mdroth@linux.vnet.ibm.com>
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>


Reviewed-by: Cedric Le Goater <clg@fr.ibm.com>

> ---
>  hw/ppc/spapr.c              | 14 +++-----------
>  hw/ppc/spapr_hcall.c        |  8 ++------
>  hw/ppc/spapr_ovec.c         | 30 ++++++++++--------------------
>  include/hw/ppc/spapr_ovec.h |  4 +---
>  4 files changed, 16 insertions(+), 40 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 5187f5b0a5..32e1cc1d3f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1840,8 +1840,6 @@ static bool spapr_ov5_cas_needed(void *opaque)
>  {
>      SpaprMachineState *spapr = opaque;
>      SpaprOptionVector *ov5_mask = spapr_ovec_new();
> -    SpaprOptionVector *ov5_legacy = spapr_ovec_new();
> -    SpaprOptionVector *ov5_removed = spapr_ovec_new();
>      bool cas_needed;
>  
>      /* Prior to the introduction of SpaprOptionVector, we had two option
> @@ -1873,17 +1871,11 @@ static bool spapr_ov5_cas_needed(void *opaque)
>      spapr_ovec_set(ov5_mask, OV5_DRCONF_MEMORY);
>      spapr_ovec_set(ov5_mask, OV5_DRMEM_V2);
>  
> -    /* spapr_ovec_diff returns true if bits were removed. we avoid using
> -     * the mask itself since in the future it's possible "legacy" bits may be
> -     * removed via machine options, which could generate a false positive
> -     * that breaks migration.
> -     */
> -    spapr_ovec_intersect(ov5_legacy, spapr->ov5, ov5_mask);
> -    cas_needed = spapr_ovec_diff(ov5_removed, spapr->ov5, ov5_legacy);
> +    /* We need extra information if we have any bits outside the mask
> +     * defined above */
> +    cas_needed = !spapr_ovec_subset(spapr->ov5, ov5_mask);
>  
>      spapr_ovec_cleanup(ov5_mask);
> -    spapr_ovec_cleanup(ov5_legacy);
> -    spapr_ovec_cleanup(ov5_removed);
>  
>      return cas_needed;
>  }
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 0f19be794c..f1799b1b70 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1671,7 +1671,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>      target_ulong fdt_bufsize = args[2];
>      target_ulong ov_table;
>      uint32_t cas_pvr;
> -    SpaprOptionVector *ov1_guest, *ov5_guest, *ov5_cas_old, *ov5_updates;
> +    SpaprOptionVector *ov1_guest, *ov5_guest, *ov5_cas_old;
>      bool guest_radix;
>      Error *local_err = NULL;
>      bool raw_mode_supported = false;
> @@ -1770,9 +1770,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>      /* capabilities that have been added since CAS-generated guest reset.
>       * if capabilities have since been removed, generate another reset
>       */
> -    ov5_updates = spapr_ovec_new();
> -    spapr->cas_reboot = spapr_ovec_diff(ov5_updates,
> -                                        ov5_cas_old, spapr->ov5_cas);
> +    spapr->cas_reboot = !spapr_ovec_subset(ov5_cas_old, spapr->ov5_cas);
>      spapr_ovec_cleanup(ov5_cas_old);
>      /* Now that processing is finished, set the radix/hash bit for the
>       * guest if it requested a valid mode; otherwise terminate the boot. */
> @@ -1849,8 +1847,6 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>          spapr->fdt_blob = fdt;
>      }
>  
> -    spapr_ovec_cleanup(ov5_updates);
> -
>      if (spapr->cas_reboot) {
>          qemu_system_reset_request(SHUTDOWN_CAUSE_SUBSYSTEM_RESET);
>      }
> diff --git a/hw/ppc/spapr_ovec.c b/hw/ppc/spapr_ovec.c
> index 811fadf143..0ff6d1aeae 100644
> --- a/hw/ppc/spapr_ovec.c
> +++ b/hw/ppc/spapr_ovec.c
> @@ -76,31 +76,21 @@ void spapr_ovec_intersect(SpaprOptionVector *ov,
>      bitmap_and(ov->bitmap, ov1->bitmap, ov2->bitmap, OV_MAXBITS);
>  }
>  
> -/* returns true if options bits were removed, false otherwise */
> -bool spapr_ovec_diff(SpaprOptionVector *ov,
> -                     SpaprOptionVector *ov_old,
> -                     SpaprOptionVector *ov_new)
> +/* returns true if ov1 has a subset of bits in ov2 */
> +bool spapr_ovec_subset(SpaprOptionVector *ov1, SpaprOptionVector *ov2)
>  {
> -    unsigned long *change_mask = bitmap_new(OV_MAXBITS);
> -    unsigned long *removed_bits = bitmap_new(OV_MAXBITS);
> -    bool bits_were_removed = false;
> +    unsigned long *tmp = bitmap_new(OV_MAXBITS);
> +    bool result;
>  
> -    g_assert(ov);
> -    g_assert(ov_old);
> -    g_assert(ov_new);
> -
> -    bitmap_xor(change_mask, ov_old->bitmap, ov_new->bitmap, OV_MAXBITS);
> -    bitmap_and(ov->bitmap, ov_new->bitmap, change_mask, OV_MAXBITS);
> -    bitmap_and(removed_bits, ov_old->bitmap, change_mask, OV_MAXBITS);
> +    g_assert(ov1);
> +    g_assert(ov2);
>  
> -    if (!bitmap_empty(removed_bits, OV_MAXBITS)) {
> -        bits_were_removed = true;
> -    }
> +    bitmap_andnot(tmp, ov1->bitmap, ov2->bitmap, OV_MAXBITS);
> +    result = bitmap_empty(tmp, OV_MAXBITS);
>  
> -    g_free(change_mask);
> -    g_free(removed_bits);
> +    g_free(tmp);
>  
> -    return bits_were_removed;
> +    return result;
>  }
>  
>  void spapr_ovec_cleanup(SpaprOptionVector *ov)
> diff --git a/include/hw/ppc/spapr_ovec.h b/include/hw/ppc/spapr_ovec.h
> index 7891e9caac..2bed517a2b 100644
> --- a/include/hw/ppc/spapr_ovec.h
> +++ b/include/hw/ppc/spapr_ovec.h
> @@ -66,9 +66,7 @@ SpaprOptionVector *spapr_ovec_clone(SpaprOptionVector *ov_orig);
>  void spapr_ovec_intersect(SpaprOptionVector *ov,
>                            SpaprOptionVector *ov1,
>                            SpaprOptionVector *ov2);
> -bool spapr_ovec_diff(SpaprOptionVector *ov,
> -                     SpaprOptionVector *ov_old,
> -                     SpaprOptionVector *ov_new);
> +bool spapr_ovec_subset(SpaprOptionVector *ov1, SpaprOptionVector *ov2);
>  void spapr_ovec_cleanup(SpaprOptionVector *ov);
>  void spapr_ovec_set(SpaprOptionVector *ov, long bitnr);
>  void spapr_ovec_clear(SpaprOptionVector *ov, long bitnr);
> 


