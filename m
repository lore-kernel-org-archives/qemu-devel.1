Received: from eggs.gnu.org ([2001:4830:134:3::10]:52588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fbSAL-0005oT-5y
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 10:56:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fbSAK-0005qG-5a
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 10:56:57 -0400
Date: Fri, 6 Jul 2018 16:56:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180706145645.GB3939@localhost.localdomain>
References: <20180625114106.GJ5024@localhost.localdomain>
	<20180625114528.GL16514@angien.pipo.sk>
	<20180702080411.GA4299@localhost.localdomain>
	<60f6bf3c-6cad-c86f-01d7-8c376a6ccfe0@de.ibm.com>
	<20180703111949.GB24516@redhat.com>
	<20180703113229.GD3812@localhost.localdomain>
	<20180704150256.408d4a07.cohuck@redhat.com>
	<20180704133440.GE4334@localhost.localdomain>
	<CAFEAcA-RVBXBj=+nr_D=bexLP4Rwgs+xyjJQ8VoOM9aOOVUJ3A@mail.gmail.com>
	<20180706131103.4e713911.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706131103.4e713911.cohuck@redhat.com>
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Peter Krempa <pkrempa@redhat.com>

Am 06.07.2018 um 13:11 hat Cornelia Huck geschrieben:
> On Wed, 4 Jul 2018 17:14:02 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
> 
> > On 4 July 2018 at 14:34, Kevin Wolf <kwolf@redhat.com> wrote:
> > > Essentially, what is important to me isn't getting these options dropped
> > > exactly in 3.0, but not setting a bad precedence that deprecation isn't
> > > actually worth anything. We may easily end up with this deprecation
> > > process:
> > >
> > > depreate a feature
> > > release QEMU version n + 1
> > > release QEMU version n + 2
> > > remove the feature
> > > while libvirt hasn't removed use of the feature:
> > >     # ...and why should it when everything is still working?
> > >     reinstate the feature
> > >     release QEMU version n + x
> > >     remove the feature  
> > 
> > My take on the deprecation policy essentially is that it gives
> > us a *minimum* bar for how soon we can drop something. We
> > shouldn't be using it as an "always target this speed for
> > dropping something" -- we ought to be pragmatic. We can
> > drop stuff that's unused quickly, but should be slower
> > for things that still have major users (or reconsider
> > the deprecation entirely, potentially). There should be
> > a balance between making our work as developers easier and
> > inconveniencing our users.
> 
> What about the following?
> 
> - put a feature on the "normal" deprecation list to remove after two
>   releases
> Case (a): nobody complains, either within the deprecation period or
> when it is finally removed
>   -> all is good
> Case (b): the feature turns out to be widely used, and/or it turns out
> that it offers value that currently can't be offered easily in another
> way
>   -> remove from deprecation list; this obviously needs more thinking
> Case (c): the feature is used, the users are willing to move away from
> it, but they need a bit more time
>   -> put it on a "deprecation watchlist", listing the users we are
>   waiting for, and then remove after all are done (no +2)
> 
> That way, we can still easily remove old cruft (case (a)), but still
> accommodate cases like this (case (c)). The obvious drawback is that
> we'd need someone to curate the deprecation watchlist, to poke the
> users we're waiting for, and probably remove anyway after some time if
> they don't get their act together.

The problem is that things are only starting to move after two releases
have passed. The original idea was to already use that time. If we don't
use it, then waiting for two releases is pointless and we can just
directly let things go to a deprecation watchlist.

Maybe we can just use the existing wiki page:

    https://wiki.qemu.org/index.php/Features/LegacyRemoval

And add a column for whether libvirt is ready? Of course, that only
makes sense if libvirt people make use of and contribute to this page.

Kevin
