Received: from eggs.gnu.org ([2001:4830:134:3::10]:38639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dg4mp-0007Rk-6i
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 03:55:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dg4mj-0006T4-9f
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 03:55:15 -0400
Date: Fri, 11 Aug 2017 15:54:55 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170811075455.GC27391@lemon.lan>
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-19-f4bug@amsat.org>
	<87mv7aumav.fsf@linaro.org>
	<8e2e3aa5-4459-76ba-3309-af6b30220346@amsat.org>
	<87fud0vmak.fsf@linaro.org>
	<3e66742f-04c5-51b7-de3a-f692c0637bc5@amsat.org>
	<20170810104604.342af354.cohuck@redhat.com>
	<CAFEAcA-GP53g+vfgDH1mNQnPHcrNULb+gkQk4JeJhb=8UCt+YA@mail.gmail.com>
	<20170810122520.48403984.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170810122520.48403984.cohuck@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 18/47] MAINTAINERS: add missing TCG entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Thu, 08/10 12:25, Cornelia Huck wrote:
> > I think the UI (giving no consideration to how we might implement
> > this!) would ideally be something like:
> >  * if anybody mails a patch which touches an "unmaintained" file,
> >    a robot should send a reply along the lines of "thanks for the
> >    patch; unfortunately file X is not maintained so it may be
> >    tricky to get patch review for this. You'll need to be
> >    persistent and do more of the legwork than if you were patching
> >    a file that did have an active maintainer" so contributors
> >    know when they've wandered into the swamp
> 
> That's a good idea.
> 
> >  * some mechanism for easily finding patches to unmaintained
> >    files which haven't got review yet, so that anybody with some
> >    spare time and interest can move some of them along (the idea
> >    being to spread the load rather than trying to designate a
> >    particular "owner" for this headache)
> 
> Can maybe patchew set a special flag for patches that only touch
> unmaintained files?

Interesting idea. We have a number of patch status tracking feature requests for
patchew already. We can tackle them one by one. (The next priority is implement
"merged".)

> 
> >  * ditto for finding patches to unmaintained files which have got
> >    review but which haven't been committed
> > 
> > thanks
> > -- PMM
> 
