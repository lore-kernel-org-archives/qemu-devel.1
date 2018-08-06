Received: from eggs.gnu.org ([2001:4830:134:3::10]:52253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fmlm8-0002WD-Pt
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 16:06:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fmlm3-0005Z8-RN
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 16:06:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fmlm3-0005XP-K8
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 16:06:39 -0400
Date: Mon, 6 Aug 2018 17:06:35 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180806200635.GA12341@localhost.localdomain>
References: <20180805112850.26063-1-mark.cave-ayland@ilande.co.uk>
	<20180805112850.26063-2-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180805112850.26063-2-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 1/2] sysbus: always allow
 explicit_ofw_unit_address() to override address generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: marcel.apfelbaum@gmail.com, lersek@redhat.com, qemu-devel@nongnu.org

On Sun, Aug 05, 2018 at 12:28:49PM +0100, Mark Cave-Ayland wrote:
> Some SysBusDevices either use sysbus_init_mmio() without
> sysbus_mmio_map() or the first MMIO memory region doesn't represent the
> bus address, causing a firmware device path with an invalid address to
> be generated.
> 
> SysBusDeviceClass does provide a virtual explicit_ofw_unit_address()
> method that can be used to override this process, but it was originally intended
> only as as a fallback option meaning that any existing MMIO memory regions still
> take priority whilst determining the firmware device address.
> 
> There is currently only one user of explicit_ofw_unit_address() and that
> is the PCI expander bridge (PXB) device which has no MMIO/PIO resources
> defined. This enables us to allow explicit_ofw_unit_address() to take
> priority without affecting backwards compatibility, allowing the address
> to be customised as required.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Queueing for 3.1.

-- 
Eduardo
