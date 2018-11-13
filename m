Received: from eggs.gnu.org ([2001:4830:134:3::10]:50807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gMZkZ-0000up-K3
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 09:33:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gMZkT-0000xn-Fc
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 09:33:07 -0500
Date: Tue, 13 Nov 2018 12:32:23 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181113143223.GK12503@habkost.net>
References: <20181109221213.7310-1-crosa@redhat.com>
	<20181112104953.GB11580@linux.fritz.box>
	<f1c27ed2-9aba-edaf-2c49-ff565a0847ce@redhat.com>
	<20181112160025.GE11580@linux.fritz.box>
	<b51dd4e4-e814-db42-86be-698c0d87f8ef@redhat.com>
	<20181113121836.GC4830@localhost.localdomain>
	<20181113132653.GG12503@habkost.net>
	<20181113135116.GE4830@localhost.localdomain>
	<a596c3a8-9099-391d-f418-4600e0e614f0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a596c3a8-9099-391d-f418-4600e0e614f0@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] Acceptance tests for qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>

On Tue, Nov 13, 2018 at 09:20:11AM -0500, Cleber Rosa wrote:
> 
> 
> On 11/13/18 8:51 AM, Kevin Wolf wrote:
> > Am 13.11.2018 um 14:26 hat Eduardo Habkost geschrieben:
> >> On Tue, Nov 13, 2018 at 01:18:36PM +0100, Kevin Wolf wrote:
> >> [...]
> >>> Anyway, one specific concern about the "simple way" I have is that we're
> >>> adding a hard dependency on an external package (Avocado) that isn't
> >>> usually installed anyway on developer machines. Maintainers will of
> >>> course just install it. But will this reduce the amount of tests that
> >>> contributors run, and increase the amount of untested patches on the
> >>> mailing list?
> >>>
> >>> Maybe we can keep a simple in-tree runner like ./check that doesn't have
> >>> any external dependencies and runs all of those tests that don't make
> >>> use of Avocado utility functions etc.? And you'd use Avocado when you
> >>> want to run all tests or use advanced test harness options.
> >>
> >> What problems you are trying to address here, exactly?
> >>
> >> If you don't have Avocado installed in your system, all you need
> >> is Python 3, an internet connection, and the ability to type
> >> "make check-acceptance" on your keyboard.
> > 
> > Thanks, didn't know that one. Apparently you don't only need to have
> > Python 3 available on the system, but also explicitly use it for
> > ./configure?
> > 
> >     $ LANG=C make check-acceptance
> >     /home/kwolf/source/qemu/tests/Makefile.include:930: *** "venv directory for tests requires Python 3".  Stop.
> > 
> > While this doesn't make the tests available automatically for everyone,
> > we'll get there when we finally make Python 3 the default (hopefully
> > soon), which is already a lot better than what docs/devel/testing.rst
> > promises:
> > 
> >     These tests are written using the Avocado Testing Framework (which
> >     must be installed separately) [...]
> > 
> > Maybe time to update the docs to match the improved situation? :-)
> > 
> > Kevin
> > 
> 
> The docs were updated when "make check-acceptance" was used.  That
> sentence is still true, Avocado must be installed separately, it's just
> that "check-venv", used by "check-acceptance" does just that.

With check-venv, we made "installing avocado" a small
implementation detail that people don't need to care about when
running the tests.

I believe the sentence "which must be installed separately" is
now confusing and misleading.  It can be easily interpreted as
"must be installed manually by the user", which is not case.

> [...]

-- 
Eduardo
