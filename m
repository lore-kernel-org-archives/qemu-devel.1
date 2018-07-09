Received: from eggs.gnu.org ([2001:4830:134:3::10]:59834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fcU2F-00064J-Q0
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 07:08:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fcU2E-00009l-Hi
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 07:08:51 -0400
Date: Mon, 9 Jul 2018 13:08:38 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180709130838.16f011a4.cohuck@redhat.com>
In-Reply-To: <87tvp8or4u.fsf@dusky.pond.sub.org>
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
	<20180706145645.GB3939@localhost.localdomain>
	<CAFEAcA9J=Jmd=+9vEo4LLdk0LcL42fchHcAp3fp_+9q1tsCoNg@mail.gmail.com>
	<87tvp8or4u.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Peter Krempa <pkrempa@redhat.com>

On Mon, 09 Jul 2018 08:33:05 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Peter Maydell <peter.maydell@linaro.org> writes:
> 
> > On 6 July 2018 at 15:56, Kevin Wolf <kwolf@redhat.com> wrote:  
> >> Am 06.07.2018 um 13:11 hat Cornelia Huck geschrieben:  
> >>> That way, we can still easily remove old cruft (case (a)), but still
> >>> accommodate cases like this (case (c)). The obvious drawback is that
> >>> we'd need someone to curate the deprecation watchlist, to poke the
> >>> users we're waiting for, and probably remove anyway after some time if
> >>> they don't get their act together.  
> >>
> >> The problem is that things are only starting to move after two releases
> >> have passed.  
> >
> > Right, so clearly just "put a note in the documentation" isn't
> > sufficient advertisement/prodding of things going away.  
> 
> Yes.  Ideas on more forceful notification have been tossed around, we
> just have to act on them.
> 
> >                                                         (Also, two
> > releases is pretty fast. Many of our users will be using distro
> > packaged versions of QEMU which will lag further behind than
> > bleeding-edge users. The system version of QEMU on my desktop
> > machine is 2.5...)  
> 
> If you consume QEMU in a way that's impacted by the changes the
> deprecation policy guards, you have two sane options:
> 
> * Track upstream deprecation, either continuously, or at least right
>   after a QEMU release.  Since 2.10, they're collected in qemu-doc
>   appendix "Deprecated features".

Can we draw more attention to this in any way? Point it out prominently
in the release notes? Send a list to known consumers (e.g. libvirt) on
release time?

> 
> * Batch that work before you switch QEMU versions.  Make sure to
>   allocate enough time.
> 
> If you consume only downstream versions of QEMU, and don't want to track
> upstream, go ahead and pick the second option.  It should do even if you
> leap from 2.5 (December 2015) all the way to 3.0.

If you are a direct user of QEMU, you really need to follow development
more closely, or you won't be able to complain about removal of a
useful feature until it has already been gone for some time.

If you only use QEMU through libvirt, you should be fine as long as
libvirt (and distro packagers) do not mess up.

Do we have any idea about how many end users using libvirt or other
tooling vs. QEMU directly? Of those not going via libvirt, are they
more likely to follow development or use a distro package?
