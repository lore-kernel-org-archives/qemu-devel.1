Received: from eggs.gnu.org ([2001:4830:134:3::10]:53374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eGnvy-0007rb-72
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 10:24:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eGnvs-0001xg-Ib
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 10:24:30 -0500
Date: Mon, 20 Nov 2017 16:24:11 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171120152411.GD7197@localhost.localdomain>
References: <20171117181653.20651-1-kwolf@redhat.com>
	<CAFEAcA8Y9OpRpSkQwAHPaN8gAPen7M3kJmLi4FDLB7DWBKV1WA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8Y9OpRpSkQwAHPaN8gAPen7M3kJmLi4FDLB7DWBKV1WA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/25] Block layer patches for 2.11.0-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Am 20.11.2017 um 15:53 hat Peter Maydell geschrieben:
> On 17 November 2017 at 18:16, Kevin Wolf <kwolf@redhat.com> wrote:
> > The following changes since commit fec035a53fa15c4c8c4e62bfef56a35df4161e38:
> >
> >   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20171117-pull-request' into staging (2017-11-17 10:18:41 +0000)
> >
> > are available in the git repository at:
> >
> >   git://repo.or.cz/qemu/kevin.git tags/for-upstream
> >
> > for you to fetch changes up to d5a49c6e7d9e42059450674ec845b7bc0d62cb7e:
> >
> >   Merge remote-tracking branch 'mreitz/tags/pull-block-2017-11-17' into queue-block (2017-11-17 18:24:30 +0100)
> >
> > ----------------------------------------------------------------
> > Block layer patches for 2.11.0-rc2
> >
> > ----------------------------------------------------------------
> 
> Hi. I'm afraid this fails 'make check' (Linux x86-64, gcc, debug build):
> 
>   GTESTER tests/test-replication
> **
> ERROR:/home/petmay01/linaro/qemu-for-merges/tests/test-replication.c:117:test_blk_write:
> assertion failed: (async_ret == 0)
> GTester: last random seed: R02S7bcadec8b2ecdf71fa8abd7f833c90f5
> /home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:863:
> recipe for target 'check-tests/test-replication' failed

I'll try to reproduce this, but so far I don't seem to be able to get it
to fail on my main laptop.

Kevin
