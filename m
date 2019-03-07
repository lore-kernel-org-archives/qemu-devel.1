Received: from eggs.gnu.org ([209.51.188.92]:60926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1rDZ-0002eT-RL
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:29:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1rDY-0007ep-ST
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:29:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h1rDY-0007eS-JS
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:29:40 -0500
Date: Thu, 7 Mar 2019 11:29:33 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190307112933.GA2853@work-vm>
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<9fb589af-a78e-6eeb-ca1c-a5049c5ac5ab@redhat.com>
	<CAFEAcA_RQU+HYczN4Z=vEL8U31---GTi_HOxg8y50pzX8p+p7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_RQU+HYczN4Z=vEL8U31---GTi_HOxg8y50pzX8p+p7Q@mail.gmail.com>
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel <qemu-devel@nongnu.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On Thu, 7 Mar 2019 at 06:39, Thomas Huth <thuth@redhat.com> wrote:
> > On 06/03/2019 19.12, Paolo Bonzini wrote:
> > > lately I have been thinking of converting the QEMU build system to
> > > Meson.  Meson is a relatively new build system that can replace
> > > Autotools or hand-written Makefiles such as QEMU; as a die-hard
> > > Autotools fan, I must say that Meson is by far better than anything else
> > > that has ever tried to replace Autotools, and actually has the potential
> > > to do so.
> > >
> > > Advantages of Meson that directly matter for QEMU include:[...]
> >
> > I'm not objecting a new build system per se, but could you elaborate on
> >  problems of the current QEMU build system that will be fixed by this
> > change? Since apart from some minor glitches (with the *.mak file
> > dependencies for example), the current build system seems to work quite
> > well for me ... so at least I currently don't feel enough pain yet to do
> > such a big step, just because there is another new cool build system
> > around...
> 
> Yes, that tends to be my view. Our current build system:
>  * has no dependencies that are problematic for older hosts
>    (contrast Meson, which needs Python 3.5, even if we take
>    the drastic step of shipping an entire build tool along
>    with QEMU; OSX python is 2.7 still)
>  * is not particularly hard to deal with for the common cases
>    ("add new source file" is straightforward)
>  * covers all our requirements as far as I'm aware
>    (whereas you've listed a couple of places where Meson
>    would need changes/extensions to support things we do already)
>  * is generally flexible enough to be hackable to deal with odd
>    cases (it has escape mechanisms to generic-programmability,
>    even if they're ugly and awkward)

Pretty regularly I just give up on build directories and recreate
them because of changes that our Makefiles haven't realised
when updating a tree.
(I can't say it's any one fault anywhere)

Having said that, the counterpoint in Meson is that it's build
directories seem tobe exact-meson version dependent; doing a minor
host update and you find you have to nuke your build directories.

Dave

> So I think we'd need a more compelling reason to move right now.
> (This might change in the future, eg if Meson catches on to the
> extent that everybody is using it and competitors like CMake are
> more obviously eclipsed by it, in the way that git took over
> from svn and relegated mercurial and bzr to obscurity.)
> 
> thanks
> -- PMM
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
