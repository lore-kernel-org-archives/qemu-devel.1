Received: from eggs.gnu.org ([2001:4830:134:3::10]:40860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gMZBP-0007jd-Ta
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 08:56:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gMZBO-0003lH-T0
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 08:56:47 -0500
Date: Tue, 13 Nov 2018 11:56:14 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181113135614.GI12503@habkost.net>
References: <20181109221213.7310-1-crosa@redhat.com>
	<20181112104953.GB11580@linux.fritz.box>
	<f1c27ed2-9aba-edaf-2c49-ff565a0847ce@redhat.com>
	<20181112160025.GE11580@linux.fritz.box>
	<b51dd4e4-e814-db42-86be-698c0d87f8ef@redhat.com>
	<20181113121836.GC4830@localhost.localdomain>
	<20181113132653.GG12503@habkost.net>
	<20181113135116.GE4830@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113135116.GE4830@localhost.localdomain>
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] Acceptance tests for qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>

On Tue, Nov 13, 2018 at 02:51:16PM +0100, Kevin Wolf wrote:
> Am 13.11.2018 um 14:26 hat Eduardo Habkost geschrieben:
> > On Tue, Nov 13, 2018 at 01:18:36PM +0100, Kevin Wolf wrote:
> > [...]
> > > Anyway, one specific concern about the "simple way" I have is that we're
> > > adding a hard dependency on an external package (Avocado) that isn't
> > > usually installed anyway on developer machines. Maintainers will of
> > > course just install it. But will this reduce the amount of tests that
> > > contributors run, and increase the amount of untested patches on the
> > > mailing list?
> > > 
> > > Maybe we can keep a simple in-tree runner like ./check that doesn't have
> > > any external dependencies and runs all of those tests that don't make
> > > use of Avocado utility functions etc.? And you'd use Avocado when you
> > > want to run all tests or use advanced test harness options.
> > 
> > What problems you are trying to address here, exactly?
> > 
> > If you don't have Avocado installed in your system, all you need
> > is Python 3, an internet connection, and the ability to type
> > "make check-acceptance" on your keyboard.
> 
> Thanks, didn't know that one. Apparently you don't only need to have
> Python 3 available on the system, but also explicitly use it for
> ./configure?
> 
>     $ LANG=C make check-acceptance
>     /home/kwolf/source/qemu/tests/Makefile.include:930: *** "venv directory for tests requires Python 3".  Stop.

I suggested in another thread that we should simply use "python3"
instead of $(PYTHON) here, to solve that problem.  I think we can
use you reply as evidence that this is really the right thing to
do.  :)

> 
> While this doesn't make the tests available automatically for everyone,
> we'll get there when we finally make Python 3 the default (hopefully
> soon), which is already a lot better than what docs/devel/testing.rst
> promises:
> 
>     These tests are written using the Avocado Testing Framework (which
>     must be installed separately) [...]
> 
> Maybe time to update the docs to match the improved situation? :-)

Absolutely.  Thanks for the feedback!

-- 
Eduardo
