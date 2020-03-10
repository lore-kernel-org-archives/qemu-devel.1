Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AC8C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:55:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 251C324683
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251C324683
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBcXk-0003tr-Aj
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 06:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jBcMu-0008VB-Lq
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:44:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jBcMt-0006fl-7o
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:44:12 -0400
Received: from 14.mo3.mail-out.ovh.net ([188.165.43.98]:51158)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jBcMt-0006dE-1I
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:44:11 -0400
Received: from player772.ha.ovh.net (unknown [10.110.208.160])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id B00EB245995
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 11:44:08 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id 12A07104E439B;
 Tue, 10 Mar 2020 10:43:56 +0000 (UTC)
Date: Tue, 10 Mar 2020 11:43:51 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 2/2] spapr: Enable virtio iommu_platform=on by default
Message-ID: <20200310114351.5381504e@bahia.home>
In-Reply-To: <20200305125903.096c3897@bahia.home>
References: <20200305043009.611636-1-david@gibson.dropbear.id.au>
 <20200305043009.611636-3-david@gibson.dropbear.id.au>
 <20200305125903.096c3897@bahia.home>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 8032169937567062502
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedruddvtddgudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuffhomhgrihhnpehoiihlrggsshdrohhrghenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejvddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.43.98
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
Cc: pair@us.ibm.com, mst@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org,
 paulus@samba.org, clg@kaod.org, mdroth@us.ibm.com, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Mar 2020 12:59:03 +0100
Greg Kurz <groug@kaod.org> wrote:

> On Thu,  5 Mar 2020 15:30:09 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
> > Traditionally, virtio devices don't do DMA by the usual path on the
> > guest platform.  In particular they usually bypass any virtual IOMMU
> > the guest has, using hypervisor magic to access untranslated guest
> > physical addresses.
> > 
> > There's now the optional iommu_platform flag which can tell virtio
> > devices to use the platform's normal DMA path, including any IOMMUs.
> > That flag was motiviated for the case of hardware virtio
> > implementations, but there are other reasons to want it.
> > 
> > Specifically, the fact that the virtio device doesn't use vIOMMU
> > translation means that virtio devices are unsafe to pass to nested
> > guests, or to use with VFIO userspace drivers inside the guest.  This
> > is particularly noticeable on the pseries platform which *always* has
> > a guest-visible vIOMMU.
> > 
> > Not using the normal DMA path also causes difficulties for the guest
> > side driver when using the upcoming POWER Secure VMs (a.k.a. PEF).
> > While it's theoretically possible to handle this on the guest side,
> > it's really fiddly.  Given the other problems with the non-translated
> > virtio device, let's just enable vIOMMU translation for virtio devices
> > by default in the pseries-5.0 (and later) machine types.
> > 
> > This does mean the new machine type will no longer support guest
> > kernels older than 4.8, unless they have support for the virtio
> > IOMMU_PLATFORM flag backported (which some distro kernels like RHEL7
> > do).
> > 
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> 
> The patch looks good but I'm not sure if we're quite ready to merge
> it yet. With this applied, I get zero output on a virtio-serial based
> console:
> 
> ie.
>   -chardev stdio,id=con0 -device virtio-serial -device virtconsole,chardev=con0 
> 
> FYI, virtio-serial is a bit broken for spapr with iommu_platform=off already:
> 
> (1) pressing a key in the console during SLOF or grub has no effect
> 
> (2) the guest kernel boot stays stuck around quiesce
> 
> These are regressions introduced by this SLOF update:
> 
> a363e9ed8731f45674260932a340a0d81c4b0a6f is the first bad commit
> commit a363e9ed8731f45674260932a340a0d81c4b0a6f
> Author: Alexey Kardashevskiy <aik@ozlabs.ru>
> Date:   Tue Dec 17 11:31:54 2019 +1100
>     pseries: Update SLOF firmware image
> 
> A trivial fix was already posted on the SLOF list for (1) :
> 
> https://patchwork.ozlabs.org/patch/1249338/
> 
> (2) is still under investigation but the console is _at least_
> functional until the guest OS takes control. This is no longer
> the case with this patch.
> 

Some progress was made on the SLOF front:

https://patchwork.ozlabs.org/project/slof/list/?series=163314

With these series applied to SLOF, I can now boot a fedora31 guest
with a virtio-serial console and iommu_platform=on... but now
I'm trying out other virtio devices supported by SLOF and I'm
running into issues around virtio-pci.disable-legacy as mentioned
in some other mail...

It seems we may not be ready to merge this series yet.

> >  hw/ppc/spapr.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 3cfc98ac61..5ef099536e 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -4575,6 +4575,7 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
> >       */
> >      static GlobalProperty compat[] = {
> >          { TYPE_VIRTIO_PCI, "disable-legacy", "on", },
> > +        { TYPE_VIRTIO_DEVICE, "iommu_platform", "on", },
> >      };
> >  
> >      mc->alias = "pseries";
> > @@ -4622,6 +4623,7 @@ static void spapr_machine_4_2_class_options(MachineClass *mc)
> >      SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
> >      static GlobalProperty compat[] = {
> >          { TYPE_VIRTIO_PCI, "disable-legacy", "auto" },
> > +        { TYPE_VIRTIO_DEVICE, "iommu_platform", "off", },
> >      };
> >  
> >      spapr_machine_5_0_class_options(mc);
> 


