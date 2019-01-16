Received: from eggs.gnu.org ([209.51.188.92]:40086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gjjkR-00015Y-Gs
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:52:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gjjkP-0007YP-U4
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:52:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gjjkP-0007Kh-GI
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:52:41 -0500
Date: Wed, 16 Jan 2019 12:52:17 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190116115217.jduhqrwbjhuibmoq@sirius.home.kraxel.org>
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
	<1547566866-129386-11-git-send-email-imammedo@redhat.com>
	<15698cec-79eb-7a17-cf70-3a8fcb7962a6@redhat.com>
	<20190116113227.47ebdea2@redhat.com>
	<314cffa2-f153-011a-9c6e-01e94c73590a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <314cffa2-f153-011a-9c6e-01e94c73590a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 10/14] tests: acpi: ignore SMBIOS tests
 when UEFI firmware is used
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Andrew Jones <drjones@redhat.com>

  Hi,

> This approach allows the UEFI app source to live in the QEMU tree, and
> the affected maintainer(s) would be personally responsible for setting
> up their edk2 clones, and compilers. (The edk2 clone could even be a
> submodule of QEMU, for example at roms/edk2.) For example,
> "roms/Makefile" already calls an external EFIROM utility (also from
> edk2) in order to build the combined iPXE option ROMs.
> 
> And yes, we could turn the UEFI binaries into bootable ISO images at once.
> 
> I'll try to post some patches soon (or not so soon). I think the app's
> source code, and the edk2 submodule, should live under roms/, and the
> bootable images should live under pc-bios/.
> 
> (In fact we could use this opportunity to build & bundle OVMF itself...
> not sure if that's in scope for now. Gerd, what's your take?)

Well, there is still the idea to move over firmware submodules and
prebuilt firmware blobs to a separate repo.  Expermimental repo:
https://git.kraxel.org/cgit/qemu-firmware/.  Not touched for more than a
year due to being busy with other stuff.  Oh well ...

(if someone feels like picking this up feel free to do so).

I think adding edk2 as submodule below roms/ makes sense.  Adding rules
to roms/Makefile to build the blobs makes sense too.  Not sure we want
the binaries actually copied over to pc-bios/ and commited as the uefi
firmware is pretty big ...

Not sure what a good place for the uefi app would be.  I'd tend to not
use roms/, that is the place for firmware submodules.  contrib/ or test/
maybe?

cheers,
  Gerd
