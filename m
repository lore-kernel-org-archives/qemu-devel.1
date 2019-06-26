Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2A2C48BD8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:43:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFB5E214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB5E214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg7Gy-00062U-9h
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 08:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56355)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hg7DJ-0001Kg-Hz
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:39:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hg7DI-0000Gf-0c
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:39:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54012)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>)
 id 1hg7DH-0000ER-MC; Wed, 26 Jun 2019 08:39:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5384230C120E;
 Wed, 26 Jun 2019 12:39:40 +0000 (UTC)
Received: from localhost (ovpn-116-101.gru2.redhat.com [10.97.116.101])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 52A3160BF3;
 Wed, 26 Jun 2019 12:39:36 +0000 (UTC)
Date: Wed, 26 Jun 2019 09:39:34 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Message-ID: <20190626123934.GZ1862@habkost.net>
References: <20190625232333.30752-1-marcandre.lureau@redhat.com>
 <20190626015503.GX1862@habkost.net>
 <CAJ+F1CKWRvuDxNuidWPE6+A7gKmbJ2h9G3DcDDVbd24y1XMYKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKWRvuDxNuidWPE6+A7gKmbJ2h9G3DcDDVbd24y1XMYKw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 26 Jun 2019 12:39:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] virtio-pci: fix missing device properties
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
Cc: Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 26, 2019 at 11:48:20AM +0200, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Wed, Jun 26, 2019 at 3:56 AM Eduardo Habkost <ehabkost@redhat.com> w=
rote:
> >
> > On Wed, Jun 26, 2019 at 01:23:33AM +0200, Marc-Andr=E9 Lureau wrote:
> > > Since commit a4ee4c8baa37154 ("virtio: Helper for registering virti=
o
> > > device types"), virtio-gpu-pci, virtio-vga, and virtio-crypto-pci l=
ost
> > > some properties: "ioeventfd" and "vectors". This may cause various
> > > issues, such as failing migration or invalid properties.
> > >
> > > Since those VirtioPCI devices do not have a base name, their class =
are
> > > initialized with virtio_pci_generic_base_class_init(). However, if =
the
> > > VirtioPCIDeviceTypeInfo provided a class_init which sets dc->props,
> > > the properties were overwritten by virtio_pci_generic_class_init().
> > >
> > > Instead, introduce an intermediary base-type to register the generi=
c
> > > properties.
> > >
> > > Fixes: a4ee4c8baa37154f42b4dc6a13fee79268d15238
> > > Cc: qemu-stable@nongnu.org
> > > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  hw/virtio/virtio-pci.c | 28 ++++++++++++++--------------
> > >  1 file changed, 14 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > > index e6d5467e54..62c4977332 100644
> > > --- a/hw/virtio/virtio-pci.c
> > > +++ b/hw/virtio/virtio-pci.c
> > > @@ -1913,13 +1913,6 @@ static void virtio_pci_generic_class_init(Ob=
jectClass *klass, void *data)
> > >      dc->props =3D virtio_pci_generic_properties;
> > >  }
> > >
> > > -/* Used when the generic type and the base type is the same */
> > > -static void virtio_pci_generic_base_class_init(ObjectClass *klass,=
 void *data)
> > > -{
> > > -    virtio_pci_base_class_init(klass, data);
> > > -    virtio_pci_generic_class_init(klass, NULL);
> > > -}
> > > -
> > >  static void virtio_pci_transitional_instance_init(Object *obj)
> > >  {
> > >      VirtIOPCIProxy *proxy =3D VIRTIO_PCI(obj);
> > > @@ -1938,14 +1931,13 @@ static void virtio_pci_non_transitional_ins=
tance_init(Object *obj)
> > >
> > >  void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
> > >  {
> > > +    char *base_name =3D NULL;
> > >      TypeInfo base_type_info =3D {
> > >          .name          =3D t->base_name,
> > >          .parent        =3D t->parent ? t->parent : TYPE_VIRTIO_PCI=
,
> > >          .instance_size =3D t->instance_size,
> > >          .instance_init =3D t->instance_init,
> > >          .class_size    =3D t->class_size,
> > > -        .class_init    =3D virtio_pci_base_class_init,
> > > -        .class_data    =3D (void *)t,
> > >          .abstract      =3D true,
> > >      };
> > >      TypeInfo generic_type_info =3D {
> > > @@ -1961,13 +1953,20 @@ void virtio_pci_types_register(const Virtio=
PCIDeviceTypeInfo *t)
> > >
> > >      if (!base_type_info.name) {
> > >          /* No base type -> register a single generic device type *=
/
> > > -        base_type_info.name =3D t->generic_name;
> > > -        base_type_info.class_init =3D virtio_pci_generic_base_clas=
s_init;
> > > -        base_type_info.interfaces =3D generic_type_info.interfaces=
;
> > > -        base_type_info.abstract =3D false;
> > > -        generic_type_info.name =3D NULL;
> > > +        /* use intermediate %s-base-type to add generic device pro=
ps */
> > > +        base_name =3D g_strdup_printf("%s-base-type", t->generic_n=
ame);
> > > +        base_type_info.name =3D base_name;
> > > +        base_type_info.class_init =3D virtio_pci_generic_class_ini=
t;
> > > +
> > > +        generic_type_info.parent =3D base_name;
> > > +        generic_type_info.class_init =3D virtio_pci_base_class_ini=
t;
> > > +        generic_type_info.class_data =3D (void *)t;
> >
> > Why are you using virtio_pci_generic_class_init for the base
> > class, and virtio_pci_base_class_init for the subclass, but doing
> > exactly the opposite when t->base_name is set?
> >
> > Isn't it simpler to just initialize base_type_info.name and leave
> > all the rest alone?  Patch below.
>=20
> That was my initial approach. But then I tested the backport on v4.0.0,=
 you get:
>=20
> hw/display/virtio-vga.c:200:virtio_vga_class_init: Object
> 0x56247edbc0e0 is not an instance of type virtio-vga
>=20
> The problem is that the introduced base class calls the t->class_init,
> which expects the final class (virtio-vga, not virtio-vga-base-type).

Ouch.  In this case:

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

This would be much easier if we could append properties to
dc->props.  But this would be too complex for a
4.0-stable bug fix.

>=20
> This seems to be limited to virtio-vga, and gone in upstream since the
> registration changed. But I would rather have the same patch
> reviewed/applied.
>=20
>=20
> >
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index e6d5467e54..3ee50a0783 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -1913,13 +1913,6 @@ static void virtio_pci_generic_class_init(Obje=
ctClass *klass, void *data)
> >      dc->props =3D virtio_pci_generic_properties;
> >  }
> >
> > -/* Used when the generic type and the base type is the same */
> > -static void virtio_pci_generic_base_class_init(ObjectClass *klass, v=
oid *data)
> > -{
> > -    virtio_pci_base_class_init(klass, data);
> > -    virtio_pci_generic_class_init(klass, NULL);
> > -}
> > -
> >  static void virtio_pci_transitional_instance_init(Object *obj)
> >  {
> >      VirtIOPCIProxy *proxy =3D VIRTIO_PCI(obj);
> > @@ -1938,8 +1931,11 @@ static void virtio_pci_non_transitional_instan=
ce_init(Object *obj)
> >
> >  void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
> >  {
> > +    char *base_name =3D t->base_name ?
> > +                      NULL :
> > +                      g_strdup_printf("%s-base-type", t->generic_nam=
e);
> >      TypeInfo base_type_info =3D {
> > -        .name          =3D t->base_name,
> > +        .name          =3D t->base_name ?: base_name,
> >          .parent        =3D t->parent ? t->parent : TYPE_VIRTIO_PCI,
> >          .instance_size =3D t->instance_size,
> >          .instance_init =3D t->instance_init,
> > @@ -1959,21 +1955,8 @@ void virtio_pci_types_register(const VirtioPCI=
DeviceTypeInfo *t)
> >          },
> >      };
> >
> > -    if (!base_type_info.name) {
> > -        /* No base type -> register a single generic device type */
> > -        base_type_info.name =3D t->generic_name;
> > -        base_type_info.class_init =3D virtio_pci_generic_base_class_=
init;
> > -        base_type_info.interfaces =3D generic_type_info.interfaces;
> > -        base_type_info.abstract =3D false;
> > -        generic_type_info.name =3D NULL;
> > -        assert(!t->non_transitional_name);
> > -        assert(!t->transitional_name);
> > -    }
> > -
> >      type_register(&base_type_info);
> > -    if (generic_type_info.name) {
> > -        type_register(&generic_type_info);
> > -    }
> > +    type_register(&generic_type_info);
>=20
> t->generic_name can't be NULL anymore? I thought the condition was
> done for a good reason.

My mistake.  I forgot generic_type_info.name could be NULL
because of t->generic_name was already NULL.

>=20
> >
> >      if (t->non_transitional_name) {
> >          const TypeInfo non_transitional_type_info =3D {
> > @@ -2005,6 +1988,7 @@ void virtio_pci_types_register(const VirtioPCID=
eviceTypeInfo *t)
> >          };
> >          type_register(&transitional_type_info);
> >      }
> > +    g_free(base_name);
> >  }
> >
> >  /* virtio-pci-bus */
> >
> >
> > --
> > Eduardo
> >
>=20
>=20
> --=20
> Marc-Andr=E9 Lureau

--=20
Eduardo

