Received: from eggs.gnu.org ([2001:4830:134:3::10]:53483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eFMr2-0004qi-8j
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:17:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eFMqw-0008U4-NH
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:17:28 -0500
Date: Thu, 16 Nov 2017 18:17:16 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171116181556-mutt-send-email-mst@kernel.org>
References: <20171116132339.4facb858@bahia.lab.toulouse-stg.fr.ibm.com>
	<20171116172602-mutt-send-email-mst@kernel.org>
	<20171116085345.7b02ecdd@t450s.home>
	<20171116175713-mutt-send-email-mst@kernel.org>
	<20171116090448.4d53ac71@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171116090448.4d53ac71@t450s.home>
Subject: Re: [Qemu-devel] QEMU terminates during reboot after memory unplug
 with vhost=on
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, imammedo@redhat.com, bharata@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On Thu, Nov 16, 2017 at 09:04:48AM -0700, Alex Williamson wrote:
> > Range is unmapped by listener but device has not been reset yet,
> > so it will get errors when attempting to access guest RAM.
> 
> So IOMMU faults would occur if the device continues to try to DMA
> into that range.  Sloppy ordering, but vfio wouldn't have any way to
> tell the difference between this and a runtime RAM unplug.

It's clear vfio won't be able to tell the difference, but
the device will as RAM unplug involves guest coordinating
with the device to avoid addressing the removed memory.

-- 
MST
