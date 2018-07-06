Received: from eggs.gnu.org ([2001:4830:134:3::10]:46491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fbKwa-0003oK-Ro
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 03:14:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fbKwX-00069a-ME
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 03:14:16 -0400
Date: Fri, 6 Jul 2018 09:14:09 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180706071409.un7f6yg4me3hklfp@sirius.home.kraxel.org>
References: <20180704112859.20146-1-kraxel@redhat.com>
	<20180704185321.GZ7451@localhost.localdomain>
	<6a0aba7b46b168360fb291eaec769eb0@sebastianbauer.info>
	<20180704205206.GG7451@localhost.localdomain>
	<20180704210459.GH7451@localhost.localdomain>
	<e60e8b1220bd00040b5ae08f93095e28@sebastianbauer.info>
	<20180705131211.GJ7451@localhost.localdomain>
	<cf24174f-04c0-6044-546c-5ff1d83761d2@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf24174f-04c0-6044-546c-5ff1d83761d2@ilande.co.uk>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] vga: make stdvga the global
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sebastian Bauer <mail@sebastianbauer.info>, Aleksandar Markovic <aleksandar.markovic@mips.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>

On Thu, Jul 05, 2018 at 05:24:09PM +0100, Mark Cave-Ayland wrote:
> On 05/07/18 14:12, Eduardo Habkost wrote:
> 
> > > I also checked the code, default values are used also for other fields in
> > > that struct (e.g., default_cpus). If default values are considered fragile,
> > > they must be changed as well in the middle term. However, given a solid
> > > documentation (which is currently missing for these fields) I still think
> > > that default values are acceptable.
> > > 
> > > Note that there seems also be the possibility to set != NULL default values
> > > in the machine_class_init() function.
> > 
> > I don't mind if the default value is defined at
> > machine_class_init() or main().  What bothers me is a default
> > value that depends on vga_interface_available(), because it can
> > be easily broken by a build config change (as demonstrated by the
> > bug fixed by this patch).
> 
> I've already sent David a for-3.0 patch to set stdvga for the PPC Mac
> machines, but should I also do the same for PReP too?

Makes sense, yes.

> Is it also worth explicitly adding this for sun4u? And what about
> non-ISA/PCI cards such as sun4m's TCX/CG3?

Hmm, sparc has its own mechanism to use tcx as default (IIRC you get tcx
unless -vga cg3 is specified).  Should be possible to switch this over
to use the MachineClass field instead.

cheers,
  Gerd
