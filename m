Received: from eggs.gnu.org ([2001:4830:134:3::10]:44580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eguzM-0004Bf-W5
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:12:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eguzM-0003Ti-1O
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:11:56 -0500
References: <20180120154412.9990-1-mreitz@redhat.com>
	<20180120154412.9990-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <94fe98ba-1db0-61b2-3df6-7bc9db988885@redhat.com>
Date: Wed, 31 Jan 2018 10:11:46 -0600
MIME-Version: 1.0
In-Reply-To: <20180120154412.9990-3-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hBLZIUA5JBvA8V3Q78nhKuxLreGrGWi37"
Subject: Re: [Qemu-devel] [PATCH v2 2/6] qapi: Replace qobject_to_X(o) by
 qobject_to(o, X)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hBLZIUA5JBvA8V3Q78nhKuxLreGrGWi37
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <94fe98ba-1db0-61b2-3df6-7bc9db988885@redhat.com>
Subject: Re: [PATCH v2 2/6] qapi: Replace qobject_to_X(o) by qobject_to(o, X)
References: <20180120154412.9990-1-mreitz@redhat.com>
 <20180120154412.9990-3-mreitz@redhat.com>
In-Reply-To: <20180120154412.9990-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/20/2018 09:44 AM, Max Reitz wrote:
> This patch was generated using the following Coccinelle script:
>=20
> @@
> expression Obj;
> @@
> (
> - qobject_to_qnum(Obj)
> + qobject_to(Obj, QNum)
> |
> - qobject_to_qstring(Obj)
> + qobject_to(Obj, QString)
> |
> - qobject_to_qdict(Obj)
> + qobject_to(Obj, QDict)
> |
> - qobject_to_qlist(Obj)
> + qobject_to(Obj, QList)
> |
> - qobject_to_qbool(Obj)
> + qobject_to(Obj, QBool)
> )

Worth adding these to scripts/coccinelle/qobject.cocci?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--hBLZIUA5JBvA8V3Q78nhKuxLreGrGWi37
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpx6sIACgkQp6FrSiUn
Q2pe2ggAmip/HeQpz91iGQEgfZufTE4mCdNdVLghq9at4m4/dqYT7HQASwacwSbs
bwSW5sqkf19aZkOa6ZlDgwHkeWsU/LBFTWWSz1h5Fdx2IFpbk1otURwSE1KIo634
ttj0qYhPCTvmQm9VRDgg4xJeBT32fgnon/BUSo9My7w12i0+DhImkzn8R71zHs8Q
iTRv/gip0z43CB5F/nAdGnXEPf0kvJhPrDmzpxzYhabYIlVHIRxKL4xcWfBfbtwW
Oh2RmQqPtJFmsKyU3uETZWPO6w3EQ457kClswTWdS1JfX0l/+eEKdAPBLpCv6aNf
7FlPxjQAYqyYTAUdcPe/Br3cuyKq/Q==
=CZUy
-----END PGP SIGNATURE-----

--hBLZIUA5JBvA8V3Q78nhKuxLreGrGWi37--
