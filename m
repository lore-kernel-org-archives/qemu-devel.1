Received: from eggs.gnu.org ([2001:4830:134:3::10]:45832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e0UXe-0001fa-I7
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:28:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e0UXb-0007fM-FC
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:27:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e0UXb-0007eb-97
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:27:55 -0400
Date: Fri, 6 Oct 2017 12:27:51 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171006152751.GR4015@localhost.localdomain>
References: <20171005203638.19255-1-ehabkost@redhat.com>
	<CAFEAcA-jBzTXWNrRCB8GXm2FcZdT3pPFZiGT6O6Oc8qpfSK_jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-jBzTXWNrRCB8GXm2FcZdT3pPFZiGT6O6Oc8qpfSK_jA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/9] x86 and machine queue, 2017-10-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, Oct 06, 2017 at 01:17:42PM +0100, Peter Maydell wrote:
> On 5 October 2017 at 21:36, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > The following changes since commit d8f932cc696250cb740240d668b39df5fbb2d5a0:
> >
> >   Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2017-10-05 16:54:29 +0100)
> >
> > are available in the git repository at:
> >
> >   git://github.com/ehabkost/qemu.git tags/x86-and-machine-pull-request
> >
> > for you to fetch changes up to 7d7e9c4fd6873d9624956cbe0a5cbfae59b7f8af:
> >
> >   x86: Correct translation of some rdgsbase and wrgsbase encodings (2017-10-05 17:30:06 -0300)
> >
> > ----------------------------------------------------------------
> > x86 and machine queue, 2017-10-05
> >
> > Includes x86, NUMA, ACPI, QOM, CPU, and option/config parsing
> > patches.
> >
> > Highlights:
> > * Deprecation of -nodefconfig option;
> > * MachineClass::valid_cpu_types field.
> >
> > ----------------------------------------------------------------
> 
> This fails tests, I'm afraid:
[...]
> acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-6QYK7Y.dsl,
> aml:/tmp/aml-E8YK7Y], Expected [asl:/tmp/asl-1H1I7Y.dsl,
> aml:tests/acpi-test-data/pc/DSDT.memhp].
> acpi-test: Warning. not showing difference since no diff utility is
> specified. Set 'DIFF' environment variable to a preferred diff utility
> and run 'make V=1 check' again to see ASL difference.OK
> 
> and same for /i386/acpi/piix4/numamem and for the
> equivalent q35 tests.
> 
> Fails on s390, netbsd, freebsd, aarch32, x86-64.
> 

Oops, sorry!

I need to find out why it didn't fail on travis-ci:
https://travis-ci.org/ehabkost/qemu/builds/283884670

-- 
Eduardo
