Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCACC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 07:17:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D88022206
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 07:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DasKlBmW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D88022206
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaD3B-0006v6-4L
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 02:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaD1x-0006Ei-7z
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 02:16:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37010)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaD1s-0004P4-KD
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 02:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604474183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gC6w6bdzO35mzpXoH8TEX4sbkF5wrprXLyz1cJsaeqA=;
 b=DasKlBmW/rVCFcMD/DKjw1l0uDdBjA11+PQ/lWO6McmAscmDHJIFDiKvaBvMK21yL1qJKC
 Ch1zEZp9FbXH9gm8vU1qg+PUvT2TJZyC+MXWt/VpTBIyDDJG1Y+iWzjIK2yytHYfM6+0K2
 08RjnYUmibOO57PJcSr9frZ+5gkudDo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-i-eJfTQEOuuElG0foUqCYA-1; Wed, 04 Nov 2020 02:16:19 -0500
X-MC-Unique: i-eJfTQEOuuElG0foUqCYA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F643186DD31;
 Wed,  4 Nov 2020 07:16:18 +0000 (UTC)
Received: from localhost (ovpn-112-86.ams2.redhat.com [10.36.112.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8EC2E3C04;
 Wed,  4 Nov 2020 07:16:14 +0000 (UTC)
Date: Wed, 4 Nov 2020 07:16:13 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: VFIO Migration
Message-ID: <20201104071613.GA390503@stefanha-x1.localdomain>
References: <20201102111153.GC42093@stefanha-x1.localdomain>
 <ac694df6-0842-3483-dfc6-db82830bb02b@redhat.com>
 <20201103121515.GB243332@stefanha-x1.localdomain>
 <311b467a-3000-7091-77d1-4d6c0e42c1fd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <311b467a-3000-7091-77d1-4d6c0e42c1fd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
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
 quintela@redhat.com, qemu-devel@nongnu.org,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 04, 2020 at 11:32:34AM +0800, Jason Wang wrote:
>=20
> On 2020/11/3 =E4=B8=8B=E5=8D=888:15, Stefan Hajnoczi wrote:
> > On Tue, Nov 03, 2020 at 04:46:53PM +0800, Jason Wang wrote:
> > > On 2020/11/2 =E4=B8=8B=E5=8D=887:11, Stefan Hajnoczi wrote:
> > > > There is discussion about VFIO migration in the "Re: Out-of-Process
> > > > Device Emulation session at KVM Forum 2020" thread. The current sta=
tus
> > > > is that Kirti proposed a VFIO device region type for saving and loa=
ding
> > > > device state. There is currently no guidance on migrating between
> > > > different device versions or device implementations from different
> > > > vendors. This is known to be non-trivial and raised discussion abou=
t
> > > > whether it should really be handled by VFIO or centralized in QEMU.
> > > >=20
> > > > Below is a document that describes how to ensure migration compatib=
ility
> > > > in VFIO. It does not require changes to the VFIO migration interfac=
e. It
> > > > can be used for both VFIO/mdev kernel devices and vfio-user devices=
.
> > > >=20
> > > > The idea is that the device state blob is opaque to the VMM but the=
 same
> > > > level of migration compatibility that exists today is still availab=
le.
> > >=20
> > > So if we can't mandate this or there's no way to validate this. Vendo=
r is
> > > still free to implement their own protocol which could lead a lot of
> > > maintaining burden.
> > Yes, the device state representation is their responsibility. We can't
> > do that for them since they define the hardware interface and internal
> > state.
> >=20
> > As Michael and Paolo have mentioned in the other thread, we can provide
> > guidelines and standardize common aspects.
> >=20
> > > > Migration can fail if loading the device state is not possible. It =
should fail
> > > > early with a clear error message. It must not appear to complete bu=
t leave the
> > > > device inoperable due to a migration problem.
> > >=20
> > > For VFIO-user, how management know that a VM can be migrated from src=
 to
> > > dst? For kernel, we have sysfs.
> > vfio-user devices will normally be instantiated in one of two ways:
> >=20
> > 1. Launching a device backend and passing command-line parameters:
> >=20
> >       $ my-nic --socket-path /tmp/my-nic-vfio-user.sock \
> >                --model https://vendor-a.com/my-nic \
> > =09      --rss on
> >=20
> >     Here "model" is the device model URL. The program could support
> >     multiple device models.
> >=20
> >     The "rss" device configuration parameter enables Receive Side Scali=
ng
> >     (RSS) as an example of a configuration parameter.
> >=20
> > 2. Creating a device using an RPC interface:
> >=20
> >       (qemu) device-add my-nic,rss=3Don
> >=20
> > If the device instantiation succeeds then it is safe to live migrate.
> > The device is exposing the desired hardware interface and expecting the
> > right device state representation.
>=20
>=20
> Does this mean there will still be a "my-nic" stub in qemu? (I thought it
> should be a generic one like device-add "vfio-user-pci")

No, sorry for the confusing example. I was thinking of
qemu-storage-daemon or multi-process QEMU where devices could be
configured over a QMP/HMP monitor. The device happens to be implemented
in the QEMU codebase but the VMM doesn't need a stub device.

A D-Bus or gRPC example would have been clearer because it's not
associated with a VMM.

> >=20
> > > > The rest of this document describes how these requirements can be m=
et.
> > > >=20
> > > > Device Models
> > > > -------------
> > > > Devices have a *hardware interface* consisting of hardware register=
s,
> > > > interrupts, and so on.
> > > >=20
> > > > The hardware interface together with the device state representatio=
n is called
> > > > a *device model*. Device models can be assigned URIs such as
> > > > https://qemu.org/devices/e1000e to uniquely identify them.
> > >=20
> > > It looks worse than "pci://vendor_id.device_id.subvendor_id.subdevice=
_id".
> > > "e1000e" means a lot of different 8275X implementations that have sub=
tle but
> > > easy to be ignored differences.
> > If you wish to reflect those differences in the device model URI then
> > you can use:
> >=20
> >    https://qemu.org/devices/pci/<vendor-id>/<device-id>/<subvendor-id>/=
<subdevice-id>
> >=20
> > Another option is to use device configuration parameters to express
> > differences.
> >=20
> > The important thing is that this device model URI has one owner. No one
> > else will use qemu.org. There can be many different e1000e device model
> > URIs, if necessary (with slightly different hardware interfaces and/or
> > device state representations). This avoids collisions.
> >=20
> > > And is it possible to have a list of URIs here?
> > A device implementation (mdev driver, vfio-user device backend, etc) ma=
y
> > support multiple device model URIs.
> >=20
> > A device instance has an immutable device model URI and list of
> > configuration parameters. In other words, once the device is created it=
s
> > ABI is fixed for the lifetime of the device. A new device instance can
> > be configured by powering off the machine, hotplug, etc.
> >=20
> > > > Multiple implementations of a device model may exist. They are they=
 are
> > > > interchangeable if they follow the same hardware interface and devi=
ce
> > > > state representation.
> > > >=20
> > > > Multiple implementations of the same hardware interface may exist w=
ith
> > > > different device state representations, in which case the device mo=
dels are not
> > > > interchangeable and must be assigned different URIs.
> > > >=20
> > > > Migration is only possible when the same device model is supported =
by the
> > > > *source* and the *destination* devices.
> > > >=20
> > > > Device Configuration
> > > > --------------------
> > > > Device models may have parameters that affect the hardware interfac=
e or device
> > > > state representation. For example, a network card may have a config=
urable
> > > > address filtering table size parameter called ``rx-filter-size``. A
> > > > device state saved with ``rx-filter-size=3D32`` cannot be safely lo=
aded
> > > > into a device with ``rx-filter-size=3D0``, because changing the siz=
e from
> > > > 32 to 0 may disrupt device operation.
> > >=20
> > > Do we allow the migration from "rx-filter-size=3D16" to "rx-filter-si=
ze=3D32" (I
> > > guess not?) And should we extend the concept to "device capability" i=
nstead
> > > of just state representation.=C2=A0 E.g src has CAP_X=3Don,CAP_Y=3Dof=
f but dst has
> > > CAP_X=3Don,CAP_Y=3Don, so we disallow the migration from src to dst.
> > A device instance's configuration parameters are immutable.
> > rx-filter-size=3D16 cannot be migrated to rx-filter-size=3D32.
>=20
>=20
> But then it looks to me we can't migrate back, or do you mean it is requi=
red
> to have the ability to change the max rx-filter-size.

We can migrate a device with rx-filter-size=3D16 from old -> new if the
new device implementation supports rx-filter-size=3D16. We can migrate
back to the old device implementation because it supports
rx-filter-size=3D16.

If you want to change the configuration parameters then new device must
be instantiated during poweroff or hotplug. This is how
rx-filter-size=3D16 can be changed to rx-filter-size=3D32, but it must be
done explicitly (configuration parameters don't change across
migration).

> > Yes, configuration parameters can describe capabilities. I think of
> > capabilities as something that affects the guest-visible hardware
> > interface (e.g. the RSS feature bit is enabled) that is mentioned in th=
e
> > text, but it would be clearer to mention them explicitly.
> >=20
> > > > A list of configuration parameters is called the *device configurat=
ion*.
> > > > Migration is expected to succeed when the same device model and con=
figuration
> > > > that was used for saving the device state is used again to load it.
> > > >=20
> > > > Note that not all parameters used to instantiate a device need to b=
e part of
> > > > the device configuration. For example, assigning a network card to =
a specific
> > > > physical port is not part of the device configuration since it is n=
ot part of
> > > > the device's hardware interface or the device state representation.
> > >=20
> > > Yes, but the task needs to be done by management somehow. So do you e=
xpect a
> > > vendor specific provisioning API here?
> > There seems to be no consensus on this yet. It's the question of how to
> > manage the lifecycle of VFIO, mdev, vhost-user, and vfio-user devices.
> > There are attempts to standardize in some of these areas.
> >=20
> > For mdev drivers we can standardize the sysfs interface so management
> > tools can query source devices and instantiate destination devices
> > without device-specific code.
>=20
>=20
> Even for mdev, it should be have some class defined for sysfs which could=
 be
> a standard way to configure NVME or virtio device.

Discussion on the mdev sysfs interface has started in the sub-thread
with Alex Williamson.

> > The problem with subsection semantics is that they break rollback. Once
> > the old device state has been loaded by the new device implementation,
> > saving the device state produces the new device state representation.
> > The old device implementation can no longer load it :(.
>=20
>=20
> Only when subsection is needed.

Good point. Most rollback migrations still work, only the ones that
introduce new subsections fail.

> >    Manual
> > intervention is necessary to tell the new device implementation to save
> > in the old representation.
>=20
>=20
> If we don't support subsection, could we end up with a deadlock like we d=
o
> migration since want upgrade the kernel, but if we don't upgrade the kern=
el,
> we can't do live migration.

Can you explain in more detail?

I think the approach described in this document works, except it
requires manual intervention to change device configuration parameters
whereas subsections are automatically applied by the new QEMU.

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+iVT0ACgkQnKSrs4Gr
c8hi3QgAx686EmYZzkAvJruoZYV/9DNo46Lj42AM3ssGNuPJ2ZrGrG9VVm3zPVhi
ONMMDHmDRcS0j8CWvt5PJKE/XlUVn76qcoYEktt4H7fTyMyGlKTUrhjZKB7rSesE
bnfueNxuEiJcDoFRGi3qVnBXubZS61KWG9qqxfehgzisFaSDNGZCL4XPkpJRO0U9
ZqUQkK0Zo9NIE8pLo0+OFrMGLuY4AYafvhD6go46c4ys1b54Q3zl0appooNDzpzg
MUb1OeyzeQKuaNhQsekdkJvunxUBmZg2OaxZBSQ9yJUkhXoIPEaupkREpfnEgDo7
SiwsaW/z10BnXz6yHzvnieTBiANQPg==
=wu4m
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--


