Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237C8C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 07:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 793232080D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 07:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XxT4wv5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 793232080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaDNb-0002eL-Sa
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 02:38:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaDLf-0001lw-5I
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 02:36:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41553)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaDLc-0005v0-Lo
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 02:36:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604475406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oL/OqKS+hMlRz4o6Zc+6ZjO1VGdR0Dom1mgzNNMbEBU=;
 b=XxT4wv5OYwtXF4ATWcFr9pEMpMx67R9qUP0uTd9aybsSOC+dbJt93TXXYY43ygo+azL5cB
 Lo9e8tAwbCRfz1679BNvukmlL9cMWZhfpHE+T/NFDdLflTG/c8xmayYBzdm/iPzPd9to2e
 Z0+CtS5ubpC4cCtlRa+UZ0Qaekm2ZhI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-QDlTdqKvM6GG9eLYOfn1Dg-1; Wed, 04 Nov 2020 02:36:42 -0500
X-MC-Unique: QDlTdqKvM6GG9eLYOfn1Dg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9E9164166;
 Wed,  4 Nov 2020 07:36:40 +0000 (UTC)
Received: from localhost (ovpn-112-86.ams2.redhat.com [10.36.112.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 36E0B6EF78;
 Wed,  4 Nov 2020 07:36:37 +0000 (UTC)
Date: Wed, 4 Nov 2020 07:36:36 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: VFIO Migration
Message-ID: <20201104073636.GB390503@stefanha-x1.localdomain>
References: <20201102111153.GC42093@stefanha-x1.localdomain>
 <20201103121709.GD3566@work-vm>
 <20201103152752.GC253848@stefanha-x1.localdomain>
 <20201103184951.GM3566@work-vm>
MIME-Version: 1.0
In-Reply-To: <20201103184951.GM3566@work-vm>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
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
 quintela@redhat.com, Jason Wang <jasowang@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2020 at 06:49:51PM +0000, Dr. David Alan Gilbert wrote:
> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > On Tue, Nov 03, 2020 at 12:17:09PM +0000, Dr. David Alan Gilbert wrote:
> > > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
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
> > > I think this is a unique identifier, not actually a URI; the https://
> > > isn't needed since no one expects to ever connect to this.
> >=20
> > Yes, it could be any unique string. If the URI idea is not popular we
> > can use any similar scheme.
>=20
> I'm OK with it being a URI; just drop the https.

Okay.

> > > > However, secondary aspects related to the physical port may affect =
the device's
> > > > hardware interface and need to be reflected in the device configura=
tion. The
> > > > link speed may depend on the physical port and be reported through =
the device's
> > > > hardware interface. In that case a ``link-speed`` configuration par=
ameter is
> > > > required to prevent unexpected changes to the link speed after migr=
ation.
> > >=20
> > > That's an interesting example; because depending on the device, it mi=
ght
> > > be:
> > >     a) Completely virtualised so that the guest *shouldn't* know what
> > > the physical link speed is, precisely to allow the physical network o=
n
> > > the destination to be different.
> > >=20
> > >     b) Part of the migrated state
> > >=20
> > >     c) Something that's allowed to be reloaded after migration
> > >=20
> > >     d) Configurable
> > >=20
> > > so I'm not sure whether it's a good example in this case or not.
> >=20
> > Can you think of an example that has only one option?
> >=20
> > I tried but couldn't. For example take a sound card. The guest is aware
> > the device supports stereo playback (2 output channels), but which exac=
t
> > stereo host device is used doesn't matter, they are all suitable.
> >=20
> > Now imagine migrating to a 7.1 surround-sound device. Similar options
> > come into play:
> >=20
> > a) Emulate stereo and mix it to 7.1 surround-sound on the physical
> >    device. The guest still sees the stereo device.
> >=20
> > b) Refuse migration.
> >=20
> > c) Indicate that the output has switched and let the guest reconfigure
> >    itself (e.g. a sound card with multiple outputs, where one of them i=
s
> >    stereo and another is 7.1 surround sound).
> >=20
> > Which option is desirable depends on the use case.
>=20
> Yes, but I think it might be worth calling out these differences;  there
> are explicitly cases where you don't want external changes to be visible
> and other cases where you do; both are valid, but both need thinking
> about. (Another one, GPU whether you have a monitor plugged in!)

Okay.

> > > Maybe what's needed is a stronger instruction to abstract external
> > > device state so that it's not part of the configuration in most cases=
.
> >=20
> > Do you want to propose something?
>=20
> I think something like 'Some part of a devices state may be irrelevant
> to a migration; for example on some NICs it might be preferable to hide
> the physical characteristics of the link from the guest.'

Got it.

> > > > For example, if address filtering support was added to a network ca=
rd then
> > > > device versions and the corresponding configurations may look like =
this:
> > > > * ``version=3D1`` - Behaves as if ``rx-filter-size=3D0``
> > > > * ``version=3D2`` - ``rx-filter-size=3D32``
> > >=20
> > > Note configuration parameters might have been added during the life o=
f
> > > the device; e.g. if the original card had no support for rx-filters, =
it
> > > might not have a rx-filter-size parameter.
> >=20
> > version=3D1 does not explicitly set rx-filter-size=3D0. When a new para=
meter
> > is introduced it must have a default value that disables its effect on
> > the hardware interface and/or device state representation. This is
> > described in a bit more detail in the next section, maybe it should be
> > reordered.
>=20
> We've generally found the definition of devices tends in practice to be
> done newer->older; i.e. you define the current machine, and then define
> the next older machine setting the defaults that used to be true; then
> define the older version behind that....

That is not possible here because an older device implementation is
unaware of new configuration parameters.

Looking at the example above, imagine a version=3D1 device is instantiated
on a device implementation that supports both version=3D1 and version=3D2.
Should the configuration parameter list for version=3D1 be empty or
rx-filter-size=3D0?

It must to be empty, otherwise an older device implementation that only
supports version=3D1 cannot instantiate the device. The older device
implementation does not recognize the rx-filter-size configuration
parameter (it was introduced in version=3D2) so we cannot set it to 0.

> > > > Device States
> > > > -------------
> > > > The details of the device state representation are not covered in t=
his document
> > > > but the general requirements are discussed here.
> > > >=20
> > > > The device state consists of data accessible through the device's h=
ardware
> > > > interface and internal state that is needed to restore device opera=
tion.
> > > > State in the hardware interface includes the values of hardware reg=
isters.
> > > > An example of internal state is an index value needed to avoid proc=
essing
> > > > queued requests more than once.
> > >=20
> > > I try and emphasise that 'internal state' should be represented in a =
way
> > > that reflects the problem rather than the particular implementation;
> > > this gives it a better chance of migrating to future versions.
> >=20
> > Sounds like a good idea.
> >=20
> > > > Changes can be made to the device state representation as follows. =
Each change
> > > > to device state must have a corresponding device configuration para=
meter that
> > > > allows the change to toggled:
> > > >=20
> > > > * When the parameter is disabled the hardware interface and device =
state
> > > >   representation are unchanged. This allows old device states to be=
 loaded.
> > > >=20
> > > > * When the parameter is enabled the change comes into effect.
> > > >=20
> > > > * The parameter's default value disables the change. Therefore old =
versions do
> > > >   not have to explicitly specify the parameter.
> > > >=20
> > > > The following example illustrates migration from an old device
> > > > implementation to a new one. A version=3D1 network card is migrated=
 to a
> > > > new device implementation that is also capable of version=3D2 and a=
dds the
> > > > rx-filter-size=3D32 parameter. The new device is instantiated with
> > > > version=3D1, which disables rx-filter-size and is capable of loadin=
g the
> > > > version=3D1 device state. The migration completes successfully but =
note
> > > > the device is still operating at version=3D1 level in the new devic=
e.
> > > >=20
> > > > The following example illustrates migration from a new device
> > > > implementation back to an older one. The new device implementation
> > > > supports version=3D1 and version=3D2. The old device implementation=
 supports
> > > > version=3D1 only. Therefore the device can only be migrated when
> > > > instantiated with version=3D1 or the equivalent full configuration
> > > > parameters.
> > >=20
> > > I'm sometimes asked for 'ways out' of buggy migration cases; e.g. wha=
t
> > > happens if version=3D1 forgot to migrate the X register; or what happ=
ens
> > > if verison=3D1 forgot to handle the special, rare case when X=3D5 and=
 we
> > > now need to migrate some extra state.
> >=20
> > Can these cases be handled by adding additional configuration parameter=
s?
> >=20
> > If version=3D1 is lacks essential state then version=3D2 can add it. Th=
e
> > user must configure the device to use version before they can save the
> > full state.
> >=20
> > If version=3D1 didn't handle the X=3D5 case then the same solution is
> > needed. A new configuration parameter is introduced and the user needs
> > to configure the device to be the new version before migrating.
> >=20
> > Unfortunately this requires poweroff or hotplugging a new device
> > instance. But some disruption is probably necessarily anyway so the
> > migration code on the host side can be patched to use the updated devic=
e
> > state representation.
>=20
> There are some corner cases that people sometimes prefer; for example
> lets say the X=3D5 case is actually really rare - but when it happens the
> device is hopelessly broken, some device authors prefer to fix it and
> send the extra data and let the migration fail if the destination
> doesn't understand it (it would break anyway).

The device implementation needs to be updated to send the extra data. At
that point a new device configuration parameter should be introduced and
if the user wishes to run the new version of the device then the extra
data will be sent.

If the destination doesn't support the new parameter then migration will
be refused. That matches what you've described, so I think the approach
in this document handles this case.

> I've also been asked
> by mst for a 'unexpected data' mechanism to send data that the
> destination might not expect if it didn't know about it, for similar
> cases.

Do you mean optional data that can be more or less safely dropped? A new
device configuration parameter is not needed because the hardware
interface and device state representation remain compatible. That
feature can be defined in the device state representation spec and is
not visible at the layer discussed in this document. But I think it's
worth adding an explanation into this document explaining what to do.

Stefan

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+iWgMACgkQnKSrs4Gr
c8i9pQgAp7C3W+ldjQLu+khvmY+Cr1vht0INcrshEybRTwpge9/H3pVvmOlGbUjD
rPd/kJu4xotcaq/1qE83io7K/R9ZLy/Iv3btr4EAmPJvkYf/14dPwjl0aBuNzKvY
K3VQQpMrsCWKKuLZbZFkzgN5dohiODFFo5XWF7UzcOsrLaRySKCoilMN3G1OEHiM
ZXkG0qSeet3f4VKo4I87oxsDpL1wLxj6hddAKR1yK9B/CYHYFbCSXyW2LHbXh/RM
j17Rm8scg3t1i9jRd0g9y4bJ1I5h8Z4geL2Nq4ovCMEJ+PiM5F1Ceabilav+k2p+
Oqd6TId4Ei3B2ziyDU0wylupDyip0Q==
=0k9D
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--


