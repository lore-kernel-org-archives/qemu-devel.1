Received: from eggs.gnu.org ([2001:4830:134:3::10]:47191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fSlbN-0007gd-7z
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 11:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fSlbK-0000nn-6H
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 11:52:57 -0400
Received: from 8.mo173.mail-out.ovh.net ([46.105.46.122]:33563)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fSlbJ-0000n1-WF
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 11:52:54 -0400
Received: from player774.ha.ovh.net (unknown [10.109.105.96])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id B6CCDC5598
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 17:52:51 +0200 (CEST)
Date: Tue, 12 Jun 2018 17:52:41 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180612175241.7340be80@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <CAFEAcA85qHjDLBYxWW9i4T91m1uTS6TAY_y2A6_840n-_tDZKw@mail.gmail.com>
References: <20180612064503.14282-1-david@gibson.dropbear.id.au>
	<CAFEAcA85qHjDLBYxWW9i4T91m1uTS6TAY_y2A6_840n-_tDZKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/33] ppc-for-3.0 queue 20180612
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>

On Tue, 12 Jun 2018 15:34:22 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 12 June 2018 at 07:44, David Gibson <david@gibson.dropbear.id.au> wrote:
> > The following changes since commit 2afc4e3df80d947dd1bd42ce80278f591b35c74a:
> >
> >   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2018-06-11' into staging (2018-06-11 15:31:20 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/dgibson/qemu.git tags/ppc-for-3.0-20180612
> >
> > for you to fetch changes up to 30f79dc13f116a79ff45d37ad0f5c035012064a7:
> >
> >   spapr_pci: Remove unhelpful pagesize warning (2018-06-12 10:44:36 +1000)
> >
> > ----------------------------------------------------------------
> > ppc patch queue 2018-06-12
> >
> > Here's another batch of ppc patches towards the 3.0 release.  There's
> > a fair bit here, because I've been working through my mail backlog
> > after a holiday.  There's not much of a central theme, amongst other
> > things we have:
> >     * ppc440 / sam460ex improvements
> >     * logging and error cleanups
> >     * 40p (PReP) bugfixes
> >     * Macintosh fixes and cleanups
> >     * Add emulation of the new POWER9 store-forwarding barrier
> >       instruction variant
> >     * Hotplug cleanups
> >  
> 
> Applied, thanks.
> 
> -- PMM

Oh... so we've broken bisect until Cedric's fix is merged.

https://patchwork.ozlabs.org/patch/928222/

Cheers,

--
Greg
