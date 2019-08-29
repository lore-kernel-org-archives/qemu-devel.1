Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF98C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33C2F2053B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C2F2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3I7E-0004zH-Vn
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 06:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1i3I5f-0003dS-5Q
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1i3I5d-0001WD-M4
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:55:42 -0400
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:58387)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1i3I5d-0001Us-FI
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:55:41 -0400
Received: from player726.ha.ovh.net (unknown [10.109.143.145])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 4B2141A7DA7
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 12:55:39 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player726.ha.ovh.net (Postfix) with ESMTPSA id CF11E92910A7;
 Thu, 29 Aug 2019 10:55:31 +0000 (UTC)
Date: Thu, 29 Aug 2019 12:55:30 +0200
From: Greg Kurz <groug@kaod.org>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190829125530.7f79efc1@bahia.lan>
In-Reply-To: <35775479-e5fe-fc90-cc19-d6b6f8f3a570@linux.vnet.ibm.com>
References: <156576293464.29984.1631520917528142744.stgit@aravinda>
 <20190829122108.36c226c3@bahia.lan>
 <35775479-e5fe-fc90-cc19-d6b6f8f3a570@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 12621900906828831124
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudeivddgfedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.63.121
Subject: Re: [Qemu-devel] [Qemu-ppc] [patch-for-4.2 PATCH v11 0/6]
 target-ppc/spapr: Add FWNMI support in QEMU for PowerKVM guests
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
Cc: aik@au1.ibm.com, qemu-devel@nongnu.org, paulus@ozlabs.org,
 qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 29 Aug 2019 16:08:53 +0530
Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:

> 
> 
> On Thursday 29 August 2019 03:51 PM, Greg Kurz wrote:
> > On Wed, 14 Aug 2019 11:40:50 +0530
> > Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:
> > 
> >> This patch set adds support for FWNMI in PowerKVM guests.
> >>
> >> System errors such as SLB multihit and memory errors
> >> that cannot be corrected by hardware is passed on to
> >> the kernel for handling by raising machine check
> >> exception (an NMI). Upon such machine check exceptions,
> >> if the address in error belongs to guest then KVM
> >> invokes guests' 0x200 interrupt vector if the guest
> >> is not FWNMI capable. For FWNMI capable guest
> >> KVM passes the control to QEMU by exiting the guest.
> >>
> >> This patch series adds functionality to QEMU to pass
> >> on such machine check exceptions to the FWNMI capable
> >> guest kernel by building an error log and invoking
> >> the guest registered machine check handling routine.
> >>
> >> The KVM changes are now part of the upstream kernel
> >> (commit e20bbd3d). This series contain QEMU changes.
> >>
> >> Change Log v11:
> >>   - Moved FWNMI SPAPR cap defaults to 4.2 class option
> >>   - Fixed issues with handling fwnmi KVM capability
> >>
> > 
> > Hi Aravinda,
> > 
> > I'm afraid this series needs rebasing. It doesn't apply
> > cleanly on current ppc-for-4.2 (SHA1 b1e8156743).
> 
> This was based on the latest 4.2 at the time of posting (14th Aug).

I was on vacation at that time but you're probably right.

> Meanwhile may be due to changes to 4.2 it is not applying cleanly. I
> will rebase it to the latest 4.2 and post it again.
> 

Thanks !

> Regards,
> Aravinda
> 
> > 
> > Cheers,
> > 
> > --
> > Greg
> > 
> >> Change Log v10:
> >>   - Reshuffled the patch sequence + minor fixes
> >>
> >> Change Log v9:
> >>   - Fixed kvm cap and spapr cap issues
> >>
> >> Change Log v8:
> >>   - Added functionality to check FWNMI capability during
> >>     VM migration
> >> ---
> >>
> >> Aravinda Prasad (6):
> >>       Wrapper function to wait on condition for the main loop mutex
> >>       ppc: spapr: Introduce FWNMI capability
> >>       target/ppc: Handle NMI guest exit
> >>       target/ppc: Build rtas error log upon an MCE
> >>       ppc: spapr: Handle "ibm,nmi-register" and "ibm,nmi-interlock" RTAS calls
> >>       migration: Include migration support for machine check handling
> >>
> >>
> >>  cpus.c                   |    5 +
> >>  hw/ppc/spapr.c           |   78 +++++++++++++
> >>  hw/ppc/spapr_caps.c      |   29 +++++
> >>  hw/ppc/spapr_events.c    |  268 ++++++++++++++++++++++++++++++++++++++++++++++
> >>  hw/ppc/spapr_rtas.c      |   78 +++++++++++++
> >>  include/hw/ppc/spapr.h   |   25 ++++
> >>  include/qemu/main-loop.h |    8 +
> >>  target/ppc/cpu.h         |    1 
> >>  target/ppc/kvm.c         |   38 +++++++
> >>  target/ppc/kvm_ppc.h     |   13 ++
> >>  target/ppc/trace-events  |    1 
> >>  11 files changed, 542 insertions(+), 2 deletions(-)
> >>
> >> --
> >> Signature
> > 
> > 
> 


