Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977A8C388F9
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:13:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F18BF20757
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RnttWad6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F18BF20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxzu-0008Ba-Ut
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:13:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kZxsQ-0002bi-PP
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:05:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59089)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kZxsM-0008Gu-8f
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604415932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cAq0zPlTXsCKa/xZUGjvTNU8Jth3STSSJ2gNaKzIHiM=;
 b=RnttWad6QhE4GG4hzahlAHvUBsiCdj717FfyzEocb0kfA5XUOiQeuKSSQGksfFNfkRyCC3
 f6daszdEVxllV0hcY/Ah8I1jQkmpVvHXQfW0u88XVvTiw6eLTd+RalaMtyP0l4xfe6OPGs
 ZeqDJs9mX9blkzgI+wGWH7gY2H1lS24=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-XYTBq8TpOAWY-r1FcIceKg-1; Tue, 03 Nov 2020 10:05:14 -0500
X-MC-Unique: XYTBq8TpOAWY-r1FcIceKg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2788D18C89D0;
 Tue,  3 Nov 2020 15:05:13 +0000 (UTC)
Received: from localhost (ovpn-115-37.ams2.redhat.com [10.36.115.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BBB897512C;
 Tue,  3 Nov 2020 15:05:09 +0000 (UTC)
Date: Tue, 3 Nov 2020 15:05:08 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: VFIO Migration
Message-ID: <20201103150508.GB253848@stefanha-x1.localdomain>
References: <20201102111153.GC42093@stefanha-x1.localdomain>
 <20201103113929.GH205187@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201103113929.GH205187@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
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
 quintela@redhat.com, Jason Wang <jasowang@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2020 at 11:39:29AM +0000, Daniel P. Berrang=E9 wrote:
> On Mon, Nov 02, 2020 at 11:11:53AM +0000, Stefan Hajnoczi wrote:
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
> >=20
> > Migration can fail if loading the device state is not possible. It shou=
ld fail
> > early with a clear error message. It must not appear to complete but le=
ave the
> > device inoperable due to a migration problem.
>=20
> I think there needs to be an addition requirement.
>=20
>  It must be possible for a management application to query the supported
>  versions, independantly of execution of a migration  operation.
>=20
> This is important to large scale data center / cloud management applicati=
ons
> because before initiating a migration they need to *automatically* select
> a target host with high level of confidence that is will be compatible wi=
th
> the source host.
>=20
> Today QEMU migration compatibility is largely determined by the machine
> type version. Apps can query the supported machine types for host to
> check whether it is compatible. Similarly they will query CPU model
> features to check compatiblity.
>=20
> Validation and error checking at time of migration is of course still
> required, but the goal should be that an mgmt application will *NEVER*
> hit these errors because they will have pre-selected a host that is
> known to be compatible based on reported versions that are supported.

Okay. What do you think of the following?

  [
    {
      "model": "https://qemu.org/devices/e1000e",
      "params": [
        "rss",
=09...more configuration parameters...
      ],
      "versions": [
        {
=09  "name": "1",
=09  "params": [],
=09},
=09{
=09  "name": "2",
=09  "params": ["rss=3Don"],
=09},
=09...more versions...
      ]
    },
    ...more device models...
  ]

The management tool can generate the configuration parameter list by
expanding a version into its params.

Configuration parameter types and input ranges need more thought. For
example, version 1 of the device might not have rx-table-size (it's
effectively 0). Version 2 introduces rx-table-size and sets it to 32.
Version 3 raises the value to 64. In addition, the user can set a custom
value like rx-table-size=3D48. I haven't defined the rules for this yet,
but it's clear there needs to be a way to extend configuration
parameters.

To check migration compatibility:
1. Verify that the device model URL matches the JSON data[n].model
   field.
2. For every configuration parameter name from the source device,
   check that it is contained within the JSON data[n].params list.

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
> The mechanism needs to be able to report all supported versions strings,
> not simple the latest version string. I think we need to specify the
> actual mechanism todo this query too, because we can't end up in a place
> where there's a different approach to queries for each device type.

Makes sense.

Stefan

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+hcaQACgkQnKSrs4Gr
c8g6Ogf/eWtotESqLmCJ0a9GcW3GIqdB3JGnTYdvVIt0LBP188BGJ688ZH08zte+
LZUxSY5aG+GCqvQnvL5vNrJHISSr3x5wObgraSbiC8mvRPIF8bqdkb+5gsSY68+C
FFLUptnEqxHA0pK8DeAbS4aMXeliRSlP2d1xXABWFiHOB9l1h0AAuSWqUDjGIuJu
oa6eIDYfmGoEtrevvUyO0aOwNuOQkOHhQXCjDCLaKrih/WjxVaSVZx2EVH+Jvh1v
NjL2LQvuw3fmQI/6U6n5YhDZxYRhzcWb8qTmb76tZAsrLFA6Pukz+QsyWkNVjTUx
8DbRffI+ELiEjN+kZizB/puiEi9Svw==
=hDcY
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--


