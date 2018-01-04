Received: from eggs.gnu.org ([2001:4830:134:3::10]:40115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eX6av-0003gn-I4
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:34:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eX6ap-0008Cl-Jm
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:34:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eX6ap-0008Ba-En
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:34:03 -0500
References: <20171229142922.31701-1-hpoussin@reactos.org>
	<20171229142922.31701-6-hpoussin@reactos.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <a6bfd7bf-3f09-1a3b-431a-1dfa45214fac@redhat.com>
Date: Thu, 4 Jan 2018 16:33:55 +0200
MIME-Version: 1.0
In-Reply-To: <20171229142922.31701-6-hpoussin@reactos.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 05/16] piix4: rename some variables in
 realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 29/12/2017 16:29, Herv=C3=A9 Poussineau wrote:
> PIIX4 structure is now 's'
> PCI device is now 'pci'

Please don't use 'pci'. Use pci_dev', the former is too wide,

Thanks,
Marcel

> DeviceState is now 'dev'
>=20
> Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> ---
>   hw/isa/piix4.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
> index 6b8bc3faf0..4f476dc7e6 100644
> --- a/hw/isa/piix4.c
> +++ b/hw/isa/piix4.c
> @@ -87,16 +87,17 @@ static const VMStateDescription vmstate_piix4 =3D {
>       }
>   };
>  =20
> -static void piix4_realize(PCIDevice *dev, Error **errp)
> +static void piix4_realize(PCIDevice *pci, Error **errp)
>   {
> -    PIIX4State *d =3D PIIX4_PCI_DEVICE(dev);
> +    DeviceState *dev =3D DEVICE(pci);
> +    PIIX4State *s =3D DO_UPCAST(PIIX4State, dev, pci);
>  =20
> -    if (!isa_bus_new(DEVICE(d), pci_address_space(dev),
> -                     pci_address_space_io(dev), errp)) {
> +    if (!isa_bus_new(dev, pci_address_space(pci),
> +                     pci_address_space_io(pci), errp)) {
>           return;
>       }
> -    piix4_dev =3D &d->dev;
> -    qemu_register_reset(piix4_reset, d);
> +    piix4_dev =3D pci;
> +    qemu_register_reset(piix4_reset, s);
>   }
>  =20
>   int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn)
>=20
