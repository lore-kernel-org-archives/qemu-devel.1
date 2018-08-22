Received: from eggs.gnu.org ([2001:4830:134:3::10]:39127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fsRpZ-000718-E4
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fsRpV-0000IB-JN
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27369)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fsRpT-0000GJ-DE
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:40 -0400
Date: Wed, 22 Aug 2018 09:01:35 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180822120135.GN18995@localhost.localdomain>
References: <68a98c1b-e6dd-f2df-1499-17c2b8b583be@redhat.com>
	<20180817092936.GC11124@redhat.com>
	<e8a14a22915569b492adb414e5ccc98dcf64a24d.camel@redhat.com>
	<39b3c8b8-25eb-3a8e-3a5a-abd584a11e2c@laine.org>
	<f961907dde47f1a7fa3be400bed6356f136ec704.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f961907dde47f1a7fa3be400bed6356f136ec704.camel@redhat.com>
Subject: Re: [Qemu-devel] [libvirt] clean/simple Q35 support in libvirt+QEMU
 for guest OSes that don't support virtio-1.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: Laine Stump <laine@laine.org>, Libvirt <libvir-list@redhat.com>, qemu list <qemu-devel@nongnu.org>

On Wed, Aug 22, 2018 at 12:36:27PM +0200, Andrea Bolognani wrote:
> On Tue, 2018-08-21 at 14:21 -0400, Laine Stump wrote:
> > On 08/17/2018 06:35 AM, Andrea Bolognani wrote:
> > > If we decide we want to explicitly spell out the options instead
> > > of relying on QEMU changing behavior based on the slot type, which
> > > is probably a good idea anyway, I think we should have
> > > 
> > >   virtio-0.9 => disable-legacy=no,disable-modern=no
> > >   virtio-1.0 => disable-legacy=yes,disable-modern=no
> > > 
> > > There's basically no reason to have a device legacy-only rather
> > > than transitional, and spelling out both options instead of only
> > > one of them just seems more robust.
> > 
> > I agree with both of those, but the counter-argument is that "virtio"
> > already describes a transitional device like your proposal for
> > virtio-0.9 (at least today), and it makes the versioned models less
> > orthogonal. In the end, I could go either way...
> 
> Yeah, Dan already made that argument and convinced me that we
> should use virtio-0.9 for legacy only, virtio-1.0 for modern only
> and plain virtio for no enforced behavior / transitional.

I don't understand why we are optimizing the new system for the
less useful use cases:

I don't see a use case where virtio-0.9 (legacy-only) would be
more useful than virtio-transitional.  I don't see why anybody
would prefer a legacy-only device instead of a transitional
device.  Even if your guest has only legacy drivers, it might be
upgraded and get new drivers in the future.

I don't see a use case where virtio-1.0 (modern-only) would be
more useful than "virtio".  If you are running i440fx, you get a
transitional device with "virtio", and I don't see why anybody
would prefer a modern-only device.  If you are running Q35, you
already get a modern-only device with "virtio".

The most useful feature users need is the ability to ask for a
transitional virtio device on Q35, and this use case is
explicitly being left out of the proposal.  Why?

-- 
Eduardo
