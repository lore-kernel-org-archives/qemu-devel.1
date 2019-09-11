Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B090ECDE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:56:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 283FC21A4C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 283FC21A4C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7xTz-0003fV-AG
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 03:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1i7xSO-0002H6-Or
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1i7xSN-0001P4-6o
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:54:28 -0400
Received: from 3.mo173.mail-out.ovh.net ([46.105.34.1]:43352)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1i7xSN-0001OO-0c
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:54:27 -0400
Received: from player691.ha.ovh.net (unknown [10.109.159.48])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id CE5D011901B
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 09:54:24 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player691.ha.ovh.net (Postfix) with ESMTPSA id 159F29C41116;
 Wed, 11 Sep 2019 07:54:17 +0000 (UTC)
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20190911040452.8341-1-david@gibson.dropbear.id.au>
 <20190911040452.8341-8-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <4eb60836-7b25-d71a-11dc-2a7bdad2319f@kaod.org>
Date: Wed, 11 Sep 2019 09:54:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911040452.8341-8-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 12119186598345345830
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrtddugdduvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.34.1
Subject: Re: [Qemu-devel] [PATCH 7/7] spapr: Perform machine reset in a more
 sensible order
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
Cc: aik@ozlabs.ru, lvivier@redhat.com, philmd@redhat.com, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/09/2019 06:04, David Gibson wrote:
> We've made several changes in the past to the machine reset order to fix
> specific problems.  However, we've ended up with an order that doesn't make
> a lot of logical sense.  This is an attempt to rectify this.

There are some more problems though. See below.

> 
> First we reset global CAS options, since that should depend on nothing
> else.  Then we reset the CPUs, which shouldn't depend on external devices.
> Then the irq subsystem, then the bulk of devices (which might rely on
> irqs).  Finally we set up the entry state ready for boot, which could
> potentially rely on a bunch of other things.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c | 47 +++++++++++++++++++++++++----------------------
>  1 file changed, 25 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 5a919a6cc1..1560a11738 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1724,6 +1724,28 @@ static void spapr_machine_reset(MachineState *machine)
>      void *fdt;
>      int rc;
>  
> +    /*
> +     * If this reset wasn't generated by CAS, we should reset our
> +     * negotiated options and start from scratch
> +     */
> +    if (!spapr->cas_reboot) {
> +        spapr_ovec_cleanup(spapr->ov5_cas);
> +        spapr->ov5_cas = spapr_ovec_new();
> +
> +        ppc_set_compat_all(spapr->max_compat_pvr, &error_fatal);
> +    }
> +
> +    /*
> +     * There is no CAS under qtest. Simulate one to please the code that
> +     * depends on spapr->ov5_cas. This is especially needed to test device
> +     * unplug, so we do that before resetting the DRCs.
> +     */
> +    if (qtest_enabled()) {
> +        spapr_ovec_cleanup(spapr->ov5_cas);
> +        spapr->ov5_cas = spapr_ovec_clone(spapr->ov5);
> +    }
> +
> +    /* Reset the CPUs */
>      spapr_caps_apply(spapr);
>  
>      first_ppc_cpu = POWERPC_CPU(first_cpu);
> @@ -1741,34 +1763,15 @@ static void spapr_machine_reset(MachineState *machine)
>          spapr_setup_hpt_and_vrma(spapr);
>      }
>  
> -    qemu_devices_reset();
> -
> -    /*
> -     * If this reset wasn't generated by CAS, we should reset our
> -     * negotiated options and start from scratch
> -     */
> -    if (!spapr->cas_reboot) {
> -        spapr_ovec_cleanup(spapr->ov5_cas);
> -        spapr->ov5_cas = spapr_ovec_new();
> -
> -        ppc_set_compat_all(spapr->max_compat_pvr, &error_fatal);
> -    }
> -
> +    /* Reset IRQ subsystem */
>      /*
>       * This is fixing some of the default configuration of the XIVE
>       * devices. To be called after the reset of the machine devices.
>       */
>      spapr_irq_reset(spapr, &error_fatal);

spapr_irq_reset() is now called before qemu_devices_reset(). So it will
break the XIVE emulated model.

KVM P8 guests are also broken : 

 qemu-system-ppc64: kernel_irqchip requested but unavailable: Unable to restore KVM interrupt controller state (0x0) for CPU 0: Invalid argument

Something wrong in kvmppc_xics_set_icp(). I need to look closer.

and TCG P9 guests still do the reset after CAS. 

C.

>  
> -    /*
> -     * There is no CAS under qtest. Simulate one to please the code that
> -     * depends on spapr->ov5_cas. This is especially needed to test device
> -     * unplug, so we do that before resetting the DRCs.
> -     */
> -    if (qtest_enabled()) {
> -        spapr_ovec_cleanup(spapr->ov5_cas);
> -        spapr->ov5_cas = spapr_ovec_clone(spapr->ov5);
> -    }
> +    /* Reset other devices */
> +    qemu_devices_reset();
>  
>      /* DRC reset may cause a device to be unplugged. This will cause troubles
>       * if this device is used by another device (eg, a running vhost backend
> 


