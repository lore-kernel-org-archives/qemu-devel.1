Received: from eggs.gnu.org ([2001:4830:134:3::10]:58264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fNbeF-0000Vy-MJ
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fNbeA-00048i-O1
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:14:35 -0400
Date: Tue, 29 May 2018 12:14:17 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180529121417.1e44484b.cohuck@redhat.com>
In-Reply-To: <20180528232719.4721-13-f4bug@amsat.org>
References: <20180528232719.4721-1-f4bug@amsat.org>
	<20180528232719.4721-13-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 12/21] hw: Do not include
 "sysemu/block-backend.h" if it is not necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, Michael Walle <michael@walle.cc>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Fam Zheng <famz@redhat.com>, Magnus Damm <magnus.damm@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Max Filippov <jcmvbkbc@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:virtio-blk" <qemu-block@nongnu.org>, "open
	list:sPAPR" <qemu-ppc@nongnu.org>, "open list:virtio-ccw" <qemu-s390x@nongnu.org>, "open list:X86" <xen-devel@lists.xenproject.org>

On Mon, 28 May 2018 20:27:10 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Remove those unneeded includes to speed up the compilation
> process a little bit. (Continue 7eceff5b5a1fa cleanup)
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/collie.c                          | 1 -
>  hw/arm/gumstix.c                         | 1 -
>  hw/arm/mainstone.c                       | 1 -
>  hw/arm/nseries.c                         | 1 -
>  hw/arm/omap1.c                           | 1 -
>  hw/arm/omap2.c                           | 1 -
>  hw/arm/omap_sx1.c                        | 1 -
>  hw/arm/pxa2xx.c                          | 1 -
>  hw/arm/spitz.c                           | 1 -
>  hw/arm/versatilepb.c                     | 1 -
>  hw/arm/vexpress.c                        | 1 -
>  hw/arm/virt.c                            | 1 -
>  hw/arm/xilinx_zynq.c                     | 1 -
>  hw/arm/z2.c                              | 1 -
>  hw/block/dataplane/virtio-blk.c          | 1 -
>  hw/block/virtio-blk.c                    | 1 -
>  hw/core/qdev-properties.c                | 1 -
>  hw/cris/axis_dev88.c                     | 1 -
>  hw/display/tc6393xb.c                    | 1 -
>  hw/ide/pci.c                             | 1 -
>  hw/ide/via.c                             | 1 -
>  hw/isa/isa-superio.c                     | 1 -
>  hw/lm32/lm32_boards.c                    | 1 -
>  hw/lm32/milkymist.c                      | 1 -
>  hw/microblaze/petalogix_ml605_mmu.c      | 1 -
>  hw/microblaze/petalogix_s3adsp1800_mmu.c | 1 -
>  hw/mips/mips_r4k.c                       | 1 -
>  hw/ppc/spapr.c                           | 1 -
>  hw/ppc/virtex_ml507.c                    | 2 --
>  hw/s390x/virtio-ccw.c                    | 1 -
>  hw/scsi/mptsas.c                         | 1 -
>  hw/sd/pl181.c                            | 1 -
>  hw/sd/sdhci.c                            | 1 -
>  hw/sd/ssi-sd.c                           | 1 -
>  hw/sh4/r2d.c                             | 1 -
>  hw/virtio/virtio-pci.c                   | 1 -
>  hw/xen/xen_devconfig.c                   | 1 -
>  hw/xtensa/xtfpga.c                       | 1 -
>  38 files changed, 39 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>
