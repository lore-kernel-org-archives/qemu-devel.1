Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47E0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:28:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A84A20772
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGiXd983"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A84A20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIXr-000630-Qj
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jtI06-0005KQ-IZ
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:53:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34629
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jtI04-0005KS-RY
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594245187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zTzr5iD2CS9STbPsb2S2gZXB7VKOk3wVYAvVkMESVIc=;
 b=AGiXd983W2hD4JGyhQmMZAfE5rGefINfQfObFcFKrbOAcgZ1HojD4PJ74WFF6xdmnSTmFf
 PoLJXn5WD7EkxjsyIPudvJooFsS3wF1E3f33agTZ6nbGR3+x4O2UvIXhFSHH83BG6C+huB
 +a10Gp2O79ec4E+Qr1GYMHJgPN0iDpY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-s8dxpJkBMYiCm1AidWXiFg-1; Wed, 08 Jul 2020 12:50:37 -0400
X-MC-Unique: s8dxpJkBMYiCm1AidWXiFg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DE101082;
 Wed,  8 Jul 2020 16:50:35 +0000 (UTC)
Received: from gondolin (ovpn-112-239.ams2.redhat.com [10.36.112.239])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB38260E1C;
 Wed,  8 Jul 2020 16:50:26 +0000 (UTC)
Date: Wed, 8 Jul 2020 18:50:12 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v5 3/5] virtio-scsi: default num_queues to -smp N
Message-ID: <20200708185012.470125bb.cohuck@redhat.com>
In-Reply-To: <20200708130526.GD487183@stefanha-x1.localdomain>
References: <20200706135650.438362-1-stefanha@redhat.com>
 <20200706135650.438362-4-stefanha@redhat.com>
 <20200707174453.50c3ec85.cohuck@redhat.com>
 <20200708130526.GD487183@stefanha-x1.localdomain>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/Dl+_goxTFu6j_rkQ.+Ak8zL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, qemu-devel@nongnu.org,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/Dl+_goxTFu6j_rkQ.+Ak8zL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Jul 2020 14:05:26 +0100
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> On Tue, Jul 07, 2020 at 05:44:53PM +0200, Cornelia Huck wrote:
> > On Mon,  6 Jul 2020 14:56:48 +0100
> > Stefan Hajnoczi <stefanha@redhat.com> wrote:

> > > diff --git a/hw/virtio/virtio-scsi-pci.c b/hw/virtio/virtio-scsi-pci.=
c
> > > index 3ff9eb7ef6..fa4b3bfb50 100644
> > > --- a/hw/virtio/virtio-scsi-pci.c
> > > +++ b/hw/virtio/virtio-scsi-pci.c
> > > @@ -46,13 +46,17 @@ static void virtio_scsi_pci_realize(VirtIOPCIProx=
y *vpci_dev, Error **errp)
> > >  {
> > >      VirtIOSCSIPCI *dev =3D VIRTIO_SCSI_PCI(vpci_dev);
> > >      DeviceState *vdev =3D DEVICE(&dev->vdev);
> > > -    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(vdev);
> > >      DeviceState *proxy =3D DEVICE(vpci_dev);
> > > +    VirtIOSCSIConf *conf =3D &dev->vdev.parent_obj.conf;
> > >      char *bus_name;
> > > =20
> > > +    if (conf->num_queues =3D=3D VIRTIO_SCSI_AUTO_NUM_QUEUES) {
> > > +        conf->num_queues =3D
> > > +            virtio_pci_optimal_num_queues(VIRTIO_SCSI_VQ_NUM_FIXED);
> > > +    }
> > > +
> > >      if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
> > > -        vpci_dev->nvectors =3D vs->conf.num_queues +
> > > -                             VIRTIO_SCSI_VQ_NUM_FIXED + 1;
> > > +        vpci_dev->nvectors =3D conf->num_queues + VIRTIO_SCSI_VQ_NUM=
_FIXED + 1;
> > >      }
> > > =20
> > >      /* =20
> >=20
> > One corner case where the setup may end up being a bit odd is a
> > situation where nvectors was specified, but num_queues was not, and the
> > device suddenly ends up with more queues than vectors. But I don't see
> > a reason why you would want to specify nvectors but not num_queues in a
> > real word scenario, so I think we can ignore that corner case. =20
>=20
> I agree, I've ignored that case. Other options include printing a
> warning or even an error when num_queues disagrees with nvectors.

I think an error would be too harsh, but a warning sounds useful.

--Sig_/Dl+_goxTFu6j_rkQ.+Ak8zL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl8F+UQACgkQ3s9rk8bw
L6+V3RAAnYFSyFWK8HM50TTRM8dSI1hjqm7VFu78RJyDX8+cSUku9+/oySGgwlP+
SmERgZKJuh3JqgXMjBMNNB0uRl2kMTMFJr7JmP+RQfNOQgiHPkKjKU7ivAkE9ivv
kj1uJbZ3jOjSD2GIVBxGdTl+Kg75B7Zzidhr7uax5H9fSkUQgGuuHng46PqKYPyN
5QpdI+YI3XGr4KGk59yY+CJwlWOcgzd9sh6D2BGjmzQTncVgBSRCS4PGFRki+oMT
f/9zzZLDZCBNG7VETThC7aXrezTXsFH13wfz2OUlZ/LVLy5RP6EE7vCLfmoSQHPv
49WzxKY7ee2GlaGh520Cm7fU3AHDDnuTyQA2ac2cDLjDvvYhPbLfOYw0FB4++1lT
gW8GISvKeErB5pr8v9c9Ae7MfOC/z2leOywhrKZcwyGfYV9zTiL4XjAU+0WvrNBW
Y9dlS5r05dELLQR3ZOtbm/02Tc3gICnYyJofNNUNOpf2r6Blosrrz80WqlrOWHoe
UF0ok4lRZ2ZY6abSFuz3AWm/QVOIdT54/rj9DWKeWPJFuNytODDIG7J24NYwcO+7
sBPmzjJgfWkuMV5THvgeCv+kteHJj9ClXfNj5U6zD0ZDb4+tIEk6dv/jjCpaSLS6
GV9obfJ/iokGPkk9G1nouvw+uBt3oi8iBmWDoii5d5t+wDCPHm0=
=/oAN
-----END PGP SIGNATURE-----

--Sig_/Dl+_goxTFu6j_rkQ.+Ak8zL--


