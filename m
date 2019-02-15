Received: from eggs.gnu.org ([209.51.188.92]:43493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gudNx-0007Hz-IJ
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:18:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gudNw-00040m-Nl
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:18:33 -0500
Received: from 12.mo5.mail-out.ovh.net ([46.105.39.65]:46920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gudNw-0003yF-He
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:18:32 -0500
Received: from player772.ha.ovh.net (unknown [10.109.160.54])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 3B60421C4BE
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 14:18:30 +0100 (CET)
Date: Fri, 15 Feb 2019 14:18:24 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190215141824.3549d285@bahia.lan>
In-Reply-To: <4690ad87-f634-4f3b-a39c-ee61bfc64e75@kaod.org>
References: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
	<155023081228.1011724.12474992370439652538.stgit@bahia.lan>
	<4690ad87-f634-4f3b-a39c-ee61bfc64e75@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/10] xics: Drop the KVM ICP class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Fri, 15 Feb 2019 13:55:53 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 2/15/19 12:40 PM, Greg Kurz wrote:
> > The KVM ICP class isn't used anymore. Drop it. =20
>=20
> Isn't migration complaining ?  If not,
>=20

Hm.. no, but why would migration complain ?

> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> Thanks,
>=20
> C.
>=20
>=20
>=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/intc/xics_kvm.c    |   18 ------------------
> >  include/hw/ppc/xics.h |    3 ---
> >  2 files changed, 21 deletions(-)
> >=20
> > diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> > index 4eebced516b6..fae4ac431f2f 100644
> > --- a/hw/intc/xics_kvm.c
> > +++ b/hw/intc/xics_kvm.c
> > @@ -152,23 +152,6 @@ void icp_kvm_realize(DeviceState *dev, Error **err=
p)
> >      QLIST_INSERT_HEAD(&kvm_enabled_icps, enabled_icp, node);
> >  }
> > =20
> > -static void icp_kvm_class_init(ObjectClass *klass, void *data)
> > -{
> > -    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > -    ICPStateClass *icpc =3D ICP_CLASS(klass);
> > -
> > -    device_class_set_parent_realize(dc, icp_kvm_realize,
> > -                                    &icpc->parent_realize);
> > -}
> > -
> > -static const TypeInfo icp_kvm_info =3D {
> > -    .name =3D TYPE_KVM_ICP,
> > -    .parent =3D TYPE_ICP,
> > -    .instance_size =3D sizeof(ICPState),
> > -    .class_init =3D icp_kvm_class_init,
> > -    .class_size =3D sizeof(ICPStateClass),
> > -};
> > -
> >  /*
> >   * ICS-KVM
> >   */
> > @@ -425,7 +408,6 @@ fail:
> >  static void xics_kvm_register_types(void)
> >  {
> >      type_register_static(&ics_kvm_info);
> > -    type_register_static(&icp_kvm_info);
> >  }
> > =20
> >  type_init(xics_kvm_register_types)
> > diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> > index ab61dc24010a..fae54e6f28ae 100644
> > --- a/include/hw/ppc/xics.h
> > +++ b/include/hw/ppc/xics.h
> > @@ -50,9 +50,6 @@ typedef struct XICSFabric XICSFabric;
> >  #define TYPE_ICP "icp"
> >  #define ICP(obj) OBJECT_CHECK(ICPState, (obj), TYPE_ICP)
> > =20
> > -#define TYPE_KVM_ICP "icp-kvm"
> > -#define KVM_ICP(obj) OBJECT_CHECK(ICPState, (obj), TYPE_KVM_ICP)
> > -
> >  #define TYPE_PNV_ICP "pnv-icp"
> >  #define PNV_ICP(obj) OBJECT_CHECK(PnvICPState, (obj), TYPE_PNV_ICP)
> > =20
> >  =20
>=20
