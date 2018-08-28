Received: from eggs.gnu.org ([2001:4830:134:3::10]:34359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1fuhNm-000384-0r
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 13:02:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1fuhNY-0007AJ-GN
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 13:02:14 -0400
Received: from mail-qt0-x233.google.com ([2607:f8b0:400d:c0d::233]:43727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1fuhNX-00078Q-FO
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 13:02:07 -0400
Received: by mail-qt0-x233.google.com with SMTP id g53-v6so2500087qtg.10
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 10:02:06 -0700 (PDT)
Date: Tue, 28 Aug 2018 13:02:04 -0400
From: Kevin O'Connor <kevin@koconnor.net>
Message-ID: <20180828170203.GA1018@morn.lan>
References: <1533793434-7614-1-git-send-email-whois.zihan.yang@gmail.com>
	<ece2a3ff-678d-00b6-3fd6-660972c5beca@gmail.com>
	<20180827070406.t525gr43qpu7wpsj@sirius.home.kraxel.org>
	<CAKwiv-gyGoqEpmpicxo_a3cQBsb0-XoT9cqkJu5WOtkUtAx0eQ@mail.gmail.com>
	<5f5dc082-7053-d6b9-b01f-fffba1847ba5@gmail.com>
	<20180828060752.mmsd7x7uobqm2gsr@sirius.home.kraxel.org>
	<8b232ca6-4643-24c7-d93d-589a452d0785@gmail.com>
	<20180828101458.pnsldezdzp6tdulp@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828101458.pnsldezdzp6tdulp@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [SeaBIOS] [RFC v2 0/3] Support multiple pci
 domains in pci_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, seabios@seabios.org, qemu-devel@nongnu.org, Zihan Yang <whois.zihan.yang@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Tue, Aug 28, 2018 at 12:14:58PM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > > Where is the pxb-pcie device?  0000:$somewhere?  Or $domain:00:00.0?
> > 
> >  0000:$somewhere (On PCI domain 0)
> 
> Cool, so we don't have an chicken-and-egg issue.
> 
> > > If we can access pxb-pcie registers before configuring MMCFG then yes,
> > > we should use pxb-pcie registers for that.
> > 
> > Yes, we can.
> 
> Ok, so we can configure mmcfg as hidden pci bar, simliar to the q35
> mmcfg.  Any configuration hints can be passed as pci vendor capability
> (simliar to the bridge window size hints), if needed.

Just so I understand, the proposal is to have SeaBIOS search for
pxb-pcie devices on the main PCI bus and allocate address space for
each.  (These devices would not be considered pci buses in the
traditional sense.)  Then SeaBIOS will traverse that address space
(MMCFG) and allocate BARs (both address space and io space) for the
PCI devices found in that address space.  Finally, QEMU will take all
those allocations and use it when generating the ACPI tables.

Did I get that right?

-Kevin
