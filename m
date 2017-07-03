Received: from eggs.gnu.org ([2001:4830:134:3::10]:51001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS4Ii-0007za-4g
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS4If-0006zj-07
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:34:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dS4Ie-0006yb-Pu
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:34:12 -0400
Date: Mon, 3 Jul 2017 19:34:07 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170703193026-mutt-send-email-mst@kernel.org>
References: <1498773362-18675-1-git-send-email-zuban32s@gmail.com>
	<20170630020622-mutt-send-email-mst@kernel.org>
	<ec616cb6-f693-76c5-5732-ec6ee7840d9c@redhat.com>
	<20170703142711.0a1db036@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170703142711.0a1db036@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 0/6] q35: add acpi pci hotplug support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Aleksandr Bezzubikov <zuban32s@gmail.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

On Mon, Jul 03, 2017 at 02:27:11PM +0200, Igor Mammedov wrote:
> On Fri, 30 Jun 2017 10:25:05 +0300
> Marcel Apfelbaum <marcel@redhat.com> wrote:
> 
> [...]
> > 
> > So for the modern systems not supporting PCI ACPI hotplug
> > we don't need pci-bridges anyway, but for the older ones
> > the ACPI code of the pci-bridge will be loaded into the
> > ACPI namespace only if a pci-bridge is actually hot-plugged.
> 
> just note that the set of 'older' guest OSes is limited to
> one that do not support SHPC (i.e. to EOLed WinXP & co)
> as for linux and more modern Windows SHPC hotplug should
> just work without our ACPI hack (which taxes low memory
> to keep acpi tables for bridges).
> 
> So I'm in favor of Michael's suggestion to leave ACPI PCI
> only in PC machine for old WinXP guests and to keep Q35
> clean, where linux or newer Windows guests could just
> use standard SHPC.
> 
> [...]

I didn't realize windows actually supports SHPC for PCI.

Do they correctly set _OSC Arg3, bit offset 1?
	SHPC Native Hot Plug control
	The OS sets this bit to 1 to request control over PCI/PCI-X Standard Hot-Plug Controller
	(SHPC) hot plug. If the OS successfully receives control of this feature, it must track and
	update the status of hot plug slots and handle hot plug events as described in the SHPC
	Specification.
I was under impression they only set bit 0.

-- 
MST
