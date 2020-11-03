Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CB4C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:04:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30303208B6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mtw1958i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30303208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZu6r-0000FV-UV
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 06:04:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kZu6F-0008F3-UA
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:03:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45694)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kZu6C-0006QX-B9
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:03:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604401413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ebDavcGv925psYcohg6lY1+VWqhQDhseVKgKiJKHRHw=;
 b=Mtw1958ijncVHoUHZG2m1JNqbDfCB5io015fddmMvff5A8ecRci4yi+vaqsiJoXlt0MkgK
 qm0DX0rAnJ4HCsJObZ1Lm+ge6yGfcAbHwZqAN+/Zcluz5adGrgrNnfWHf6MoU716tsXuHB
 uUwhIHgvg+4ZBgI/I3gxhZ3mM7TiErQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-KC8QQbLUMyme2F8lOhimaw-1; Tue, 03 Nov 2020 06:03:30 -0500
X-MC-Unique: KC8QQbLUMyme2F8lOhimaw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 266638030B1;
 Tue,  3 Nov 2020 11:03:29 +0000 (UTC)
Received: from localhost (ovpn-115-1.ams2.redhat.com [10.36.115.1])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E57455779;
 Tue,  3 Nov 2020 11:03:25 +0000 (UTC)
Date: Tue, 3 Nov 2020 11:03:24 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: VFIO Migration
Message-ID: <20201103110324.GA243332@stefanha-x1.localdomain>
References: <20201102111153.GC42093@stefanha-x1.localdomain>
 <20201102123823.066d156a@w520.home>
MIME-Version: 1.0
In-Reply-To: <20201102123823.066d156a@w520.home>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
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
Cc: John G Johnson <john.g.johnson@oracle.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, mtsirkin@redhat.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 quintela@redhat.com, Jason Wang <jasowang@redhat.com>, "Zeng,
 Xin" <xin.zeng@intel.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Felipe Franciosi <felipe@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2020 at 12:38:23PM -0700, Alex Williamson wrote:
>=20
> Cc+ Intel folks as this really bumps into the migration compatibility
> discussion[1][2][3]
>=20
> On Mon, 2 Nov 2020 11:11:53 +0000
> Stefan Hajnoczi <stefanha@redhat.com> wrote:
>=20
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
> >=20
> > I hope this will help us reach consensus and let us discuss specifics.
> >=20
> > If you followed the previous discussion, I changed the approach from
> > sending a magic constant in the device state blob to identifying device
> > models by URIs. Therefore the device state structure does not need to b=
e
> > defined here - the critical information for ensuring device migration
> > compatibility is the device model and configuration defined below.
> >=20
> > Stefan
> > ---
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
> >=20
> > Overview
> > --------
> > The purpose of device states is to save the device at a point in time a=
nd then
> > restore the device back to the saved state later. This is more challeng=
ing than
> > it first appears.
> >=20
> > The process of saving a device state and loading it later is called
> > *migration*. The state may be loaded by the same device that saved it o=
r by a
> > new instance of the device, possibly running on a different computer.
> >=20
> > It must be possible to migrate to a newer implementation of the device
> > as well as to an older implementation of the device. This allows users
> > to upgrade and roll back their systems.
>=20
>=20
> It must be possible to specify, but we can't necessarily force a vendor
> to support it.

The wording is unclear. This migration scheme makes it possible but does
not require implementations to support advanced migration scenarios. A
VFIO/mdev driver or vfio-user device backend can refuse to instantiate
with certain device configuration parameters. For example, if version=3D1
is no longer supported in the latest device implementation then it can
return an error.

> It must also be possible to describe incompatibilities,
> whether due to lack of support or forks in the migration format.

Compatibility is handled by the device model and configuration
parameters that are used to instantiate devices. If device model URIs
differ then the devices are incompatible (e.g.
https://vendor-a.com/rtl8139 and https://vendor-b.com/rtl8139). When
changes are made to the guest-visible hardware interface or device state
representation then they are toggled via configuration parameters (e.g.
rss=3Don|off).

Here is an example:

The device model is a network card as defined by the
https://vendor-a.com/my-nic device model. Receive Side Scaling (RSS) is
an optional feature and the configuration parameter rss=3Don|off toggles
its availability. When rss=3Don the RSS feature is available in the
hardware interface, but it doesn't necessarily mean that the guest
driver has to enable the feature.

Now we wish to migrate to another implementation of the same device
model. On the destination machine RSS is not available, so trying to
instantiate https://vendor-a.com/my-nic with rss=3Don will fail with an
error because the feature is unavailable (this could be because the
implementation doesn't support the feature or because the host lacks the
capability).

The following combinations are possible:

Source    Available   Result
          on Dest?
-------------------------------------------------------------------
rss=3Doff          no   OK.
rss=3Doff         yes   OK. rss=3Don is supported but we don't need it.
rss=3Don           no   FAIL. rss=3Don is not supported on destination!
rss=3Don          yes   OK.

By the way, this shows why this scheme is a conservative bound on
migration compatibility. If the guest driver hasn't enabled RSS and
won't be using it then we could potentially migrate rss=3Don even when the
destination does not support rss=3Don. But doing this reliably isn't
tractable so instead we use strict migration compatibility.

Regarding forking, if you want complete freedom you can pick a new
device model URI. Device instances using the old device model URI are
not considered compatible with the new device model URI. However, you
can then introduce changes to the hardware interface or device state
representation without agreement from the owner of the old device model
URI.

If instead you want to collaborate you can agree on changes with the
device model URI owner. You can change the device's hardware interface
and device state representation as described in this document.
Basically, each change must be reflect in a device configuration
parameter.

> > Migration can fail if loading the device state is not possible. It shou=
ld fail
> > early with a clear error message. It must not appear to complete but le=
ave the
> > device inoperable due to a migration problem.
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
> >=20
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
> >=20
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
> > the device's hardware interface or the device state representation. The=
 device
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
> >=20
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
> >   representation are unchanged. This allows old device states to be loa=
ded.
> >=20
> > * When the parameter is enabled the change comes into effect.
> >=20
> > * The parameter's default value disables the change. Therefore old vers=
ions do
> >   not have to explicitly specify the parameter.
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
> >=20
> > Orchestrating Migrations
> > ------------------------
> > The following steps must be followed to migrate devices:
> >=20
> > 1. Check that the source and destination devices support the same devic=
e model.
> >=20
> > 2. Check that the destination device supports the source device's
> >    configuration. Each configuration parameter must be accepted by the
> >    destination in order to ensure that it will be possible to load the =
device
> >    state.
> >=20
> > 3. The device state is saved on the source and loaded on the destinatio=
n.
> >=20
> > 4. If migration succeeds then the destination resumes operation and the=
 source
> >    must not resume operation. If the migration fails then the source re=
sumes
> >    operation and the destination must not resume operation.
> >=20
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
> >=20
> > Device creation fails if the version and/or configuration parameters ar=
e not
> > supported.
> >=20
> > There must be a mechanism to query the "latest" configuration for a dev=
ice
> > model. It may simply report the ``version=3D5`` where 5 is the latest v=
ersion but
> > it could also report all configuration parameters instead of using a ve=
rsion
> > alias.
>=20
> When we talk about "instantiating" a device here, are we referring to
> managing the device on the host or within QEMU via something like
> vfio_realize()?  We create an instance of an mdev on the host via an
> mdev type using operations on the host sysfs.  That mdev type doesn't
> really seem to map to your idea if a device model represented by a URI.
> How are supported URIs exposed and specified when the device is
> instantiated?
>=20
> Same for device configuration, we might have per device attributes in
> host sysfs defining the configuration of a given mdev device, are these
> the device configuration values?  It seems like you're referring to
> something much more QEMU centric, but vfio-pci in QEMU handles all
> devices the same, aside from quirks.
>=20
> Likewise, I don't know where versions would be exposed in the current
> vfio interface.

"Instantiating" means writing to the mdev "create" sysfs attr. I am not
very familiar with mdev so this could be totally wrong, but I'll try to
define a mapping:

1. The mdev driver sets up struct
   mdev_parent_opts->supported_type_groups as follows:

  /* Device model URI */
  static ssize_t model_show(struct kobject *kobj,
                            struct device *dev,
                            char *buf)
  {
      return sprintf(buf, "https://vendor-a.com/my-nic\n");
  }
  static MDEV_TYPE_ATTR_RO(model);

  /* Receive Side Scaling (RSS) */
  static ssize_t rss_show(struct kobject *kobj,
                          struct dev *dev,
=09=09=09  char *buf)
  {
      return sprintf(buf, "%d\n", ...->rss);
  }
  static ssize_t rss_store(struct kobject *kobj,
                           struct attribute *attr,
=09=09=09   const char *page,
=09=09=09   size_t count)
  {
      char *p =3D (char *) page;
      unsigned long val =3D simple_strtoul(p, &p, 10);

      ...->rss =3D !!val;
      return count;
  }
  static MDEV_TYPE_ATTR_RW(rss);

  /* Device version */
  static ssize_t version_show(struct kobject *kobj,
                              struct dev *dev,
=09=09=09      char *buf)
  {
      return sprintf(buf, "%u\n", ...->version);
  }
  static ssize_t version_store(struct kobject *kobj,
                               struct attribute *attr,
=09=09=09       const char *page,
=09=09=09       size_t count)
  {
      char *p =3D (char *) page;
      unsigned long val =3D simple_strtoul(p, &p, 10);

      /* Set device configuration parameters to their defaults */
      switch (version) {
      case 1:
          ...->rss =3D false;
=09  ...->version =3D 1;
=09  break;

      case 2:
          ...->rss =3D true;
=09  ...->version =3D 2;
=09  break;

      default:
          return -ENOTSUPP;
      }

      return count;
  }
  static MDEV_TYPE_ATTR_RW(rss);

  static struct attribute *mdev_type_my_nic_attrs[] =3D {
      &mdev_type_attr_model.attr,
      &mdev_type_attr_rss.attr,
      &mdev_type_attr_version.attr,
      NULL,
  };

  static struct attribute_group mdev_type_group_my_nic =3D {
      .name  =3D "my-nic", /* shorthand name */
      .attrs =3D mdev_type_my_nic_attrs,
  };

  struct attribute_group *supported_type_groups[] =3D {
      &mdev_type_group_my_nic,
      NULL,
  };

2. The userspace tooling enumerates supported device models by reading
   the "model" sysfs attr from each supported type attr group.

3. Userspace picks the device model it wishes to instantiate and sets
   the "version" sysfs attr and other device configuration parameters as
   desired.

4. Userspace instantiates the device by writing to the mdev "create" sysfs
   attr. If instantiation succeeds then migrating a device state saved
   by the same device model with the same configuration parameters is
   possible.

Maybe a cleaner way to structure this is to include the version as part
of the supported type group. So "my-nic" becomes "my-nic-1", "my-nic-2",
etc. There would still be a "version" sysfs attr but it would be
read-only. Device configuration parameters would only be present if they
were actually available in that version. For example, "my-nic-1" would
not expose an "rss" sysfs attr because it was introduced in "my-nic-2".
I see pros and cons to both the approach I outlined above and this
alternative, maybe someone more familiar with mdev has a preference?

> There's also a desire to support the vfio migration interface on
> non-mdev vfio devices.  We don't know yet if those will be separate,
> device specific vfio bus drivers or be integrated into existing
> vfio-pci, but the host device is likely instantiated by binding to a
> driver, so again I don't really understand where you're proposing this
> negotiation occurs.  Will management tools be required to create a
> device on-demand to fulfill a migration request or can we manipulate an
> existing device into that desired.  Some management layers embrace the
> idea of device pools rather than dynamic creation.  Thanks,

The concept of device instantiation is natural for mdev and vfio-user,
but not essential.

When dealing with physical devices (even PCI SR-IOV), we don't need to
instantiate them explicitly. Device instances can already exist. As long
as we know their device model URI and configuration parameters we can
ensure migration compatibility.

For example, imagine a physical PCI NIC accompanied by a non-mdev VFIO
migration driver. The device model URI and configuration parameter
information can be distributed alongside the VFIO migration driver. It
could be available via modinfo(8), as a separate metadata file, via a
vendor-specific tool, etc.

Management tools need to match the device model/configuration from the
source device against the destination device. If the destination is
capable of supporting the source's device model/configuration then
migration can proceed safely.

Let's look at the case where we are migration from an older version of a
device to a newer version. On the source we have:

  model =3D https://vendor-a.com/my-nic

On the destination we have:

  model =3D https://vendor-a.com/my-nic
  rss =3D on

The two devices are incompatible because the destination exposes the RSS
feature that is not present on the source. The RSS feature involves
guest-visible hardware interface changes and a change to the device
state representation. It is not safe to migrate!

In this case an extra configuration step is necessary so that the
destination device can accept the device state from the source. The
management tool invokes a vendor-specific tool to put the device into
the right configuration:

  # vendor-tool set-migration-config --device 0000:00:04.0 \
                                     --model https://vendor-a.com/my-nic

(This tool only succeeds when the device is bound to VFIO but not yet
opened.)

The tool invokes ioctls on the vendor-specific VFIO driver that does two
things:
1. Tells the device to present the old hardware interface without RSS
2. Uses the old device state representation without RSS support

Does this approach fit?

> [1]https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg04519.html
> [2]https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00293.html
> [3]https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg02983.html

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+hOPwACgkQnKSrs4Gr
c8isIggAxBJUtdReVRrz9AlO6Xbx7BIqb/lXpXnAHnxw5CTkoemg6v51PbupyslP
xzePMW44zmoubbV+1f0pV6eu9X4/fclzldwY8KGlM73xQ8Mv4qybgD9b5HMrtgGw
prrGbvhTt9QofU/5H1MOm0sdxC2L9NYN/LEmecqtv0k3Zy2VfI8/xjn6PrhT0oIW
3lFsRcZv6jBYJ8Q+o2a0dH6P+3smCzZRpZTwvoB4+BRfVNL2O7i32r9FUrKG5fzc
+yG9QhBgzJZNZbj3ffBUytSD9Lwyw0IL1S3d1oCXRL0Wdc6Gt3LSl0mQ45D1NEci
x6Q5tmhXwbuar3YSNSCSpTno9SFnOg==
=gfA7
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--


