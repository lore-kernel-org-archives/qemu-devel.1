Received: from eggs.gnu.org ([2001:4830:134:3::10]:54109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fH8uQ-0006nN-Co
	for qemu-devel@nongnu.org; Fri, 11 May 2018 10:20:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fH8uM-0006Yb-ET
	for qemu-devel@nongnu.org; Fri, 11 May 2018 10:20:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41838 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fH8uM-0006XT-8c
	for qemu-devel@nongnu.org; Fri, 11 May 2018 10:20:30 -0400
Date: Fri, 11 May 2018 15:20:23 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180511142023.GD2720@work-vm>
References: <20180509112406.6183-1-quintela@redhat.com>
	<CAFEAcA9+qqcVO1gq7PiLqCdKiHkrE81KroEdz7+iPanQ50zJRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9+qqcVO1gq7PiLqCdKiHkrE81KroEdz7+iPanQ50zJRQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/41] Migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Juan Quintela <quintela@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 9 May 2018 at 12:23, Juan Quintela <quintela@redhat.com> wrote:
> > Hi
> >
> > this includes the reviewed patches for migration:
> > - update docs (dave)
> > - fixes for blocktime (text cleatups) (dave)
> > - migration+tls (dave)
> > - rdma index fix (lidong)
> > - Postcopy recovery (peterx)
> > - Parts reviewed of multifd and tests (me)
> >
> > There are missing parts of RDMA, will be sent after this is in.  This got already too big.
> >
> > Please, apply.
> >
> > The following changes since commit e5cd695266c5709308aa95b1baae499e4b5d4544:
> >
> >   Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2018-05-08 17:05:58 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/juanquintela/qemu.git tags/migration/20180509
> >
> > for you to fetch changes up to c14eb5ac63b0d2cd146ca004daaeaf56677b7ed1:
> >
> >   Migration+TLS: Fix crash due to double cleanup (2018-05-09 12:17:22 +0200)
> >
> > ----------------------------------------------------------------
> > migration/next for 20180509
> >
> 
> Hi. I get some test failures here:
> 
> S390x host:
> TEST: tests/migration-test... (pid=57456)
>   /ppc64/migration/deprecated:                                         OK
>   /ppc64/migration/bad_dest:                                           OK
>   /ppc64/migration/postcopy/unix:                                      OK
>   /ppc64/migration/precopy/unix:                                       OK
>   /ppc64/migration/xbzrle/unix:
> Unexpected 32 on dest_serial serial
> **
> ERROR:/home/linux1/qemu/tests/migration-test.c:144:wait_for_serial:
> code should not be reached
> FAIL
> 
> aarch64 host:
> 
> Memory content inconsistency at 44f7000 first_byte = 7 last_byte = 6
> current = 5 hit_edge = 1
> ERROR:/home/peter.maydell/qemu/tests/migration-test.c:281:check_guests_ram:
> 'bad' should be FALSE
> (this is probably for ppc64 guest; unfortunately this system doesn't
> have a make that knows about --output-sync, so the make check output
> is hard to interpret.)

I'd be tempted to drop 03/41 xbzrle test  and see what happens;
it's a heavy CPU eater so might be making things worse when in parallel.
I suspect that aarch64 case is the same one we occasionally hit
due to the page flag dirtying being wrong in TCG.

Can you do that without another pull?

Dave

> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
