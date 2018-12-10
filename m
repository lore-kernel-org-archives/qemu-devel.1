Received: from eggs.gnu.org ([2001:4830:134:3::10]:34610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gWLSl-0000uT-6l
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:19:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gWLSi-00048A-RY
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:19:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gWLSi-00047k-Kc
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:19:04 -0500
Date: Mon, 10 Dec 2018 14:19:00 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181210131900.wh3hsnu3j5r6pnhy@sirius.home.kraxel.org>
References: <20181130093852.20739-1-maozhongyi@cmss.chinamobile.com>
	<20181130093852.20739-6-maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181130093852.20739-6-maozhongyi@cmss.chinamobile.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 05/21] display/g364fb: Convert sysbus
 init function to realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, f4bug@amsat.org, alistair.francis@wdc.com, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

On Fri, Nov 30, 2018 at 05:38:36PM +0800, Mao Zhongyi wrote:
> Use DeviceClass rather than SysBusDeviceClass in
> g364fb_sysbus_class_init().
>=20
> Cc: pbonzini@redhat.com
> Cc: kraxel@redhat.com
> Cc: f4bug@amsat.org
> Cc: alistair.francis@wdc.com
>=20
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

> ---
>  hw/display/g364fb.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
> index 8ad7e5d824..3407adf98d 100644
> --- a/hw/display/g364fb.c
> +++ b/hw/display/g364fb.c
> @@ -489,18 +489,16 @@ typedef struct {
>      G364State g364;
>  } G364SysBusState;
> =20
> -static int g364fb_sysbus_init(SysBusDevice *sbd)
> +static void g364fb_sysbus_realize(DeviceState *dev, Error **errp)
>  {
> -    DeviceState *dev =3D DEVICE(sbd);
>      G364SysBusState *sbs =3D G364(dev);
>      G364State *s =3D &sbs->g364;
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> =20
>      g364fb_init(dev, s);
>      sysbus_init_irq(sbd, &s->irq);
>      sysbus_init_mmio(sbd, &s->mem_ctrl);
>      sysbus_init_mmio(sbd, &s->mem_vram);
> -
> -    return 0;
>  }
> =20
>  static void g364fb_sysbus_reset(DeviceState *d)
> @@ -518,9 +516,8 @@ static Property g364fb_sysbus_properties[] =3D {
>  static void g364fb_sysbus_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
> =20
> -    k->init =3D g364fb_sysbus_init;
> +    dc->realize =3D g364fb_sysbus_realize;
>      set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
>      dc->desc =3D "G364 framebuffer";
>      dc->reset =3D g364fb_sysbus_reset;
> --=20
> 2.17.1
>=20
>=20
>=20
