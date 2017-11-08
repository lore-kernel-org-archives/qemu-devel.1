Received: from eggs.gnu.org ([2001:4830:134:3::10]:50093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eCWd3-0002bv-JH
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 15:07:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eCWd0-0004GT-Ec
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 15:07:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eCWd0-0004G4-81
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 15:07:14 -0500
Date: Wed, 8 Nov 2017 18:07:02 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171108200702.GT3111@localhost.localdomain>
References: <fddffbab-7aab-72b4-f42f-d18e94517350@redhat.com>
	<17ed046b-2c29-340b-9802-f43a709715e2@redhat.com>
	<20171010155003.GD3246@localhost.localdomain>
	<4b9e65ed-3636-bff4-3cca-52f6b80bca3b@redhat.com>
	<20171010194117.GK3246@localhost.localdomain>
	<cdd2b3da-b243-0d17-c3b7-305532b3bc43@redhat.com>
	<20171013190138.GB3246@localhost.localdomain>
	<c0614596-8157-0d91-77a7-e28946b8b13f@redhat.com>
	<20171013235644.GE3246@localhost.localdomain>
	<eea713f7-2b5e-0233-ebd2-6610d344d2d0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eea713f7-2b5e-0233-ebd2-6610d344d2d0@redhat.com>
Subject: Re: [Qemu-devel] [libvirt] [PATCH 0/7] x86: Rework KVM-defaults
 compat code, enable kvm_pv_unhalt by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Waiman Long <longman@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

On Tue, Nov 07, 2017 at 12:21:16PM +0100, Paolo Bonzini wrote:
> On 14/10/2017 01:56, Eduardo Habkost wrote:
> > Now, I don't know yet what's the best default for a guest that
> > has CONFIG_PARAVIRT_SPINLOCK when it sees a host that supports
> > kvm_pv_unhalt.  But I'm arguing that it's the guest
> > responsibility to choose what to do when it detects such a host,
> > instead of expecting the host to hide features from the guest.
> > The guest and the guest administrator have more information to
> > choose what's best.
> > 
> > In other words, if exposing kvm_pv_unhalt on CPUID really makes
> > some guests behave poorly, can we fix the guests instead?
> 
> Waiman just did it. :)
> 
> https://marc.info/?l=linux-kernel&m=150972337909996

Thanks for the pointer.  I will resubmit the series for 2.12
after 2.11 is released.

-- 
Eduardo
