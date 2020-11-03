Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E52DC388F9
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 18:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF6FF20786
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 18:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZRdR4oP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF6FF20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka0rw-00071i-Jm
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 13:17:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ka0r2-0006ZA-02
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 13:16:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35728)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ka0qz-0005Pz-Jn
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 13:16:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604427380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5y8wErqzn0H1ikahfKbgz8Zkn2TbU4+UaOo6SKisZMA=;
 b=ZRdR4oP8PL+eVmb481r/l3cdOGlpKJMZKkZjicjdvzEp/iRqeOQbTnl/mCDzME2/1YlY2X
 ub4ohy9i7Fj+lltSDsXOdL56X3oEqE18hSdxRa3/ab1mkW5dZUSA9WMw1RB8OIqPYKofWj
 8ufSpcXXN0cQW2s8WV/7m8e/DnpKZ8M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-xbrdqk_QNbS_Jg790nHnUw-1; Tue, 03 Nov 2020 13:16:16 -0500
X-MC-Unique: xbrdqk_QNbS_Jg790nHnUw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97F88185FD8B;
 Tue,  3 Nov 2020 18:16:15 +0000 (UTC)
Received: from localhost (ovpn-115-37.ams2.redhat.com [10.36.115.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 269B3610F3;
 Tue,  3 Nov 2020 18:16:11 +0000 (UTC)
Date: Tue, 3 Nov 2020 18:16:10 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: VFIO Migration
Message-ID: <20201103181610.GG259481@stefanha-x1.localdomain>
References: <20201102111153.GC42093@stefanha-x1.localdomain>
 <20201103113929.GH205187@redhat.com>
 <20201103150508.GB253848@stefanha-x1.localdomain>
 <20201103152303.GN205187@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201103152303.GN205187@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HB4mHL4PVvkpZAgW"
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
Cc: John G Johnson <john.g.johnson@oracle.com>, mtsirkin@redhat.com,
 quintela@redhat.com, Jason Wang <jasowang@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--HB4mHL4PVvkpZAgW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2020 at 03:23:03PM +0000, Daniel P. Berrang=E9 wrote:
> On Tue, Nov 03, 2020 at 03:05:08PM +0000, Stefan Hajnoczi wrote:
> > On Tue, Nov 03, 2020 at 11:39:29AM +0000, Daniel P. Berrang=E9 wrote:
> > > On Mon, Nov 02, 2020 at 11:11:53AM +0000, Stefan Hajnoczi wrote:
> > > > Overview
> > > > --------
> > > > The purpose of device states is to save the device at a point in ti=
me and then
> > > > restore the device back to the saved state later. This is more chal=
lenging than
> > > > it first appears.
> > > >=20
> > > > The process of saving a device state and loading it later is called
> > > > *migration*. The state may be loaded by the same device that saved =
it or by a
> > > > new instance of the device, possibly running on a different compute=
r.
> > > >=20
> > > > It must be possible to migrate to a newer implementation of the dev=
ice
> > > > as well as to an older implementation of the device. This allows us=
ers
> > > > to upgrade and roll back their systems.
> > > >=20
> > > > Migration can fail if loading the device state is not possible. It =
should fail
> > > > early with a clear error message. It must not appear to complete bu=
t leave the
> > > > device inoperable due to a migration problem.
> > >=20
> > > I think there needs to be an addition requirement.
> > >=20
> > >  It must be possible for a management application to query the suppor=
ted
> > >  versions, independantly of execution of a migration  operation.
> > >=20
> > > This is important to large scale data center / cloud management appli=
cations
> > > because before initiating a migration they need to *automatically* se=
lect
> > > a target host with high level of confidence that is will be compatibl=
e with
> > > the source host.
> > >=20
> > > Today QEMU migration compatibility is largely determined by the machi=
ne
> > > type version. Apps can query the supported machine types for host to
> > > check whether it is compatible. Similarly they will query CPU model
> > > features to check compatiblity.
> > >=20
> > > Validation and error checking at time of migration is of course still
> > > required, but the goal should be that an mgmt application will *NEVER=
*
> > > hit these errors because they will have pre-selected a host that is
> > > known to be compatible based on reported versions that are supported.
> >=20
> > Okay. What do you think of the following?
> >=20
> >   [
> >     {
> >       "model": "https://qemu.org/devices/e1000e",
> >       "params": [
> >         "rss",
> > =09...more configuration parameters...
> >       ],
> >       "versions": [
> >         {
> > =09  "name": "1",
> > =09  "params": [],
> > =09},
> > =09{
> > =09  "name": "2",
> > =09  "params": ["rss=3Don"],
> > =09},
> > =09...more versions...
> >       ]
> >     },
> >     ...more device models...
> >   ]
> >=20
> > The management tool can generate the configuration parameter list by
> > expanding a version into its params.
> >=20
> > Configuration parameter types and input ranges need more thought. For
> > example, version 1 of the device might not have rx-table-size (it's
> > effectively 0). Version 2 introduces rx-table-size and sets it to 32.
> > Version 3 raises the value to 64. In addition, the user can set a custo=
m
> > value like rx-table-size=3D48. I haven't defined the rules for this yet=
,
> > but it's clear there needs to be a way to extend configuration
> > parameters.
> >=20
> > To check migration compatibility:
> > 1. Verify that the device model URL matches the JSON data[n].model
> >    field.
> > 2. For every configuration parameter name from the source device,
> >    check that it is contained within the JSON data[n].params list.
>=20
> I'm not convinced that this makes sense. A matching set of parameter
> names + values does not imply that the migration data stream is
> actually compatible.
>=20
> ie implementations may need to change the internal migration data
> stream to fix bugs, without adding/removing a config parameter.
> The migration version string alone expresses data stream compatibility.

This is not the approach described in this document. The point of this
approach is precisely that migration is known to be safe when the device
model URI and configuration parameters match on source and destination.

Changes to the guest-visible hardware interface and/or device state
representation always require a new configuration parameter under this
approach.

> This is similar to how 2 QEMU command lines can have identical set
> of configuration parameters, aside from the machine type version,
> and thus be migration *incompatible.

That is not possible under this approach.

> Basically the version string should be considered an opaque blob
> that expresses compatibility on its own.

The version string is not directly part of the migration compatibility
check under this approach. It's is simply an alias for a list of
configuration parameters.

Stefan

--HB4mHL4PVvkpZAgW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+hnmoACgkQnKSrs4Gr
c8j4iwf/W/tycfiuJvar6lxbKzKcuGdiAfIApuS6MK5IWC3pRJtFotuPMe8l9Bg5
KZSihpF+1iMDXaHZkEfAYAk5x6GPN3KiRZSxzo66NHbqJ0berpfYkbeHYUHu2HsM
QtlH1VjmwEJ0ww75ErgSbs0dbgoCdn24Tdi4PLReol1B0QBSA1AjixdVJ9nqcUGi
sls1eMJx9JjjggG3XXPuzb4Y5hviPfZuhV/gCsbBIrdojBaWXo9y7pleFKBBGsfE
eMAKdqkwxX9VDJyf2wCieuE12ihhm9S+O42oKpXmCcttMY3oC4iViwMo/819VNcI
tAMVJGdJeCzOFoCz/YFnTFxG2KGm7Q==
=6qrk
-----END PGP SIGNATURE-----

--HB4mHL4PVvkpZAgW--


