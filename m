Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8127DC606BD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 16:07:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59846204EC
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 16:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59846204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkWBH-00077l-HW
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 12:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42320)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hkW6y-0004NS-RS
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 12:03:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hkW6x-0004SC-JM
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 12:03:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61529)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hkW6w-0004NA-0D
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 12:03:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E316885540;
 Mon,  8 Jul 2019 16:03:23 +0000 (UTC)
Received: from work-vm (ovpn-117-74.ams2.redhat.com [10.36.117.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A23F05D9C8;
 Mon,  8 Jul 2019 16:03:22 +0000 (UTC)
Date: Mon, 8 Jul 2019 17:03:20 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <20190708160320.GM2746@work-vm>
References: <20190705010711.23277-1-marcel.apfelbaum@gmail.com>
 <03CB6DEC-3D25-4C09-9C9C-3A5206D1D1F7@gmail.com>
 <CAMzgYoMzLHEpSwLOu4nZAEK_E50xBsaYUfdXeCeHrq+-kaL=4w@mail.gmail.com>
 <49bb8456-a4b1-5a0e-e34d-cf5977e821ae@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <49bb8456-a4b1-5a0e-e34d-cf5977e821ae@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Mon, 08 Jul 2019 16:03:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] hw/net: fix vmxnet3 live migration
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
Cc: Sukrit Bhatnagar <skrtbhtngr@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org,
 Yuval Shaia <yuval.shaia@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Marcel Apfelbaum (marcel.apfelbaum@gmail.com) wrote:
>=20
>=20
> On 7/5/19 2:14 PM, Sukrit Bhatnagar wrote:
> > On Fri, 5 Jul 2019 at 16:29, Dmitry Fleytman <dmitry.fleytman@gmail.c=
om> wrote:
> > >=20
> > > > On 5 Jul 2019, at 4:07, Marcel Apfelbaum <marcel.apfelbaum@gmail.=
com> wrote:
> > > >=20
> > > > At some point vmxnet3 live migration stopped working and git-bise=
ct
> > > > didn't help finding a working version.
> > > > The issue is the PCI configuration space is not being migrated
> > > > successfully and MSIX remains masked at destination.
> > > >=20
> > > > Remove the migration differentiation between PCI and PCIe since
> > > > the logic resides now inside VMSTATE_PCI_DEVICE.
> > > > Remove also the VMXNET3_COMPAT_FLAG_DISABLE_PCIE based differenti=
ation
> > > > since at 'realize' time is decided if the device is PCI or PCIe,
> > > > then the above macro is enough.
> > > >=20
> > > > Use the opportunity to move to the standard VMSTATE_MSIX
> > > > instead of the deprecated SaveVMHandlers.
> > > >=20
> > > > Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > >=20
> > > Reviewed-by: Dmitry Fleytman <dmitry.fleytman@gmail.com>
> > >=20
> > Tested-by: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
>=20
> Thanks for the fast testing and review!
>=20
> David, since the live migration was broken long before this patch,
> I don't need=A0 to add any compatibility code, right?

Right, although we should probably bump the version_id field, that way
you'll get a nice clean error if you try and migrate from the old<->new.

(It's nice to get rid of the old msix oddity).

> If so, can you merge it using your migration tree?

I could do; or since it's entirely in vmxnet3 Dmitry can take it.

Dave

> Thanks,
> Marcel
>=20
>=20
> > > > ---
> > > > hw/net/vmxnet3.c | 52 ++-----------------------------------------=
-----
> > > > 1 file changed, 2 insertions(+), 50 deletions(-)
> > > >=20
> > > > diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
> > > > index 10d01d0058..8b17548b02 100644
> > > > --- a/hw/net/vmxnet3.c
> > > > +++ b/hw/net/vmxnet3.c
> > > > @@ -2141,21 +2141,6 @@ vmxnet3_cleanup_msi(VMXNET3State *s)
> > > >      msi_uninit(d);
> > > > }
> > > >=20
> > > > -static void
> > > > -vmxnet3_msix_save(QEMUFile *f, void *opaque)
> > > > -{
> > > > -    PCIDevice *d =3D PCI_DEVICE(opaque);
> > > > -    msix_save(d, f);
> > > > -}
> > > > -
> > > > -static int
> > > > -vmxnet3_msix_load(QEMUFile *f, void *opaque, int version_id)
> > > > -{
> > > > -    PCIDevice *d =3D PCI_DEVICE(opaque);
> > > > -    msix_load(d, f);
> > > > -    return 0;
> > > > -}
> > > > -
> > > > static const MemoryRegionOps b0_ops =3D {
> > > >      .read =3D vmxnet3_io_bar0_read,
> > > >      .write =3D vmxnet3_io_bar0_write,
> > > > @@ -2176,11 +2161,6 @@ static const MemoryRegionOps b1_ops =3D {
> > > >      },
> > > > };
> > > >=20
> > > > -static SaveVMHandlers savevm_vmxnet3_msix =3D {
> > > > -    .save_state =3D vmxnet3_msix_save,
> > > > -    .load_state =3D vmxnet3_msix_load,
> > > > -};
> > > > -
> > > > static uint64_t vmxnet3_device_serial_num(VMXNET3State *s)
> > > > {
> > > >      uint64_t dsn_payload;
> > > > @@ -2203,7 +2183,6 @@ static uint64_t vmxnet3_device_serial_num(V=
MXNET3State *s)
> > > >=20
> > > > static void vmxnet3_pci_realize(PCIDevice *pci_dev, Error **errp)
> > > > {
> > > > -    DeviceState *dev =3D DEVICE(pci_dev);
> > > >      VMXNET3State *s =3D VMXNET3(pci_dev);
> > > >      int ret;
> > > >=20
> > > > @@ -2249,8 +2228,6 @@ static void vmxnet3_pci_realize(PCIDevice *=
pci_dev, Error **errp)
> > > >          pcie_dev_ser_num_init(pci_dev, VMXNET3_DSN_OFFSET,
> > > >                                vmxnet3_device_serial_num(s));
> > > >      }
> > > > -
> > > > -    register_savevm_live(dev, "vmxnet3-msix", -1, 1, &savevm_vmx=
net3_msix, s);
> > > > }
> > > >=20
> > > > static void vmxnet3_instance_init(Object *obj)
> > > > @@ -2440,29 +2417,6 @@ static const VMStateDescription vmstate_vm=
xnet3_int_state =3D {
> > > >      }
> > > > };
> > > >=20
> > > > -static bool vmxnet3_vmstate_need_pcie_device(void *opaque)
> > > > -{
> > > > -    VMXNET3State *s =3D VMXNET3(opaque);
> > > > -
> > > > -    return !(s->compat_flags & VMXNET3_COMPAT_FLAG_DISABLE_PCIE)=
;
> > > > -}
> > > > -
> > > > -static bool vmxnet3_vmstate_test_pci_device(void *opaque, int ve=
rsion_id)
> > > > -{
> > > > -    return !vmxnet3_vmstate_need_pcie_device(opaque);
> > > > -}
> > > > -
> > > > -static const VMStateDescription vmstate_vmxnet3_pcie_device =3D =
{
> > > > -    .name =3D "vmxnet3/pcie",
> > > > -    .version_id =3D 1,
> > > > -    .minimum_version_id =3D 1,
> > > > -    .needed =3D vmxnet3_vmstate_need_pcie_device,
> > > > -    .fields =3D (VMStateField[]) {
> > > > -        VMSTATE_PCI_DEVICE(parent_obj, VMXNET3State),
> > > > -        VMSTATE_END_OF_LIST()
> > > > -    }
> > > > -};
> > > > -
> > > > static const VMStateDescription vmstate_vmxnet3 =3D {
> > > >      .name =3D "vmxnet3",
> > > >      .version_id =3D 1,
> > > > @@ -2470,9 +2424,8 @@ static const VMStateDescription vmstate_vmx=
net3 =3D {
> > > >      .pre_save =3D vmxnet3_pre_save,
> > > >      .post_load =3D vmxnet3_post_load,
> > > >      .fields =3D (VMStateField[]) {
> > > > -            VMSTATE_STRUCT_TEST(parent_obj, VMXNET3State,
> > > > -                                vmxnet3_vmstate_test_pci_device,=
 0,
> > > > -                                vmstate_pci_device, PCIDevice),
> > > > +            VMSTATE_PCI_DEVICE(parent_obj, VMXNET3State),
> > > > +            VMSTATE_MSIX(parent_obj, VMXNET3State),
> > > >              VMSTATE_BOOL(rx_packets_compound, VMXNET3State),
> > > >              VMSTATE_BOOL(rx_vlan_stripping, VMXNET3State),
> > > >              VMSTATE_BOOL(lro_supported, VMXNET3State),
> > > > @@ -2508,7 +2461,6 @@ static const VMStateDescription vmstate_vmx=
net3 =3D {
> > > >      },
> > > >      .subsections =3D (const VMStateDescription*[]) {
> > > >          &vmxstate_vmxnet3_mcast_list,
> > > > -        &vmstate_vmxnet3_pcie_device,
> > > >          NULL
> > > >      }
> > > > };
> > > > --
> > > > 2.17.1
> > > >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

