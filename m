Received: from eggs.gnu.org ([2001:4830:134:3::10]:50289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e2etD-00082l-3q
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 10:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e2et8-0006iA-AQ
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 10:55:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e2et8-0006hP-4k
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 10:55:06 -0400
Date: Thu, 12 Oct 2017 16:54:58 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171012165458.0648efd8.cohuck@redhat.com>
In-Reply-To: <641129f5-6dde-eafb-fda6-822ff0e83bd4@linux.vnet.ibm.com>
References: <1507124979-8880-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1507124979-8880-5-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171009084506.77da9d5c@t450s.home>
	<e59c8274-c390-b99f-85dd-ec3763520ff1@linux.vnet.ibm.com>
	<20171010113520.6c3d03e3.cohuck@redhat.com>
	<1952d9c1-6ef8-0f1d-d89a-08e1236ad275@linux.vnet.ibm.com>
	<20171011142053.1f1e2723.cohuck@redhat.com>
	<641129f5-6dde-eafb-fda6-822ff0e83bd4@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 4/5] s390x/pci: Refuse to realize
 VFIO-PCI if AIS needed but supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: pasic@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, Alex Williamson <alex.williamson@redhat.com>

On Thu, 12 Oct 2017 16:48:26 +0200
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> On 11/10/2017 14:20, Cornelia Huck wrote:
> > On Tue, 10 Oct 2017 18:01:53 +0200
> > Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
> >   
> >> Since in the case we have no AIS in KVM only PCI is impacted, do you
> >> think we can fence IRQFD for MSI with
> >>
> >> kvm_msi_via_irqfd_allowed = false;
> >>
> >> in kvm_arch_init_irq_routing() ?  
> > 
> > Hm, it seems we never set that for s390x... does that imply that we
> > never support irqfd for pci anyway?  
> 
> ... yes, we never supported irqfd for virtio-pci anyway.
> This explains a lot of things to me.
> :)

:D

> 
> >   
> >>
> >> In fact, if we also verify the AIS availability in the same routine we
> >> can avoid the ugly include of vfio/pci.h  
> > 
> > If we can get the serialization right (and setting that value to false
> > does indeed have the desired effect), that's probably the way to go.
> >   
> 
> So now, in v2, we will be able to **enable** irqfd if we detect that we 
> handle AIS in kernel. :)

Let's see how that works out :)
