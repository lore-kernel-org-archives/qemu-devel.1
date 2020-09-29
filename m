Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC014C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 18:40:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 101502074A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 18:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aL4JNbZ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 101502074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNKXm-00030O-SJ
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 14:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNKWT-0002QI-TH
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 14:38:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26851)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNKWR-0006E6-M0
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 14:38:45 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601404722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FdD13MorY5K7ZLklnmfIOk3wcXOtQ56hxJVqYMMC+cE=;
 b=aL4JNbZ+kTj+Hqxil74bkOUrD9n2Y1HVlTXirdM4ej4z9fVfprZgpza/cGx2Cr29SMbZID
 JN8d5tjjCUHjhC/77khSjnIrncTmu+vqL+iWJqoZOkfSj4ByvO7YcTqDZQ8jaQ9bfVdagE
 2ijoq/88xLymp84QMad3EDXoTUIzGj0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-OotXDz8eMbunWKKIJmM1eQ-1; Tue, 29 Sep 2020 14:38:38 -0400
X-MC-Unique: OotXDz8eMbunWKKIJmM1eQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C86E71015EDF;
 Tue, 29 Sep 2020 18:38:36 +0000 (UTC)
Received: from localhost (ovpn-113-13.ams2.redhat.com [10.36.113.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C10F96198E;
 Tue, 29 Sep 2020 18:38:24 +0000 (UTC)
Date: Tue, 29 Sep 2020 19:38:24 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: Outline for VHOST_USER_PROTOCOL_F_VDPA
Message-ID: <20200929183824.GC191675@stefanha-x1.localdomain>
References: <20200928092537.GA44353@stefanha-x1.localdomain>
 <20200929020114-mutt-send-email-mst@kernel.org>
 <20200929085751.GA181609@stefanha-x1.localdomain>
 <20200929055110-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200929055110-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
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

--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2020 at 06:04:34AM -0400, Michael S. Tsirkin wrote:
> On Tue, Sep 29, 2020 at 09:57:51AM +0100, Stefan Hajnoczi wrote:
> > On Tue, Sep 29, 2020 at 02:09:55AM -0400, Michael S. Tsirkin wrote:
> > > On Mon, Sep 28, 2020 at 10:25:37AM +0100, Stefan Hajnoczi wrote:
> > > > Why extend vhost-user with vDPA?
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > Reusing VIRTIO emulation code for vhost-user backends
> > > > -----------------------------------------------------
> > > > It is a common misconception that a vhost device is a VIRTIO device=
.
> > > > VIRTIO devices are defined in the VIRTIO specification and consist =
of a
> > > > configuration space, virtqueues, and a device lifecycle that includ=
es
> > > > feature negotiation. A vhost device is a subset of the correspondin=
g
> > > > VIRTIO device. The exact subset depends on the device type, and som=
e
> > > > vhost devices are closer to the full functionality of their
> > > > corresponding VIRTIO device than others. The most well-known exampl=
e is
> > > > that vhost-net devices have rx/tx virtqueues and but lack the virti=
o-net
> > > > control virtqueue. Also, the configuration space and device lifecyc=
le
> > > > are only partially available to vhost devices.
> > > >=20
> > > > This difference makes it impossible to use a VIRTIO device as a
> > > > vhost-user device and vice versa. There is an impedance mismatch an=
d
> > > > missing functionality. That's a shame because existing VIRTIO devic=
e
> > > > emulation code is mature and duplicating it to provide vhost-user
> > > > backends creates additional work.
> > >=20
> > >=20
> > > The biggest issue facing vhost-user and absent in vdpa is
> > > backend disconnect handling. This is the reason control path
> > > is kept under QEMU control: we do not need any logic to
> > > restore control path data, and we can verify a new backend
> > > is consistent with old one.
> >=20
> > I don't think using vhost-user with vDPA changes that. The VMM still
> > needs to emulate a virtio-pci/ccw/mmio device that the guest interfaces
> > with. If the device backend goes offline it's possible to restore that
> > state upon reconnection. What have I missed?
>=20
> The need to maintain the state in a way that is robust
> against backend disconnects and can be restored.

QEMU is only bypassed for virtqueue accesses. Everything else still
goes through the virtio-pci emulation in QEMU (VIRTIO configuration
space, status register). vDPA doesn't change this.

Existing vhost-user messages can be kept if they are useful (e.g.
virtqueue state tracking). So I think the situation is no different than
with the existing vhost-user protocol.

> > Regarding reconnection in general, it currently seems like a partially
> > solved problem in vhost-user. There is the "Inflight I/O tracking"
> > mechanism in the spec and some wording about reconnecting the socket,
> > but in practice I wouldn't expect all device types, VMMs, or device
> > backends to actually support reconnection. This is an area where a
> > uniform solution would be very welcome too.
>=20
> I'm not aware of big issues. What are they?

I think "Inflight I/O tracking" can only be used when request processing
is idempotent? In other words, it can only be used when submitting the
same request multiple times is safe.

A silly example where this recovery mechanism cannot be used is if a
device has a persistent counter that is incremented by the request. The
guest can't be sure that the counter will be incremented exactly once.

Another example: devices that support requests with compare-and-swap
semantics cannot use this mechanism. During recover the compare will
fail if the request was just completing when the backend crashed.

Do I understand the limitations of this mechanism correctly? It doesn't
seem general and I doubt it can be applied to all existing device types.

> > There was discussion about recovering state in muser. The original idea
> > was for the muser kernel module to host state that persists across
> > device backend restart. That way the device backend can go away
> > temporarily and resume without guest intervention.
> >=20
> > Then when the vfio-user discussion started the idea morphed into simply
> > keeping a tmpfs file for each device instance (no special muser.ko
> > support needed anymore). This allows the device backend to resume
> > without losing state. In practice a programming framework is needed to
> > make this easy and safe to use but it boils down to a tmpfs mmap.
> >=20
> > > > If there was a way to reuse existing VIRTIO device emulation code i=
t
> > > > would be easier to move to a multi-process architecture in QEMU. Wa=
nt to
> > > > run --netdev user,id=3Dnetdev0 --device virtio-net-pci,netdev=3Dnet=
dev0 in a
> > > > separate, sandboxed process? Easy, run it as a vhost-user-net devic=
e
> > > > instead of as virtio-net.
> > >=20
> > > Given vhost-user is using a socket, and given there's an elaborate
> > > protocol due to need for backwards compatibility, it seems safer to
> > > have vhost-user interface in a separate process too.
> >=20
> > Right, with vhost-user only the virtqueue processing is done in the
> > device backend. The VMM still has to do the virtio transport emulation
> > (pci, ccw, mmio) and vhost-user connection lifecycle, which is complex.
>=20
> IIUC all vfio user does is add another protocol in the VMM,
> and move code out of VMM to backend.
>=20
> Architecturally I don't see why it's safer.

It eliminates one layer of device emulation (virtio-pci). Fewer
registers to emulate means a smaller attack surface.

It's possible to take things further, maybe with the proposed ioregionfd
mechanism, where the VMM's KVM_RUN loop no longer handles MMIO/PIO
exits. A separate process can handle them. Maybe some platform devices
need CPU state access though.

BTW I think the goal of removing as much emulation from the VMM as
possible is interesting.

Did you have some other approach in mind to remove the PCI and
virtio-pci device from the VMM?

> Something like multi-process patches seems like a way to
> add defence in depth by having a process in the middle,
> outside both VMM and backend.

There is no third process in mpqemu. The VMM uses a UNIX domain socket
to communicate directly with the device backend. There is a PCI "proxy"
device in the VMM that does this communication when the guest accesses
registers. The device backend has a PCI "remote" host controller that a
PCIDevice instance is plugged into and the UNIX domain socket protocol
commands are translated into PCIDevice operations.

This is exactly the same as vfio-user. The only difference is that
vfio-user uses an existing set of commands, whereas mpqemu defines a new
protocol that will eventually need to provide equivalent functionality.

> > Going back to Marc-Andr=C3=A9's point, why don't we focus on vfio-user =
so the
> > entire device can be moved out of the VMM?
> >=20
> > Stefan
>=20
> The fact that vfio-user adds a kernel component is one issue.

vfio-user only needs a UNIX domain socket. The muser.ko kernel module
that was discussed after last KVM Forum is not used by vfio-user.

Stefan

--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9zfx8ACgkQnKSrs4Gr
c8gldQgAt4+ZcTb+zts0KOXsWajjA2FYsyM/wlFbhqh/PXSbioySPjnuVQfM7hW9
t0Pyc9SZD4koaXZGltFZCgAkH6rTXvvaP0wjzgRirdqHmoufeNHXDMQiBX0qZ66f
zbP11RTFP7zySm63JUTbUtdXNlbdRqr9enUfEzLIYOZigubvBwELfx4GXzeqz6nN
nt1psuEtdrcwYkGp8FjlC07l5mzOLXsLbSsV1/AMxco0caMAH3s4PEWt1IWNjCAS
0DvfmPz/DPXpKCXJFFwfUtCUuUfdZHfYjGNHSzfvBq1haTc7RUJG/0njc2yDiMHf
LIWzDx4fTAe+JzSIc0/oUPg9ZdH2gg==
=3Dsk
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--


