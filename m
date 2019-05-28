Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82563C04AB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 00:38:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 372D12081C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 00:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="C5nfEG9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 372D12081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54961 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVQ8a-00071D-Bz
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 20:38:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVQ7o-0006iV-1o
	for qemu-devel@nongnu.org; Mon, 27 May 2019 20:37:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVQ7l-0008FS-Om
	for qemu-devel@nongnu.org; Mon, 27 May 2019 20:37:55 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:49815 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1hVQ7j-0007oA-Aq
	for qemu-devel@nongnu.org; Mon, 27 May 2019 20:37:52 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45CZgG2CsBz9s7h; Tue, 28 May 2019 10:37:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559003850;
	bh=2yhfRzmGOYXURDXJhI05sDwvoLdEOZZWxHqvyUN9Z8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C5nfEG9UsqGMkKrDhCm6rtL94SVEFaf2zK+v5R15130PGh0mMKlIgkzZmgswQ3yqG
	0pmkWjs+zVV1Rk8q6Ou/yp+C7eCL1mYXtO2YChzBluum3utlNy23wgNHTULpa12mEP
	MPspK5BkxhZZbIFMYOv1tmtBtwd5m0/rUdUW8ijQ=
Date: Tue, 28 May 2019 10:08:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190528000854.GA11618@umbus.fritz.box>
References: <20190520231008.20140-1-mst@redhat.com>
	<20190320112646.3712-2-xieyongji@baidu.com>
	<20190524121909.277ae31e@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <20190524121909.277ae31e@bahia.lan>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PULL v2 04/36] virtio: Introduce started flag to
 VirtioDevice
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Xie Yongji <xieyongji@baidu.com>,
	Zhang Yu <zhangyu31@baidu.com>, qemu-devel@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2019 at 12:19:09PM +0200, Greg Kurz wrote:
> On Mon, 20 May 2019 19:10:35 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>=20
> > From: Xie Yongji <xieyongji@baidu.com>
> >=20
> > The virtio 1.0 transitional devices support driver uses the device
> > before setting the DRIVER_OK status bit. So we introduce a started
> > flag to indicate whether driver has started the device or not.
> >=20
> > Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> > Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> > Message-Id: <20190320112646.3712-2-xieyongji@baidu.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  include/hw/virtio/virtio.h |  2 ++
> >  hw/virtio/virtio.c         | 52 ++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 52 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > index 7140381e3a..27c0efc3d0 100644
> > --- a/include/hw/virtio/virtio.h
> > +++ b/include/hw/virtio/virtio.h
> > @@ -105,6 +105,8 @@ struct VirtIODevice
> >      uint16_t device_id;
> >      bool vm_running;
> >      bool broken; /* device in invalid state, needs reset */
> > +    bool started;
> > +    bool start_on_kick; /* virtio 1.0 transitional devices support tha=
t */
> >      VMChangeStateEntry *vmstate;
> >      char *bus_name;
> >      uint8_t device_endian;
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 28056a7ef7..5d533ac74e 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -1162,10 +1162,16 @@ int virtio_set_status(VirtIODevice *vdev, uint8=
_t val)
> >              }
> >          }
> >      }
> > +    vdev->started =3D val & VIRTIO_CONFIG_S_DRIVER_OK;
> > +    if (unlikely(vdev->start_on_kick && vdev->started)) {
> > +        vdev->start_on_kick =3D false;
> > +    }
> > +
> >      if (k->set_status) {
> >          k->set_status(vdev, val);
> >      }
> >      vdev->status =3D val;
> > +
> >      return 0;
> >  }
> > =20
> > @@ -1208,6 +1214,9 @@ void virtio_reset(void *opaque)
> >          k->reset(vdev);
> >      }
> > =20
> > +    vdev->start_on_kick =3D (virtio_host_has_feature(vdev, VIRTIO_F_VE=
RSION_1) &&
> > +                          !virtio_vdev_has_feature(vdev, VIRTIO_F_VERS=
ION_1));
> > +    vdev->started =3D false;
> >      vdev->broken =3D false;
> >      vdev->guest_features =3D 0;
> >      vdev->queue_sel =3D 0;
> > @@ -1518,14 +1527,21 @@ void virtio_queue_set_align(VirtIODevice *vdev,=
 int n, int align)
> > =20
> >  static bool virtio_queue_notify_aio_vq(VirtQueue *vq)
> >  {
> > +    bool ret =3D false;
> > +
> >      if (vq->vring.desc && vq->handle_aio_output) {
> >          VirtIODevice *vdev =3D vq->vdev;
> > =20
> >          trace_virtio_queue_notify(vdev, vq - vdev->vq, vq);
> > -        return vq->handle_aio_output(vdev, vq);
> > +        ret =3D vq->handle_aio_output(vdev, vq);
> > +
> > +        if (unlikely(vdev->start_on_kick)) {
> > +            vdev->started =3D true;
> > +            vdev->start_on_kick =3D false;
> > +        }
> >      }
> > =20
> > -    return false;
> > +    return ret;
> >  }
> > =20
> >  static void virtio_queue_notify_vq(VirtQueue *vq)
> > @@ -1539,6 +1555,11 @@ static void virtio_queue_notify_vq(VirtQueue *vq)
> > =20
> >          trace_virtio_queue_notify(vdev, vq - vdev->vq, vq);
> >          vq->handle_output(vdev, vq);
> > +
> > +        if (unlikely(vdev->start_on_kick)) {
> > +            vdev->started =3D true;
> > +            vdev->start_on_kick =3D false;
> > +        }
> >      }
> >  }
> > =20
> > @@ -1556,6 +1577,11 @@ void virtio_queue_notify(VirtIODevice *vdev, int=
 n)
> >      } else if (vq->handle_output) {
> >          vq->handle_output(vdev, vq);
> >      }
> > +
> > +    if (unlikely(vdev->start_on_kick)) {
> > +        vdev->started =3D true;
> > +        vdev->start_on_kick =3D false;
> > +    }
> >  }
> > =20
> >  uint16_t virtio_queue_vector(VirtIODevice *vdev, int n)
> > @@ -1770,6 +1796,13 @@ static bool virtio_broken_needed(void *opaque)
> >      return vdev->broken;
> >  }
> > =20
> > +static bool virtio_started_needed(void *opaque)
> > +{
> > +    VirtIODevice *vdev =3D opaque;
> > +
> > +    return vdev->started;
>=20
> Existing machine types don't know about the "virtio/started" subsection. =
This
> breaks migration to older QEMUs if the driver has started the device, ie.=
 most
> probably always when it comes to live migration.
>=20
> My understanding is that we do try to support backward migration though. =
It
> is a regular practice in datacenters to migrate workloads without having =
to
> take care of the QEMU version. FWIW I had to fix similar issues downstream
> many times in the past because customers had filed bugs.
>=20
> Cc'ing David for his opinion.

Uh.. did you mean to CC me, or Dave Gilbert?

I mean, I think you're right that we should try to maintain backwards
migration, but this isn't really my area of authority.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzsfBMACgkQbDjKyiDZ
s5Lp/Q//egv7JLkpqA8+Rx+FjMPiyyDEp92IRje/i3eD3ucVVYbSM6+nvFGIDp8L
0J1Dz41QV8x4tQa4epWikR8gm5Gy6xD5ihahuHjIFaKPX9E/TxfcbvIARJlv4A8q
hhPoEySvI17EzAIoHLqHlMF3VwF8CeRngAh2+lcnKQ8ow9MrITEI2T4dYZty5YQk
9PsPu2P0u/l/2JGP0Uaf82LaaL9i05w9D4SLSLYw3p5+5uwM9NZWTaQr+Q7gHdjS
CTqDeDOuszMwFeEOGuD/O5THbOdPdwVIxkRGshOKYP/z1aq5qZHxtbvxD5UVXhRg
l5d7ZF/5JmOrE6kkCg/W4p+9yiNDlDj2tImJ9cRL9My7ez2Q8B8OrHJFiNbOivTo
xB+AVQaEJ9JPk6P0UEo7+w0yuIA+OrZH9JoLdT26eVPxcHo8VOkeiO92P26bSUzw
jUSc1xcdLou9QYmO72WtyI1zv2EtHDufH3fTPPfhQUMrfj0owBJwfS6PyVXfrNdD
lMqL4AwfP7a6pMl83U+mYezXSnFlgG5Ih4PZe7omrINytglaHnIQ/DvKvzY75xMq
ckoojEYuj1LcOhQGSjt7yKMKxgEb8upUaCnj9Q3eyseGlKmur+B/YjFFdj/nZaRd
Hr+lXLhJQvMyAacC8ZkkMRmzVRoK2unMOuQXzFomkLXSBp6E67Q=
=NKVN
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--

