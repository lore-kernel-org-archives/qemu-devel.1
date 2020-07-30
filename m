Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FEAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 01:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB6202072A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 01:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6202072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0xSo-0002Lw-0z
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 21:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hogan.wang@huawei.com>)
 id 1k0xSF-0001pX-9D
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 21:33:55 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2530 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hogan.wang@huawei.com>)
 id 1k0xSC-0002gj-W4
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 21:33:54 -0400
Received: from nkgeml705-chm.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id D20D3B268AEA87C55F1E;
 Thu, 30 Jul 2020 09:33:45 +0800 (CST)
Received: from dggema763-chm.china.huawei.com (10.1.198.205) by
 nkgeml705-chm.china.huawei.com (10.98.57.154) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Thu, 30 Jul 2020 09:33:45 +0800
Received: from dggema763-chm.china.huawei.com ([10.9.49.85]) by
 dggema763-chm.china.huawei.com ([10.9.49.85]) with mapi id 15.01.1913.007;
 Thu, 30 Jul 2020 09:33:45 +0800
From: "Wangjing (Hogan, Cloud Infrastructure Service Product Dept.)"
 <hogan.wang@huawei.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v5] hw/pci-host: save/restore pci host config register for
 old ones
Thread-Topic: [PATCH v5] hw/pci-host: save/restore pci host config register
 for old ones
Thread-Index: AdZmEXTR0VdHDjN/NUCLnjaWxT6fug==
Date: Thu, 30 Jul 2020 01:33:44 +0000
Message-ID: <38c48e6e14f34721b32b990414db7df9@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.149.56]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=hogan.wang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 21:33:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Huangweidong \(C\)" <weidong.huang@huawei.com>,
 "Wangxin \(Alexander\)" <wangxinxin.wang@huawei.com>,
 "jusual@redhat.com" <jusual@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> On Tue, Jul 28, 2020 at 11:27:09AM +0800, Hogan Wang wrote:
> > The i440fx and q35 machines integrate i440FX or MCH PCI device by defau=
lt.
> > Refer to i440FX and ICH9-LPC spcifications, there are some reserved=20
> > configuration registers can used to save/restore PCIHostState.config_re=
g.
> > It's nasty but friendly to old ones.
> >=20
> > Reproducer steps:
> > step 1. Make modifications to seabios and qemu for increase=20
> > reproduction efficiency, write 0xf0 to 0x402 port notify qemu to stop=20
> > vcpu after
> > 0x0cf8 port wrote i440 configure register. qemu stop vcpu when catch
> > 0x402 port wrote 0xf0.
> >=20
> > seabios:/src/hw/pci.c
> > @@ -52,6 +52,11 @@ void pci_config_writeb(u16 bdf, u32 addr, u8 val)
> >          writeb(mmconfig_addr(bdf, addr), val);
> >      } else {
> >          outl(ioconfig_cmd(bdf, addr), PORT_PCI_CMD);
> > +       if (bdf =3D=3D 0 && addr =3D=3D 0x72 && val =3D=3D 0xa) {
> > +            dprintf(1, "stop vcpu\n");
> > +            outb(0xf0, 0x402); // notify qemu to stop vcpu
> > +            dprintf(1, "resume vcpu\n");
> > +        }
> >          outb(val, PORT_PCI_DATA + (addr & 3));
> >      }
> >  }
> >=20
> > qemu:hw/char/debugcon.c
> > @@ -60,6 +61,9 @@ static void debugcon_ioport_write(void *opaque, hwadd=
r addr, uint64_t val,
> >      printf(" [debugcon: write addr=3D0x%04" HWADDR_PRIx " val=3D0x%02"=
=20
> > PRIx64 "]\n", addr, val);  #endif
> >=20
> > +    if (ch =3D=3D 0xf0) {
> > +        vm_stop(RUN_STATE_PAUSED);
> > +    }
> >      /* XXX this blocks entire thread. Rewrite to use
> >       * qemu_chr_fe_write and background I/O callbacks */
> >      qemu_chr_fe_write_all(&s->chr, &ch, 1);
> >=20
> > step 2. start vm1 by the following command line, and then vm stopped.
> > $ qemu-system-x86_64 -machine pc-i440fx-5.0,accel=3Dkvm\  -netdev=20
> > tap,ifname=3Dtap-test,id=3Dhostnet0,vhost=3Don,downscript=3Dno,script=
=3Dno\
> >  -device=20
> > virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,bus=3Dpci.0,addr=3D0x13,boot=
index=3D3
> > \  -device cirrus-vga,id=3Dvideo0,vgamem_mb=3D16,bus=3Dpci.0,addr=3D0x2=
\
> >  -chardev file,id=3Dseabios,path=3D/var/log/test.seabios,append=3Don\
> >  -device isa-debugcon,iobase=3D0x402,chardev=3Dseabios\
> >  -monitor stdio
> >=20
> > step 3. start vm2 to accept vm1 state.
> > $ qemu-system-x86_64 -machine pc-i440fx-5.0,accel=3Dkvm\  -netdev=20
> > tap,ifname=3Dtap-test1,id=3Dhostnet0,vhost=3Don,downscript=3Dno,script=
=3Dno\
> >  -device=20
> > virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,bus=3Dpci.0,addr=3D0x13,boot=
index=3D3
> > \  -device cirrus-vga,id=3Dvideo0,vgamem_mb=3D16,bus=3Dpci.0,addr=3D0x2=
\
> >  -chardev file,id=3Dseabios,path=3D/var/log/test.seabios,append=3Don\
> >  -device isa-debugcon,iobase=3D0x402,chardev=3Dseabios\
> >  -monitor stdio \
> >  -incoming tcp:127.0.0.1:8000
> >=20
> > step 4. execute the following qmp command in vm1 to migrate.
> > (qemu) migrate tcp:127.0.0.1:8000
> >=20
> > step 5. execute the following qmp command in vm2 to resume vcpu.
> > (qemu) cont
> >=20
> > Before this patch, we get KVM "emulation failure" error on vm2.
> > This patch fixes it.
> >=20
> > Signed-off-by: Hogan Wang <hogan.wang@huawei.com>
> > ---
> >  hw/pci-host/i440fx.c | 46 ++++++++++++++++++++++++++++++++++++++++++++
> >  hw/pci-host/q35.c    | 44 ++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 90 insertions(+)
> >=20
> > diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c index=20
> > 8ed2417f0c..419e27c21a 100644
> > --- a/hw/pci-host/i440fx.c
> > +++ b/hw/pci-host/i440fx.c
> > @@ -64,6 +64,14 @@ typedef struct I440FXState {
> >   */
> >  #define I440FX_COREBOOT_RAM_SIZE 0x57
> > =20
> > +/* Older I440FX machines (5.0 and older) do not support=20
> > +i440FX-pcihost state
> > + * migration, use some reserved INTEL 82441 configuration registers=20
> > +to
> > + * save/restore i440FX-pcihost config register. Refer to [INTEL 440FX=
=20
> > +PCISET
> > + * 82441FX PCI AND MEMORY CONTROLLER (PMC) AND 82442FX DATA BUS=20
> > +ACCELERATOR
> > + * (DBX) Table 1. PMC Configuration Space]  */ #define=20
> > +I440FX_PCI_HOST_CONFIG_REG 0x94
> > +
> >  static void i440fx_update_memory_mappings(PCII440FXState *d)  {
> >      int i;
> > @@ -98,15 +106,53 @@ static void i440fx_write_config(PCIDevice *dev, =20
> > static int i440fx_post_load(void *opaque, int version_id)  {
> >      PCII440FXState *d =3D opaque;
> > +    PCIDevice *dev;
> > +    PCIHostState *s =3D OBJECT_CHECK(PCIHostState,
> > +                                   object_resolve_path("/machine/i440f=
x", NULL),
> > +                                   TYPE_PCI_HOST_BRIDGE);
> > =20
> >      i440fx_update_memory_mappings(d);
> > +
> > +    if (!s->mig_enabled) {
>=20
> Thinking more about it, I think we should rename mig_enabled to config_re=
g_mig_enabled or something like this.
>=20
Thanks for your pertinent suggestions, I will resend a new patch to fix it.
>
> > +        dev =3D PCI_DEVICE(d);
> > +        s->config_reg =3D pci_get_long(&dev->config[I440FX_PCI_HOST_CO=
NFIG_REG]);
> > +        pci_set_long(&dev->config[I440FX_PCI_HOST_CONFIG_REG], 0);
> > +    }
> > +    return 0;
> > +}
> > +
> > +static int i440fx_pre_save(void *opaque) {
> > +    PCIDevice *dev =3D opaque;
> > +    PCIHostState *s =3D OBJECT_CHECK(PCIHostState,
> > +                                   object_resolve_path("/machine/i440f=
x", NULL),
> > +                                   TYPE_PCI_HOST_BRIDGE);
> > +    if (!s->mig_enabled) {
> > +        pci_set_long(&dev->config[I440FX_PCI_HOST_CONFIG_REG],
> > +                     s->config_reg);
> > +    }
> > +    return 0;
> > +}
> > +
> > +static int i440fx_post_save(void *opaque) {
> > +    PCIDevice *dev =3D opaque;
> > +    PCIHostState *s =3D OBJECT_CHECK(PCIHostState,
> > +                                   object_resolve_path("/machine/i440f=
x", NULL),
> > +                                   TYPE_PCI_HOST_BRIDGE);
> > +    if (!s->mig_enabled) {
> > +        pci_set_long(&dev->config[I440FX_PCI_HOST_CONFIG_REG], 0);
> > +    }
> >      return 0;
> >  }
> > =20
> > +
>=20
> Extra empty line.
>=20
>=20
> >  static const VMStateDescription vmstate_i440fx =3D {
> >      .name =3D "I440FX",
> >      .version_id =3D 3,
> >      .minimum_version_id =3D 3,
> > +    .pre_save =3D i440fx_pre_save,
> > +    .post_save =3D i440fx_post_save,
> >      .post_load =3D i440fx_post_load,
> >      .fields =3D (VMStateField[]) {
> >          VMSTATE_PCI_DEVICE(parent_obj, PCII440FXState), diff --git=20
> > a/hw/pci-host/q35.c b/hw/pci-host/q35.c index b67cb9c29f..d87f892945=20
> > 100644
> > --- a/hw/pci-host/q35.c
> > +++ b/hw/pci-host/q35.c
> > @@ -43,6 +43,14 @@
> > =20
> >  #define Q35_PCI_HOST_HOLE64_SIZE_DEFAULT (1ULL << 35)
> > =20
> > +/* Older Q35 machines (5.0 and older) do not support q35-pcihost=20
> > +state
> > + * migration, use some reserved INTEL MCH configuration registers to
> > + * save/restore q35-pcihost config register. Refer to [Intel 3 Series
> > + * Chipset Family Datasheet Table 5-1. DRAM Controller Register=20
> > +Address
> > + * Map (D0:F0)]
> > + */
> > +#define Q35_PCI_HOST_CONFIG_REG 0x70
> > +
> >  static void q35_host_realize(DeviceState *dev, Error **errp)  {
> >      PCIHostState *pci =3D PCI_HOST_BRIDGE(dev); @@ -513,14 +521,50 @@=
=20
> > static void mch_update(MCHPCIState *mch)  static int=20
> > mch_post_load(void *opaque, int version_id)  {
> >      MCHPCIState *mch =3D opaque;
> > +    PCIDevice *dev;
> > +    PCIHostState *s =3D OBJECT_CHECK(PCIHostState,
> > +                                   object_resolve_path("/machine/q35",=
 NULL),
> > +                                   TYPE_PCI_HOST_BRIDGE);
> >      mch_update(mch);
> > +    if (!s->mig_enabled) {
> > +        dev =3D PCI_DEVICE(mch);
> > +        s->config_reg =3D pci_get_long(&dev->config[Q35_PCI_HOST_CONFI=
G_REG]);
> > +        pci_set_long(&dev->config[Q35_PCI_HOST_CONFIG_REG], 0);
> > +    }
> > +    return 0;
> > +}
> > +
> > +static int mch_pre_save(void *opaque) {
> > +    PCIDevice *dev =3D opaque;
> > +    PCIHostState *s =3D OBJECT_CHECK(PCIHostState,
> > +                                   object_resolve_path("/machine/q35",=
 NULL),
> > +                                   TYPE_PCI_HOST_BRIDGE);
> > +    if (!s->mig_enabled) {
> > +        pci_set_long(&dev->config[Q35_PCI_HOST_CONFIG_REG], s->config_=
reg);
> > +    }
> >      return 0;
> >  }
> > =20
> > +static int mch_post_save(void *opaque) {
> > +    PCIDevice *dev =3D opaque;
> > +    PCIHostState *s =3D OBJECT_CHECK(PCIHostState,
> > +                                   object_resolve_path("/machine/q35",=
 NULL),
> > +                                   TYPE_PCI_HOST_BRIDGE);
> > +    if (!s->mig_enabled) {
> > +        pci_set_long(&dev->config[Q35_PCI_HOST_CONFIG_REG], 0);
> > +    }
> > +    return 0;
> > +}
> > +
> > +
> >  static const VMStateDescription vmstate_mch =3D {
> >      .name =3D "mch",
> >      .version_id =3D 1,
> >      .minimum_version_id =3D 1,
> > +    .pre_save =3D mch_pre_save,
> > +    .post_save =3D mch_post_save,
> >      .post_load =3D mch_post_load,
> >      .fields =3D (VMStateField[]) {
> >          VMSTATE_PCI_DEVICE(parent_obj, MCHPCIState),
> > --
> > 2.27.0
> >=20


