Received: from eggs.gnu.org ([2001:4830:134:3::10]:47456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dhGMG-0006sR-2p
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 10:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dhGMB-0005cW-Vo
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 10:28:44 -0400
Date: Mon, 14 Aug 2017 17:20:21 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170814172001-mutt-send-email-mst@kernel.org>
References: <20170809070357.28723-1-david@gibson.dropbear.id.au>
	<CAFEAcA_n88x0w1cVirQ61h+NOrvX1V7bXD1LCASVGyUZU=qDgg@mail.gmail.com>
	<20170811085157.GY13670@umbus.fritz.box>
	<CAFEAcA91j7zA2ptiLrcYL+cVF41_SJ2p0hL8Z=ejBiaqjfA--Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA91j7zA2ptiLrcYL+cVF41_SJ2p0hL8Z=ejBiaqjfA--Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/6] ppc patch queue 2017-08-09
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, QEMU Developers <qemu-devel@nongnu.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Alexander Graf <agraf@suse.de>, Greg Kurz <groug@kaod.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Fri, Aug 11, 2017 at 09:59:00AM +0100, Peter Maydell wrote:
> On 11 August 2017 at 09:51, David Gibson <david@gibson.dropbear.id.au> wrote:
> > On Thu, Aug 10, 2017 at 01:47:03PM +0100, Peter Maydell wrote:
> >> On 9 August 2017 at 08:03, David Gibson <david@gibson.dropbear.id.au> wrote:
> >> > I haven't completed a Travis build for this, which is part of my usual
> >> > test regime, since the first dozen or so Travis builds are failing
> >> > more often than not on master as well.  I don't know why this is -
> >> > seems to be failing some of the x86 tests.
> >>
> >> Doesn't look much worse than usual to me -- of the last 24 travis
> >> builds for master 4 failed and 20 passed.
> >
> > Uh.. that's not been my experience.  I was a bit unclear in my
> > description, though.  Until maybe a week and a half ago I found the
> > Travis build was fairly reliable, though there were occasional
> > transien failures.  Now, essentially every Travis build is failing for
> > me.  Specifically most of the first dozen or so of the batch of build
> > configurations on Travis fail (that's "X" not "!").  These seem to be
> > transient failures in the sense that if I rebuild enough times they'll
> > eventually pass, but unlike earlier when the builds would suceed most
> > of the time, they now seem to succeed at best around 1/3 of the time
> > (that's ~1/3 of the time for each configuration sub-build, so with a
> > dozen or so apparently affected that means a complete passing build
> > essentially never).
> >
> > See for example https://travis-ci.org/dgibson/qemu/builds/263312174
> > where 5 subbuilds have failed (which is relatively few).  In each case
> > the failing error seems to be something like:
> >
> > ERROR:tests/vhost-user-test.c:807:test_connect_fail: child process (/i386/vhost-user/connect-fail/subprocess [55883]) failed unexpectedly
> >
> > Seems to be i386 in some cases and x86_64 in others.

And is it always the connect-fail test?

> Weird. https://travis-ci.org/qemu/qemu/builds is the master
> build history and as you can see it's mostly greens.
> Not sure why your setup would be significantly worse:
> maybe one of the travis submaintainers has an idea.
> It could just be our vhost-user-test is flaky but I don't
> know why that should hit you much more than master...
> 
> 
> thanks
> -- PMM
