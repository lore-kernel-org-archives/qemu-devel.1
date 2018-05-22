Received: from eggs.gnu.org ([2001:4830:134:3::10]:59192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fLAwq-0007Sr-Lx
	for qemu-devel@nongnu.org; Tue, 22 May 2018 13:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fLAwm-0001Lk-N3
	for qemu-devel@nongnu.org; Tue, 22 May 2018 13:19:44 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1fLAwm-0001LX-IN
	for qemu-devel@nongnu.org; Tue, 22 May 2018 13:19:40 -0400
Received: by mail-io0-f195.google.com with SMTP id e78-v6so19392671iod.0
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 10:19:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180522165058.15404-3-kraxel@redhat.com>
References: <20180522165058.15404-1-kraxel@redhat.com>
	<20180522165058.15404-3-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 22 May 2018 19:19:39 +0200
Message-ID: <CAMxuvayfne0WMBHxzVs8tPN47Jc=7=PY69m7MHPebPHD7-K7SQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/6] vga-pci: use PCI_VGA_MMIO_SIZE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Tue, May 22, 2018 at 6:50 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Ah, now we have a user!

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/display/vga-pci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
> index fb3e4cd400..700ac58c69 100644
> --- a/hw/display/vga-pci.c
> +++ b/hw/display/vga-pci.c
> @@ -232,7 +232,8 @@ static void pci_std_vga_realize(PCIDevice *dev, Error=
 **errp)
>
>      /* mmio bar for vga register access */
>      if (d->flags & (1 << PCI_VGA_FLAG_ENABLE_MMIO)) {
> -        memory_region_init(&d->mmio, NULL, "vga.mmio", 4096);
> +        memory_region_init(&d->mmio, NULL, "vga.mmio",
> +                           PCI_VGA_MMIO_SIZE);
>
>          if (d->flags & (1 << PCI_VGA_FLAG_ENABLE_QEXT)) {
>              qext =3D true;
> @@ -267,7 +268,8 @@ static void pci_secondary_vga_realize(PCIDevice *dev,=
 Error **errp)
>      s->con =3D graphic_console_init(DEVICE(dev), 0, s->hw_ops, s);
>
>      /* mmio bar */
> -    memory_region_init(&d->mmio, OBJECT(dev), "vga.mmio", 4096);
> +    memory_region_init(&d->mmio, OBJECT(dev), "vga.mmio",
> +                       PCI_VGA_MMIO_SIZE);
>
>      if (d->flags & (1 << PCI_VGA_FLAG_ENABLE_QEXT)) {
>          qext =3D true;
> --
> 2.9.3
>
