Received: from eggs.gnu.org ([2001:4830:134:3::10]:37223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cGmw7-0005xH-3L
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:16:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cGmw3-0007tn-SP
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:16:03 -0500
Received: from 16.mo1.mail-out.ovh.net ([178.33.104.224]:56570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cGmw3-0007tP-M2
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:15:59 -0500
Received: from player795.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id D81DE284D8
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 14:15:57 +0100 (CET)
Date: Tue, 13 Dec 2016 14:15:43 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20161213141543.06812da0@bahia.lan>
In-Reply-To: <491c0ca6-c559-441b-7a14-3656bfc0abfc@redhat.com>
References: <20161031025314.GJ18226@umbus.fritz.box>
	<ee1d7da4-373c-4be0-7e67-897a1c90042f@ozlabs.ru>
	<20161101024634.GA14860@umbus.fritz.box>
	<1479218565.3319.18.camel@redhat.com>
	<3353ecef-2308-13e3-025d-df41b2e89945@ozlabs.ru>
	<1479457042.1391.11.camel@redhat.com>
	<20161123050049.GD17795@umbus.fritz.box>
	<1480081581.4367.65.camel@redhat.com>
	<20161202041835.GF10089@umbus.fritz.box>
	<1481045447.6553.36.camel@redhat.com>
	<20161207041121.GB12489@umbus.fritz.box>
	<1481128923.3620.1.camel@redhat.com>
	<491c0ca6-c559-441b-7a14-3656bfc0abfc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH qemu] spapr_pci: Create
 PCI-express root bus by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: Andrea Bolognani <abologna@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, libvir-list@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>, benh@kernel.crashing.org, Marcel Apfelbaum <mapfelba@redhat.com>

On Tue, 13 Dec 2016 14:25:44 +0200
Marcel Apfelbaum <marcel@redhat.com> wrote:

> >> Now... from what Laine was saying it sounds like more of the
> >> differences between PCI-E placement and PCI placement may be
> >> implemented by libvirt than qemu than I realized.  So possibly we do
> >> want to make the bus be PCI-E on the qemu side, but have libvirt use
> >> the vanilla-PCI placement guidelines rather than PCI-E for pseries.  
> >
> > Basically the special casing I was mentioning earlier.  
> 
> That looks complicated.. I wish I would no more about the pseries
> PCIe stuff, does any one know where I can get the info ? (besides 'google it'...)

This is described in the LoPAPR specification, available at:

https://openpowerfoundation.org/wp-content/uploads/2016/05/LoPAPR_DRAFT_v11_24March2016_cmt1.pdf

Cheers.

--
Greg
