Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DB3C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 07:51:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9B12215E5
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 07:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B12215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibgUQ-0005Rf-Qe
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 02:51:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ibgTV-0004u3-IE
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 02:50:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ibgTU-0006DX-83
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 02:50:29 -0500
Received: from 2.mo4.mail-out.ovh.net ([46.105.72.36]:54340)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ibgTU-00069Y-1k
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 02:50:28 -0500
Received: from player714.ha.ovh.net (unknown [10.108.54.67])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id AA66021418D
 for <qemu-devel@nongnu.org>; Mon,  2 Dec 2019 08:50:18 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player714.ha.ovh.net (Postfix) with ESMTPSA id B45AACB4C370;
 Mon,  2 Dec 2019 07:50:10 +0000 (UTC)
Date: Mon, 2 Dec 2019 08:50:09 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [for-5.0 1/4] spapr: Don't trigger a CAS reboot for XICS/XIVE
 mode changeover
Message-ID: <20191202085009.44f3909f@bahia.w3ibm.bluemix.net>
In-Reply-To: <20191129053356.232413-2-david@gibson.dropbear.id.au>
References: <20191129053356.232413-1-david@gibson.dropbear.id.au>
 <20191129053356.232413-2-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 13995498795052079590
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudejgedgudduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejudegrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.72.36
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 clg@kaod.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 Nov 2019 16:33:53 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> PAPR allows the interrupt controller used on a POWER9 machine (XICS or
> XIVE) to be selected by the guest operating system, by using the
> ibm,client-architecture-support (CAS) feature negotiation call.
> 
> Currently, if the guest selects an interrupt controller different from the
> one selected at initial boot, this causes the system to be reset with the
> new model and the boot starts again.  This means we run through the SLOF
> boot process twice, as well as any other bootloader (e.g. grub) in use
> before the OS calls CAS.  This can be confusing and/or inconvenient for
> users.
> 
> Thanks to two fairly recent changes, we no longer need this reboot.  1) we
> now completely regenerate the device tree when CAS is called (meaning we
> don't need special case updates for all the device tree changes caused by
> the interrupt controller mode change),  2) we now have explicit code paths
> to activate and deactivate the different interrupt controllers, rather than
> just implicitly calling those at machine reset time.
> 
> We can therefore eliminate the reboot for changing irq mode, simply by
> putting a called to spapr_irq_update_active_intc() before we call

putting a call

> spapr_h_cas_compose_response() (which gives the updated device tree to the
> guest firmware and OS).
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Convenient indeed ! :)

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_hcall.c | 33 +++++++++++++--------------------
>  1 file changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 140f05c1c6..05a7ca275b 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1767,21 +1767,10 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>      }
>      spapr->cas_pre_isa3_guest = !spapr_ovec_test(ov1_guest, OV1_PPC_3_00);
>      spapr_ovec_cleanup(ov1_guest);
> -    if (!spapr->cas_reboot) {
> -        /* If spapr_machine_reset() did not set up a HPT but one is necessary
> -         * (because the guest isn't going to use radix) then set it up here. */
> -        if ((spapr->patb_entry & PATE1_GR) && !guest_radix) {
> -            /* legacy hash or new hash: */
> -            spapr_setup_hpt_and_vrma(spapr);
> -        }
> -        spapr->cas_reboot =
> -            (spapr_h_cas_compose_response(spapr, args[1], args[2],
> -                                          ov5_updates) != 0);
> -    }
>  
>      /*
> -     * Ensure the guest asks for an interrupt mode we support; otherwise
> -     * terminate the boot.
> +     * Ensure the guest asks for an interrupt mode we support;
> +     * otherwise terminate the boot.
>       */
>      if (guest_xive) {
>          if (!spapr->irq->xive) {
> @@ -1797,14 +1786,18 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>          }
>      }
>  
> -    /*
> -     * Generate a machine reset when we have an update of the
> -     * interrupt mode. Only required when the machine supports both
> -     * modes.
> -     */
> +    spapr_irq_update_active_intc(spapr);
> +
>      if (!spapr->cas_reboot) {
> -        spapr->cas_reboot = spapr_ovec_test(ov5_updates, OV5_XIVE_EXPLOIT)
> -            && spapr->irq->xics && spapr->irq->xive;
> +        /* If spapr_machine_reset() did not set up a HPT but one is necessary
> +         * (because the guest isn't going to use radix) then set it up here. */
> +        if ((spapr->patb_entry & PATE1_GR) && !guest_radix) {
> +            /* legacy hash or new hash: */
> +            spapr_setup_hpt_and_vrma(spapr);
> +        }
> +        spapr->cas_reboot =
> +            (spapr_h_cas_compose_response(spapr, args[1], args[2],
> +                                          ov5_updates) != 0);
>      }
>  
>      spapr_ovec_cleanup(ov5_updates);


