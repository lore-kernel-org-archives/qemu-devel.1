Received: from eggs.gnu.org ([2001:4830:134:3::10]:40876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g6yy9-0002M1-EQ
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 10:14:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g6yy8-0006Ho-M1
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 10:14:41 -0400
Date: Mon, 1 Oct 2018 16:14:30 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181001141430.GA4445@localhost.localdomain>
References: <20180925151541.18932-1-mreitz@redhat.com>
	<CAFEAcA-3bf02knEbNgq5ouFVnJDL6a9HqAvCo3Z4vaWYu-8yUw@mail.gmail.com>
	<CAFEAcA9cKPNKs_eR638eEqbAVW9sLxwHdnKVb-P-6hXJ3Kwyig@mail.gmail.com>
	<CAFEAcA95G4Nc4+Av0JNeh2NHa5NZR1wyos28V9xhQZn4v0WAWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA95G4Nc4+Av0JNeh2NHa5NZR1wyos28V9xhQZn4v0WAWA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/42] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Am 01.10.2018 um 15:03 hat Peter Maydell geschrieben:
> On 28 September 2018 at 15:36, Peter Maydell <peter.maydell@linaro.org> wrote:
> > I'm finding that test-bdrv-drain hangs intermittently on my OSX host.
> 
> Ping? Between this and test-replication I'm finding that my
> parallel build tests for merges are failing about 50% of the
> time :-(

Sorry, there wasn't much more than a weekend between your report and
now.

For the replication one, I think we can just take the AioContext lock in
the test case while we decide how the API should really be used. I'll
prepare a fix for that (and hopefully I'll be able to reproduce the
problem reliably enough to verify the fix).

Max said he could reproduce some hang in test-bdrv-drain (though we
don't know if this has anything to do with your OS X hang, which looked
rather odd) and would look into it, but I don't think we know the
problem yet. I'll try to reproduce that one after fixing the replication
test.

> If there's no immediate sign of a fix, could we disable these tests?

I hope we don't have to, though it depends on your definition of
immediate. :-)

Kevin
