Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234D7C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:42:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E277A20721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbLdek4h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E277A20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVYYW-0007SK-3j
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 06:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jVYXF-0006A9-87
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:41:17 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36847)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jVYXE-0004xX-8Z
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:41:16 -0400
Received: by mail-wr1-x444.google.com with SMTP id d15so20321363wrx.3
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 03:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=NGnT3NUWy8fgy8AhJnTXjj15j5ReSdGSgxmfl07V1HU=;
 b=MbLdek4hen9MfBxFeiwzgXeF7cvEJBHBS9csHaM3ffiCYmAHiFzX6AbjSJR+ZvTEBp
 uKTmJzZoN2oNl/zKxjBZnEvdQGfpM8IgBL11h5mfL3gKB10EqSotcerzbl3tsf5ObL5k
 CYtGMQqGTgObXV/ALWynKrgSgZD8nZdJPF0gO72c6rbKpqMYb4PQq+P43KAXeY2Rsggw
 bYjvxJsBquLcFaLBlfIBjjkwHHO9MNJHBc8zIeRWd1tFOO1AIualkrelkREna8Guom9J
 Q+ppKRbWG2X/KpMSKd+bH3WcyJbbKPNp3dQ3/L+OfllMQzFqGwCLruyoBdgiGQ/IEIzf
 0kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NGnT3NUWy8fgy8AhJnTXjj15j5ReSdGSgxmfl07V1HU=;
 b=jlbTOFiKP+BXP0CIuNpgLuy7gXneEZ0l/zdEbLbaGi7E76sns1H4m7c/scSM8HxOoy
 2Y3ZDb603A64mXRbudfJF5sm00Dpxj1QSUIkEsCnI7vCOxTP3TXv3Y8/f+GNbLNaXc4o
 w4LGwWl4ThlhJvCsS6C4Dg3XNFW6rcj9Muj/c1rIDqcDAYa/W8lODoZQpKfGgtm8Wd34
 Fv4PRHvzWEZmcGidlXi9UEmFeMB+/7xCurrmZyBHkgGocEtaCdQ+H7+v8fSFOavr8pjn
 lzF9lCLfUEWyDeWV8Pl4oF6OL7y5KqU/6t5F5g2q5lcKpj6jLIs8QIwY9Gn23mP4lP/t
 jGvA==
X-Gm-Message-State: AGi0PubjJtvrrliFAS13S4o+Tat3M/ArA06U2pghBJzNKiFfsB92wRB/
 xuN8JLgxrjXWNX9YqIgpEHg=
X-Google-Smtp-Source: APiQypJFWLFRiyYOL2cRL4enM0H/nPyBu3Ub3fxpvy0/oOkwwn4RxutJej7KAbecRko81oa6E3g49w==
X-Received: by 2002:a5d:65ce:: with SMTP id e14mr2392578wrw.314.1588588874527; 
 Mon, 04 May 2020 03:41:14 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id s12sm12250022wmc.7.2020.05.04.03.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 03:41:13 -0700 (PDT)
Date: Mon, 4 May 2020 11:41:11 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 2/4] device-core: use RCU for list of childs of a bus
Message-ID: <20200504104111.GB354891@stefanha-x1.localdomain>
References: <20200416203624.32366-1-mlevitsk@redhat.com>
 <20200416203624.32366-3-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
In-Reply-To: <20200416203624.32366-3-mlevitsk@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2020 at 11:36:22PM +0300, Maxim Levitsky wrote:
> @@ -90,9 +92,13 @@ static void bus_reset_child_foreach(Object *obj, Reset=
tableChildCallback cb,
>      BusState *bus =3D BUS(obj);
>      BusChild *kid;
> =20
> -    QTAILQ_FOREACH(kid, &bus->children, sibling) {
> +    rcu_read_lock();
> +
> +    QTAILQ_FOREACH_RCU(kid, &bus->children, sibling) {
>          cb(OBJECT(kid->child), opaque, type);
>      }
> +
> +    rcu_read_unlock();
>  }
> =20
>  static void qbus_realize(BusState *bus, DeviceState *parent, const char =
*name)
> @@ -138,10 +144,15 @@ static void bus_unparent(Object *obj)
>      /* Only the main system bus has no parent, and that bus is never fre=
ed */
>      assert(bus->parent);
> =20
> -    while ((kid =3D QTAILQ_FIRST(&bus->children)) !=3D NULL) {
> +    rcu_read_lock();
> +
> +    while ((kid =3D QTAILQ_FIRST_RCU(&bus->children)) !=3D NULL) {
>          DeviceState *dev =3D kid->child;
>          object_unparent(OBJECT(dev));
>      }
> +
> +    rcu_read_unlock();

rcu_read_lock() is called but this looks like a list write operation.
If I understand correctly bus->children list writes can only be called
with the QEMU global mutex and therefore rcu_read_lock() is not required
here?

> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 85f062def7..f0c87e582e 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -50,26 +50,37 @@ const VMStateDescription *qdev_get_vmsd(DeviceState *=
dev)
>      return dc->vmsd;
>  }
> =20
> +static void bus_free_bus_child(BusChild *kid)
> +{
> +    object_unref(OBJECT(kid->child));

Users like scsi_device_find() do not take a refcount on the child.  If
the device is removed then bus_free_bus_child may call object_unref()
while another thread is still accessing the child.

Maybe I'm missing something that prevents this scenario?

If not, then another patch is necessary first that introduces stricter
refcount discipline across the codebase. This applies both to users who
directly access bus->children as well as to those who call walk() and
stash child pointers in their callback function.

> +    g_free(kid);
> +}
> +
>  static void bus_remove_child(BusState *bus, DeviceState *child)
>  {
>      BusChild *kid;
> =20
> -    QTAILQ_FOREACH(kid, &bus->children, sibling) {
> +    rcu_read_lock();

List write under rcu_read_lock().

> @@ -82,7 +93,9 @@ static void bus_add_child(BusState *bus, DeviceState *c=
hild)
>      kid->child =3D child;
>      object_ref(OBJECT(kid->child));
> =20
> -    QTAILQ_INSERT_HEAD(&bus->children, kid, sibling);
> +    rcu_read_lock();
> +    QTAILQ_INSERT_HEAD_RCU(&bus->children, kid, sibling);
> +    rcu_read_unlock();

List write under rcu_read_lock().

> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 472bbd233b..b0f4a35f81 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -367,12 +367,16 @@ static int virtio_scsi_do_tmf(VirtIOSCSI *s, VirtIO=
SCSIReq *req)
>      case VIRTIO_SCSI_T_TMF_I_T_NEXUS_RESET:
>          target =3D req->req.tmf.lun[1];
>          s->resetting++;
> -        QTAILQ_FOREACH(kid, &s->bus.qbus.children, sibling) {
> +
> +        rcu_read_lock();
> +        QTAILQ_FOREACH_RCU(kid, &s->bus.qbus.children, sibling) {

We need a QTAILQ_FOREACH_WITH_RCU_READ_LOCK() macro that combines
WITH_RCU_READ_LOCK() and QTAILQ_FOREACH_RCU(). :-)

> diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bu=
s.h
> index 38c9399cd4..58733f28e2 100644
> --- a/include/hw/virtio/virtio-bus.h
> +++ b/include/hw/virtio/virtio-bus.h
> @@ -128,8 +128,11 @@ void virtio_bus_set_vdev_config(VirtioBusState *bus,=
 uint8_t *config);
>  static inline VirtIODevice *virtio_bus_get_device(VirtioBusState *bus)
>  {
>      BusState *qbus =3D &bus->parent_obj;
> -    BusChild *kid =3D QTAILQ_FIRST(&qbus->children);
> -    DeviceState *qdev =3D kid ? kid->child : NULL;
> +    BusChild *kid;
> +    DeviceState *qdev;
> +
> +    kid =3D QTAILQ_FIRST(&qbus->children);

QTAILQ_FIRST_RCU()

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6v8UcACgkQnKSrs4Gr
c8jAZAgAhINpLkvsHYvbt4UylQC19LpFX936/CALQ4CcOMzPxEaKn3Om0Wa10hAG
jxeFyQBlhCmrjmXPngRJVVeIPn5vwsn4jwS0zoCV60olvZWmKuWU9XyJmZJ4H/tc
HNHluZBqIf3zUYVip8n2PvYJYc+ecoaszIvVXE5VN0EuyPjYveLWqHYcG41H9AV9
jzTf7muebFHVfqm2CERhwih2J/jM2ngfVg2tOhKlhGCrE7o/e5ut69yg39e5+qf7
sZW3vRxoDaz6lh8MJ3emAzlN6Lne5nIOgsTtB6SpOdr2Jn+9Y07GjYpT/20W2/RJ
ZBYfC8dY+C8LZYb7sA1aC7aOtjuzhA==
=2pVu
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--

