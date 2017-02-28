Received: from eggs.gnu.org ([2001:4830:134:3::10]:38047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cimhI-0008IV-HA
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:40:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cimhF-0002MP-E4
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:40:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cimhF-0002M8-4e
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:40:25 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31B95C037F6B
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 18:40:25 +0000 (UTC)
References: <148830500441.258.8927797894103383324@0e2666bad730>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9bccf145-9481-2eee-dabb-33001071a841@redhat.com>
Date: Tue, 28 Feb 2017 12:40:22 -0600
MIME-Version: 1.0
In-Reply-To: <148830500441.258.8927797894103383324@0e2666bad730>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FHImn5M6BVoGS2qJhUnx7FbrMAbrIiOUm"
Subject: Re: [Qemu-devel] [PATCH v3 00/26] qapi: QMP dispatch and input
 visitor work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, armbru@redhat.com
Cc: famz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FHImn5M6BVoGS2qJhUnx7FbrMAbrIiOUm
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org, armbru@redhat.com
Cc: famz@redhat.com
Message-ID: <9bccf145-9481-2eee-dabb-33001071a841@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/26] qapi: QMP dispatch and input
 visitor work
References: <148830500441.258.8927797894103383324@0e2666bad730>
In-Reply-To: <148830500441.258.8927797894103383324@0e2666bad730>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/28/2017 12:03 PM, no-reply@patchew.org wrote:
> Hi,
>=20
> This series seems to have some coding style problems. See output below =
for
> more information:
>=20

> Checking PATCH 18/26: tests-qobject-input-strict: Merge into test-qobje=
ct-input-visitor...
> ERROR: line over 90 characters
> #486: FILE: tests/test-qobject-input-visitor.c:847:
> +    v =3D visitor_input_test_init(data, "{ 'integer': -42, 'boolean': =
true, 'string': 'foo', 'extra': 42 }");

Code motion, can be ignored (we may want to clean it up later, but
doesn't affect this series).


> Checking PATCH 24/26: tests: Cover input visit beyond end of list...
> ERROR: if this code is redundant consider removing it
> #85: FILE: tests/test-qobject-input-visitor.c:956:
> +#if 0 /* FIXME crash */

Fixed later in the series, so doesn't impact the overall submission.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--FHImn5M6BVoGS2qJhUnx7FbrMAbrIiOUm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtcQWAAoJEKeha0olJ0Nqq1kIAKdFPsALxyhoZTunIgP5p+q9
g3P3f2gLu9hFq8yP3MLu94REWM74UpyDcrPonngE3iUtVOxPsdiXx5RS0LAIaF2n
HE6x5nhb4SdUo2fS+QHi6P3gdAHgS17FUKbNSL+PhkE2MY6wv887FROZPAfSSRWA
qoPuWa6bu9nWXyj2h5oe3XECAEApZkhdfsLPO4dSZiNC075azg5Q4l7kB4bl2LM2
Mef2enLgDMzSShqnqoUmMcvkVLk357ozMFL3+FWuelFgbDjaf6K0BPLQQfmrAuLH
VFAeyzDZ3AuPCR4OelHKeGrIb9Z3l8wKaXAWTEwtfbP3a78cU0iOWU1kMuQ5uCg=
=asRt
-----END PGP SIGNATURE-----

--FHImn5M6BVoGS2qJhUnx7FbrMAbrIiOUm--
