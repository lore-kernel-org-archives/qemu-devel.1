Received: from eggs.gnu.org ([209.51.188.92]:37116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gjkMj-0002t3-As
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 07:32:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gjkMi-0001dx-98
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 07:32:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gjkMi-0001ah-24
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 07:32:16 -0500
Date: Wed, 16 Jan 2019 13:31:33 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190116133133.3c43531f@redhat.com>
In-Reply-To: <20190116115217.jduhqrwbjhuibmoq@sirius.home.kraxel.org>
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
	<1547566866-129386-11-git-send-email-imammedo@redhat.com>
	<15698cec-79eb-7a17-cf70-3a8fcb7962a6@redhat.com>
	<20190116113227.47ebdea2@redhat.com>
	<314cffa2-f153-011a-9c6e-01e94c73590a@redhat.com>
	<20190116115217.jduhqrwbjhuibmoq@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1E?= =?UTF-8?B?YXVkw6k=?= <philmd@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Andrew Jones <drjones@redhat.com>

On Wed, 16 Jan 2019 12:52:17 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
> 
> > This approach allows the UEFI app source to live in the QEMU tree, and
> > the affected maintainer(s) would be personally responsible for setting
> > up their edk2 clones, and compilers. (The edk2 clone could even be a
> > submodule of QEMU, for example at roms/edk2.) For example,
> > "roms/Makefile" already calls an external EFIROM utility (also from
> > edk2) in order to build the combined iPXE option ROMs.
> > 
> > And yes, we could turn the UEFI binaries into bootable ISO images at once.
> > 
> > I'll try to post some patches soon (or not so soon). I think the app's
> > source code, and the edk2 submodule, should live under roms/, and the
> > bootable images should live under pc-bios/.
> > 
> > (In fact we could use this opportunity to build & bundle OVMF itself...
> > not sure if that's in scope for now. Gerd, what's your take?)  
> 
> Well, there is still the idea to move over firmware submodules and
> prebuilt firmware blobs to a separate repo.  Expermimental repo:
> https://git.kraxel.org/cgit/qemu-firmware/.  Not touched for more than a
> year due to being busy with other stuff.  Oh well ...
> 
> (if someone feels like picking this up feel free to do so).
> 
> I think adding edk2 as submodule below roms/ makes sense.  Adding rules
> to roms/Makefile to build the blobs makes sense too.  Not sure we want
> the binaries actually copied over to pc-bios/ and commited as the uefi
> firmware is pretty big ...
> 
> Not sure what a good place for the uefi app would be.  I'd tend to not
> use roms/, that is the place for firmware submodules.  contrib/ or test/
> maybe?
Could be tests/data/acpi in this case

> 
> cheers,
>   Gerd
> 
