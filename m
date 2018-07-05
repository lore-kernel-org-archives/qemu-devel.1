Received: from eggs.gnu.org ([2001:4830:134:3::10]:42933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faxnP-00046l-DI
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 02:31:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faxnM-0002zc-AA
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 02:31:15 -0400
Date: Thu, 5 Jul 2018 08:31:07 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180705063107.d6osq5lrt7v6kbga@sirius.home.kraxel.org>
References: <20180704112859.20146-1-kraxel@redhat.com>
	<20180704185321.GZ7451@localhost.localdomain>
	<6a0aba7b46b168360fb291eaec769eb0@sebastianbauer.info>
	<20180704205206.GG7451@localhost.localdomain>
	<20180704210459.GH7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704210459.GH7451@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH] vga: make stdvga the global default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Sebastian Bauer <mail@sebastianbauer.info>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>

> roms/config.vga-bochs-display:CONFIG_VGA_PCI=y
> roms/config.vga-cirrus:CONFIG_VGA_CIRRUS=y
> roms/config.vga-cirrus:CONFIG_VGA_PCI=y
> roms/config.vga-isavga:CONFIG_VGA_PCI=n
> roms/config.vga-qxl:CONFIG_VGA_PCI=y
> roms/config.vga-ramfb:CONFIG_VGA_PCI=n
> roms/config.vga-stdvga:CONFIG_VGA_PCI=y
> roms/config.vga-virtio:CONFIG_VGA_PCI=y
> roms/config.vga-vmware:CONFIG_VGA_PCI=y
> 
> * I have no idea what this is, I guess this is not related to the
>   QEMU build system at all.  :)

seabios config, for vgabios builds (make -C roms vgabios).

cheers,
  Gerd
