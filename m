Received: from eggs.gnu.org ([2001:4830:134:3::10]:38338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1coB8b-00054U-Pv
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 11:47:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1coB8a-0007xh-C2
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 11:46:57 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:47486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1coB8a-0007lj-6c
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 11:46:56 -0400
Date: Wed, 15 Mar 2017 16:46:38 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170315154638.2cofbirjrohz26ia@aurel32.net>
References: <87tw6y8bs8.fsf@secure.mitica>
	<CAFEAcA978SJemCfYJPa8jwtuhhi6JGh9pEDGYNJ1npJA3nvEQA@mail.gmail.com>
	<20170314081312.GB13140@stefanha-x1.localdomain>
	<CAFEAcA9F2BPexRieaEhu+UpJxoOdEfw8eggW8b2SjuoMMTNgog@mail.gmail.com>
	<87wpbstesf.fsf@secure.mitica> <20170314160113.GM2445@work-vm>
	<20170314162020.GT2652@redhat.com>
	<d9497461-e7c5-b914-362d-16b0cdea9fba@redhat.com>
	<CAFEAcA-Y=KNBTj32_C1HOuRcEL9vxMimxjPpwrQpG9apGqBjSQ@mail.gmail.com>
	<5a03eebc-669c-c67b-d857-f4d1bbbeff36@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a03eebc-669c-c67b-d857-f4d1bbbeff36@twiddle.net>
Subject: Re: [Qemu-devel] Obsolete QEMU host environments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, QEMU Developer <qemu-devel@nongnu.org>, KVM devel mailing list <kvm@vger.kernel.org>, Stefan Hajnoczi <stefanha@gmail.com>

On 2017-03-15 07:09, Richard Henderson wrote:
> On 03/15/2017 03:07 AM, Peter Maydell wrote:
> > On 14 March 2017 at 17:54, Thomas Huth <thuth@redhat.com> wrote:
> > > Our ia64 host backend in QEMU (tcg/ia64) is still marked as maintained
> > > ... so it's maybe not as dead as you think? Or should we rather get rid
> > > of that soon, too?
> > 
> > I don't actually mind whether we keep tcg/ia64 or drop it.
> > But if we keep it then we must have a machine we can test
> > it on -- that means one I have access to (and which we
> > can otherwise use for central testing), not just one the
> > maintainer might happen to have.
> > 
> > Also, that MAINTAINERS entry was added in 2011, so it's
> > probably about as out of date as the code :-)
> 
> Red Hat's last ia64 machine died a few years ago, so I haven't
> been able to test it for quite some time.
> 
> I don't know if Aurelien can still test on ia64 or not.

I have the same issue, the last QEMU test I have been able to do on an
ia64 machine dates from last summer, so something like 9 months ago. I
don't think anybody has a lot of interest in ia64 anymore, so I guess
it's time to just remove the ia64 host backend.

Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
