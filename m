Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D66AC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:23:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2940120748
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="glboqRkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2940120748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is63K-0002Lc-3T
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 09:23:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50383)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1is5xL-0002a5-9w
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:17:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1is5xG-0008EA-9l
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:17:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60657
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1is5xG-0008DP-4z
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:17:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579184221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iqnMHwRuY4RC6PtS4IJXcZfRQCZidUznt1pwiS4r0TE=;
 b=glboqRkMhfaafxUMdcmF2k+dULeGC9pPnVTemBlu3sPzkO+IXzWvjc4OgUuGCh1FwUKzuS
 ITCMpw75P1EOKHeX4RloMgPBvrKGC4NtfefFdeuvdZlvGhuZBKKUQMaJ8HFkmdjMRJHg0M
 u2ZQ6aMJTvK3PSPNo3QY64gNmGekIzA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-hFteMBXoNiaEC1DO5lbIaw-1; Thu, 16 Jan 2020 09:16:59 -0500
X-MC-Unique: hFteMBXoNiaEC1DO5lbIaw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FDE519057A9;
 Thu, 16 Jan 2020 14:16:58 +0000 (UTC)
Received: from localhost (ovpn-117-207.ams2.redhat.com [10.36.117.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 54F9C5C28D;
 Thu, 16 Jan 2020 14:16:54 +0000 (UTC)
Date: Thu, 16 Jan 2020 14:16:54 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 3/5] virtio-scsi: default num_queues to -smp N
Message-ID: <20200116141654.GK163546@stefanha-x1.localdomain>
References: <20200116105842.271179-1-stefanha@redhat.com>
 <20200116105842.271179-4-stefanha@redhat.com>
 <20200116125349.6a3aeaa9.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200116125349.6a3aeaa9.cohuck@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ee6FjwWxuMujAVRe"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ee6FjwWxuMujAVRe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2020 at 12:53:49PM +0100, Cornelia Huck wrote:
> On Thu, 16 Jan 2020 10:58:40 +0000
> Stefan Hajnoczi <stefanha@redhat.com> wrote:
>=20
> > Automatically size the number of request virtqueues to match the number
> > of vCPUs.  This ensures that completion interrupts are handled on the
> > same vCPU that submitted the request.  No IPI is necessary to complete
> > an I/O request and performance is improved.
> >=20
> > Remember that virtqueue numbering assumptions are being removed from th=
e
> > virtio-pci proxy object, so the Control and Event virtqueues are counte=
d
> > by ->get_num_virtqueues() and we only add 1 for the Configuration Chang=
e
> > interrupt:
> >=20
> >      if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
> > -        vpci_dev->nvectors =3D vs->conf.num_queues + 3;
> > +        vpci_dev->nvectors =3D vdc->get_num_virtqueues(VIRTIO_DEVICE(v=
dev)) + 1;
> >      }
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  hw/core/machine.c               |  3 +++
> >  hw/scsi/vhost-scsi.c            |  2 ++
> >  hw/scsi/vhost-user-scsi.c       |  2 ++
> >  hw/scsi/virtio-scsi.c           | 18 ++++++++++++++++++
> >  hw/virtio/vhost-scsi-pci.c      |  4 ++--
> >  hw/virtio/vhost-user-scsi-pci.c |  4 ++--
> >  hw/virtio/virtio-scsi-pci.c     |  4 ++--
> >  include/hw/virtio/virtio-scsi.h |  1 +
> >  8 files changed, 32 insertions(+), 6 deletions(-)
> >=20
>=20
> > @@ -878,6 +879,18 @@ static struct SCSIBusInfo virtio_scsi_scsi_info =
=3D {
> >      .load_request =3D virtio_scsi_load_request,
> >  };
> > =20
> > +static uint32_t virtio_scsi_get_num_virtqueues(VirtIODevice *vdev)
> > +{
> > +    VirtIOSCSICommon *s =3D VIRTIO_SCSI_COMMON(vdev);
> > +    uint32_t request_queues =3D s->conf.num_queues;
> > +
> > +    if (s->conf.num_queues =3D=3D 1 && s->conf.auto_num_queues) {
> > +        request_queues =3D current_machine->smp.cpus;
> > +    }
> > +
> > +    return VIRTIO_SCSI_VQ_NUM_FIXED + request_queues;
>=20
> I'm not sure doing this at the device level is the right thing to do.
> For now, only virtio-pci will call this function, and there basing the
> number of virtqueues off the number of cpus makes sense; but that's a
> property of the transport, not of the device.
>=20
> Consider e.g. a virtio-scsi-ccw device: If we wanted to introduce a way
> to automatically pick a good number of virtqueues there, this functions
> likely would not return a particularly useful value, as queue interrupt
> processing does not really relate to the number of cpus with adapter
> interrupts. It's not a problem right now, as only virtio-pci calls
> this, but someone looking at this callback is likely getting the
> impression that this is a generically useful function.

That's a great point.  Maybe the direction should be reversed so that
the device asks the transport to suggest the optimal number of queues
when auto-num-queues is enabled.

Stefan

--ee6FjwWxuMujAVRe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4gcFYACgkQnKSrs4Gr
c8huOwf+N1HE5t25dobgSpZ6ecmge36+v0qU0W6iYHYnE74P2xYM/jgoHDh+AKwG
idqWy9+El+zJDRsh8XGF4z/okz+ZXvFwjFqh/njmtFu8zrt0bq+aZS2U0kB8b7RS
5RDIX0jWo/o4BN5DDEONBONSCHcys86X1Q/DAcfZj7mKSoxtsv0WJNK4GwttCXhN
nHFWK02BY+Z2hA9oHDK4BMms8yEIn/EbIMwG48s3S2tBZiM56yyxepYW1bgHcMrw
93sfN7wcNcoqdI6os5s/zy2N686TU32u6UUN+87x9sZ9OxIktA1wDuxqhDR1UwfR
0sAnh+HqvjQTbRf5OgYXwMSeEI3t8g==
=5snB
-----END PGP SIGNATURE-----

--ee6FjwWxuMujAVRe--


