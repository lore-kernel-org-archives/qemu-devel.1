Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165C6C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:50:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA2420768
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA2420768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOco9-0006nM-05
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 03:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50935)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jOcn3-0004x7-No
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:48:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jOcn1-0007AE-Qd
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:48:57 -0400
Received: from 3.mo177.mail-out.ovh.net ([46.105.36.172]:46115)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jOcn1-000795-JI
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:48:55 -0400
Received: from player750.ha.ovh.net (unknown [10.108.54.13])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 6A9D212D15F
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 09:48:53 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player750.ha.ovh.net (Postfix) with ESMTPSA id A7A48115D0F3D;
 Wed, 15 Apr 2020 07:48:01 +0000 (UTC)
Subject: Re: [PATCH-for-5.1 3/3] hw: Remove unnecessary DEVICE() cast
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200412210954.32313-1-f4bug@amsat.org>
 <20200412210954.32313-4-f4bug@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <353d0861-7c91-1662-7acf-5bebabaa3a4c@kaod.org>
Date: Wed, 15 Apr 2020 09:47:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200412210954.32313-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 13574975176934788083
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrfedvgdduvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejhedtrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.36.172
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Anthony Perard <anthony.perard@citrix.com>,
 xen-devel@lists.xenproject.org, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/12/20 11:09 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> The DEVICE() macro is defined as:
>=20
>   #define DEVICE(obj) OBJECT_CHECK(DeviceState, (obj), TYPE_DEVICE)
>=20
> Remove unnecessary DEVICE() casts.
>=20
> Patch created mechanically using spatch with this script:
>=20
>   @@
>   typedef DeviceState;
>   DeviceState *s;
>   @@
>   -   DEVICE(s)
>   +   s
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

For ftgmac100,

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/display/artist.c         | 2 +-
>  hw/display/cg3.c            | 2 +-
>  hw/display/sm501.c          | 2 +-
>  hw/display/tcx.c            | 4 ++--
>  hw/display/vga-isa.c        | 2 +-
>  hw/i2c/imx_i2c.c            | 2 +-
>  hw/i2c/mpc_i2c.c            | 2 +-
>  hw/ide/piix.c               | 2 +-
>  hw/misc/macio/pmu.c         | 2 +-
>  hw/net/ftgmac100.c          | 3 +--
>  hw/net/imx_fec.c            | 2 +-
>  hw/nubus/nubus-device.c     | 2 +-
>  hw/pci-host/bonito.c        | 2 +-
>  hw/ppc/spapr.c              | 2 +-
>  hw/sh4/sh_pci.c             | 2 +-
>  hw/xen/xen-legacy-backend.c | 2 +-
>  16 files changed, 17 insertions(+), 18 deletions(-)
>=20
> diff --git a/hw/display/artist.c b/hw/display/artist.c
> index 753dbb9a77..7e2a4556bd 100644
> --- a/hw/display/artist.c
> +++ b/hw/display/artist.c
> @@ -1353,7 +1353,7 @@ static void artist_realizefn(DeviceState *dev, Er=
ror **errp)
>      s->cursor_height =3D 32;
>      s->cursor_width =3D 32;
> =20
> -    s->con =3D graphic_console_init(DEVICE(dev), 0, &artist_ops, s);
> +    s->con =3D graphic_console_init(dev, 0, &artist_ops, s);
>      qemu_console_resize(s->con, s->width, s->height);
>  }
> =20
> diff --git a/hw/display/cg3.c b/hw/display/cg3.c
> index a1ede10394..f7f1c199ce 100644
> --- a/hw/display/cg3.c
> +++ b/hw/display/cg3.c
> @@ -321,7 +321,7 @@ static void cg3_realizefn(DeviceState *dev, Error *=
*errp)
> =20
>      sysbus_init_irq(sbd, &s->irq);
> =20
> -    s->con =3D graphic_console_init(DEVICE(dev), 0, &cg3_ops, s);
> +    s->con =3D graphic_console_init(dev, 0, &cg3_ops, s);
>      qemu_console_resize(s->con, s->width, s->height);
>  }
> =20
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index de0ab9d977..2a564889bd 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -1839,7 +1839,7 @@ static void sm501_init(SM501State *s, DeviceState=
 *dev,
>                                  &s->twoD_engine_region);
> =20
>      /* create qemu graphic console */
> -    s->con =3D graphic_console_init(DEVICE(dev), 0, &sm501_ops, s);
> +    s->con =3D graphic_console_init(dev, 0, &sm501_ops, s);
>  }
> =20
>  static const VMStateDescription vmstate_sm501_state =3D {
> diff --git a/hw/display/tcx.c b/hw/display/tcx.c
> index 76de16e8ea..1fb45b1aab 100644
> --- a/hw/display/tcx.c
> +++ b/hw/display/tcx.c
> @@ -868,9 +868,9 @@ static void tcx_realizefn(DeviceState *dev, Error *=
*errp)
>      sysbus_init_irq(sbd, &s->irq);
> =20
>      if (s->depth =3D=3D 8) {
> -        s->con =3D graphic_console_init(DEVICE(dev), 0, &tcx_ops, s);
> +        s->con =3D graphic_console_init(dev, 0, &tcx_ops, s);
>      } else {
> -        s->con =3D graphic_console_init(DEVICE(dev), 0, &tcx24_ops, s)=
;
> +        s->con =3D graphic_console_init(dev, 0, &tcx24_ops, s);
>      }
>      s->thcmisc =3D 0;
> =20
> diff --git a/hw/display/vga-isa.c b/hw/display/vga-isa.c
> index 0633ed382c..3aaeeeca1e 100644
> --- a/hw/display/vga-isa.c
> +++ b/hw/display/vga-isa.c
> @@ -74,7 +74,7 @@ static void vga_isa_realizefn(DeviceState *dev, Error=
 **errp)
>                                          0x000a0000,
>                                          vga_io_memory, 1);
>      memory_region_set_coalescing(vga_io_memory);
> -    s->con =3D graphic_console_init(DEVICE(dev), 0, s->hw_ops, s);
> +    s->con =3D graphic_console_init(dev, 0, s->hw_ops, s);
> =20
>      memory_region_add_subregion(isa_address_space(isadev),
>                                  VBE_DISPI_LFB_PHYSICAL_ADDRESS,
> diff --git a/hw/i2c/imx_i2c.c b/hw/i2c/imx_i2c.c
> index 30b9aea247..2e02e1c4fa 100644
> --- a/hw/i2c/imx_i2c.c
> +++ b/hw/i2c/imx_i2c.c
> @@ -305,7 +305,7 @@ static void imx_i2c_realize(DeviceState *dev, Error=
 **errp)
>                            IMX_I2C_MEM_SIZE);
>      sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
>      sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
> -    s->bus =3D i2c_init_bus(DEVICE(dev), NULL);
> +    s->bus =3D i2c_init_bus(dev, NULL);
>  }
> =20
>  static void imx_i2c_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/i2c/mpc_i2c.c b/hw/i2c/mpc_i2c.c
> index 0aa1be3ce7..9a724f3a3e 100644
> --- a/hw/i2c/mpc_i2c.c
> +++ b/hw/i2c/mpc_i2c.c
> @@ -332,7 +332,7 @@ static void mpc_i2c_realize(DeviceState *dev, Error=
 **errp)
>      memory_region_init_io(&i2c->iomem, OBJECT(i2c), &i2c_ops, i2c,
>                            "mpc-i2c", 0x14);
>      sysbus_init_mmio(SYS_BUS_DEVICE(dev), &i2c->iomem);
> -    i2c->bus =3D i2c_init_bus(DEVICE(dev), "i2c");
> +    i2c->bus =3D i2c_init_bus(dev, "i2c");
>  }
> =20
>  static void mpc_i2c_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/ide/piix.c b/hw/ide/piix.c
> index 3b2de4c312..b402a93636 100644
> --- a/hw/ide/piix.c
> +++ b/hw/ide/piix.c
> @@ -193,7 +193,7 @@ int pci_piix3_xen_ide_unplug(DeviceState *dev, bool=
 aux)
>              blk_unref(blk);
>          }
>      }
> -    qdev_reset_all(DEVICE(dev));
> +    qdev_reset_all(dev);
>      return 0;
>  }
> =20
> diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
> index b8466a4a3f..4b7def9096 100644
> --- a/hw/misc/macio/pmu.c
> +++ b/hw/misc/macio/pmu.c
> @@ -758,7 +758,7 @@ static void pmu_realize(DeviceState *dev, Error **e=
rrp)
> =20
>      if (s->has_adb) {
>          qbus_create_inplace(&s->adb_bus, sizeof(s->adb_bus), TYPE_ADB_=
BUS,
> -                            DEVICE(dev), "adb.0");
> +                            dev, "adb.0");
>          s->adb_poll_timer =3D timer_new_ms(QEMU_CLOCK_VIRTUAL, pmu_adb=
_poll, s);
>          s->adb_poll_mask =3D 0xffff;
>          s->autopoll_rate_ms =3D 20;
> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
> index 041ed21017..25ebee7ec2 100644
> --- a/hw/net/ftgmac100.c
> +++ b/hw/net/ftgmac100.c
> @@ -1035,8 +1035,7 @@ static void ftgmac100_realize(DeviceState *dev, E=
rror **errp)
>      qemu_macaddr_default_if_unset(&s->conf.macaddr);
> =20
>      s->nic =3D qemu_new_nic(&net_ftgmac100_info, &s->conf,
> -                          object_get_typename(OBJECT(dev)), DEVICE(dev=
)->id,
> -                          s);
> +                          object_get_typename(OBJECT(dev)), dev->id, s=
);
>      qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a=
);
>  }
> =20
> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
> index a35c33683e..7adcc9df65 100644
> --- a/hw/net/imx_fec.c
> +++ b/hw/net/imx_fec.c
> @@ -1323,7 +1323,7 @@ static void imx_eth_realize(DeviceState *dev, Err=
or **errp)
> =20
>      s->nic =3D qemu_new_nic(&imx_eth_net_info, &s->conf,
>                            object_get_typename(OBJECT(dev)),
> -                          DEVICE(dev)->id, s);
> +                          dev->id, s);
> =20
>      qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a=
);
>  }
> diff --git a/hw/nubus/nubus-device.c b/hw/nubus/nubus-device.c
> index 01ccad9e8e..ffe78a8823 100644
> --- a/hw/nubus/nubus-device.c
> +++ b/hw/nubus/nubus-device.c
> @@ -156,7 +156,7 @@ void nubus_register_rom(NubusDevice *dev, const uin=
t8_t *rom, uint32_t size,
> =20
>  static void nubus_device_realize(DeviceState *dev, Error **errp)
>  {
> -    NubusBus *nubus =3D NUBUS_BUS(qdev_get_parent_bus(DEVICE(dev)));
> +    NubusBus *nubus =3D NUBUS_BUS(qdev_get_parent_bus(dev));
>      NubusDevice *nd =3D NUBUS_DEVICE(dev);
>      char *name;
>      hwaddr slot_offset;
> diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
> index cc6545c8a8..f212796044 100644
> --- a/hw/pci-host/bonito.c
> +++ b/hw/pci-host/bonito.c
> @@ -606,7 +606,7 @@ static void bonito_pcihost_realize(DeviceState *dev=
, Error **errp)
>      BonitoState *bs =3D BONITO_PCI_HOST_BRIDGE(dev);
> =20
>      memory_region_init(&bs->pci_mem, OBJECT(dev), "pci.mem", BONITO_PC=
ILO_SIZE);
> -    phb->bus =3D pci_register_root_bus(DEVICE(dev), "pci",
> +    phb->bus =3D pci_register_root_bus(dev, "pci",
>                                       pci_bonito_set_irq, pci_bonito_ma=
p_irq,
>                                       dev, &bs->pci_mem, get_system_io(=
),
>                                       0x28, 32, TYPE_PCI_BUS);
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 9a2bd501aa..3337f5e79c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4031,7 +4031,7 @@ static void spapr_phb_plug(HotplugHandler *hotplu=
g_dev, DeviceState *dev,
>      /* hotplug hooks should check it's enabled before getting this far=
 */
>      assert(drc);
> =20
> -    spapr_drc_attach(drc, DEVICE(dev), &local_err);
> +    spapr_drc_attach(drc, dev, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> diff --git a/hw/sh4/sh_pci.c b/hw/sh4/sh_pci.c
> index 08f2fc1dde..0a3e86f949 100644
> --- a/hw/sh4/sh_pci.c
> +++ b/hw/sh4/sh_pci.c
> @@ -129,7 +129,7 @@ static void sh_pci_device_realize(DeviceState *dev,=
 Error **errp)
>      for (i =3D 0; i < 4; i++) {
>          sysbus_init_irq(sbd, &s->irq[i]);
>      }
> -    phb->bus =3D pci_register_root_bus(DEVICE(dev), "pci",
> +    phb->bus =3D pci_register_root_bus(dev, "pci",
>                                       sh_pci_set_irq, sh_pci_map_irq,
>                                       s->irq,
>                                       get_system_memory(),
> diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
> index 4a373b2373..f9d013811a 100644
> --- a/hw/xen/xen-legacy-backend.c
> +++ b/hw/xen/xen-legacy-backend.c
> @@ -705,7 +705,7 @@ int xen_be_init(void)
> =20
>      xen_sysdev =3D qdev_create(NULL, TYPE_XENSYSDEV);
>      qdev_init_nofail(xen_sysdev);
> -    xen_sysbus =3D qbus_create(TYPE_XENSYSBUS, DEVICE(xen_sysdev), "xe=
n-sysbus");
> +    xen_sysbus =3D qbus_create(TYPE_XENSYSBUS, xen_sysdev, "xen-sysbus=
");
>      qbus_set_bus_hotplug_handler(xen_sysbus, &error_abort);
> =20
>      return 0;
>=20


