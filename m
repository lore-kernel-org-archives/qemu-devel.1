Received: from eggs.gnu.org ([2001:4830:134:3::10]:59408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fQYNr-0002KV-J3
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:21:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fQYNo-0002WA-Et
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:21:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52158 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fQYNo-0002Vp-AH
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:21:48 -0400
Date: Wed, 6 Jun 2018 15:21:46 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180606132146.gcqbyfhu6whwszzq@sirius.home.kraxel.org>
References: <20180425140749.6x3w4h4i2n6uaq7o@sirius.home.kraxel.org>
	<1ed94b1c-b416-eebe-9cf3-91943a0e6c5a@redhat.com>
	<20180531084347.xb2r5aolkis2nmqg@sirius.home.kraxel.org>
	<4b65af58-8451-a365-6c81-52c49e42b6ff@redhat.com>
	<20180605110647.7ctaj7fiy6x4ewdw@sirius.home.kraxel.org>
	<a3fe57cf-1569-834d-5528-d85847b29f9f@redhat.com>
	<20180605131649.fu3cellm7vwaf4ao@sirius.home.kraxel.org>
	<20d457f0-647f-04e3-76c3-ed58f3494208@redhat.com>
	<20180606084900.77jv3z4il47bx5gi@sirius.home.kraxel.org>
	<149b77cf-d195-5bf1-d9b8-7e4a0e639411@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149b77cf-d195-5bf1-d9b8-7e4a0e639411@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/7] ramfb: simple boot framebuffer,
 no legacy vga
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>

  Hi,

> > QemuRamfbDxe registers as VenHw device with a fresh generated uuid.
> > The uuid should probably go to some header file, suggestions where to
> > place it best?
> 
> (1) Under "OvmfPkg/Include/Guid/". The file "VirtioMmioTransport.h" is a
> minimal example.

Ok.

> (4) Once you add the venhw GUID as a standalone header file (see (1)),
> you won't need to duplicate the constants between patches. In
> "gQemuRamfbDevicePath", you'll be able to use the EFI_GUID structure
> initializer macro from the header file.

Sure.

> (5) Does it work if you replace ACPI_ADR_DISPLAY_TYPE_VGA with
> ACPI_ADR_DISPLAY_TYPE_EXTERNAL_DIGITAL? QemuVideoDxe uses the former,
> but VirtioGpuDxe uses the latter. Windows has some really obscure
> requirements dependent on "ACPI display type", if I remember correctly,
> and "external" looked the most robust when I last checked.

I'll try.

> > so consplitter will pick up the ramfb device even though it isn't a
> > pci display device. The firmware display will show up on ramfb in
> > addition to other display devices (if any).  Is that approach ok?
> 
> Absolutely, that's what we want.

Cool.

> > If so I'll do that for armvirt too.
> 
> (6) No extra steps should be necessary for ArmVirtPkg; in the

> Therefore, the second call will simply pick up the devpath from the new
> child (GOP) handle automatically, and add it to both ConOut and ErrOut.
> 
> Does it not work for you?

Didn't test arm at all yet, wanted to get x86 into shape first.  I'll
have a look as soon as I've fixed all the things listed above on x86.

thanks,
  Gerd
