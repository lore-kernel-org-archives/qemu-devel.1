Received: from eggs.gnu.org ([2001:4830:134:3::10]:45847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g7Mvm-0004WP-4B
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:49:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g7Mvf-0007Go-Ue
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:49:48 -0400
Received: from 10.mo69.mail-out.ovh.net ([46.105.73.241]:36569)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g7Mve-0007D9-DG
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:49:42 -0400
Received: from player734.ha.ovh.net (unknown [10.109.146.76])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id DEDEB2E1F2
	for <qemu-devel@nongnu.org>; Tue,  2 Oct 2018 17:49:26 +0200 (CEST)
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20181001220942.2382-1-f4bug@amsat.org>
	<20181001220942.2382-4-f4bug@amsat.org>
Message-ID: <9ac76827-9630-24f6-69a3-2bf981b9116b@kaod.org>
Date: Tue, 2 Oct 2018 17:49:21 +0200
MIME-Version: 1.0
In-Reply-To: <20181001220942.2382-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/15] hw/timer/sun4v-rtc: Use
 DeviceState::realize rather than SysBusDevice::init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>

On 10/2/18 12:09 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Move from the legacy SysBusDevice::init method to using DeviceState::re=
alize.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/timer/sun4v-rtc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/timer/sun4v-rtc.c b/hw/timer/sun4v-rtc.c
> index 13be94f8da..4e7f6a1eff 100644
> --- a/hw/timer/sun4v-rtc.c
> +++ b/hw/timer/sun4v-rtc.c
> @@ -63,21 +63,21 @@ void sun4v_rtc_init(hwaddr addr)
>      sysbus_mmio_map(s, 0, addr);
>  }
> =20
> -static int sun4v_rtc_init1(SysBusDevice *dev)
> +static void sun4v_rtc_realize(DeviceState *dev, Error **errp)
>  {
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>      Sun4vRtc *s =3D SUN4V_RTC(dev);
> =20
>      memory_region_init_io(&s->iomem, OBJECT(s), &sun4v_rtc_ops, s,
>                            "sun4v-rtc", 0x08ULL);
> -    sysbus_init_mmio(dev, &s->iomem);
> -    return 0;
> +    sysbus_init_mmio(sbd, &s->iomem);
>  }
> =20
>  static void sun4v_rtc_class_init(ObjectClass *klass, void *data)
>  {
> -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> -    k->init =3D sun4v_rtc_init1;
> +    dc->realize =3D sun4v_rtc_realize;
>  }
> =20
>  static const TypeInfo sun4v_rtc_info =3D {
>=20
