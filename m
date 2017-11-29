Received: from eggs.gnu.org ([2001:4830:134:3::10]:57845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eJvoP-00085t-BE
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 01:25:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eJvoK-0002X6-Ft
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 01:25:37 -0500
Received: from mail-he1eur01on0115.outbound.protection.outlook.com
	([104.47.0.115]:53207
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1eJvoJ-0002WL-Uw
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 01:25:32 -0500
Date: Wed, 29 Nov 2017 09:25:24 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20171129062523.GE2374@rkaganip.lan>
References: <1511530010-511740-1-git-send-email-dplotnikov@virtuozzo.com>
	<20171128195817.GA29077@localhost.localdomain>
	<2cd31202-27c3-983f-85a9-6814ff504706@virtuozzo.com>
	<20171129061258-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171129061258-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH] i386: turn off l3-cache property by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Denis V. Lunev" <den@virtuozzo.com>, Eduardo Habkost <ehabkost@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>, pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org

On Wed, Nov 29, 2017 at 06:17:40AM +0200, Michael S. Tsirkin wrote:
> On Tue, Nov 28, 2017 at 11:20:27PM +0300, Denis V. Lunev wrote:
> > > There's one thing I don't understand in your test case: if you
> > > just found out that Linux will behave worse if it assumes that
> > > the VCPUs are sharing a L3 cache, why are you configuring a
> > > 8-core VCPU topology explicitly?
> > >
> > > Do you still see a difference in the numbers if you use "-smp 8"
> > > with no "cores" and "threads" options?
> > >
> > This is quite simple. A lot of software licenses are bound to the amount
> > of CPU __sockets__. Thus it is mandatory in a lot of cases to set topology
> > with 1 socket/xx cores to reduce the amount of money necessary to
> > be paid for the software.
> 
> This answers the first question but not the second one.

The answer to the second one is no, there's no difference (from memory,
I don't have the numbers at hand.)

> If the answer to the second one is negative, then I don't understand why
> changing the default makes sense.

Because the setting adversly affected the performance in some
configurations?

That said, we may be well past the point where that would matter because
the new setting has been there for a few releases already...

> I would expect qemu by default to be as close to emulating a physical
> system as possible.  If one has to deviate from that for some workloads,
> that is fine, but probably not a good default.

Thanks,
Roman.
