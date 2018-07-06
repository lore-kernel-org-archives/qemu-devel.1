Received: from eggs.gnu.org ([2001:4830:134:3::10]:39857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fbTWF-0007ng-AQ
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fbTWC-00085w-6V
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:23:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34044 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fbTWC-00085R-1P
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:23:36 -0400
Date: Fri, 6 Jul 2018 17:23:32 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180706162331.GG2661@work-vm>
References: <20180706143105.93472-1-dgilbert@redhat.com>
	<CAFEAcA9JBpv+psc7PeENohPOcurzWHYPk4Pg09WCQM0S74XYbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9JBpv+psc7PeENohPOcurzWHYPk4Pg09WCQM0S74XYbQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] tests/migration: Skip tests for ppc
 tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 6 July 2018 at 15:31, Dr. David Alan Gilbert (git)
> <dgilbert@redhat.com> wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > PPC tcg seems to be failing migration tests quite regularly;
> > we believe this is TCG bugs in dirty bit updating; it's
> > not clear why PPC fails more but lets skip for the moment.
> >
> > $ ./tests/migration-test
> > /ppc64/migration/deprecated: OK
> > /ppc64/migration/bad_dest: Skipping test: kvm_hv not available OK
> > /ppc64/migration/postcopy/unix: Skipping test: kvm_hv not available OK
> > /ppc64/migration/precopy/unix: Skipping test: kvm_hv not available OK
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  tests/migration-test.c | 23 +++++++++++++++++------
> >  1 file changed, 17 insertions(+), 6 deletions(-)
> >
> 
> Applied to master, thanks -- hopefully this will reduce the
> number of spurious test failures I encounter.

Yes; although note I believe the failures are actually real TCG
errors that do need fixing, so not actually spurious as such.

Dave

> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
