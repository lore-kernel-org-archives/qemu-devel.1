Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84682C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9B862072E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jCNXVCUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B862072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNBXS-0006zJ-Pd
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 05:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNBSf-0002uL-6a
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 04:58:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33656)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNBSd-0000SY-7S
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 04:58:12 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601369889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X1CLgCMpJtmtDEnrZWZMqzB74gW57+sxbgacUqJD2Aw=;
 b=jCNXVCUfOQ29oGpghpfSTlJHbF9mYcGYKzMoi6mzpcJmjM0ohNdXRZ+b5Q0NPV41yL+w3l
 9Kpl7/TZrLpbJi2uGP8DAZ0Z6A+6O4oL5Ui3BJtE3OSgpWTyjn668pzHixBwMrSNDePSFj
 79dv3Qp4mH5vdYJbiRt9uhbz761Mcw4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-LswdeQFaNbqIOhvSt4fmHQ-1; Tue, 29 Sep 2020 04:58:06 -0400
X-MC-Unique: LswdeQFaNbqIOhvSt4fmHQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B85418A2249;
 Tue, 29 Sep 2020 08:58:04 +0000 (UTC)
Received: from localhost (ovpn-115-4.ams2.redhat.com [10.36.115.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 08F5E81C54;
 Tue, 29 Sep 2020 08:57:51 +0000 (UTC)
Date: Tue, 29 Sep 2020 09:57:51 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: Outline for VHOST_USER_PROTOCOL_F_VDPA
Message-ID: <20200929085751.GA181609@stefanha-x1.localdomain>
References: <20200928092537.GA44353@stefanha-x1.localdomain>
 <20200929020114-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200929020114-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: lulu@redhat.com, tiwei.bie@intel.com, jasowang@redhat.com,
 qemu-devel@nongnu.org, raphael.norwitz@nutanix.com, maxime.coquelin@redhat.com,
 kraxel@redhat.com, Felipe Franciosi <felipe@nutanix.com>,
 marcandre.lureau@redhat.com, Nikos Dragazis <ndragazis@arrikto.com>,
 changpeng.liu@intel.com, Daniele Buono <dbuono@us.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2020 at 02:09:55AM -0400, Michael S. Tsirkin wrote:
> On Mon, Sep 28, 2020 at 10:25:37AM +0100, Stefan Hajnoczi wrote:
> > Why extend vhost-user with vDPA?
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Reusing VIRTIO emulation code for vhost-user backends
> > -----------------------------------------------------
> > It is a common misconception that a vhost device is a VIRTIO device.
> > VIRTIO devices are defined in the VIRTIO specification and consist of a
> > configuration space, virtqueues, and a device lifecycle that includes
> > feature negotiation. A vhost device is a subset of the corresponding
> > VIRTIO device. The exact subset depends on the device type, and some
> > vhost devices are closer to the full functionality of their
> > corresponding VIRTIO device than others. The most well-known example is
> > that vhost-net devices have rx/tx virtqueues and but lack the virtio-ne=
t
> > control virtqueue. Also, the configuration space and device lifecycle
> > are only partially available to vhost devices.
> >=20
> > This difference makes it impossible to use a VIRTIO device as a
> > vhost-user device and vice versa. There is an impedance mismatch and
> > missing functionality. That's a shame because existing VIRTIO device
> > emulation code is mature and duplicating it to provide vhost-user
> > backends creates additional work.
>=20
>=20
> The biggest issue facing vhost-user and absent in vdpa is
> backend disconnect handling. This is the reason control path
> is kept under QEMU control: we do not need any logic to
> restore control path data, and we can verify a new backend
> is consistent with old one.

I don't think using vhost-user with vDPA changes that. The VMM still
needs to emulate a virtio-pci/ccw/mmio device that the guest interfaces
with. If the device backend goes offline it's possible to restore that
state upon reconnection. What have I missed?

Regarding reconnection in general, it currently seems like a partially
solved problem in vhost-user. There is the "Inflight I/O tracking"
mechanism in the spec and some wording about reconnecting the socket,
but in practice I wouldn't expect all device types, VMMs, or device
backends to actually support reconnection. This is an area where a
uniform solution would be very welcome too.

There was discussion about recovering state in muser. The original idea
was for the muser kernel module to host state that persists across
device backend restart. That way the device backend can go away
temporarily and resume without guest intervention.

Then when the vfio-user discussion started the idea morphed into simply
keeping a tmpfs file for each device instance (no special muser.ko
support needed anymore). This allows the device backend to resume
without losing state. In practice a programming framework is needed to
make this easy and safe to use but it boils down to a tmpfs mmap.

> > If there was a way to reuse existing VIRTIO device emulation code it
> > would be easier to move to a multi-process architecture in QEMU. Want t=
o
> > run --netdev user,id=3Dnetdev0 --device virtio-net-pci,netdev=3Dnetdev0=
 in a
> > separate, sandboxed process? Easy, run it as a vhost-user-net device
> > instead of as virtio-net.
>=20
> Given vhost-user is using a socket, and given there's an elaborate
> protocol due to need for backwards compatibility, it seems safer to
> have vhost-user interface in a separate process too.

Right, with vhost-user only the virtqueue processing is done in the
device backend. The VMM still has to do the virtio transport emulation
(pci, ccw, mmio) and vhost-user connection lifecycle, which is complex.

Going back to Marc-Andr=E9's point, why don't we focus on vfio-user so the
entire device can be moved out of the VMM?

Stefan

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9y9w8ACgkQnKSrs4Gr
c8g8nggAwWm11CwXIHmHHf4xkBwIRbtOUCenCO+WbPvTSVCnSDUwM/vMI7qLWVHK
gPZJXjVgrPTwzDM6U5xUn/Fqfb6T1T1LvWwnYvwEolNHPNkTBWDC5MevECCUm6yL
O3nVmhpBOiH8dhYsInmoqAZ7o5UrAvkyv8eEU6orez9q18tAILz3QIljNuW/bwVc
dXG8pW7YOkqhymUxFSFQ+aGr6/guGbTJUFfY+1wpTtg3osSKGp50/yloRX8tNt4K
DoVzKiyJnzLjYSJ1rowl5yx+17PEAztlW5olcN7UcBGtfGMVJ6wklOh40lDbLWi3
gQJ41AAjwxWxvq2BPn7pHXeq73DIFg==
=jm+O
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--


