Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538FEC4742C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:17:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 918A422243
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D6FWBP+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 918A422243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZvFn-0005ub-A9
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 07:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kZvDn-0004xK-4Q
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:15:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35040)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kZvDj-0006Wr-4f
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604405725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xnblgYX7XrrCh0cBgEElEO26CGPgUpRNwvHugroAXDg=;
 b=D6FWBP+QJdfbHJppstJ71EvUE+otNuGehdWHA24S/MsF/s3QtLl0Dw2xDAed/Mob/CKuXp
 wtjMv4zyCtQPAsWMI+u2RvGHHyHMJ9d4nHLBgksmvwRniLsNc5YNWpXxouN2rjzOJx373i
 V9tkUS9v7Lt4HZdegsNwizR+O2WZ6j8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-ggQc02zKNcW7SGoOY_0K5w-1; Tue, 03 Nov 2020 07:15:21 -0500
X-MC-Unique: ggQc02zKNcW7SGoOY_0K5w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F27A835B4F;
 Tue,  3 Nov 2020 12:15:20 +0000 (UTC)
Received: from localhost (ovpn-115-1.ams2.redhat.com [10.36.115.1])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C2FD173661;
 Tue,  3 Nov 2020 12:15:16 +0000 (UTC)
Date: Tue, 3 Nov 2020 12:15:15 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: VFIO Migration
Message-ID: <20201103121515.GB243332@stefanha-x1.localdomain>
References: <20201102111153.GC42093@stefanha-x1.localdomain>
 <ac694df6-0842-3483-dfc6-db82830bb02b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ac694df6-0842-3483-dfc6-db82830bb02b@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
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

--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2020 at 04:46:53PM +0800, Jason Wang wrote:
>=20
> On 2020/11/2 =E4=B8=8B=E5=8D=887:11, Stefan Hajnoczi wrote:
> > There is discussion about VFIO migration in the "Re: Out-of-Process
> > Device Emulation session at KVM Forum 2020" thread. The current status
> > is that Kirti proposed a VFIO device region type for saving and loading
> > device state. There is currently no guidance on migrating between
> > different device versions or device implementations from different
> > vendors. This is known to be non-trivial and raised discussion about
> > whether it should really be handled by VFIO or centralized in QEMU.
> >=20
> > Below is a document that describes how to ensure migration compatibilit=
y
> > in VFIO. It does not require changes to the VFIO migration interface. I=
t
> > can be used for both VFIO/mdev kernel devices and vfio-user devices.
> >=20
> > The idea is that the device state blob is opaque to the VMM but the sam=
e
> > level of migration compatibility that exists today is still available.
>=20
>=20
> So if we can't mandate this or there's no way to validate this. Vendor is
> still free to implement their own protocol which could lead a lot of
> maintaining burden.

Yes, the device state representation is their responsibility. We can't
do that for them since they define the hardware interface and internal
state.

As Michael and Paolo have mentioned in the other thread, we can provide
guidelines and standardize common aspects.

> > Migration can fail if loading the device state is not possible. It shou=
ld fail
> > early with a clear error message. It must not appear to complete but le=
ave the
> > device inoperable due to a migration problem.
>=20
>=20
> For VFIO-user, how management know that a VM can be migrated from src to
> dst? For kernel, we have sysfs.

vfio-user devices will normally be instantiated in one of two ways:

1. Launching a device backend and passing command-line parameters:

     $ my-nic --socket-path /tmp/my-nic-vfio-user.sock \
              --model https://vendor-a.com/my-nic \
=09      --rss on

   Here "model" is the device model URL. The program could support
   multiple device models.

   The "rss" device configuration parameter enables Receive Side Scaling
   (RSS) as an example of a configuration parameter.

2. Creating a device using an RPC interface:

     (qemu) device-add my-nic,rss=3Don

If the device instantiation succeeds then it is safe to live migrate.
The device is exposing the desired hardware interface and expecting the
right device state representation.

> >=20
> > The rest of this document describes how these requirements can be met.
> >=20
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
>=20
> It looks worse than "pci://vendor_id.device_id.subvendor_id.subdevice_id"=
.
> "e1000e" means a lot of different 8275X implementations that have subtle =
but
> easy to be ignored differences.

If you wish to reflect those differences in the device model URI then
you can use:

  https://qemu.org/devices/pci/<vendor-id>/<device-id>/<subvendor-id>/<subd=
evice-id>

Another option is to use device configuration parameters to express
differences.

The important thing is that this device model URI has one owner. No one
else will use qemu.org. There can be many different e1000e device model
URIs, if necessary (with slightly different hardware interfaces and/or
device state representations). This avoids collisions.

> And is it possible to have a list of URIs here?

A device implementation (mdev driver, vfio-user device backend, etc) may
support multiple device model URIs.

A device instance has an immutable device model URI and list of
configuration parameters. In other words, once the device is created its
ABI is fixed for the lifetime of the device. A new device instance can
be configured by powering off the machine, hotplug, etc.

> > Multiple implementations of a device model may exist. They are they are
> > interchangeable if they follow the same hardware interface and device
> > state representation.
> >=20
> > Multiple implementations of the same hardware interface may exist with
> > different device state representations, in which case the device models=
 are not
> > interchangeable and must be assigned different URIs.
> >=20
> > Migration is only possible when the same device model is supported by t=
he
> > *source* and the *destination* devices.
> >=20
> > Device Configuration
> > --------------------
> > Device models may have parameters that affect the hardware interface or=
 device
> > state representation. For example, a network card may have a configurab=
le
> > address filtering table size parameter called ``rx-filter-size``. A
> > device state saved with ``rx-filter-size=3D32`` cannot be safely loaded
> > into a device with ``rx-filter-size=3D0``, because changing the size fr=
om
> > 32 to 0 may disrupt device operation.
>=20
>=20
> Do we allow the migration from "rx-filter-size=3D16" to "rx-filter-size=
=3D32" (I
> guess not?) And should we extend the concept to "device capability" inste=
ad
> of just state representation.=C2=A0 E.g src has CAP_X=3Don,CAP_Y=3Doff bu=
t dst has
> CAP_X=3Don,CAP_Y=3Don, so we disallow the migration from src to dst.

A device instance's configuration parameters are immutable.
rx-filter-size=3D16 cannot be migrated to rx-filter-size=3D32.

Yes, configuration parameters can describe capabilities. I think of
capabilities as something that affects the guest-visible hardware
interface (e.g. the RSS feature bit is enabled) that is mentioned in the
text, but it would be clearer to mention them explicitly.

> > A list of configuration parameters is called the *device configuration*=
.
> > Migration is expected to succeed when the same device model and configu=
ration
> > that was used for saving the device state is used again to load it.
> >=20
> > Note that not all parameters used to instantiate a device need to be pa=
rt of
> > the device configuration. For example, assigning a network card to a sp=
ecific
> > physical port is not part of the device configuration since it is not p=
art of
> > the device's hardware interface or the device state representation.
>=20
>=20
> Yes, but the task needs to be done by management somehow. So do you expec=
t a
> vendor specific provisioning API here?

There seems to be no consensus on this yet. It's the question of how to
manage the lifecycle of VFIO, mdev, vhost-user, and vfio-user devices.
There are attempts to standardize in some of these areas.

For mdev drivers we can standardize the sysfs interface so management
tools can query source devices and instantiate destination devices
without device-specific code.

For vhost-user devices there is the backend program conventions
specification, which aims to standardize common parameters. This makes
integrating support for new device implementations easier (there is less
device implementation-specific code).

For vfio-user devices something based on the vhost-user backend program
conventions spec could work well.

The main issue could be that avoiding vendor-specific provisioning code
in management software either requires you to restrict yourself to a few
standard device types or to pass through configuration data.

A libvirt opinion would be interesting.

> > The device
> > state can be loaded and run on a different physical port without affect=
ing the
> > operation of the device. Therefore the physical port is not part of the=
 device
> > configuration.
> >=20
> > However, secondary aspects related to the physical port may affect the =
device's
> > hardware interface and need to be reflected in the device configuration=
. The
> > link speed may depend on the physical port and be reported through the =
device's
> > hardware interface. In that case a ``link-speed`` configuration paramet=
er is
> > required to prevent unexpected changes to the link speed after migratio=
n.
> >=20
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
> >=20
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
>=20
>=20
> I'm not sure how to apply the device versions consider the device state i=
s
> opaque or the device needs to export another API to do this?

Versions are just aliases for a list of configuration parameters. For
example, version=3D2 expands to rx-filter-size=3D32. The purpose of version=
s
is to provide a human-readable shorthand notation.

Versions are not involved in migration compatibility checking, instead
the device model URI and expanded configuration parameters are compared.

The version has no direct effect on the device state representation. It
has an indirect effect due to the configuration parameters that it
expands to. For example, the rx-filter-size=3D32 configuration parameter
may change the device state representation to include the 32 addresses
that the device is filtering on.

No "version check" is necessary when loading the device state
representation because the device was already instantiated with the
exact configuration parameters that determine the device state
representation.

> > For example, if address filtering support was added to a network card t=
hen
> > device versions and the corresponding configurations may look like this=
:
> > * ``version=3D1`` - Behaves as if ``rx-filter-size=3D0``
> > * ``version=3D2`` - ``rx-filter-size=3D32``
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
> >=20
> > * When the parameter is disabled the hardware interface and device stat=
e
> >    representation are unchanged. This allows old device states to be lo=
aded.
> >=20
> > * When the parameter is enabled the change comes into effect.
> >=20
> > * The parameter's default value disables the change. Therefore old vers=
ions do
> >    not have to explicitly specify the parameter.
> >=20
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
> >=20
> > The following example illustrates migration from a new device
> > implementation back to an older one. The new device implementation
> > supports version=3D1 and version=3D2. The old device implementation sup=
ports
> > version=3D1 only. Therefore the device can only be migrated when
> > instantiated with version=3D1 or the equivalent full configuration
> > parameters.
>=20
>=20
> In qemu we have subsection to facilitate the case when some fields were
> forgot to migrate. Do we need something similar here?

This is an important question and I'm not sure.

The problem with subsection semantics is that they break rollback. Once
the old device state has been loaded by the new device implementation,
saving the device state produces the new device state representation.
The old device implementation can no longer load it :(.  Manual
intervention is necessary to tell the new device implementation to save
in the old representation.

In the migration model described in this document it works the other
way around: back and forth migration is always safe. If you wish to
change the device you need to create a new instance (after poweroff or
through hotplug).

One way of achieving something similar is to provide additional
information about safe transitions between configuration parameter
lists. It is not safe to change arbitrary device configuration
parameters, but certain parameters can be safely changed.

I'm not sure if the complexity is worth it though. The downside to the
current approach is that devices must eventually be reconfigured to
upgrade to new versions, even if there is no guest-visible hardware
interface change.

Stefan

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+hSdMACgkQnKSrs4Gr
c8gw5wgAmCsBYSk4fx2j56DErDN2McNy7UGYqB9xt1iETInNJrqQR7C1ReWvjwxP
0rSeisdf4avvs3r2AbsWEzDU+hvpE8K9yiO/+OrFCUkQMwNgX/QERN0I2+vrrF7L
jMkZYaDSC6swxjy5U+sZDDO6C+PEoQWoiE8VNKbpP1NPLpQYDrhkQ+qqA55qHeex
hMkkbahWb3wHAw2yTKlDXK9cksKmGCFzeP3FFoEcok8zyatwO/0+hJn4186zaL9r
PDoBn+uc8YvF/kRxzY/I/TMnfyou65huB1XldMadGfNJ4ytHr7eY5BCv9VreZfcZ
nSXDIXGqF4aVN0ZqgKEogEOKSWpEIg==
=symp
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--


