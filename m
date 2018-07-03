Received: from eggs.gnu.org ([2001:4830:134:3::10]:37041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1faHsU-000288-S6
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1faHsR-0005I4-QZ
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:45:42 -0400
Received: from 1.mo173.mail-out.ovh.net ([178.33.111.180]:50507)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1faHsR-0005Ch-IX
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:45:39 -0400
Received: from player730.ha.ovh.net (unknown [10.109.122.124])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 13657C753C
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 11:45:30 +0200 (CEST)
Date: Tue, 3 Jul 2018 11:45:15 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180703114515.4c2f0da3@bahia.lan>
In-Reply-To: <CAFEAcA9qdYYnCNTNSotEfMzvOPCBj_baxANmixGmQKBbHejnww@mail.gmail.com>
References: <20180702163125.28729-1-pbonzini@redhat.com>
	<20180703100044.5d265acb@bahia.lan>
	<CAFEAcA9qdYYnCNTNSotEfMzvOPCBj_baxANmixGmQKBbHejnww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] fsdev: fix compilation with VIRTIO but not
 VIRTIO_9P
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 3 Jul 2018 09:46:01 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 3 July 2018 at 09:00, Greg Kurz <groug@kaod.org> wrote:
> > On Mon,  2 Jul 2018 18:31:25 +0200
> > Paolo Bonzini <pbonzini@redhat.com> wrote:
> >  
> >> hw/9pfs/Makefile.objs uses CONFIG_VIRTIO_9P to guard the definition for
> >> FileOperations structs, while fsdev/Makefile.objs uses CONFIG_VIRTIO
> >> to guard the use.  Mismatch causes linking to fail when CONFIG_VIRTIO
> >> is set but CONFIG_VIRTIO_9P is not.
> >>
> >> Fix it and use if/else to clarify that the two lines are for opposite
> >> conditions.
> >>
> >> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> >> Fixes: b5dfdb082fc350f3e68dfa61dc988d97cad28cfe
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >> ---  
> >
> > Acked-by: Greg Kurz <groug@kaod.org>
> > Tested-by: Greg Kurz <groug@kaod.org>
> >
> > Peter,
> >
> > I see this patch is needed for the latest RISC-V pull req.  
> 
> It isn't, because that pullreq only fails because of what
> looks to me like a rebase mismerge that made it change how
> the riscv default-configs enable virtio. The riscv pullreq
> should be fixed. This is just a cleanup, really.
> 

Ok, thanks for the clarification.

I've applied this to 9p-next.

> thanks
> -- PMM
