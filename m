Received: from eggs.gnu.org ([2001:4830:134:3::10]:38662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eJtoj-0006Wr-9t
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 23:17:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eJtoe-000399-9x
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 23:17:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eJtoe-00038l-3B
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 23:17:44 -0500
Date: Wed, 29 Nov 2017 06:17:40 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171129061258-mutt-send-email-mst@kernel.org>
References: <1511530010-511740-1-git-send-email-dplotnikov@virtuozzo.com>
	<20171128195817.GA29077@localhost.localdomain>
	<2cd31202-27c3-983f-85a9-6814ff504706@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd31202-27c3-983f-85a9-6814ff504706@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] i386: turn off l3-cache property by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>, pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org, rkagan@virtuozzo.com

On Tue, Nov 28, 2017 at 11:20:27PM +0300, Denis V. Lunev wrote:
> > There's one thing I don't understand in your test case: if you
> > just found out that Linux will behave worse if it assumes that
> > the VCPUs are sharing a L3 cache, why are you configuring a
> > 8-core VCPU topology explicitly?
> >
> > Do you still see a difference in the numbers if you use "-smp 8"
> > with no "cores" and "threads" options?
> >
> This is quite simple. A lot of software licenses are bound to the amount
> of CPU __sockets__. Thus it is mandatory in a lot of cases to set topology
> with 1 socket/xx cores to reduce the amount of money necessary to
> be paid for the software.

This answers the first question but not the second one.

If the answer to the second one is negative, then I don't understand why
changing the default makes sense.


I would expect qemu by default to be as close to emulating a physical
system as possible.  If one has to deviate from that for some workloads,
that is fine, but probably not a good default.

-- 
MST
