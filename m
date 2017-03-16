Received: from eggs.gnu.org ([2001:4830:134:3::10]:54304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1coacw-0001Hs-NV
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 14:59:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1coacs-0007Do-18
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 14:59:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1coacr-0007DY-Ol
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 14:59:53 -0400
Date: Thu, 16 Mar 2017 18:59:48 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170316185948.GN2567@work-vm>
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
	<20170316154643.GT15193@redhat.com>
	<CAFEAcA9WdjkAr0eWNApWQGZAw4_67sci3LtY8=9pzYDcDXiLmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9WdjkAr0eWNApWQGZAw4_67sci3LtY8=9pzYDcDXiLmg@mail.gmail.com>
Subject: Re: [Qemu-devel] Proposal for deprecating unsupported host OSes &
 architecutures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 16 March 2017 at 15:46, Daniel P. Berrange <berrange@redhat.com> wrote:
> > On Thu, Mar 16, 2017 at 03:23:45PM +0000, Peter Maydell wrote:
> >> OK, here's a concrete proposal for deprecating/dropping out of
> >> date host OS and architecture support.
> >>
> >> We'll put this in the ChangeLog 'Future incompatible changes'
> >> section:
> >> -----
> >> * Removal of support for untested host OS and architectures:
> >>
> >> The QEMU Project intends to drop support in a future release for any
> >> host OS or architecture which we do not have access to a build and test
> >> machine for. This affects the following host OSes:
> >>  * Native CYGWIN building
> >>  * GNU/kFreeBSD
> >>  * FreeBSD
> >>  * DragonFly BSD
> >>  * NetBSD
> >>  * OpenBSD
> >>  * Solaris
> >>  * AIX
> >>  * Haiku
> >> and the following host CPU architectures:
> >>  * ia64
> >>  * sparc
> >>
> >> Specifically, if we do not have a build and test system available
> >> to us by the time we release QEMU 2.10, we will remove support in the
> >> release that follows 2.10.
> >> -----
> >>
> >> I'm not sure here if we want to just have this as a bald list,
> >> or to have some kind of two tier setup with OSes we expect to
> >> dump in one tier and OSes where we're really trolling for a build
> >> machine in the other tier (the "unlikely to dump" category would
> >> get most of the BSD variants in it). Putting out a changelog
> >> that says "we're gonna drop all the BSDs" seems like it might
> >> produce a lot of yelling?
> >
> > I think it depends on the level of bit-rot we are aware of, and
> > whether we expect anyone is likely to fix the bit-rot should it
> > be discovered.
> >
> > Simply not having a build machine for QEMU CI doesn't imply that
> > it is totally broken, and even if some pieces are broken, it
> > doesn't imply that QEMU is unusable.
> 
> No, but it does imply that our CI is missing a big chunk.
> Realistically, for the BSDs where I want to get to is "we
> have BSD coverage in our CI setup". The problem at the moment
> is that we (presumably) have BSD users but we have basically
> no BSD developers active upstream, which in my view is not
> a very long-term satisfactory situation.

I build-test the FreeBSD when I do migration pulls; given it's
just a VM it's not too hard; my main reason is that I use it as
a proxy that gives it a good chance to get past your MacOS build.

Dave
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
