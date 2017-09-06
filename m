Received: from eggs.gnu.org ([2001:4830:134:3::10]:36880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dphpF-0005b7-9m
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 17:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dphpE-00078t-EF
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 17:25:33 -0400
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-15-eblake@redhat.com>
	<8064a471-f2ff-63e4-c90d-ebf3ca4e33cd@redhat.com>
	<a91fb46c-0044-3fcc-70a7-60f186a37c9f@redhat.com>
	<5b39beb0-530e-cc63-2917-cd121d515ee3@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ce91b2df-8bde-e785-8f2d-1f9862bd9501@redhat.com>
Date: Wed, 6 Sep 2017 16:25:20 -0500
MIME-Version: 1.0
In-Reply-To: <5b39beb0-530e-cc63-2917-cd121d515ee3@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PlrwnWGCTkpMbWE9IuBitJlwUEg542AtD"
Subject: Re: [Qemu-devel] [PATCH v6 14/29] libqos: Use explicit QTestState
 for fw_cfg operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: "open list:IDE" <qemu-block@nongnu.org>, Alexander Graf <agraf@suse.de>, armbru@redhat.com, "open list:sPAPR" <qemu-ppc@nongnu.org>, pbonzini@redhat.com, John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PlrwnWGCTkpMbWE9IuBitJlwUEg542AtD
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: "open list:IDE" <qemu-block@nongnu.org>, Alexander Graf <agraf@suse.de>,
 armbru@redhat.com, "open list:sPAPR" <qemu-ppc@nongnu.org>,
 pbonzini@redhat.com, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Message-ID: <ce91b2df-8bde-e785-8f2d-1f9862bd9501@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 14/29] libqos: Use explicit QTestState for
 fw_cfg operations
References: <20170901180340.30009-1-eblake@redhat.com>
 <20170901180340.30009-15-eblake@redhat.com>
 <8064a471-f2ff-63e4-c90d-ebf3ca4e33cd@redhat.com>
 <a91fb46c-0044-3fcc-70a7-60f186a37c9f@redhat.com>
 <5b39beb0-530e-cc63-2917-cd121d515ee3@redhat.com>
In-Reply-To: <5b39beb0-530e-cc63-2917-cd121d515ee3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/06/2017 04:10 PM, Eric Blake wrote:
>> I'm not a fan of including header files from other header files, so
>> changing the include order in the .c files sounds like the better
>> solution to me.
>=20
> Eww. I like headers to be self-contained.  Other than stuff we get from=

> osdep.h (which we know is included by EVERY .c file), I prefer that if =
a
> header uses another type, then it guarantees that an idempotent
> inclusion of a header that declares that type is also present in the
> header file, rather than forcing .c files to know which order to includ=
e
> things in.

The qemu tree-wide policy appears to be that a header should be
self-contained (order of inclusion in .c files shouldn't matter).  Also,
if header A only uses 'SomeType *', it can either get the definition of
SomeType from header B, or we can add the typedef to typedef.h at which
point both header A and B get the typedef from there (that is, typedef.h
is great for breaking what would otherwise be cyclic inclusion of
mutually-recursive types across different headers, as well as a way to
speed up compilation when a typedef is sufficient rather than a full
definition).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PlrwnWGCTkpMbWE9IuBitJlwUEg542AtD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmwZ8AACgkQp6FrSiUn
Q2r3Hgf+Nl41pepCki7NpI/QbVq0bssV7vJz38Ab4bp8d1io21mkg87Y3VL6ajKa
RVn4C5lT6Wx+iUe3v0JLHOE1ALg21HqY3DVVg4tUfOckpqLjCA/yuguZ8zn9nZgn
+JMx9NBXh666+mjTgsW3gz+K2JGCMvMkHcw8VW0T4eW2A5ykJK5Lc2J2qkWNbNg8
NRqKrXmc4CoJJUj4CyhlfWXN+Sh0iHBwCL1eHmIZqwu38LPD6T3mP4HYhIatjDgM
mAEjhP/42Mmhc6VwxpYaIVVRu7aQ0u/XqMwi2rz6ed3tsD/tvhj4ONALq21wlJBZ
KnBDODLovs1bM6ObDcT6n0YN89aGYA==
=rxd+
-----END PGP SIGNATURE-----

--PlrwnWGCTkpMbWE9IuBitJlwUEg542AtD--
