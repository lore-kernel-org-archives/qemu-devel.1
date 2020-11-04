Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75F5C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:12:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1405D21556
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eBTP7IXZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1405D21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaGiM-0006Qr-1i
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 06:12:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaGh2-0004on-VL
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:11:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25467)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaGgz-0008Mr-N8
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604488264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qa5GT/FaKsHY7nOiazHV0Azt6CfXRZv6ZGDpeYWUCAE=;
 b=eBTP7IXZNup2ecOUfGGBTzZx7WXCBTJXuz4g8iynjsqf+pFxyBrd4qrVeSCr4/09TgH7aO
 HH2ea4x+XfK2S9TdJi9kji1MSwPbXb39X1TCvQjl0/BmiztUp7bQDJbFamZZjndHPzofNz
 LzloI5Dj26z1e5LvjaZnifSO5WdO2w0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-IdIuQ4fxNRuU7Hv-qy5aXg-1; Wed, 04 Nov 2020 06:11:02 -0500
X-MC-Unique: IdIuQ4fxNRuU7Hv-qy5aXg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E5479CC2C;
 Wed,  4 Nov 2020 11:10:54 +0000 (UTC)
Received: from localhost (ovpn-115-145.ams2.redhat.com [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C44F873682;
 Wed,  4 Nov 2020 11:10:44 +0000 (UTC)
Date: Wed, 4 Nov 2020 11:10:24 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: VFIO Migration
Message-ID: <20201104111024.GD390503@stefanha-x1.localdomain>
References: <20201102111153.GC42093@stefanha-x1.localdomain>
 <ly5z6m79c0.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ly5z6m79c0.fsf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GyRA7555PLgSTuth"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: John G Johnson <john.g.johnson@oracle.com>, mtsirkin@redhat.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 quintela@redhat.com, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--GyRA7555PLgSTuth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2020 at 04:23:43PM +0100, Christophe de Dinechin wrote:
> On 2020-11-02 at 12:11 CET, Stefan Hajnoczi wrote...
> > There is discussion about VFIO migration in the "Re: Out-of-Process
> > Device Emulation session at KVM Forum 2020" thread. The current status
> > is that Kirti proposed a VFIO device region type for saving and loading
> > device state. There is currently no guidance on migrating between
> > different device versions or device implementations from different
> > vendors. This is known to be non-trivial and raised discussion about
> > whether it should really be handled by VFIO or centralized in QEMU.
> >
> > Below is a document that describes how to ensure migration compatibilit=
y
> > in VFIO. It does not require changes to the VFIO migration interface. I=
t
> > can be used for both VFIO/mdev kernel devices and vfio-user devices.
> >
> > The idea is that the device state blob is opaque to the VMM but the sam=
e
> > level of migration compatibility that exists today is still available.
> >
> > I hope this will help us reach consensus and let us discuss specifics.
> >
> > If you followed the previous discussion, I changed the approach from
> > sending a magic constant in the device state blob to identifying device
> > models by URIs. Therefore the device state structure does not need to b=
e
> > defined here - the critical information for ensuring device migration
> > compatibility is the device model and configuration defined below.
> >
> > Stefan
> > ---
> > VFIO Migration
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > This document describes how to save and load VFIO device states. Saving=
 a
> > device state produces a snapshot of a VFIO device's state that can be l=
oaded
> > again at a later point in time to resume the device from the snapshot.
> >
> > The data representation of the device state is outside the scope of thi=
s
> > document.
> >
> > Overview
> > --------
> > The purpose of device states is to save the device at a point in time a=
nd then
> > restore the device back to the saved state later. This is more challeng=
ing than
> > it first appears.
> >
> > The process of saving a device state and loading it later is called
> > *migration*. The state may be loaded by the same device that saved it o=
r by a
> > new instance of the device, possibly running on a different computer.
> >
> > It must be possible to migrate to a newer implementation of the device
> > as well as to an older implementation of the device. This allows users
> > to upgrade and roll back their systems.
> >
> > Migration can fail if loading the device state is not possible. It shou=
ld fail
> > early with a clear error message. It must not appear to complete but le=
ave the
> > device inoperable due to a migration problem.
> >
> > The rest of this document describes how these requirements can be met.
> >
> > Device Models
> > -------------
> > Devices have a *hardware interface* consisting of hardware registers,
> > interrupts, and so on.
> >
> > The hardware interface together with the device state representation is=
 called
> > a *device model*. Device models can be assigned URIs such as
> > https://qemu.org/devices/e1000e to uniquely identify them.
>=20
> Like others, I think we should either
>=20
> a) Give a relatively strong requirement regarding what is at the URL in
> question, e.g. docs, maybe even a machine-readable schema describing
> configuration and state for the device. Leaving the option "there can be
> nothing here" is IMO asking for trouble.
>=20
> b) simply call that a unique ID, and then either drop the https: entirely=
 or
> use something else, like pci:// or, to be more specific, vfio://
>=20
> I'd favor option (b) for a different practical reason. URLs are subject t=
o
> redirection and other mishaps. For example, using https:// begs the quest=
ion
> whether
> https://qemu.org/devices/e1000e and
> https://www.qemu.org/devices/e1000e
> should be treated as the same device. I believe that your intent is that
> they shouldn't, but if the qemu web server redirects to www, and someone
> wants to copy-paste their web browser's URL bar to the command line, they=
'd
> get the wrong one.
>=20
>=20
> >
> > Multiple implementations of a device model may exist. They are they are
>=20
> dup "they are"

Thanks, will fix.

> > interchangeable if they follow the same hardware interface and device
> > state representation.
> >
> > Multiple implementations of the same hardware interface may exist with
> > different device state representations, in which case the device models=
 are not
> > interchangeable and must be assigned different URIs.
> >
> > Migration is only possible when the same device model is supported by t=
he
> > *source* and the *destination* devices.
> >
> > Device Configuration
> > --------------------
>=20
> I find "device configuration" to be a bit confusing and ambiguous here.
> From the discussion, it appears that you are not talking about the active
> meaning of "configuration", as in "configuring" the device after migratio=
n,
> but talking about a passive meaning of "this device exists in multiple
> variant, which one am I talking about".
>=20
> I've scratched my head looking for a less ambiguous wording, but could no=
t
> find any.

The "configuration parameters" describe variations in the hardware
interface and device state representation. I'll rework this section and
just call them "device parameters" with a fuller explanation of their
purpose.

> > Device models may have parameters that affect the hardware interface or=
 device
> > state representation. For example, a network card may have a configurab=
le
> > address filtering table size parameter called ``rx-filter-size``. A
> > device state saved with ``rx-filter-size=3D32`` cannot be safely loaded
> > into a device with ``rx-filter-size=3D0``, because changing the size fr=
om
> > 32 to 0 may disrupt device operation.
> >
> > A list of configuration parameters is called the *device configuration*=
.
> > Migration is expected to succeed when the same device model and configu=
ration
> > that was used for saving the device state is used again to load it.
>=20
> If that's intended for a static decision, are you thinking about making i=
t
> part of the URI?
>=20
> Something like vfio://qemu.org/devices/e1000e?version=3D2

Neat idea, it might come in handy.

> > Note that not all parameters used to instantiate a device need to be pa=
rt of
> > the device configuration. For example, assigning a network card to a sp=
ecific
> > physical port is not part of the device configuration since it is not p=
art of
> > the device's hardware interface or the device state representation.
>=20
> I'd replace "since" with "when". There are cases where all ports are not
> equivalent. Or maybe you are saying that this is covered by other more
> relevant parts of the configuration like link speed?

Yes, the next part that talks about link speed is an example of how to
represent cases where certain aspects of the port do matter.

Based on the feedback I've gotten about this section, I think it was a
confusing example. I will rework this to make it clearer.

> What about the topology used to access the card? Would you want to be abl=
e
> to refer to things like IOMMU groups, etc?

Do you mean guest-visible IOMMU groups? In that case the vIOMMU (which
is a separate device) contains that information.

> > The device state can be loaded and run on a different physical port
> > without affecting the operation of the device. Therefore the physical p=
ort
> > is not part of the device configuration.
>=20
> I would prefer if we could offer a mechanism here, rather than a policy, =
and
> let the upper layers in the stack be able to specify the policy.
>=20
> Imagine for example that you have allocated ports between internal and
> external networks? The upper stack would probably want to migrate an
> "internal network" vfio to another "internal network" port, no?

Yes, the example is problematic. I will rework it.

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
> That makes me wonder if the distinction between configuration, version an=
d
> state is really tight.
>=20
> Consider a vGPU for example. It looks to me like the "shape" of the targe=
t
> vGPU would be part of "configuration" at first sight. But then, it might =
be
> instead a "state" request, "this is what I need", that could cause the
> target to reconfigure the vGPUs to match the description.
>=20
> Notice that such a reconfiguration might be impossible. So this is still =
a
> migration validation, but it's a bit more dynamic.

The configuration describes the maximum set of features and device
resources. Some of them may not be utilized at runtime, but the
destination still has to provide them just in case they are used.

It's conservative because it refuses all migrations that could run into
trouble. However, it also refuses some migrations that could succeed.

As mentioned, detecting those cases is too complex and risky. Better
safe than sorry.

> Similarly, if we get to network cards and "upper stacks", you could consi=
der
> the MAC address as part of the state or configuration, depending on the
> scenario. You could either want to "transport" the MAC address, or to
> have the upper stack follow some rules on which one to pick for the targe=
t.
> My understanding is that IPv6 DAD for example somewhat relies on the MAC
> address, and that this makes things complicated for OpenShift. Ask Stefan=
o
> Brivio about that, he understands the problem much better than I do.
>=20
> The bottom line is that IMO the line between configuration and state may =
be
> a bit fuzzy, even for a single device model, depending on the use case.

Yes, there is some freedom for the device designer to choose whether to
migrate values as part of the device state or to make them configuration
parameters.

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
> >
> > For example, if address filtering support was added to a network card t=
hen
> > device versions and the corresponding configurations may look like this=
:
> > * ``version=3D1`` - Behaves as if ``rx-filter-size=3D0``
> > * ``version=3D2`` - ``rx-filter-size=3D32``
>=20
> To me, this corresponds to default settings, see below.
>=20
> If two devices have different versions, do you allow migration?

Versions are just a shorthand. The configuration parameters are what is
compared to check migration compatibility.

If the configuration parameters differ then migration is not allowed.

Usually two versions specific different configuration parameters, so
migration between versions is not allowed.

> > Changes can be made to the device state representation as follows. Each=
 change
> > to device state must have a corresponding device configuration paramete=
r that
> > allows the change to toggled:
> >
> > * When the parameter is disabled the hardware interface and device stat=
e
> >   representation are unchanged. This allows old device states to be loa=
ded.
> >
> > * When the parameter is enabled the change comes into effect.
> >
> > * The parameter's default value disables the change. Therefore old vers=
ions do
> >   not have to explicitly specify the parameter.
>=20
> I see a problem with this. Imagine a new card has new parameter foo.
> Now, you once had a VM on this card that had foo=3D42. So it has
> foo-enabled=3Dtrue and foo=3D42. Then you migrate there something that do=
es not
> know about foo. Most likely, that would not even touch foo-enabled.
>=20
> So I think that you need to add that the migration starts with a "reset
> state" where all featured are disabled by default.

You are right. When I wrote the document I assumed the destination will
always be a freshly-instantiated device, but it was pointed out that
devices may be pre-existing (e.g. from a pool of available VFIO
devices).

The sub-thread with Alex Williamson discusses how to set parameters
using mdev and VFIO sysfs attrs. It will be possible to configure an
existing device without creating a new instance.

> > The following example illustrates migration from an old device
> > implementation to a new one. A version=3D1 network card is migrated to =
a
> > new device implementation that is also capable of version=3D2 and adds =
the
> > rx-filter-size=3D32 parameter. The new device is instantiated with
> > version=3D1, which disables rx-filter-size and is capable of loading th=
e
> > version=3D1 device state. The migration completes successfully but note
> > the device is still operating at version=3D1 level in the new device.
> >
> > The following example illustrates migration from a new device
> > implementation back to an older one. The new device implementation
> > supports version=3D1 and version=3D2. The old device implementation sup=
ports
> > version=3D1 only. Therefore the device can only be migrated when
> > instantiated with version=3D1 or the equivalent full configuration
> > parameters.
> >
> > Orchestrating Migrations
> > ------------------------
> > The following steps must be followed to migrate devices:
> >
> > 1. Check that the source and destination devices support the same devic=
e model.
> >
> > 2. Check that the destination device supports the source device's
> >    configuration. Each configuration parameter must be accepted by the
> >    destination in order to ensure that it will be possible to load the =
device
> >    state.
> >
> > 3. The device state is saved on the source and loaded on the destinatio=
n.
> >
> > 4. If migration succeeds then the destination resumes operation and the=
 source
> >    must not resume operation. If the migration fails then the source re=
sumes
> >    operation and the destination must not resume operation.
> >
> > VFIO Implementation
> > -------------------
> > The following applies both to kernel VFIO/mdev drivers and vfio-user de=
vice
> > backends.
> >
> > Devices are instantiated based on a version and/or configuration parame=
ters:
> > * ``version=3D1`` - use the device configuration aliased by version 1
> > * ``version=3D2,rx-filter-size=3D64`` - use version 1 and override ``rx=
-filter-size``
> > * ``rx-filter-size=3D0`` - directly set configuration parameters withou=
t using a version
> >
> > Device creation fails if the version and/or configuration parameters ar=
e not
> > supported.
> >
> > There must be a mechanism to query the "latest" configuration for a dev=
ice
> > model. It may simply report the ``version=3D5`` where 5 is the latest v=
ersion but
> > it could also report all configuration parameters instead of using a ve=
rsion
> > alias.
>=20
> Instead of "latest", we could have a query that lists the "supported"
> configurations. Again, vGPUs are a good example where this would be
> useful. A same card can be partitioned in a number of ways, and you can't
> really claim that "M10-2B" or "M10-0Q" is "latest".

Thanks. I agree, there needs to be a way to report all available
configuration parameters and device versions.

> You could arguably assign a unique URI to each sub-model. Maybe that's ho=
w
> you were envisioning things?

It could be done either way. The device model is parameterized so it's
not necessary to define a unique URI for each sub-model.

If the device state representation and the hardware interface is similar
then using a single device model URI and expressing the differences
using configuration parameters seems reasonable.

A device model does not necessarily correspond to a single PCI
Device/Vendor ID, just like a Linux driver does can support many PCI
Device/Vendor IDs.

Stefan

--GyRA7555PLgSTuth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+ijCAACgkQnKSrs4Gr
c8jPbAf8DX6pDRtTVDvgQVIRHcBGJpSV4lf6mya/iBnp+Xq78raO7JRyD3wAMUzV
puWPgmhODmrKzt/yPOQWjL5MMe/LHTjaGwATiimqo1ODAgTu5yecMyFoHdx6OcOm
NF4LTT9aNX9Ik9/pq9mOhPu8msCHzRF9mHhbEEkvkVasyhNx/NgVSDIux3HPhfpP
HZEbkQ+LWe5JVbmAWodVc8G7JMkiDHiNg2d0FcI56Uvou+BDdOrsB/pv+X+kP7ev
cv+v2bZvrKMk/4oH/oDT7JsyQV70hJuVJgn9w6S/JMw45eQQub4wtZ+rHyNRf5n9
wPtMe00yEhIewgBwnnzzAmEzHlXsXA==
=a3k6
-----END PGP SIGNATURE-----

--GyRA7555PLgSTuth--


