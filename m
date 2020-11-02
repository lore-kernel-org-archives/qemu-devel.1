Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA9BC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 14:57:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51C392074F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 14:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gv769l/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C392074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZbGy-0007L7-B6
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 09:57:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kZbGJ-0006vz-4T
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 09:56:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44152)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kZbGG-0001dl-Ki
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 09:56:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604329003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0eDsvBr1i0RypfJJAOVEUPkpTuGDF043uXEilin7qP4=;
 b=gv769l/je2q+Z6syxA0uYPAygsEX6qpB+qQVrifpQzlbm4cw7mmi19ft++m/wKabJE3lf3
 ng7LxttJEiIKNSURNdDIDo7owEjbpLrNhDPpJKZf0IoDj2/3yzuHgwAJCsW8m07Kdp1Z7Y
 fXY6mgnSgAeSDz3w+G42/ErNyVsGSOg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-EYRKDuFnM5OykuFdaZDFrA-1; Mon, 02 Nov 2020 09:56:33 -0500
X-MC-Unique: EYRKDuFnM5OykuFdaZDFrA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91E87EC11F;
 Mon,  2 Nov 2020 14:56:32 +0000 (UTC)
Received: from localhost (ovpn-114-65.ams2.redhat.com [10.36.114.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 92D9B1002C1C;
 Mon,  2 Nov 2020 14:56:27 +0000 (UTC)
Date: Mon, 2 Nov 2020 14:56:26 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: VFIO Migration
Message-ID: <20201102145626.GA186617@stefanha-x1.localdomain>
References: <20201102111153.GC42093@stefanha-x1.localdomain>
 <20201102132844.332f680c.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201102132844.332f680c.cohuck@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: John G Johnson <john.g.johnson@oracle.com>, mtsirkin@redhat.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 quintela@redhat.com, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2020 at 01:28:44PM +0100, Cornelia Huck wrote:
> On Mon, 2 Nov 2020 11:11:53 +0000
> Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > VFIO Migration
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > This document describes how to save and load VFIO device states. Saving=
 a
> > device state produces a snapshot of a VFIO device's state that can be l=
oaded
> > again at a later point in time to resume the device from the snapshot.
> >=20
> > The data representation of the device state is outside the scope of thi=
s
> > document.
>=20
> [Is this document supposed to live in the QEMU source tree later?]

It should live alongside the VFIO documentation. For vfio-user the spec
will live in qemu.git and we could also keep this document there. The
kernel VFIO/mdev drivers also need this information. They could link to
the QEMU document.

> > Device Models
> > -------------
> > Devices have a *hardware interface* consisting of hardware registers,
> > interrupts, and so on.
> >=20
> > The hardware interface together with the device state representation is=
 called
> > a *device model*. Device models can be assigned URIs such as
> > https://qemu.org/devices/e1000e to uniquely identify them.
>=20
> Is that something that needs to be put together for every device where we
> want to support migration? How do you create the URI?

Yes. If you are creating a custom device that no one else needs to
emulate then you can simply pick a unique URL:

  https://vendor.com/my-dev

There doesn't need to be anything at the URL. It's just a unique string
that no one else will use and therefore web URLs are handy because no
one else will accidentally pick your string.

If your intention is to define a standard device model that others can
emulate and migrate, then it's good practice to publish a web page about
the device model at the URL, including the hardware datasheet and the
device state representation (e.g. a spec describing the migration data
stream).

For example, https://virtio-spec.org/devices/pci/virtio-net would
contain a link to the VIRTIO specification and the device state
representation. This allows others to implement devices that are
compatible and support migration between implementations. This is
getting beyond the scope of this document, but I imagine the VIRTIO
device state representation would be QEMU's current vmstate
representation so that migration between QEMU and out-of-process devices
is possible...

> For mdev devices, would this refer to the "base" device, or to the
> device specified by a certain mdev type?

The device synthesized by the mdev driver, because that's the
guest-visible hardware interface. I didn't want to say "guest-visible"
or refer to VMs in the document, but maybe that would make things
clearer.

> > Note that the device configuration is a conservative bound on device
> > states that can be migrated successfully since not all configuration
> > parameters may be strictly required to match on the source and
> > destination devices. For example, if the device's hardware interface ha=
s
> > not yet been initialized then changes to the link speed may not be
> > noticed. However, accurately representing runtime constraints is comple=
x
> > and risks introducing migration bugs, so no attempt is made to support
> > them to achieve more relaxed bounds on successful migrations.
>=20
> Do we want a "I know what I'm doing" override?

I think that could be implementation-defined. Maybe it will be useful if
a device is very broken and you want to offer users a command-line that
allows them to migrate to safety.

> > Device Versions
> > ---------------
> > As a device evolves, the number of configuration parameters required ma=
y become
> > inconvenient for users to express in full. A device configuration can b=
e
> > aliased by a *device version*, which is a shorthand for the full device
> > configuration. This makes it easy to apply a standard device configurat=
ion
> > without listing every configuration parameter explicitly.
> >=20
> > For example, if address filtering support was added to a network card t=
hen
> > device versions and the corresponding configurations may look like this=
:
> > * ``version=3D1`` - Behaves as if ``rx-filter-size=3D0``
> > * ``version=3D2`` - ``rx-filter-size=3D32``
>=20
> Is versioning supposed to be an ascending number, with a migration from
> n->n+m possible, but not the other way around?

The actual version string does not matter. Ascending integers is a
reasonable convention because it's easy to type and for humans to
compare.

Slightly pedantic but important point: migration from n->m is not
possible according to this document. It's always migration from n->n.
Migrating does not upgrade the guest-visible aspects of the device. The
device instance always remains at its current version. Of course the
destination device implementation may contain bug fixes, etc that come
into effect right away, but they don't change the guest-visible hardware
interface or device state representation.

To actually upgrade from n->m the user must explicitly reconfigure the
guest and hotplug or reboot.

In other words, the device version (always stays the same throughout the
lifetime of a device instance) and the device implementation version
(e.g. my-virtio-net-pci-v1.1) are two different concepts.

> Are these device versions supposed to be independent of machine versions?

Yes. Since VFIO devices are passthrough devices that can be implemented
without introducing code into QEMU, they are separate from versioned
machine types. This is similar to going out and buying a PCI adapter and
putting it into a machine. The machine itself may be a Dell Foo Bar
server with a certain hardware spec, but the PCI adapter is a completely
separate device with no relation to the machine type.

> >=20
> > Device States
> > -------------
> > The details of the device state representation are not covered in this =
document
> > but the general requirements are discussed here.
> >=20
> > The device state consists of data accessible through the device's hardw=
are
> > interface and internal state that is needed to restore device operation=
.
> > State in the hardware interface includes the values of hardware registe=
rs.
> > An example of internal state is an index value needed to avoid processi=
ng
> > queued requests more than once.
> >=20
> > Changes can be made to the device state representation as follows. Each=
 change
> > to device state must have a corresponding device configuration paramete=
r that
> > allows the change to toggled:
>=20
> s/to/to be/ :)

To be or not to be! Thanks.

> > VFIO Implementation
> > -------------------
> > The following applies both to kernel VFIO/mdev drivers and vfio-user de=
vice
> > backends.
> >=20
> > Devices are instantiated based on a version and/or configuration parame=
ters:
> > * ``version=3D1`` - use the device configuration aliased by version 1
> > * ``version=3D2,rx-filter-size=3D64`` - use version 1 and override ``rx=
-filter-size``
> > * ``rx-filter-size=3D0`` - directly set configuration parameters withou=
t using a version
>=20
> I think some of this would be encapsulated in the mdev type for
> mediated devices.

Yes, the device model and configuration need to be provided when
creating the mdev instance. This assumption is built into this design:

You decide the device model and configuration at creation time, not at
migration time. In other words, each device instance is fully specified
at all times and there is no choice of "in which format should we
save/load this?".

This approach is simple and easy to troubleshoot, but if someone can
think of a reason why it's too limited, please share.

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+gHhoACgkQnKSrs4Gr
c8gf3wf9EYcUJ0bTkVm0hcL3WewA49ZE259OWF0/X81qSH05bYcUeH36EieyxZWW
RmxPP6aKoVxhHEG5KzhpQDSz4dpRggtqIUFLXvkHHL56TG2Odm1b54cF3MzxcApM
3RQP4p7pWm7miduazgebwFYqjM6ApHLa5pFYCk10sKNjPJb+Qh6XWrN7iR8e8uV0
BgqYzv7DqbD6EHlLAsPiEZL9/kKgFI+67JR2g3RNHDtqZmAqq2Dg4DqpocUS0VUQ
Hjr+SXziCJ3R4FqMGq28VTjBOhnSlloAwqlsZ1KmNuRur/yEMt2eFtd3ylOxV5E9
2Sau4wZAKG4s8x/NXwmZsaSd8pgV2g==
=T5ip
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--


