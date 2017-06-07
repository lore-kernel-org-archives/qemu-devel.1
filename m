Received: from eggs.gnu.org ([2001:4830:134:3::10]:43515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dId4H-0006YC-R5
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:40:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dId4D-0007k8-7H
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:40:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6641)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dId4D-0007j4-0y
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:40:17 -0400
References: <20170607130619.1545-1-el13635@mail.ntua.gr>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b1464fa9-84fe-780c-ea32-bbaa631b1d8f@redhat.com>
Date: Wed, 7 Jun 2017 10:40:08 -0500
MIME-Version: 1.0
In-Reply-To: <20170607130619.1545-1-el13635@mail.ntua.gr>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BN0oHehCM7tjVPxdeFqKJOjg5BiFHhPma"
Subject: Re: [Qemu-devel] [PATCH RFC] block: add throttle block filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@gmail.com, berto@igalia.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BN0oHehCM7tjVPxdeFqKJOjg5BiFHhPma
From: Eric Blake <eblake@redhat.com>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@gmail.com, berto@igalia.com
Message-ID: <b1464fa9-84fe-780c-ea32-bbaa631b1d8f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] block: add throttle block filter driver
References: <20170607130619.1545-1-el13635@mail.ntua.gr>
In-Reply-To: <20170607130619.1545-1-el13635@mail.ntua.gr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/07/2017 08:06 AM, Manos Pitsidianakis wrote:
> This is part of my work for my GSOC project this summer.=20
>=20
> I am not sure if the count parameter in  bdrv_co_pwrite_zeros and=20
> bdrv_co_pdiscard refers to sectors or bytes.

Both refer to byte counts.  (We're trying to get rid of as many
sector-based interfaces as possible, but it's slow going to make sure
the conversions are still accurate).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BN0oHehCM7tjVPxdeFqKJOjg5BiFHhPma
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOB5YAAoJEKeha0olJ0NqJkUIAK+XYr0o3aeWzj9XEXN/owGU
AFIPoXKh3qAwcj/yD80agnVpi2DTj6U2ob3wwN7N78gCH6tdpceHWdBekv3mrlyh
ZlF0FUx0Fbig+EnFWMn+tfYGGO7hZaTNaSC3K7desjqR5yvp1fZfNbxBug1Rxaqq
ffal9IV88o6ekhCgeLdPdlijK4hxwY/C9gSb0tuGz4jHSmyG2Z4n/KAtwaT3cfh4
rMTPpyyjMBHGfVteSLC85Wpdzef5m0gbqnTmtg60xazR1H/VG40E/IXcKLyN++e0
y4OX+6SmBZykiD2WCoMqhzYenbLOdpDNWaA/EvXoPHAj03BsZ6ExAW2OoMJoIq0=
=vo8A
-----END PGP SIGNATURE-----

--BN0oHehCM7tjVPxdeFqKJOjg5BiFHhPma--
