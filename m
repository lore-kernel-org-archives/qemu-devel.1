Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD2EC48BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 01:57:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B1292063F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 01:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1292063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfxBo-0007aa-8l
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 21:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46517)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hfx9a-0004gV-Gt
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 21:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hfx9Y-0006sg-Q2
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 21:55:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57886)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>)
 id 1hfx9Y-0006jW-A0; Tue, 25 Jun 2019 21:55:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E567A308FC22;
 Wed, 26 Jun 2019 01:55:10 +0000 (UTC)
Received: from localhost (ovpn-116-101.gru2.redhat.com [10.97.116.101])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3DA195D719;
 Wed, 26 Jun 2019 01:55:05 +0000 (UTC)
Date: Tue, 25 Jun 2019 22:55:04 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190626015503.GX1862@habkost.net>
References: <20190625232333.30752-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190625232333.30752-1-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 26 Jun 2019 01:55:10 +0000 (UTC)
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
Cc: lvivier@redhat.com, qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 26, 2019 at 01:23:33AM +0200, Marc-Andr=E9 Lureau wrote:
> Since commit a4ee4c8baa37154 ("virtio: Helper for registering virtio
> device types"), virtio-gpu-pci, virtio-vga, and virtio-crypto-pci lost
> some properties: "ioeventfd" and "vectors". This may cause various
> issues, such as failing migration or invalid properties.
>=20
> Since those VirtioPCI devices do not have a base name, their class are
> initialized with virtio_pci_generic_base_class_init(). However, if the
> VirtioPCIDeviceTypeInfo provided a class_init which sets dc->props,
> the properties were overwritten by virtio_pci_generic_class_init().
>=20
> Instead, introduce an intermediary base-type to register the generic
> properties.
>=20
> Fixes: a4ee4c8baa37154f42b4dc6a13fee79268d15238
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/virtio/virtio-pci.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index e6d5467e54..62c4977332 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1913,13 +1913,6 @@ static void virtio_pci_generic_class_init(Object=
Class *klass, void *data)
>      dc->props =3D virtio_pci_generic_properties;
>  }
> =20
> -/* Used when the generic type and the base type is the same */
> -static void virtio_pci_generic_base_class_init(ObjectClass *klass, voi=
d *data)
> -{
> -    virtio_pci_base_class_init(klass, data);
> -    virtio_pci_generic_class_init(klass, NULL);
> -}
> -
>  static void virtio_pci_transitional_instance_init(Object *obj)
>  {
>      VirtIOPCIProxy *proxy =3D VIRTIO_PCI(obj);
> @@ -1938,14 +1931,13 @@ static void virtio_pci_non_transitional_instanc=
e_init(Object *obj)
> =20
>  void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
>  {
> +    char *base_name =3D NULL;
>      TypeInfo base_type_info =3D {
>          .name          =3D t->base_name,
>          .parent        =3D t->parent ? t->parent : TYPE_VIRTIO_PCI,
>          .instance_size =3D t->instance_size,
>          .instance_init =3D t->instance_init,
>          .class_size    =3D t->class_size,
> -        .class_init    =3D virtio_pci_base_class_init,
> -        .class_data    =3D (void *)t,
>          .abstract      =3D true,
>      };
>      TypeInfo generic_type_info =3D {
> @@ -1961,13 +1953,20 @@ void virtio_pci_types_register(const VirtioPCID=
eviceTypeInfo *t)
> =20
>      if (!base_type_info.name) {
>          /* No base type -> register a single generic device type */
> -        base_type_info.name =3D t->generic_name;
> -        base_type_info.class_init =3D virtio_pci_generic_base_class_in=
it;
> -        base_type_info.interfaces =3D generic_type_info.interfaces;
> -        base_type_info.abstract =3D false;
> -        generic_type_info.name =3D NULL;
> +        /* use intermediate %s-base-type to add generic device props *=
/
> +        base_name =3D g_strdup_printf("%s-base-type", t->generic_name)=
;
> +        base_type_info.name =3D base_name;
> +        base_type_info.class_init =3D virtio_pci_generic_class_init;
> +
> +        generic_type_info.parent =3D base_name;
> +        generic_type_info.class_init =3D virtio_pci_base_class_init;
> +        generic_type_info.class_data =3D (void *)t;

Why are you using virtio_pci_generic_class_init for the base
class, and virtio_pci_base_class_init for the subclass, but doing
exactly the opposite when t->base_name is set?

Isn't it simpler to just initialize base_type_info.name and leave
all the rest alone?  Patch below.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index e6d5467e54..3ee50a0783 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1913,13 +1913,6 @@ static void virtio_pci_generic_class_init(ObjectCl=
ass *klass, void *data)
     dc->props =3D virtio_pci_generic_properties;
 }
=20
-/* Used when the generic type and the base type is the same */
-static void virtio_pci_generic_base_class_init(ObjectClass *klass, void =
*data)
-{
-    virtio_pci_base_class_init(klass, data);
-    virtio_pci_generic_class_init(klass, NULL);
-}
-
 static void virtio_pci_transitional_instance_init(Object *obj)
 {
     VirtIOPCIProxy *proxy =3D VIRTIO_PCI(obj);
@@ -1938,8 +1931,11 @@ static void virtio_pci_non_transitional_instance_i=
nit(Object *obj)
=20
 void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
 {
+    char *base_name =3D t->base_name ?
+                      NULL :
+                      g_strdup_printf("%s-base-type", t->generic_name);
     TypeInfo base_type_info =3D {
-        .name          =3D t->base_name,
+        .name          =3D t->base_name ?: base_name,
         .parent        =3D t->parent ? t->parent : TYPE_VIRTIO_PCI,
         .instance_size =3D t->instance_size,
         .instance_init =3D t->instance_init,
@@ -1959,21 +1955,8 @@ void virtio_pci_types_register(const VirtioPCIDevi=
ceTypeInfo *t)
         },
     };
=20
-    if (!base_type_info.name) {
-        /* No base type -> register a single generic device type */
-        base_type_info.name =3D t->generic_name;
-        base_type_info.class_init =3D virtio_pci_generic_base_class_init=
;
-        base_type_info.interfaces =3D generic_type_info.interfaces;
-        base_type_info.abstract =3D false;
-        generic_type_info.name =3D NULL;
-        assert(!t->non_transitional_name);
-        assert(!t->transitional_name);
-    }
-
     type_register(&base_type_info);
-    if (generic_type_info.name) {
-        type_register(&generic_type_info);
-    }
+    type_register(&generic_type_info);
=20
     if (t->non_transitional_name) {
         const TypeInfo non_transitional_type_info =3D {
@@ -2005,6 +1988,7 @@ void virtio_pci_types_register(const VirtioPCIDevic=
eTypeInfo *t)
         };
         type_register(&transitional_type_info);
     }
+    g_free(base_name);
 }
=20
 /* virtio-pci-bus */


--=20
Eduardo

