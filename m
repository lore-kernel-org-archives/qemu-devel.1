Received: from eggs.gnu.org ([2001:4830:134:3::10]:45954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g7Mvv-0004eN-61
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:49:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g7Mvr-0007L9-66
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:49:59 -0400
Received: from 3.mo6.mail-out.ovh.net ([178.33.253.26]:38856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g7Mvq-0007KZ-W5
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:49:55 -0400
Received: from player773.ha.ovh.net (unknown [10.109.159.90])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 9C259186793
	for <qemu-devel@nongnu.org>; Tue,  2 Oct 2018 17:49:53 +0200 (CEST)
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20181001220942.2382-1-f4bug@amsat.org>
	<20181001220942.2382-9-f4bug@amsat.org>
Message-ID: <60ee5d47-bb77-f08b-69c6-9e339e48f64e@kaod.org>
Date: Tue, 2 Oct 2018 17:49:45 +0200
MIME-Version: 1.0
In-Reply-To: <20181001220942.2382-9-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/15] hw/mips/gt64xxx_pci: Mark as bridge
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>

On 10/2/18 12:09 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> The gt64120 is currently listed as uncategorized device.
> Mark it as bridge device.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/mips/gt64xxx_pci.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
> index dcd1a66329..1cd8aac658 100644
> --- a/hw/mips/gt64xxx_pci.c
> +++ b/hw/mips/gt64xxx_pci.c
> @@ -1232,6 +1232,7 @@ static void gt64120_class_init(ObjectClass *klass=
, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      dc->reset =3D gt64120_reset;
>      dc->vmsd =3D &vmstate_gt64120;
>  }
>=20
