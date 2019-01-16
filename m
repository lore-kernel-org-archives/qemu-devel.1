Received: from eggs.gnu.org ([209.51.188.92]:40546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gjiU4-0007Il-BI
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:31:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gjiHD-0002mL-Ew
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:18:30 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gjiH5-0002YW-4M
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:18:20 -0500
References: <20190115100058.44712-1-sgarzare@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <8604b9af-3102-fd67-483b-672b4d5c05f1@oracle.com>
Date: Wed, 16 Jan 2019 10:18:08 +0000
MIME-Version: 1.0
In-Reply-To: <20190115100058.44712-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/4] pvh: add new PVH option rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, George Kennedy <george.kennedy@oracle.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@redhat.com>, Maran Wilson <maran.wilson@oracle.com>


On 15/01/2019 10:00, Stefano Garzarella wrote:
> This patch series is based on "[RFC v2 0/4] QEMU changes to do PVH boot" and
> provides a PVH option rom that can be used with SeaBIOS to boot uncompressed
> kernel using the x86/HVM direct boot ABI.
> 
> Patches 1 and 2 are to prepare the PVH option rom, moving common functions in a
> new header.  Patch 3 adds the new PVH option rom and patch 4 uses it when we
> are booting an uncompressed kernel using the x86/HVM direct boot ABI.
> 
> Changes in v2:
> - addressed comments by Stefan and Eric:
>    - Patch 2: moved inludes on top of linuxboot_dma.c and add <stdint.h> in
>      optrom.h
>    - Patch 4: added check of pvh.bin in xen_load_linux()
> - modified commit message of patch 2 to explain better the patch
> 
> Stefano Garzarella (4):
>    linuxboot_dma: remove duplicate definitions of FW_CFG
>    linuxboot_dma: move common functions in a new header
>    optionrom: add new PVH option rom
>    hw/i386/pc: use PVH option rom
> 
>   hw/i386/pc.c                      |   5 +
>   pc-bios/optionrom/Makefile        |   5 +-
>   pc-bios/optionrom/linuxboot_dma.c | 112 +++--------------
>   pc-bios/optionrom/optrom.h        | 110 ++++++++++++++++
>   pc-bios/optionrom/optrom_fw_cfg.h |  92 ++++++++++++++
>   pc-bios/optionrom/pvh.S           | 200 ++++++++++++++++++++++++++++++
>   pc-bios/optionrom/pvh_main.c      | 117 +++++++++++++++++
>   7 files changed, 544 insertions(+), 97 deletions(-)
>   create mode 100644 pc-bios/optionrom/optrom.h
>   create mode 100644 pc-bios/optionrom/optrom_fw_cfg.h
>   create mode 100644 pc-bios/optionrom/pvh.S
>   create mode 100644 pc-bios/optionrom/pvh_main.c
> 

I had a few very minor comments on patch3, but with that, for the series:

Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
