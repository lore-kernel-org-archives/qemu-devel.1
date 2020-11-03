Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC48C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B78120786
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jxit27VJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B78120786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZydf-0005Vk-Il
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:54:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kZyEB-00025o-Ig
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:28:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54940)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kZyE7-0007gK-Tm
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604417281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2v53eMQiUJHDUG0Oa5TPLcOeuLdsjL5YlI4XBA/YECE=;
 b=Jxit27VJslzDrnZkP7P2ALJREI33PVNfpCSAHEah0k3mJJAcYswhpIoUFw9eCWXx1an1CA
 VOfY3gAQaXqrUi/YycKfPDx/ifkPdNk6usROtw+IPhbWJSjzmLBc7mmzukY4MZvF0acRFi
 O+3Yrm8CISoW70mFAXXtuxD8apoknxg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-MsLRr1XwOdOnLSFsd5qNgg-1; Tue, 03 Nov 2020 10:27:59 -0500
X-MC-Unique: MsLRr1XwOdOnLSFsd5qNgg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4324C10866B6;
 Tue,  3 Nov 2020 15:27:58 +0000 (UTC)
Received: from localhost (ovpn-115-37.ams2.redhat.com [10.36.115.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2726A5C629;
 Tue,  3 Nov 2020 15:27:53 +0000 (UTC)
Date: Tue, 3 Nov 2020 15:27:52 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: VFIO Migration
Message-ID: <20201103152752.GC253848@stefanha-x1.localdomain>
References: <20201102111153.GC42093@stefanha-x1.localdomain>
 <20201103121709.GD3566@work-vm>
MIME-Version: 1.0
In-Reply-To: <20201103121709.GD3566@work-vm>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
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
 quintela@redhat.com, Jason Wang <jasowang@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2020 at 12:17:09PM +0000, Dr. David Alan Gilbert wrote:
> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
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
> I think this is a unique identifier, not actually a URI; the https://
> isn't needed since no one expects to ever connect to this.

Yes, it could be any unique string. If the URI idea is not popular we
can use any similar scheme.

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
>=20
> That's an interesting example; because depending on the device, it might
> be:
>     a) Completely virtualised so that the guest *shouldn't* know what
> the physical link speed is, precisely to allow the physical network on
> the destination to be different.
>=20
>     b) Part of the migrated state
>=20
>     c) Something that's allowed to be reloaded after migration
>=20
>     d) Configurable
>=20
> so I'm not sure whether it's a good example in this case or not.

Can you think of an example that has only one option?

I tried but couldn't. For example take a sound card. The guest is aware
the device supports stereo playback (2 output channels), but which exact
stereo host device is used doesn't matter, they are all suitable.

Now imagine migrating to a 7.1 surround-sound device. Similar options
come into play:

a) Emulate stereo and mix it to 7.1 surround-sound on the physical
   device. The guest still sees the stereo device.

b) Refuse migration.

c) Indicate that the output has switched and let the guest reconfigure
   itself (e.g. a sound card with multiple outputs, where one of them is
   stereo and another is 7.1 surround sound).

Which option is desirable depends on the use case.

> Maybe what's needed is a stronger instruction to abstract external
> device state so that it's not part of the configuration in most cases.

Do you want to propose something?

> > For example, if address filtering support was added to a network card t=
hen
> > device versions and the corresponding configurations may look like this=
:
> > * ``version=3D1`` - Behaves as if ``rx-filter-size=3D0``
> > * ``version=3D2`` - ``rx-filter-size=3D32``
>=20
> Note configuration parameters might have been added during the life of
> the device; e.g. if the original card had no support for rx-filters, it
> might not have a rx-filter-size parameter.

version=3D1 does not explicitly set rx-filter-size=3D0. When a new paramete=
r
is introduced it must have a default value that disables its effect on
the hardware interface and/or device state representation. This is
described in a bit more detail in the next section, maybe it should be
reordered.

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
>=20
> I try and emphasise that 'internal state' should be represented in a way
> that reflects the problem rather than the particular implementation;
> this gives it a better chance of migrating to future versions.

Sounds like a good idea.

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
>=20
> I'm sometimes asked for 'ways out' of buggy migration cases; e.g. what
> happens if version=3D1 forgot to migrate the X register; or what happens
> if verison=3D1 forgot to handle the special, rare case when X=3D5 and we
> now need to migrate some extra state.

Can these cases be handled by adding additional configuration parameters?

If version=3D1 is lacks essential state then version=3D2 can add it. The
user must configure the device to use version before they can save the
full state.

If version=3D1 didn't handle the X=3D5 case then the same solution is
needed. A new configuration parameter is introduced and the user needs
to configure the device to be the new version before migrating.

Unfortunately this requires poweroff or hotplugging a new device
instance. But some disruption is probably necessarily anyway so the
migration code on the host side can be patched to use the updated device
state representation.

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
>=20
> This is written in terms of a 'check'; there are at least three tricky
> things:
>=20
>   a) Where they both have the same parameter, do they accept the same
> range of values; e.g. a newer version of the card might allow
> rx-filter-size to go upto 128

The easy way to handle that without lots of metadata is by instantiating
the destination device to see if it works.

But in the next point you mention cloud where we need a way to find a
host that supports a given device. Metadata is probably needed to make
that check easy. In the email reply to Daniel Berrange I posted the
beginning of a JSON schema that describes device models for this
purpose. I think that offers a solution for the cloud case.

Stefan

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+hdvgACgkQnKSrs4Gr
c8iDWwf+MBbgTuSZUgV6vmv+eL7YSB1fgU3kIU8kYg/7ypsBDjzziR0XKyE7wnFo
orAMW26ZCeJYssrtkNI+n4Yi4DmXkge9+ruvOMZr8TreyZW0ByqQyF/ggTt1oxQH
6noV/oZBg6XNCnq/G8TriPewaZY50NTe5G8XLS4wkKm67z108a72QwhtQZC5SBuK
PBNV93Taei76HicvSR6vDl5MtW8EeIV/Frflt4Ju/KjO/5Fyq/ih5UnoU/fyg9ZP
EbS+Oma1CyhsT4ncb2KTlVbprNjGmSooOo+gwwObbGrHiF77LRTn8pDBZumnkmj6
cCCrnLcYHHMX1+t4cg3e+zbk7THWYg==
=nC2D
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--


