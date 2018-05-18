Received: from eggs.gnu.org ([2001:4830:134:3::10]:57642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fJfB5-0004qy-58
	for qemu-devel@nongnu.org; Fri, 18 May 2018 09:12:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fJfB3-0005pe-Sb
	for qemu-devel@nongnu.org; Fri, 18 May 2018 09:12:11 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:39552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fJfB3-0005oQ-HZ
	for qemu-devel@nongnu.org; Fri, 18 May 2018 09:12:09 -0400
Received: by mail-wm0-x241.google.com with SMTP id f8-v6so15134983wmc.4
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 06:12:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180517092513.735-2-kraxel@redhat.com>
References: <20180517092513.735-1-kraxel@redhat.com>
	<20180517092513.735-2-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 18 May 2018 15:12:07 +0200
Message-ID: <CAJ+F1C+Gq9QDBLQiuFDJ3c8gdV3kLhk_mGD8DOfkdhB2+3ic=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] vga: move bochs vbe defines to header
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Thu, May 17, 2018 at 11:25 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> Create a new header file, move the bochs vbe dispi interface
> defines to it, so they can be used outside vga code.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/vga_int.h           | 35 ++---------------------
>  include/hw/display/bochs-vbe.h | 64 ++++++++++++++++++++++++++++++++++++=
++++++
>  hw/display/vga-pci.c           | 13 ---------
>  3 files changed, 66 insertions(+), 46 deletions(-)
>  create mode 100644 include/hw/display/bochs-vbe.h
>
> diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
> index fe23b81442..313cff84fc 100644
> --- a/hw/display/vga_int.h
> +++ b/hw/display/vga_int.h
> @@ -29,42 +29,11 @@
>  #include "exec/memory.h"
>  #include "ui/console.h"
>
> +#include "hw/display/bochs-vbe.h"
> +
>  #define ST01_V_RETRACE      0x08
>  #define ST01_DISP_ENABLE    0x01
>
> -#define VBE_DISPI_MAX_XRES              16000
> -#define VBE_DISPI_MAX_YRES              12000
> -#define VBE_DISPI_MAX_BPP               32
> -
> -#define VBE_DISPI_INDEX_ID              0x0
> -#define VBE_DISPI_INDEX_XRES            0x1
> -#define VBE_DISPI_INDEX_YRES            0x2
> -#define VBE_DISPI_INDEX_BPP             0x3
> -#define VBE_DISPI_INDEX_ENABLE          0x4
> -#define VBE_DISPI_INDEX_BANK            0x5
> -#define VBE_DISPI_INDEX_VIRT_WIDTH      0x6
> -#define VBE_DISPI_INDEX_VIRT_HEIGHT     0x7
> -#define VBE_DISPI_INDEX_X_OFFSET        0x8
> -#define VBE_DISPI_INDEX_Y_OFFSET        0x9
> -#define VBE_DISPI_INDEX_NB              0xa /* size of vbe_regs[] */
> -#define VBE_DISPI_INDEX_VIDEO_MEMORY_64K 0xa /* read-only, not in vbe_re=
gs */
> -
> -#define VBE_DISPI_ID0                   0xB0C0
> -#define VBE_DISPI_ID1                   0xB0C1
> -#define VBE_DISPI_ID2                   0xB0C2
> -#define VBE_DISPI_ID3                   0xB0C3
> -#define VBE_DISPI_ID4                   0xB0C4
> -#define VBE_DISPI_ID5                   0xB0C5
> -
> -#define VBE_DISPI_DISABLED              0x00
> -#define VBE_DISPI_ENABLED               0x01
> -#define VBE_DISPI_GETCAPS               0x02
> -#define VBE_DISPI_8BIT_DAC              0x20
> -#define VBE_DISPI_LFB_ENABLED           0x40
> -#define VBE_DISPI_NOCLEARMEM            0x80
> -
> -#define VBE_DISPI_LFB_PHYSICAL_ADDRESS  0xE0000000
> -
>  #define CH_ATTR_SIZE (160 * 100)
>  #define VGA_MAX_HEIGHT 2048
>
> diff --git a/include/hw/display/bochs-vbe.h b/include/hw/display/bochs-vb=
e.h
> new file mode 100644
> index 0000000000..6f27ed4a91
> --- /dev/null
> +++ b/include/hw/display/bochs-vbe.h
> @@ -0,0 +1,64 @@

No header guards & copyright notice?

> +/*
> + * bochs vesa bios extension interface
> + */
> +
> +#define VBE_DISPI_MAX_XRES              16000
> +#define VBE_DISPI_MAX_YRES              12000
> +#define VBE_DISPI_MAX_BPP               32
> +
> +#define VBE_DISPI_INDEX_ID              0x0
> +#define VBE_DISPI_INDEX_XRES            0x1
> +#define VBE_DISPI_INDEX_YRES            0x2
> +#define VBE_DISPI_INDEX_BPP             0x3
> +#define VBE_DISPI_INDEX_ENABLE          0x4
> +#define VBE_DISPI_INDEX_BANK            0x5
> +#define VBE_DISPI_INDEX_VIRT_WIDTH      0x6
> +#define VBE_DISPI_INDEX_VIRT_HEIGHT     0x7
> +#define VBE_DISPI_INDEX_X_OFFSET        0x8
> +#define VBE_DISPI_INDEX_Y_OFFSET        0x9
> +#define VBE_DISPI_INDEX_NB              0xa /* size of vbe_regs[] */
> +#define VBE_DISPI_INDEX_VIDEO_MEMORY_64K 0xa /* read-only, not in vbe_re=
gs */
> +
> +/* VBE_DISPI_INDEX_ID */
> +#define VBE_DISPI_ID0                   0xB0C0
> +#define VBE_DISPI_ID1                   0xB0C1
> +#define VBE_DISPI_ID2                   0xB0C2
> +#define VBE_DISPI_ID3                   0xB0C3
> +#define VBE_DISPI_ID4                   0xB0C4
> +#define VBE_DISPI_ID5                   0xB0C5
> +
> +/* VBE_DISPI_INDEX_ENABLE */
> +#define VBE_DISPI_DISABLED              0x00
> +#define VBE_DISPI_ENABLED               0x01
> +#define VBE_DISPI_GETCAPS               0x02
> +#define VBE_DISPI_8BIT_DAC              0x20
> +#define VBE_DISPI_LFB_ENABLED           0x40
> +#define VBE_DISPI_NOCLEARMEM            0x80
> +
> +/* only used by isa-vga, pci vga devices use a memory bar */
> +#define VBE_DISPI_LFB_PHYSICAL_ADDRESS  0xE0000000
> +
> +
> +/*
> + * qemu extension: mmio bar (region 2)
> + */
> +
> +#define PCI_VGA_MMIO_SIZE     0x1000
> +

This one seems unused, you could remove it

> +/* vga register region */
> +#define PCI_VGA_IOPORT_OFFSET 0x400
> +#define PCI_VGA_IOPORT_SIZE   (0x3e0 - 0x3c0)
> +
> +/* bochs vbe register region */
> +#define PCI_VGA_BOCHS_OFFSET  0x500
> +#define PCI_VGA_BOCHS_SIZE    (0x0b * 2)
> +
> +/* qemu extension register region */
> +#define PCI_VGA_QEXT_OFFSET   0x600
> +#define PCI_VGA_QEXT_SIZE     (2 * 4)
> +
> +/* qemu extension registers */
> +#define PCI_VGA_QEXT_REG_SIZE         (0 * 4)
> +#define PCI_VGA_QEXT_REG_BYTEORDER    (1 * 4)
> +#define  PCI_VGA_QEXT_LITTLE_ENDIAN   0x1e1e1e1e
> +#define  PCI_VGA_QEXT_BIG_ENDIAN      0xbebebebe
> diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
> index f312930664..fb3e4cd400 100644
> --- a/hw/display/vga-pci.c
> +++ b/hw/display/vga-pci.c
> @@ -31,19 +31,6 @@
>  #include "qemu/timer.h"
>  #include "hw/loader.h"
>
> -#define PCI_VGA_IOPORT_OFFSET 0x400
> -#define PCI_VGA_IOPORT_SIZE   (0x3e0 - 0x3c0)
> -#define PCI_VGA_BOCHS_OFFSET  0x500
> -#define PCI_VGA_BOCHS_SIZE    (0x0b * 2)
> -#define PCI_VGA_QEXT_OFFSET   0x600
> -#define PCI_VGA_QEXT_SIZE     (2 * 4)
> -#define PCI_VGA_MMIO_SIZE     0x1000
> -
> -#define PCI_VGA_QEXT_REG_SIZE         (0 * 4)
> -#define PCI_VGA_QEXT_REG_BYTEORDER    (1 * 4)
> -#define  PCI_VGA_QEXT_LITTLE_ENDIAN   0x1e1e1e1e
> -#define  PCI_VGA_QEXT_BIG_ENDIAN      0xbebebebe
> -
>  enum vga_pci_flags {
>      PCI_VGA_FLAG_ENABLE_MMIO =3D 1,
>      PCI_VGA_FLAG_ENABLE_QEXT =3D 2,
> --
> 2.9.3
>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


--=20
Marc-Andr=C3=A9 Lureau
