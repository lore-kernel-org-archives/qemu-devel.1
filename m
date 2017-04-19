Received: from eggs.gnu.org ([2001:4830:134:3::10]:57962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0edT-0003BW-Jv
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 21:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0edS-0001xO-CE
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 21:42:23 -0400
Date: Tue, 18 Apr 2017 22:42:07 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170419014207.GT25239@thinpad.lan.raisama.net>
References: <20170418221724.5707-1-ehabkost@redhat.com>
	<20170418221724.5707-4-ehabkost@redhat.com>
	<20170419002926.GC23273@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170419002926.GC23273@umbus.fritz.box>
Subject: Re: [Qemu-devel] [RFC v2 3/6] pci: Rename and change signatures of
 pci_bus_new() & related functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, aik@ozlabs.ru, David Gibson <dgibson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Alexander Graf <agraf@suse.de>, Aurelien Jarno <aurelien@aurel32.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Paul Burton <paul.burton@imgtec.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Scott Wood <scottwood@freescale.com>, Yongbok Kim <yongbok.kim@imgtec.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

On Wed, Apr 19, 2017 at 10:29:26AM +1000, David Gibson wrote:
> On Tue, Apr 18, 2017 at 07:17:21PM -0300, Eduardo Habkost wrote:
> > pci_bus_new*() and pci_register_bus() work only when the 'parent'
> > argument is a PCI_HOST_BRIDGE object. Rename them to reflect that they
> > are meant to initialize a bus that's in a PCI host bridge.
> > 
> > The new function names are:
> > * pci_host_bus_init() (replacing pci_bus_new())
> > * pci_host_bus_init_inplace() (replacing pci_bus_new_inplace())
> > * pci_host_bus_init_irqs() (replacing pci_register_bus())
> 
> I like the idea, but I'm not terribly convinced by these names.
> Aren't functions which allocate objects usually called whatever_new()
> rather than whatever_init()?  And pci_register_bus() appears to do
> more than just initialize irqs.

I agree the names aren't terribly clear. This is what they are
supposed to mean:

* pci_host_bus_init(phb) initializes phb->bus.
* pci_host_bus_init(phb) initializes phb->bus using an
  already-allocated object.
* pci_host_bus_init_irqs() does the same as pci_host_bus_init(),
  but also calls pci_bus_irqs().

I plan to submit API documentation comments later. I am open to
alternative name suggestions.

-- 
Eduardo
