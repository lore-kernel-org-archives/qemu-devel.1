Received: from eggs.gnu.org ([2001:4830:134:3::10]:45054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0TD9-0003SH-6a
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 09:30:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0TD8-0004hU-Ht
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 09:30:27 -0400
Date: Tue, 18 Apr 2017 10:30:05 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170418133005.GL25239@thinpad.lan.raisama.net>
References: <20170417215916.12431-1-ehabkost@redhat.com>
	<20170417215916.12431-4-ehabkost@redhat.com>
	<9cbafe84-88bb-ca3c-d85e-dae71af438ff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cbafe84-88bb-ca3c-d85e-dae71af438ff@redhat.com>
Subject: Re: [Qemu-devel] [RFC 3/7] pci: Change pci_bus_new*() parameter to
 PCIHostState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, aik@ozlabs.ru, David Gibson <dgibson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org

On Tue, Apr 18, 2017 at 04:27:23PM +0300, Marcel Apfelbaum wrote:
[...]
> > @@ -431,7 +430,7 @@ PCIBus *pci_register_bus(DeviceState *parent, const char *name,
> >  {
> >      PCIBus *bus;
> > 
> > -    bus = pci_bus_new(parent, name, address_space_mem,
> > +    bus = pci_bus_new(PCI_HOST_BRIDGE(parent), name, address_space_mem,
> 
> If you request the parent to be PCI_HOST_BRIDGE, why don't you change also the signature of
> pci_register_bus ?

I do it on patch 4/7.

-- 
Eduardo
