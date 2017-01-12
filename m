Received: from eggs.gnu.org ([2001:4830:134:3::10]:50573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <somlo@cmu.edu>) id 1cRV5T-00089N-O8
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:26:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <somlo@cmu.edu>) id 1cRV5S-00055J-GS
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:25:59 -0500
Date: Wed, 11 Jan 2017 21:25:10 -0500
From: "Gabriel L. Somlo" <somlo@cmu.edu>
Message-ID: <20170112022510.GA14378@foober.ini.cmu.edu>
References: <20170111173457.30455-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170111173457.30455-1-lersek@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 wave 1 0/4] fw-cfg: support writeable
 blobs and more files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, Anthony Perard <anthony.perard@citrix.com>, Artyom Tarasenko <atar4qemu@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Michael Walle <michael@walle.cc>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-arm@nongnu.org

On Wed, Jan 11, 2017 at 06:34:53PM +0100, Laszlo Ersek wrote:
> This is the first (fw_cfg) half of the v5 iteration of the series posted
> here:
> <http://lists.nongnu.org/archive/html/qemu-devel/2016-12/msg00129.html>.
> 
> In this version, the fw_cfg patches have been separated into a
> standalone "wave", for helping review / maintenance, and also for
> enabling independent features on top of writeable blobs. More
> importantly, I've addressed Igor's v4 feedback. See the individual
> patches for the details.
> 
> Patch #3 is included verbatim from Eduardo's pending series (see the
> patch notes for the archive URL), as a dependency for patch #4. If
> Eduardo's series is merged first, patch #3 can be dropped (in fact
> git-rebase should do it automatically).
> 
> Please excuse the surprisingly long list of CC's, it's due to the fact
> that fw_cfg is quite widely used (see patch #4).
> 
> Cc: "Gabriel L. Somlo" <somlo@cmu.edu>

Whole series:

Acked-by: Gabriel Somlo <somlo@cmu.edu>

Data passed in via the "-fw_cfg" qemu command still shows up fine in
/sys/firmware/qemu-fw-cfg on the guest, so also:

Tested-by: Gabriel Somlo <somlo@cmu.edu>

Thanks,
--Gabriel

> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Artyom Tarasenko <atar4qemu@gmail.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: Michael Walle <michael@walle.cc>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Shannon Zhao <zhaoshenglong@huawei.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: qemu-arm@nongnu.org
> 
> Thanks
> Laszlo
> 
> 
> Eduardo Habkost (1):
>   pc: Add 2.9 machine-types
> 
> Laszlo Ersek (2):
>   fw-cfg: turn FW_CFG_FILE_SLOTS into a device property
>   fw-cfg: bump "file_slots" to 0x20 for 2.9+ machine types
> 
> Michael S. Tsirkin (1):
>   fw-cfg: support writeable blobs
> 
>  docs/specs/fw_cfg.txt          |  36 ++++++++++----
>  hw/lm32/lm32_hwsetup.h         |   2 +-
>  include/hw/compat.h            |  10 +++-
>  include/hw/i386/pc.h           |   2 +
>  include/hw/loader.h            |   7 +--
>  include/hw/nvram/fw_cfg.h      |   3 +-
>  include/hw/nvram/fw_cfg_keys.h |   3 +-
>  hw/arm/virt-acpi-build.c       |   2 +-
>  hw/core/loader.c               |  18 ++++---
>  hw/i386/acpi-build.c           |   4 +-
>  hw/i386/pc_piix.c              |  15 ++++--
>  hw/i386/pc_q35.c               |  13 ++++-
>  hw/nvram/fw_cfg.c              | 110 +++++++++++++++++++++++++++++++++++------
>  13 files changed, 177 insertions(+), 48 deletions(-)
> 
> -- 
> 2.9.3
> 
