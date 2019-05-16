Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1428AC04AB4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 06:59:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D655320862
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 06:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D655320862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49799 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRAMG-0005Fq-Mk
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 02:59:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hRALQ-0004t6-Or
	for qemu-devel@nongnu.org; Thu, 16 May 2019 02:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hRALP-0003Kf-Fa
	for qemu-devel@nongnu.org; Thu, 16 May 2019 02:58:24 -0400
Received: from 13.mo3.mail-out.ovh.net ([188.165.33.202]:46350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hRALP-0003Jw-AF
	for qemu-devel@nongnu.org; Thu, 16 May 2019 02:58:23 -0400
Received: from player715.ha.ovh.net (unknown [10.109.146.1])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 3DE8B21438F
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 08:58:20 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player715.ha.ovh.net (Postfix) with ESMTPSA id 90DFA5C17AA0;
	Thu, 16 May 2019 06:58:15 +0000 (UTC)
Date: Thu, 16 May 2019 08:58:14 +0200
From: Greg Kurz <groug@kaod.org>
To: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Message-ID: <20190516085814.022ef4b1@bahia.lan>
In-Reply-To: <20190516063957.GA25414@sathnaga86>
References: <155793986451.464434.12887933000007255549.stgit@bahia.lan>
	<20190516063957.GA25414@sathnaga86>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 723672166454696405
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrleelgdduudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.33.202
Subject: Re: [Qemu-devel] [PATCH] spapr/xive: Sanity checks of OV5 during CAS
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
	=?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 May 2019 12:09:57 +0530
Satheesh Rajendran <sathnaga@linux.vnet.ibm.com> wrote:

> On Wed, May 15, 2019 at 07:04:24PM +0200, Greg Kurz wrote:
> > If a machine is started with ic-mode=xive but the guest only knows
> > about XICS, eg. an RHEL 7.6 guest, the kernel panics. This is
> > expected but a bit unfortunate since the crash doesn't provide
> > much information for the end user to guess what's happening.
> > 
> > Detect that during CAS and exit QEMU with a proper error message
> > instead, like it is already done for the MMU.
> > 
> > Even if this is less likely to happen, the opposite case of a guest
> > that only knows about XIVE would certainly fail all the same if the
> > machine is started with ic-mode=xics.
> > 
> > Also, the only valid values a guest can pass in byte 23 of OV5 during
> > CAS are 0b00 (XIVE legacy mode) and 0b01 (XIVE exploitation mode). Any
> > other value is a bug, at least with the current spec. Again, it does
> > not seem right to let the guest go on without a precise idea of the
> > interrupt mode it asked for.
> > 
> > Handle these cases as well.
> > 
> > Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/ppc/spapr_hcall.c |   24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index 6c16d2b12040..63a55614b83d 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -1513,6 +1513,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
> >      bool guest_radix;
> >      Error *local_err = NULL;
> >      bool raw_mode_supported = false;
> > +    bool guest_xive;
> > 
> >      cas_pvr = cas_check_pvr(spapr, cpu, &addr, &raw_mode_supported, &local_err);
> >      if (local_err) {
> > @@ -1545,10 +1546,17 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
> >          error_report("guest requested hash and radix MMU, which is invalid.");
> >          exit(EXIT_FAILURE);
> >      }
> > +    if (spapr_ovec_test(ov5_guest, OV5_XIVE_BOTH)) {
> > +        error_report("guest requested an invalid interrupt mode");
> > +        exit(EXIT_FAILURE);
> > +    }
> > +
> >      /* The radix/hash bit in byte 24 requires special handling: */
> >      guest_radix = spapr_ovec_test(ov5_guest, OV5_MMU_RADIX_300);
> >      spapr_ovec_clear(ov5_guest, OV5_MMU_RADIX_300);
> > 
> > +    guest_xive = spapr_ovec_test(ov5_guest, OV5_XIVE_EXPLOIT);
> > +
> >      /*
> >       * HPT resizing is a bit of a special case, because when enabled
> >       * we assume an HPT guest will support it until it says it
> > @@ -1632,6 +1640,22 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
> >                                            ov5_updates) != 0);
> >      }
> > 
> > +    /*
> > +     * Ensure the guest asks for an interrupt mode we support; otherwise
> > +     * terminate the boot.
> > +     */
> > +    if (guest_xive) {
> > +        if (spapr->irq->ov5 == SPAPR_OV5_XIVE_LEGACY) {
> > +            error_report("Guest requested unavailable interrupt mode (XIVE)");
> > +            exit(EXIT_FAILURE);
> > +        }
> > +    } else {
> > +        if (spapr->irq->ov5 == SPAPR_OV5_XIVE_EXPLOIT) {
> > +            error_report("Guest requested unavailable interrupt mode (XICS)");  
> 
> Looks like there is a typo in the error msg reported, instead it should be something like below
> 
> "Guest requested unavailable interrupt mode(XIVE), please use supported interrupt mode(ic-type=xics)"
> 

Hmm... Agreed that it may be worth adding some hint for the user to proceed but...

> Same for the previous check aswell.
> 
> Coz, I booted 3.10(kernel) guest with ic-type=xive and got a below error, which seems wrong
> 
> 2019-05-16T06:24:58.713261Z qemu-system-ppc64: Guest requested unavailable interrupt mode (XICS)
> 

... this message is ok: the 3.10 kernel based guest _does_ ask for XICS,
which isn't available because of ic-mode=xive.

Cheers,

--
Greg

> Regards,
> -Satheesh.
> 
> > +            exit(EXIT_FAILURE);
> > +        }
> > +    }
> > +
> >      /*
> >       * Generate a machine reset when we have an update of the
> >       * interrupt mode. Only required when the machine supports both
> >   
> 


