Received: from eggs.gnu.org ([2001:4830:134:3::10]:52643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ecTsj-0001ME-2c
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 05:26:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ecTse-0007GP-VL
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 05:26:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1ecTse-0007GF-Px
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 05:26:40 -0500
References: <20180110190049.5389.12984.stgit@gimli.home>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <046faef4-c823-00d6-3bc9-328ab5a9d46a@redhat.com>
Date: Fri, 19 Jan 2018 11:26:34 +0100
MIME-Version: 1.0
In-Reply-To: <20180110190049.5389.12984.stgit@gimli.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/5] vfio/pci: MSI-X MMIO relocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, aik@ozlabs.ru

Hi Alex,
On 10/01/18 20:01, Alex Williamson wrote:
> v1: https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg03350.html
> 
> See patch 5/5 for a thorough description.  v2 changes the 'auto'
> behavior as we've determined that there's no algorithm which has even
> a likely chance of success.  Instead, auto is now a placeholder for
> a device/platform lookup for known good combinations (though if I'm
> pessimistic, even that might depend on guest and driver versions).
> Thanks,
> 
> Alex
> 
> ---
> 
> Alex Williamson (5):
>       vfio/pci: Fixup VFIOMSIXInfo comment
>       vfio/pci: Add base BAR MemoryRegion
>       vfio/pci: Emulate BARs
>       qapi: Create DEFINE_PROP_OFF_AUTO_PCIBAR
>       vfio/pci: Allow relocating MSI-X MMIO
> 
> 
>  hw/core/qdev-properties.c    |   11 +++
>  hw/vfio/pci.c                |  175 ++++++++++++++++++++++++++++++++++++++----
>  hw/vfio/pci.h                |    6 +
>  hw/vfio/trace-events         |    2 
>  include/hw/qdev-properties.h |    4 +
>  qapi/common.json             |   26 ++++++
>  6 files changed, 206 insertions(+), 18 deletions(-)
> 

For the whole series:
Reviewed-by: Eric Auger <eric.auger@redhat.com>
(only minor comments on 5/5)

and
Tested-by: Eric Auger <eric.auger@redhat.com>
on aarch64 with a Mellanox CX-4 device

Thanks

Eric
