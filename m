Received: from eggs.gnu.org ([2001:4830:134:3::10]:40932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g8UXP-0008RB-BR
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 14:09:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g8UXI-0000hA-Gy
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 14:09:14 -0400
Date: Fri, 5 Oct 2018 20:09:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181005180901.GA32677@localhost.localdomain>
References: <20181005143802.18412-1-peter.maydell@linaro.org>
	<CAFEAcA8-FvVG7XBLrd7NQfRcKrvo6GtPEjfqJzkjd68iP9=TeQ@mail.gmail.com>
	<20181005161739.GC4606@localhost.localdomain>
	<CAFEAcA-SWRHwnwsa+QiHXfdBRB6u2u0paV9HsEqfjR6nZvAHSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-SWRHwnwsa+QiHXfdBRB6u2u0paV9HsEqfjR6nZvAHSg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] tests: Disable test-bdrv-drain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

Am 05.10.2018 um 18:54 hat Peter Maydell geschrieben:
> On 5 October 2018 at 17:17, Kevin Wolf <kwolf@redhat.com> wrote:
> > Am 05.10.2018 um 16:41 hat Peter Maydell geschrieben:
> >> On 5 October 2018 at 15:38, Peter Maydell <peter.maydell@linaro.org> wrote:
> >> > The test-bdrv-drain test fails at least 50% of the time
> >> > on my OS build system. Disable the test until we can figure
> >>
> >> This is a typo: I meant "OSX build system".
> >>
> >> > out what's going on, as this makes pull request processing
> >> > very difficult.
> >> >
> >> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >
> > Can we disable it conditionally only on OS X instead?
> >
> > I'd hate to lose this test case, and without OS X I can't really do
> > anything to fix the problem (or to even find out if it's a test case
> > problem or a bug that the test case reveals).
> 
> If we disable it for OSX only then nobody has any incentive
> to investigate and fix it...

And if we disable it wholesale, then nobody has any incentive to fix any
bug that the test case could have uncovered.

Look, if this were on BSD or something, I'd even setup a BSD VM and try
to investigate. With OS X, that's not an option. If OS X users care
about the bug, they need to fix it. If you want to give them an
incentive, then the test case needs to stay enabled. If they don't care,
we can disable the test case for OS X (and leave QEMU broken if it's a
real bug, but eventually someone will certainly report a bug in a real
life scenario in that case).

Anyway, killing tests for Linux users because they can't fix OS X bugs
doesn't sound like a very useful policy to me.

Kevin
