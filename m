Received: from eggs.gnu.org ([2001:4830:134:3::10]:46202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gWzwx-000856-0U
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 03:32:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gWzws-0007L4-3c
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 03:32:58 -0500
Date: Wed, 12 Dec 2018 09:32:50 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181212083250.56xfzy5j4t4o6ale@sirius.home.kraxel.org>
References: <20181207160806.13569-1-mark.cave-ayland@ilande.co.uk>
	<20181207160806.13569-3-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207160806.13569-3-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 2/3] mac_newworld: enable access to EDID
 data for the VGA device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On Fri, Dec 07, 2018 at 04:08:05PM +0000, Mark Cave-Ayland wrote:
> This is in preparation for some upcoming QEMU NDRV driver changes that pass
> display information from the host to the guest.

> -    pci_vga_init(pci_bus);
> +    dev = qdev_create(BUS(pci_bus), "VGA");
> +    qdev_prop_set_int32(dev, "addr", -1);
> +    qdev_prop_set_bit(dev, "edid", true);
> +    qdev_init_nofail(dev);

Hmm.  IMO you should not overwrite the device defaults here.

edid is off by default only because it is new and I'm conservative.
I want a release (or two) with it being available for user testing.
If no issues pop up flip it to default on.

cheers,
  Gerd
