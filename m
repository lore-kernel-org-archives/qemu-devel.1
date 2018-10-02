Received: from eggs.gnu.org ([2001:4830:134:3::10]:39649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g7G8s-0008Uf-PE
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 04:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g7G8p-0001vq-L9
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 04:34:54 -0400
References: <20181001220942.2382-1-f4bug@amsat.org>
	<20181001220942.2382-14-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f2956781-a134-76e0-9463-e943d20304bb@redhat.com>
Date: Tue, 2 Oct 2018 10:34:47 +0200
MIME-Version: 1.0
In-Reply-To: <20181001220942.2382-14-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 13/15] hw/alpha/typhoon: Remove
 unuseful code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>

On 2018-10-02 00:09, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/alpha/typhoon.c | 13 -------------
>  1 file changed, 13 deletions(-)
>=20
> diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
> index d74b5b55e1..8004afe45b 100644
> --- a/hw/alpha/typhoon.c
> +++ b/hw/alpha/typhoon.c
> @@ -932,23 +932,10 @@ PCIBus *typhoon_init(ram_addr_t ram_size, ISABus =
**isa_bus,
>      return b;
>  }
> =20
> -static int typhoon_pcihost_init(SysBusDevice *dev)
> -{
> -    return 0;
> -}
> -
> -static void typhoon_pcihost_class_init(ObjectClass *klass, void *data)
> -{
> -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
> -
> -    k->init =3D typhoon_pcihost_init;
> -}
> -
>  static const TypeInfo typhoon_pcihost_info =3D {
>      .name          =3D TYPE_TYPHOON_PCI_HOST_BRIDGE,
>      .parent        =3D TYPE_PCI_HOST_BRIDGE,
>      .instance_size =3D sizeof(TyphoonState),
> -    .class_init    =3D typhoon_pcihost_class_init,
>  };
> =20
>  static void typhoon_iommu_memory_region_class_init(ObjectClass *klass,

As far as I can see, this should be fine.

Reviewed-by: Thomas Huth <thuth@redhat.com>
