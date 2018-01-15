Received: from eggs.gnu.org ([2001:4830:134:3::10]:42050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eb1OV-0003c8-7K
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:49:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eb1OS-0006zQ-2n
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:49:31 -0500
References: <20180114020412.26160-1-f4bug@amsat.org>
	<20180114020412.26160-4-f4bug@amsat.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <bdbf5163-f343-df4a-889f-35a945bb331e@redhat.com>
Date: Mon, 15 Jan 2018 11:48:55 +0200
MIME-Version: 1.0
In-Reply-To: <20180114020412.26160-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 3/3] qdev: use
 device_class_set_parent_realize/unrealize/reset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Dmitry Fleytman <dmitry@daynix.com>, Jason Wang <jasowang@redhat.com>, Fam Zheng <famz@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, Anthony Green <green@moxielogic.com>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Max Filippov <jcmvbkbc@gmail.com>, "open list:ARM cores" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>, "open list:S390" <qemu-s390x@nongnu.org>

On 14/01/2018 4:04, Philippe Mathieu-Daud=C3=A9 wrote:
> changes generated using the following Coccinelle patch:
>=20
>    @@
>    type DeviceParentClass;
>    DeviceParentClass *pc;
>    DeviceClass *dc;
>    identifier parent_fn;
>    identifier child_fn;
>    @@
>    (
>    +device_class_set_parent_realize(dc, child_fn, &pc->parent_fn);
>    -pc->parent_fn =3D dc->realize;
>    ...
>    -dc->realize =3D child_fn;
>    |
>    +device_class_set_parent_unrealize(dc, child_fn, &pc->parent_fn);
>    -pc->parent_fn =3D dc->unrealize;
>    ...
>    -dc->unrealize =3D child_fn;
>    |
>    +device_class_set_parent_reset(dc, child_fn, &pc->parent_fn);
>    -pc->parent_fn =3D dc->reset;
>    ...
>    -dc->reset =3D child_fn;
>    )
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   hw/i386/kvm/i8254.c                | 4 ++--
>   hw/i386/kvm/i8259.c                | 3 +--
>   hw/input/adb-kbd.c                 | 4 ++--
>   hw/input/adb-mouse.c               | 4 ++--
>   hw/intc/arm_gic.c                  | 3 +--
>   hw/intc/arm_gic_kvm.c              | 7 +++----
>   hw/intc/arm_gicv3.c                | 3 +--
>   hw/intc/arm_gicv3_its_kvm.c        | 3 +--
>   hw/intc/arm_gicv3_kvm.c            | 7 +++----
>   hw/intc/i8259.c                    | 3 +--
>   hw/net/vmxnet3.c                   | 4 ++--
>   hw/pci-bridge/gen_pcie_root_port.c | 3 +--

PCIe Root Port changes:

Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel

>   hw/scsi/vmw_pvscsi.c               | 4 ++--
>   hw/timer/i8254.c                   | 3 +--
>   hw/vfio/amd-xgbe.c                 | 4 ++--
>   hw/vfio/calxeda-xgmac.c            | 4 ++--
>   hw/virtio/virtio-pci.c             | 4 ++--
>   target/alpha/cpu.c                 | 4 ++--
>   target/arm/cpu.c                   | 4 ++--
>   target/cris/cpu.c                  | 4 ++--
>   target/hppa/cpu.c                  | 4 ++--
>   target/i386/cpu.c                  | 8 ++++----
>   target/lm32/cpu.c                  | 5 ++---
>   target/m68k/cpu.c                  | 5 ++---
>   target/microblaze/cpu.c            | 5 ++---
>   target/mips/cpu.c                  | 5 ++---
>   target/moxie/cpu.c                 | 5 ++---
>   target/nios2/cpu.c                 | 4 ++--
>   target/openrisc/cpu.c              | 5 ++---
>   target/ppc/translate_init.c        | 8 ++++----
>   target/s390x/cpu.c                 | 4 ++--
>   target/sh4/cpu.c                   | 4 ++--
>   target/sparc/cpu.c                 | 4 ++--
>   target/tilegx/cpu.c                | 4 ++--
>   target/tricore/cpu.c               | 4 ++--
>   target/unicore32/cpu.c             | 4 ++--
>   target/xtensa/cpu.c                | 4 ++--
>   37 files changed, 73 insertions(+), 88 deletions(-)
>=20
> diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
> index 521a58498a..13f20f47d9 100644
> --- a/hw/i386/kvm/i8254.c
> +++ b/hw/i386/kvm/i8254.c
> @@ -315,8 +315,8 @@ static void kvm_pit_class_init(ObjectClass *klass, =
void *data)
>       PITCommonClass *k =3D PIT_COMMON_CLASS(klass);
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
>  =20
> -    kpc->parent_realize =3D dc->realize;
> -    dc->realize =3D kvm_pit_realizefn;
> +    device_class_set_parent_realize(dc, kvm_pit_realizefn,
> +                                    &kpc->parent_realize);
>       k->set_channel_gate =3D kvm_pit_set_gate;
>       k->get_channel_info =3D kvm_pit_get_channel_info;
>       dc->reset =3D kvm_pit_reset;
> diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
> index b91e98074e..05394cdb7b 100644
> --- a/hw/i386/kvm/i8259.c
> +++ b/hw/i386/kvm/i8259.c
> @@ -142,8 +142,7 @@ static void kvm_i8259_class_init(ObjectClass *klass=
, void *data)
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
>  =20
>       dc->reset     =3D kvm_pic_reset;
> -    kpc->parent_realize =3D dc->realize;
> -    dc->realize   =3D kvm_pic_realize;
> +    device_class_set_parent_realize(dc, kvm_pic_realize, &kpc->parent_=
realize);
>       k->pre_save   =3D kvm_pic_get;
>       k->post_load  =3D kvm_pic_put;
>   }
> diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
> index 354f56e41e..266aed1b7b 100644
> --- a/hw/input/adb-kbd.c
> +++ b/hw/input/adb-kbd.c
> @@ -374,8 +374,8 @@ static void adb_kbd_class_init(ObjectClass *oc, voi=
d *data)
>       ADBDeviceClass *adc =3D ADB_DEVICE_CLASS(oc);
>       ADBKeyboardClass *akc =3D ADB_KEYBOARD_CLASS(oc);
>  =20
> -    akc->parent_realize =3D dc->realize;
> -    dc->realize =3D adb_kbd_realizefn;
> +    device_class_set_parent_realize(dc, adb_kbd_realizefn,
> +                                    &akc->parent_realize);
>       set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>  =20
>       adc->devreq =3D adb_kbd_request;
> diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
> index c9004233b8..47e88faf25 100644
> --- a/hw/input/adb-mouse.c
> +++ b/hw/input/adb-mouse.c
> @@ -228,8 +228,8 @@ static void adb_mouse_class_init(ObjectClass *oc, v=
oid *data)
>       ADBDeviceClass *adc =3D ADB_DEVICE_CLASS(oc);
>       ADBMouseClass *amc =3D ADB_MOUSE_CLASS(oc);
>  =20
> -    amc->parent_realize =3D dc->realize;
> -    dc->realize =3D adb_mouse_realizefn;
> +    device_class_set_parent_realize(dc, adb_mouse_realizefn,
> +                                    &amc->parent_realize);
>       set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>  =20
>       adc->devreq =3D adb_mouse_request;
> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
> index d701e49ff9..9e0a5ea725 100644
> --- a/hw/intc/arm_gic.c
> +++ b/hw/intc/arm_gic.c
> @@ -1444,8 +1444,7 @@ static void arm_gic_class_init(ObjectClass *klass=
, void *data)
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
>       ARMGICClass *agc =3D ARM_GIC_CLASS(klass);
>  =20
> -    agc->parent_realize =3D dc->realize;
> -    dc->realize =3D arm_gic_realize;
> +    device_class_set_parent_realize(dc, arm_gic_realize, &agc->parent_=
realize);
>   }
>  =20
>   static const TypeInfo arm_gic_info =3D {
> diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
> index ae095d08a3..6f467e68a8 100644
> --- a/hw/intc/arm_gic_kvm.c
> +++ b/hw/intc/arm_gic_kvm.c
> @@ -591,10 +591,9 @@ static void kvm_arm_gic_class_init(ObjectClass *kl=
ass, void *data)
>  =20
>       agcc->pre_save =3D kvm_arm_gic_get;
>       agcc->post_load =3D kvm_arm_gic_put;
> -    kgc->parent_realize =3D dc->realize;
> -    kgc->parent_reset =3D dc->reset;
> -    dc->realize =3D kvm_arm_gic_realize;
> -    dc->reset =3D kvm_arm_gic_reset;
> +    device_class_set_parent_realize(dc, kvm_arm_gic_realize,
> +                                    &kgc->parent_realize);
> +    device_class_set_parent_reset(dc, kvm_arm_gic_reset, &kgc->parent_=
reset);
>   }
>  =20
>   static const TypeInfo kvm_arm_gic_info =3D {
> diff --git a/hw/intc/arm_gicv3.c b/hw/intc/arm_gicv3.c
> index f0c967b304..479c66733c 100644
> --- a/hw/intc/arm_gicv3.c
> +++ b/hw/intc/arm_gicv3.c
> @@ -385,8 +385,7 @@ static void arm_gicv3_class_init(ObjectClass *klass=
, void *data)
>       ARMGICv3Class *agc =3D ARM_GICV3_CLASS(klass);
>  =20
>       agcc->post_load =3D arm_gicv3_post_load;
> -    agc->parent_realize =3D dc->realize;
> -    dc->realize =3D arm_gic_realize;
> +    device_class_set_parent_realize(dc, arm_gic_realize, &agc->parent_=
realize);
>   }
>  =20
>   static const TypeInfo arm_gicv3_info =3D {
> diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
> index bf290b8bff..eea6a73df2 100644
> --- a/hw/intc/arm_gicv3_its_kvm.c
> +++ b/hw/intc/arm_gicv3_its_kvm.c
> @@ -245,11 +245,10 @@ static void kvm_arm_its_class_init(ObjectClass *k=
lass, void *data)
>  =20
>       dc->realize =3D kvm_arm_its_realize;
>       dc->props   =3D kvm_arm_its_props;
> -    ic->parent_reset =3D dc->reset;
> +    device_class_set_parent_reset(dc, kvm_arm_its_reset, &ic->parent_r=
eset);
>       icc->send_msi =3D kvm_its_send_msi;
>       icc->pre_save =3D kvm_arm_its_pre_save;
>       icc->post_load =3D kvm_arm_its_post_load;
> -    dc->reset =3D kvm_arm_its_reset;
>   }
>  =20
>   static const TypeInfo kvm_arm_its_info =3D {
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index 481fe5405a..ec371772b3 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -795,10 +795,9 @@ static void kvm_arm_gicv3_class_init(ObjectClass *=
klass, void *data)
>  =20
>       agcc->pre_save =3D kvm_arm_gicv3_get;
>       agcc->post_load =3D kvm_arm_gicv3_put;
> -    kgc->parent_realize =3D dc->realize;
> -    kgc->parent_reset =3D dc->reset;
> -    dc->realize =3D kvm_arm_gicv3_realize;
> -    dc->reset =3D kvm_arm_gicv3_reset;
> +    device_class_set_parent_realize(dc, kvm_arm_gicv3_realize,
> +                                    &kgc->parent_realize);
> +    device_class_set_parent_reset(dc, kvm_arm_gicv3_reset, &kgc->paren=
t_reset);
>   }
>  =20
>   static const TypeInfo kvm_arm_gicv3_info =3D {
> diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
> index 1602255a87..76f3d873b8 100644
> --- a/hw/intc/i8259.c
> +++ b/hw/intc/i8259.c
> @@ -443,8 +443,7 @@ static void i8259_class_init(ObjectClass *klass, vo=
id *data)
>       PICClass *k =3D PIC_CLASS(klass);
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
>  =20
> -    k->parent_realize =3D dc->realize;
> -    dc->realize =3D pic_realize;
> +    device_class_set_parent_realize(dc, pic_realize, &k->parent_realiz=
e);
>       dc->reset =3D pic_reset;
>   }
>  =20
> diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
> index 0654d594c1..3648630386 100644
> --- a/hw/net/vmxnet3.c
> +++ b/hw/net/vmxnet3.c
> @@ -2664,8 +2664,8 @@ static void vmxnet3_class_init(ObjectClass *class=
, void *data)
>       c->class_id =3D PCI_CLASS_NETWORK_ETHERNET;
>       c->subsystem_vendor_id =3D PCI_VENDOR_ID_VMWARE;
>       c->subsystem_id =3D PCI_DEVICE_ID_VMWARE_VMXNET3;
> -    vc->parent_dc_realize =3D dc->realize;
> -    dc->realize =3D vmxnet3_realize;
> +    device_class_set_parent_realize(dc, vmxnet3_realize,
> +                                    &vc->parent_dc_realize);
>       dc->desc =3D "VMWare Paravirtualized Ethernet v3";
>       dc->reset =3D vmxnet3_qdev_reset;
>       dc->vmsd =3D &vmstate_vmxnet3;
> diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pci=
e_root_port.c
> index ad4e6aa7ff..4a3b13d02c 100644
> --- a/hw/pci-bridge/gen_pcie_root_port.c
> +++ b/hw/pci-bridge/gen_pcie_root_port.c
> @@ -132,8 +132,7 @@ static void gen_rp_dev_class_init(ObjectClass *klas=
s, void *data)
>       dc->vmsd =3D &vmstate_rp_dev;
>       dc->props =3D gen_rp_props;
>  =20
> -    rpc->parent_realize =3D dc->realize;
> -    dc->realize =3D gen_rp_realize;
> +    device_class_set_parent_realize(dc, gen_rp_realize, &rpc->parent_r=
ealize);
>  =20
>       rpc->aer_vector =3D gen_rp_aer_vector;
>       rpc->interrupts_init =3D gen_rp_interrupts_init;
> diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
> index 27749c0e42..a3a019e30a 100644
> --- a/hw/scsi/vmw_pvscsi.c
> +++ b/hw/scsi/vmw_pvscsi.c
> @@ -1284,8 +1284,8 @@ static void pvscsi_class_init(ObjectClass *klass,=
 void *data)
>       k->device_id =3D PCI_DEVICE_ID_VMWARE_PVSCSI;
>       k->class_id =3D PCI_CLASS_STORAGE_SCSI;
>       k->subsystem_id =3D 0x1000;
> -    pvs_k->parent_dc_realize =3D dc->realize;
> -    dc->realize =3D pvscsi_realize;
> +    device_class_set_parent_realize(dc, pvscsi_realize,
> +                                    &pvs_k->parent_dc_realize);
>       dc->reset =3D pvscsi_reset;
>       dc->vmsd =3D &vmstate_pvscsi;
>       dc->props =3D pvscsi_properties;
> diff --git a/hw/timer/i8254.c b/hw/timer/i8254.c
> index dbc4a0baec..1057850808 100644
> --- a/hw/timer/i8254.c
> +++ b/hw/timer/i8254.c
> @@ -358,8 +358,7 @@ static void pit_class_initfn(ObjectClass *klass, vo=
id *data)
>       PITCommonClass *k =3D PIT_COMMON_CLASS(klass);
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
>  =20
> -    pc->parent_realize =3D dc->realize;
> -    dc->realize =3D pit_realizefn;
> +    device_class_set_parent_realize(dc, pit_realizefn, &pc->parent_rea=
lize);
>       k->set_channel_gate =3D pit_set_channel_gate;
>       k->get_channel_info =3D pit_get_channel_info_common;
>       k->post_load =3D pit_post_load;
> diff --git a/hw/vfio/amd-xgbe.c b/hw/vfio/amd-xgbe.c
> index fab196cebf..0c4ec4ba25 100644
> --- a/hw/vfio/amd-xgbe.c
> +++ b/hw/vfio/amd-xgbe.c
> @@ -34,8 +34,8 @@ static void vfio_amd_xgbe_class_init(ObjectClass *kla=
ss, void *data)
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
>       VFIOAmdXgbeDeviceClass *vcxc =3D
>           VFIO_AMD_XGBE_DEVICE_CLASS(klass);
> -    vcxc->parent_realize =3D dc->realize;
> -    dc->realize =3D amd_xgbe_realize;
> +    device_class_set_parent_realize(dc, amd_xgbe_realize,
> +                                    &vcxc->parent_realize);
>       dc->desc =3D "VFIO AMD XGBE";
>       dc->vmsd =3D &vfio_platform_amd_xgbe_vmstate;
>       /* Supported by TYPE_VIRT_MACHINE */
> diff --git a/hw/vfio/calxeda-xgmac.c b/hw/vfio/calxeda-xgmac.c
> index 7bb17af7ad..24cee6d065 100644
> --- a/hw/vfio/calxeda-xgmac.c
> +++ b/hw/vfio/calxeda-xgmac.c
> @@ -34,8 +34,8 @@ static void vfio_calxeda_xgmac_class_init(ObjectClass=
 *klass, void *data)
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
>       VFIOCalxedaXgmacDeviceClass *vcxc =3D
>           VFIO_CALXEDA_XGMAC_DEVICE_CLASS(klass);
> -    vcxc->parent_realize =3D dc->realize;
> -    dc->realize =3D calxeda_xgmac_realize;
> +    device_class_set_parent_realize(dc, calxeda_xgmac_realize,
> +                                    &vcxc->parent_realize);
>       dc->desc =3D "VFIO Calxeda XGMAC";
>       dc->vmsd =3D &vfio_platform_calxeda_xgmac_vmstate;
>       /* Supported by TYPE_VIRT_MACHINE */
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 6c75cca88a..3eeb98c4cf 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1907,8 +1907,8 @@ static void virtio_pci_class_init(ObjectClass *kl=
ass, void *data)
>       k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
>       k->revision =3D VIRTIO_PCI_ABI_VERSION;
>       k->class_id =3D PCI_CLASS_OTHERS;
> -    vpciklass->parent_dc_realize =3D dc->realize;
> -    dc->realize =3D virtio_pci_dc_realize;
> +    device_class_set_parent_realize(dc, virtio_pci_dc_realize,
> +                                    &vpciklass->parent_dc_realize);
>       dc->reset =3D virtio_pci_reset;
>   }
>  =20
> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
> index 7d6366bae9..55675ce419 100644
> --- a/target/alpha/cpu.c
> +++ b/target/alpha/cpu.c
> @@ -233,8 +233,8 @@ static void alpha_cpu_class_init(ObjectClass *oc, v=
oid *data)
>       CPUClass *cc =3D CPU_CLASS(oc);
>       AlphaCPUClass *acc =3D ALPHA_CPU_CLASS(oc);
>  =20
> -    acc->parent_realize =3D dc->realize;
> -    dc->realize =3D alpha_cpu_realizefn;
> +    device_class_set_parent_realize(dc, alpha_cpu_realizefn,
> +                                    &acc->parent_realize);
>  =20
>       cc->class_by_name =3D alpha_cpu_class_by_name;
>       cc->has_work =3D alpha_cpu_has_work;
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index cc1856c32b..2b29747b9f 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1722,8 +1722,8 @@ static void arm_cpu_class_init(ObjectClass *oc, v=
oid *data)
>       CPUClass *cc =3D CPU_CLASS(acc);
>       DeviceClass *dc =3D DEVICE_CLASS(oc);
>  =20
> -    acc->parent_realize =3D dc->realize;
> -    dc->realize =3D arm_cpu_realizefn;
> +    device_class_set_parent_realize(dc, arm_cpu_realizefn,
> +                                    &acc->parent_realize);
>       dc->props =3D arm_cpu_properties;
>  =20
>       acc->parent_reset =3D cc->reset;
> diff --git a/target/cris/cpu.c b/target/cris/cpu.c
> index 949c7a6e25..db8d0884a1 100644
> --- a/target/cris/cpu.c
> +++ b/target/cris/cpu.c
> @@ -260,8 +260,8 @@ static void cris_cpu_class_init(ObjectClass *oc, vo=
id *data)
>       CPUClass *cc =3D CPU_CLASS(oc);
>       CRISCPUClass *ccc =3D CRIS_CPU_CLASS(oc);
>  =20
> -    ccc->parent_realize =3D dc->realize;
> -    dc->realize =3D cris_cpu_realizefn;
> +    device_class_set_parent_realize(dc, cris_cpu_realizefn,
> +                                    &ccc->parent_realize);
>  =20
>       ccc->parent_reset =3D cc->reset;
>       cc->reset =3D cris_cpu_reset;
> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index 9e7b0d4ccb..899464ae87 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -121,8 +121,8 @@ static void hppa_cpu_class_init(ObjectClass *oc, vo=
id *data)
>       CPUClass *cc =3D CPU_CLASS(oc);
>       HPPACPUClass *acc =3D HPPA_CPU_CLASS(oc);
>  =20
> -    acc->parent_realize =3D dc->realize;
> -    dc->realize =3D hppa_cpu_realizefn;
> +    device_class_set_parent_realize(dc, hppa_cpu_realizefn,
> +                                    &acc->parent_realize);
>  =20
>       cc->class_by_name =3D hppa_cpu_class_by_name;
>       cc->do_interrupt =3D hppa_cpu_do_interrupt;
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 3818d72831..3573cfab65 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4216,10 +4216,10 @@ static void x86_cpu_common_class_init(ObjectCla=
ss *oc, void *data)
>       CPUClass *cc =3D CPU_CLASS(oc);
>       DeviceClass *dc =3D DEVICE_CLASS(oc);
>  =20
> -    xcc->parent_realize =3D dc->realize;
> -    xcc->parent_unrealize =3D dc->unrealize;
> -    dc->realize =3D x86_cpu_realizefn;
> -    dc->unrealize =3D x86_cpu_unrealizefn;
> +    device_class_set_parent_realize(dc, x86_cpu_realizefn,
> +                                    &xcc->parent_realize);
> +    device_class_set_parent_unrealize(dc, x86_cpu_unrealizefn,
> +                                      &xcc->parent_unrealize);
>       dc->props =3D x86_cpu_properties;
>  =20
>       xcc->parent_reset =3D cc->reset;
> diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
> index 6f5c14767b..96c2499d0b 100644
> --- a/target/lm32/cpu.c
> +++ b/target/lm32/cpu.c
> @@ -236,9 +236,8 @@ static void lm32_cpu_class_init(ObjectClass *oc, vo=
id *data)
>       CPUClass *cc =3D CPU_CLASS(oc);
>       DeviceClass *dc =3D DEVICE_CLASS(oc);
>  =20
> -    lcc->parent_realize =3D dc->realize;
> -    dc->realize =3D lm32_cpu_realizefn;
> -
> +    device_class_set_parent_realize(dc, lm32_cpu_realizefn,
> +                                    &lcc->parent_realize);
>       lcc->parent_reset =3D cc->reset;
>       cc->reset =3D lm32_cpu_reset;
>  =20
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index 03126ba543..a07c568297 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -255,9 +255,8 @@ static void m68k_cpu_class_init(ObjectClass *c, voi=
d *data)
>       CPUClass *cc =3D CPU_CLASS(c);
>       DeviceClass *dc =3D DEVICE_CLASS(c);
>  =20
> -    mcc->parent_realize =3D dc->realize;
> -    dc->realize =3D m68k_cpu_realizefn;
> -
> +    device_class_set_parent_realize(dc, m68k_cpu_realizefn,
> +                                    &mcc->parent_realize);
>       mcc->parent_reset =3D cc->reset;
>       cc->reset =3D m68k_cpu_reset;
>  =20
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 5700652e06..d8df2fb07e 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -258,9 +258,8 @@ static void mb_cpu_class_init(ObjectClass *oc, void=
 *data)
>       CPUClass *cc =3D CPU_CLASS(oc);
>       MicroBlazeCPUClass *mcc =3D MICROBLAZE_CPU_CLASS(oc);
>  =20
> -    mcc->parent_realize =3D dc->realize;
> -    dc->realize =3D mb_cpu_realizefn;
> -
> +    device_class_set_parent_realize(dc, mb_cpu_realizefn,
> +                                    &mcc->parent_realize);
>       mcc->parent_reset =3D cc->reset;
>       cc->reset =3D mb_cpu_reset;
>  =20
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index 069f93560e..497706b669 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -174,9 +174,8 @@ static void mips_cpu_class_init(ObjectClass *c, voi=
d *data)
>       CPUClass *cc =3D CPU_CLASS(c);
>       DeviceClass *dc =3D DEVICE_CLASS(c);
>  =20
> -    mcc->parent_realize =3D dc->realize;
> -    dc->realize =3D mips_cpu_realizefn;
> -
> +    device_class_set_parent_realize(dc, mips_cpu_realizefn,
> +                                    &mcc->parent_realize);
>       mcc->parent_reset =3D cc->reset;
>       cc->reset =3D mips_cpu_reset;
>  =20
> diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
> index f1389e5097..4170284da6 100644
> --- a/target/moxie/cpu.c
> +++ b/target/moxie/cpu.c
> @@ -102,9 +102,8 @@ static void moxie_cpu_class_init(ObjectClass *oc, v=
oid *data)
>       CPUClass *cc =3D CPU_CLASS(oc);
>       MoxieCPUClass *mcc =3D MOXIE_CPU_CLASS(oc);
>  =20
> -    mcc->parent_realize =3D dc->realize;
> -    dc->realize =3D moxie_cpu_realizefn;
> -
> +    device_class_set_parent_realize(dc, moxie_cpu_realizefn,
> +                                    &mcc->parent_realize);
>       mcc->parent_reset =3D cc->reset;
>       cc->reset =3D moxie_cpu_reset;
>  =20
> diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
> index 4742e52c78..fbfaa2ce26 100644
> --- a/target/nios2/cpu.c
> +++ b/target/nios2/cpu.c
> @@ -187,8 +187,8 @@ static void nios2_cpu_class_init(ObjectClass *oc, v=
oid *data)
>       CPUClass *cc =3D CPU_CLASS(oc);
>       Nios2CPUClass *ncc =3D NIOS2_CPU_CLASS(oc);
>  =20
> -    ncc->parent_realize =3D dc->realize;
> -    dc->realize =3D nios2_cpu_realizefn;
> +    device_class_set_parent_realize(dc, nios2_cpu_realizefn,
> +                                    &ncc->parent_realize);
>       dc->props =3D nios2_properties;
>       ncc->parent_reset =3D cc->reset;
>       cc->reset =3D nios2_cpu_reset;
> diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
> index e0394b8b06..20b115afae 100644
> --- a/target/openrisc/cpu.c
> +++ b/target/openrisc/cpu.c
> @@ -132,9 +132,8 @@ static void openrisc_cpu_class_init(ObjectClass *oc=
, void *data)
>       CPUClass *cc =3D CPU_CLASS(occ);
>       DeviceClass *dc =3D DEVICE_CLASS(oc);
>  =20
> -    occ->parent_realize =3D dc->realize;
> -    dc->realize =3D openrisc_cpu_realizefn;
> -
> +    device_class_set_parent_realize(dc, openrisc_cpu_realizefn,
> +                                    &occ->parent_realize);
>       occ->parent_reset =3D cc->reset;
>       cc->reset =3D openrisc_cpu_reset;
>  =20
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 70ff15a51a..566cf552e0 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -10556,12 +10556,12 @@ static void ppc_cpu_class_init(ObjectClass *o=
c, void *data)
>       CPUClass *cc =3D CPU_CLASS(oc);
>       DeviceClass *dc =3D DEVICE_CLASS(oc);
>  =20
> -    pcc->parent_realize =3D dc->realize;
> -    pcc->parent_unrealize =3D dc->unrealize;
> +    device_class_set_parent_realize(dc, ppc_cpu_realizefn,
> +                                    &pcc->parent_realize);
> +    device_class_set_parent_unrealize(dc, ppc_cpu_unrealizefn,
> +                                      &pcc->parent_unrealize);
>       pcc->pvr_match =3D ppc_pvr_match_default;
>       pcc->interrupts_big_endian =3D ppc_cpu_interrupts_big_endian_alwa=
ys;
> -    dc->realize =3D ppc_cpu_realizefn;
> -    dc->unrealize =3D ppc_cpu_unrealizefn;
>       dc->props =3D ppc_cpu_properties;
>  =20
>       pcc->parent_reset =3D cc->reset;
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index ae3cee91a2..4c068cedff 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -463,8 +463,8 @@ static void s390_cpu_class_init(ObjectClass *oc, vo=
id *data)
>       CPUClass *cc =3D CPU_CLASS(scc);
>       DeviceClass *dc =3D DEVICE_CLASS(oc);
>  =20
> -    scc->parent_realize =3D dc->realize;
> -    dc->realize =3D s390_cpu_realizefn;
> +    device_class_set_parent_realize(dc, s390_cpu_realizefn,
> +                                    &scc->parent_realize);
>       dc->props =3D s390x_cpu_properties;
>       dc->user_creatable =3D true;
>  =20
> diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
> index e0b99fbc89..e37c187ca2 100644
> --- a/target/sh4/cpu.c
> +++ b/target/sh4/cpu.c
> @@ -236,8 +236,8 @@ static void superh_cpu_class_init(ObjectClass *oc, =
void *data)
>       CPUClass *cc =3D CPU_CLASS(oc);
>       SuperHCPUClass *scc =3D SUPERH_CPU_CLASS(oc);
>  =20
> -    scc->parent_realize =3D dc->realize;
> -    dc->realize =3D superh_cpu_realizefn;
> +    device_class_set_parent_realize(dc, superh_cpu_realizefn,
> +                                    &scc->parent_realize);
>  =20
>       scc->parent_reset =3D cc->reset;
>       cc->reset =3D superh_cpu_reset;
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index c7adc281de..ff6ed91f9a 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -858,8 +858,8 @@ static void sparc_cpu_class_init(ObjectClass *oc, v=
oid *data)
>       CPUClass *cc =3D CPU_CLASS(oc);
>       DeviceClass *dc =3D DEVICE_CLASS(oc);
>  =20
> -    scc->parent_realize =3D dc->realize;
> -    dc->realize =3D sparc_cpu_realizefn;
> +    device_class_set_parent_realize(dc, sparc_cpu_realizefn,
> +                                    &scc->parent_realize);
>       dc->props =3D sparc_cpu_properties;
>  =20
>       scc->parent_reset =3D cc->reset;
> diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
> index 2ef8ea7daa..54b6c50878 100644
> --- a/target/tilegx/cpu.c
> +++ b/target/tilegx/cpu.c
> @@ -141,8 +141,8 @@ static void tilegx_cpu_class_init(ObjectClass *oc, =
void *data)
>       CPUClass *cc =3D CPU_CLASS(oc);
>       TileGXCPUClass *tcc =3D TILEGX_CPU_CLASS(oc);
>  =20
> -    tcc->parent_realize =3D dc->realize;
> -    dc->realize =3D tilegx_cpu_realizefn;
> +    device_class_set_parent_realize(dc, tilegx_cpu_realizefn,
> +                                    &tcc->parent_realize);
>  =20
>       tcc->parent_reset =3D cc->reset;
>       cc->reset =3D tilegx_cpu_reset;
> diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
> index 179c997aa4..2edaef1aef 100644
> --- a/target/tricore/cpu.c
> +++ b/target/tricore/cpu.c
> @@ -153,8 +153,8 @@ static void tricore_cpu_class_init(ObjectClass *c, =
void *data)
>       CPUClass *cc =3D CPU_CLASS(c);
>       DeviceClass *dc =3D DEVICE_CLASS(c);
>  =20
> -    mcc->parent_realize =3D dc->realize;
> -    dc->realize =3D tricore_cpu_realizefn;
> +    device_class_set_parent_realize(dc, tricore_cpu_realizefn,
> +                                    &mcc->parent_realize);
>  =20
>       mcc->parent_reset =3D cc->reset;
>       cc->reset =3D tricore_cpu_reset;
> diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
> index 17dc1504d7..fb837aab4c 100644
> --- a/target/unicore32/cpu.c
> +++ b/target/unicore32/cpu.c
> @@ -132,8 +132,8 @@ static void uc32_cpu_class_init(ObjectClass *oc, vo=
id *data)
>       CPUClass *cc =3D CPU_CLASS(oc);
>       UniCore32CPUClass *ucc =3D UNICORE32_CPU_CLASS(oc);
>  =20
> -    ucc->parent_realize =3D dc->realize;
> -    dc->realize =3D uc32_cpu_realizefn;
> +    device_class_set_parent_realize(dc, uc32_cpu_realizefn,
> +                                    &ucc->parent_realize);
>  =20
>       cc->class_by_name =3D uc32_cpu_class_by_name;
>       cc->has_work =3D uc32_cpu_has_work;
> diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
> index 1c982a0b2e..4573388a45 100644
> --- a/target/xtensa/cpu.c
> +++ b/target/xtensa/cpu.c
> @@ -151,8 +151,8 @@ static void xtensa_cpu_class_init(ObjectClass *oc, =
void *data)
>       CPUClass *cc =3D CPU_CLASS(oc);
>       XtensaCPUClass *xcc =3D XTENSA_CPU_CLASS(cc);
>  =20
> -    xcc->parent_realize =3D dc->realize;
> -    dc->realize =3D xtensa_cpu_realizefn;
> +    device_class_set_parent_realize(dc, xtensa_cpu_realizefn,
> +                                    &xcc->parent_realize);
>  =20
>       xcc->parent_reset =3D cc->reset;
>       cc->reset =3D xtensa_cpu_reset;
>=20
