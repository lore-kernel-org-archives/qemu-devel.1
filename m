Received: from eggs.gnu.org ([2001:4830:134:3::10]:44380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eg6XV-0003yz-4x
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:19:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eg6XP-0006JL-FE
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:19:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eg6XP-0006HS-9P
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:19:43 -0500
Date: Mon, 29 Jan 2018 10:19:36 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180129101935.GB2408@work-vm>
References: <20180124212246.2352-1-wei@redhat.com>
	<20180125200525.GC2442@work-vm>
	<6e27688f-1350-62f5-23ff-7855ea502be9@redhat.com>
	<CAFEAcA_9HJBETLvsUs9dk=Hw-G_eswNt3R+o+fs70vM9buAeBA@mail.gmail.com>
	<20180126194559.GI2610@work-vm>
	<CAFEAcA_QgROXb-7ZbWhL6zM5RmqLK5hyU7Whh+-7REMsXghQmA@mail.gmail.com>
	<20180129095330.GA2408@work-vm>
	<CAFEAcA97sfayAEypoArqg4zt5eiv-D9_VoXkeTqz3wn2LutF5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA97sfayAEypoArqg4zt5eiv-D9_VoXkeTqz3wn2LutF5Q@mail.gmail.com>
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
Cc: Wei Huang <wei@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 29 January 2018 at 09:53, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> > * Peter Maydell (peter.maydell@linaro.org) wrote:
> >> On 26 January 2018 at 19:46, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> >> > * Peter Maydell (peter.maydell@linaro.org) wrote:
> >> >> I think the correct fix here is that your test code should turn
> >> >> its MMU on. Trying to treat guest RAM as uncacheable doesn't work
> >> >> for Arm KVM guests (for the same reason that VGA device video memory
> >> >> doesn't work). If it's RAM your guest has to arrange to map it as
> >> >> Normal Cacheable, and then everything should work fine.
> >> >
> >> > Does this cause problems with migrating at just the wrong point during
> >> > a VM boot?
> >>
> >> It wouldn't surprise me if it did, but I don't think I've ever
> >> tried to provoke that problem...
> >
> > If you think it'll get the RAM contents wrong, it might be best to fail
> > the migration if you can detect the cache is disabled in the guest.
> 
> I guess QEMU could look at the value of the "MMU disabled/enabled" bit
> in the guest's system registers, and refuse migration if it's off...
> 
> (cc'd Marc, Christoffer to check that I don't have the wrong end
> of the stick about how thin the ice is in the period before the
> guest turns on its MMU...)

OK; I mean it's not nice either way - but a failed migration is better
than one with corrupt RAM.

It's not pretty for cloud users; they do host-evacuations and the like
fully automatically without any knowledge of the state of a VM and hope
for migrations to work in any state.

Dave

> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
