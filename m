Received: from eggs.gnu.org ([2001:4830:134:3::10]:39369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eg68G-00023c-3b
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 04:53:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eg68D-0008NO-1X
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 04:53:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eg68C-0008LM-Ly
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 04:53:40 -0500
Date: Mon, 29 Jan 2018 09:53:31 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180129095330.GA2408@work-vm>
References: <20180124212246.2352-1-wei@redhat.com>
	<20180125200525.GC2442@work-vm>
	<6e27688f-1350-62f5-23ff-7855ea502be9@redhat.com>
	<CAFEAcA_9HJBETLvsUs9dk=Hw-G_eswNt3R+o+fs70vM9buAeBA@mail.gmail.com>
	<20180126194559.GI2610@work-vm>
	<CAFEAcA_QgROXb-7ZbWhL6zM5RmqLK5hyU7Whh+-7REMsXghQmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_QgROXb-7ZbWhL6zM5RmqLK5hyU7Whh+-7REMsXghQmA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH V1 1/1] tests: Add migration test for
 aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Wei Huang <wei@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Andrew Jones <drjones@redhat.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 26 January 2018 at 19:46, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> > * Peter Maydell (peter.maydell@linaro.org) wrote:
> >> I think the correct fix here is that your test code should turn
> >> its MMU on. Trying to treat guest RAM as uncacheable doesn't work
> >> for Arm KVM guests (for the same reason that VGA device video memory
> >> doesn't work). If it's RAM your guest has to arrange to map it as
> >> Normal Cacheable, and then everything should work fine.
> >
> > Does this cause problems with migrating at just the wrong point during
> > a VM boot?
> 
> It wouldn't surprise me if it did, but I don't think I've ever
> tried to provoke that problem...

If you think it'll get the RAM contents wrong, it might be best to fail
the migration if you can detect the cache is disabled in the guest.

Dave

> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
