Received: from eggs.gnu.org ([2001:4830:134:3::10]:56321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzUm-0001va-3s
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:50:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzUi-0007Kn-VG
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:50:24 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzUi-0007Ke-Bb
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:50:20 -0500
Received: by mail-yw1-f68.google.com with SMTP id i65-v6so3742607ywc.5
	for <qemu-devel@nongnu.org>; Sun, 11 Nov 2018 15:50:20 -0800 (PST)
MIME-Version: 1.0
References: <20181103154104.69228-1-liq3ea@163.com>
In-Reply-To: <20181103154104.69228-1-liq3ea@163.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 12 Nov 2018 00:50:08 +0100
Message-ID: <CAAdtpL5xZChUiGCiUB25Pvj5oRpoVJRDb0pMzKCAmPYpUV8a3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw: virtio-pci: drop DO_UPCAST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Sat, Nov 3, 2018 at 4:42 PM Li Qiang <liq3ea@163.com> wrote:
>
> Use VIRTIO_PCI MACRO instead.
>
> Signed-off-by: Li Qiang <liq3ea@163.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  hw/virtio/virtio-pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index a954799267..277dc20c81 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -597,7 +597,7 @@ virtio_address_space_read(VirtIOPCIProxy *proxy, hwad=
dr addr,
>  static void virtio_write_config(PCIDevice *pci_dev, uint32_t address,
>                                  uint32_t val, int len)
>  {
> -    VirtIOPCIProxy *proxy =3D DO_UPCAST(VirtIOPCIProxy, pci_dev, pci_dev=
);
> +    VirtIOPCIProxy *proxy =3D VIRTIO_PCI(pci_dev);
>      VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
>      struct virtio_pci_cfg_cap *cfg;
>
> @@ -630,7 +630,7 @@ static void virtio_write_config(PCIDevice *pci_dev, u=
int32_t address,
>  static uint32_t virtio_read_config(PCIDevice *pci_dev,
>                                     uint32_t address, int len)
>  {
> -    VirtIOPCIProxy *proxy =3D DO_UPCAST(VirtIOPCIProxy, pci_dev, pci_dev=
);
> +    VirtIOPCIProxy *proxy =3D VIRTIO_PCI(pci_dev);
>      struct virtio_pci_cfg_cap *cfg;
>
>      if (proxy->config_cap &&
> --
> 2.17.1
>
>
>
