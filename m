Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72C9C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 06:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EC6A2070D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 06:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC6A2070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58146 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVVmp-0002co-9N
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 02:40:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hVVlb-0001wU-M1
	for qemu-devel@nongnu.org; Tue, 28 May 2019 02:39:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hVVla-0000Nz-D8
	for qemu-devel@nongnu.org; Tue, 28 May 2019 02:39:23 -0400
Received: from 5.mo5.mail-out.ovh.net ([87.98.173.103]:35228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hVVla-0000JQ-5v
	for qemu-devel@nongnu.org; Tue, 28 May 2019 02:39:22 -0400
Received: from player759.ha.ovh.net (unknown [10.108.42.215])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 0827623A9F6
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 08:39:18 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player759.ha.ovh.net (Postfix) with ESMTPSA id 30D106432C2F;
	Tue, 28 May 2019 06:39:10 +0000 (UTC)
Date: Tue, 28 May 2019 08:39:09 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190528083909.65ba8be4@bahia.lan>
In-Reply-To: <20190528000854.GA11618@umbus.fritz.box>
References: <20190520231008.20140-1-mst@redhat.com>
	<20190320112646.3712-2-xieyongji@baidu.com>
	<20190524121909.277ae31e@bahia.lan>
	<20190528000854.GA11618@umbus.fritz.box>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/fjJc22yaohZP.VbC0INouSQ";
	protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 15534322489956342246
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddruddvgedguddufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.173.103
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhang Yu <zhangyu31@baidu.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Xie Yongji <xieyongji@baidu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/fjJc22yaohZP.VbC0INouSQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 28 May 2019 10:08:54 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, May 24, 2019 at 12:19:09PM +0200, Greg Kurz wrote:
> > On Mon, 20 May 2019 19:10:35 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >  =20
> > > From: Xie Yongji <xieyongji@baidu.com>
> > >=20
> > > The virtio 1.0 transitional devices support driver uses the device
> > > before setting the DRIVER_OK status bit. So we introduce a started
> > > flag to indicate whether driver has started the device or not.
> > >=20
> > > Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> > > Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> > > Message-Id: <20190320112646.3712-2-xieyongji@baidu.com>
> > > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >  include/hw/virtio/virtio.h |  2 ++
> > >  hw/virtio/virtio.c         | 52 ++++++++++++++++++++++++++++++++++++=
--
> > >  2 files changed, 52 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > > index 7140381e3a..27c0efc3d0 100644
> > > --- a/include/hw/virtio/virtio.h
> > > +++ b/include/hw/virtio/virtio.h
> > > @@ -105,6 +105,8 @@ struct VirtIODevice
> > >      uint16_t device_id;
> > >      bool vm_running;
> > >      bool broken; /* device in invalid state, needs reset */
> > > +    bool started;
> > > +    bool start_on_kick; /* virtio 1.0 transitional devices support t=
hat */
> > >      VMChangeStateEntry *vmstate;
> > >      char *bus_name;
> > >      uint8_t device_endian;
> > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > index 28056a7ef7..5d533ac74e 100644
> > > --- a/hw/virtio/virtio.c
> > > +++ b/hw/virtio/virtio.c
> > > @@ -1162,10 +1162,16 @@ int virtio_set_status(VirtIODevice *vdev, uin=
t8_t val)
> > >              }
> > >          }
> > >      }
> > > +    vdev->started =3D val & VIRTIO_CONFIG_S_DRIVER_OK;
> > > +    if (unlikely(vdev->start_on_kick && vdev->started)) {
> > > +        vdev->start_on_kick =3D false;
> > > +    }
> > > +
> > >      if (k->set_status) {
> > >          k->set_status(vdev, val);
> > >      }
> > >      vdev->status =3D val;
> > > +
> > >      return 0;
> > >  }
> > > =20
> > > @@ -1208,6 +1214,9 @@ void virtio_reset(void *opaque)
> > >          k->reset(vdev);
> > >      }
> > > =20
> > > +    vdev->start_on_kick =3D (virtio_host_has_feature(vdev, VIRTIO_F_=
VERSION_1) &&
> > > +                          !virtio_vdev_has_feature(vdev, VIRTIO_F_VE=
RSION_1));
> > > +    vdev->started =3D false;
> > >      vdev->broken =3D false;
> > >      vdev->guest_features =3D 0;
> > >      vdev->queue_sel =3D 0;
> > > @@ -1518,14 +1527,21 @@ void virtio_queue_set_align(VirtIODevice *vde=
v, int n, int align)
> > > =20
> > >  static bool virtio_queue_notify_aio_vq(VirtQueue *vq)
> > >  {
> > > +    bool ret =3D false;
> > > +
> > >      if (vq->vring.desc && vq->handle_aio_output) {
> > >          VirtIODevice *vdev =3D vq->vdev;
> > > =20
> > >          trace_virtio_queue_notify(vdev, vq - vdev->vq, vq);
> > > -        return vq->handle_aio_output(vdev, vq);
> > > +        ret =3D vq->handle_aio_output(vdev, vq);
> > > +
> > > +        if (unlikely(vdev->start_on_kick)) {
> > > +            vdev->started =3D true;
> > > +            vdev->start_on_kick =3D false;
> > > +        }
> > >      }
> > > =20
> > > -    return false;
> > > +    return ret;
> > >  }
> > > =20
> > >  static void virtio_queue_notify_vq(VirtQueue *vq)
> > > @@ -1539,6 +1555,11 @@ static void virtio_queue_notify_vq(VirtQueue *=
vq)
> > > =20
> > >          trace_virtio_queue_notify(vdev, vq - vdev->vq, vq);
> > >          vq->handle_output(vdev, vq);
> > > +
> > > +        if (unlikely(vdev->start_on_kick)) {
> > > +            vdev->started =3D true;
> > > +            vdev->start_on_kick =3D false;
> > > +        }
> > >      }
> > >  }
> > > =20
> > > @@ -1556,6 +1577,11 @@ void virtio_queue_notify(VirtIODevice *vdev, i=
nt n)
> > >      } else if (vq->handle_output) {
> > >          vq->handle_output(vdev, vq);
> > >      }
> > > +
> > > +    if (unlikely(vdev->start_on_kick)) {
> > > +        vdev->started =3D true;
> > > +        vdev->start_on_kick =3D false;
> > > +    }
> > >  }
> > > =20
> > >  uint16_t virtio_queue_vector(VirtIODevice *vdev, int n)
> > > @@ -1770,6 +1796,13 @@ static bool virtio_broken_needed(void *opaque)
> > >      return vdev->broken;
> > >  }
> > > =20
> > > +static bool virtio_started_needed(void *opaque)
> > > +{
> > > +    VirtIODevice *vdev =3D opaque;
> > > +
> > > +    return vdev->started; =20
> >=20
> > Existing machine types don't know about the "virtio/started" subsection=
. This
> > breaks migration to older QEMUs if the driver has started the device, i=
e. most
> > probably always when it comes to live migration.
> >=20
> > My understanding is that we do try to support backward migration though=
. It
> > is a regular practice in datacenters to migrate workloads without havin=
g to
> > take care of the QEMU version. FWIW I had to fix similar issues downstr=
eam
> > many times in the past because customers had filed bugs.
> >=20
> > Cc'ing David for his opinion. =20
>=20
> Uh.. did you mean to CC me, or Dave Gilbert?
>=20

Oops... Dave Gilbert indeed, but you're thoughts on that matter are valuable
as well. I remember being involved in backward migration fixes for spapr
several times.

> I mean, I think you're right that we should try to maintain backwards
> migration, but this isn't really my area of authority.
>=20

Cc'ing Dave Gilbert :)

Cheers,

--
Greg

--Sig_/fjJc22yaohZP.VbC0INouSQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlzs140ACgkQcdTV5YIv
c9b3PxAAhYZx8UCH9d0j1ScnlqsgE621yapQToWNW9xQ8S5FICLF4NvAoZ+jiAZk
oXB4Ee1I5I8mepqV4orrqkucqvWxbK3qiObaT3WDlGlgi2dgtHQA5u7SZei6BOwb
DfyY6295J3T/JGGpTNvjdYOMcdWa8s/Su89i1ELVXqZ8WN+3VJkFXf7qHv6H3/AG
hI4+fdZUtoh44nsdaEAGEck4YG9kms7ORlAT2tCipe22rPvjPvhi9+WbtOV0jI67
ehvArGKnlwdVd5xEYGdqt2MPKvSlEE9ayDxBB6Ff4DuwPPym4iIT3VtiBWt8NOUY
n1kYxZyGB5c062QEeNOU56TQnlV+vG4cfu62YiByBuTxdNlat9AtgpiP6D+YaM82
ONrCef093NPn/fxfFCF8lBoSbwQzVLMLAtpOk9+Z7l+CmqbBBlzDi8UnCkxhUAKi
MXE1UqtgKl7z1ydOvF3HaMgA8IIZFBJfAeMo3U2ASnU2jfsn14mlOjY/XJHulwcw
oCn6XYGUp7KuoG1QD/1oDk32t4waJMsXGeOIrfDxKaIjAnauS2j5Dw+2nomIa0Zf
IyfBIz8048kyrs4dEQoGyCcvjlXRXB7WeWLbwZqZwepPNEZmR7JYFwZuTRtkHRRm
tA255o3QkK2mk053rCnuvq3Df4t+Op/VK4Q994vahBR8zvd0Zks=
=FCfv
-----END PGP SIGNATURE-----

--Sig_/fjJc22yaohZP.VbC0INouSQ--

