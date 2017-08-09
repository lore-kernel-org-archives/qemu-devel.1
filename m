Received: from eggs.gnu.org ([2001:4830:134:3::10]:59067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfZJe-00060f-KS
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 18:19:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfZJd-00035h-Ah
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 18:19:02 -0400
References: <20170809215510.22802-1-pbonzini@redhat.com>
	<20170809215510.22802-2-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <eeba95b4-23a2-51da-2c41-be5ee262c965@redhat.com>
Date: Wed, 9 Aug 2017 17:18:54 -0500
MIME-Version: 1.0
In-Reply-To: <20170809215510.22802-2-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8Nh1FmRPxoeUxaIKUCkCW5kllMiXiW0us"
Subject: Re: [Qemu-devel] [PATCH 01/12] qemu-iotests: remove dead code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8Nh1FmRPxoeUxaIKUCkCW5kllMiXiW0us
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <eeba95b4-23a2-51da-2c41-be5ee262c965@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/12] qemu-iotests: remove dead code
References: <20170809215510.22802-1-pbonzini@redhat.com>
 <20170809215510.22802-2-pbonzini@redhat.com>
In-Reply-To: <20170809215510.22802-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/09/2017 04:54 PM, Paolo Bonzini wrote:
> This includes shell function, shell variables, command line options
> (randomize.awk does not exist) and conditions that can never be true
> (./qemu does not exist anymore).

Can we point to a commit id where we stopped making ./qemu?  Is it still
worth supporting a local symlink?

>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/qemu-iotests/check         | 36 +--------------------
>  tests/qemu-iotests/common        | 23 --------------
>  tests/qemu-iotests/common.config | 26 ---------------
>  tests/qemu-iotests/common.rc     | 68 --------------------------------=
--------
>  4 files changed, 1 insertion(+), 152 deletions(-)
>=20
> -#
> -# - These can be added to $HOST_CONFIG_DIR (witch default to ./config)=


Good riddance to the wrong word ('which' was intended)

Other than possibly still wanting ./qemu convenience, this looks like a
reasonable cleanup.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--8Nh1FmRPxoeUxaIKUCkCW5kllMiXiW0us
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmLik4ACgkQp6FrSiUn
Q2qQIQf+OnxtJM65NgyAW6CnJsbWT4jJErp4cdJyTdnwdjrBmLr/rmgcp+MNbik5
13fNFmS2LpJob7+wQb1zXHOwX4fD6TNmjJWIlHTK34a/8N79fNkcqPxc5dnwNscU
VSgTPfzxiIkd5tofh6tVi2uIfg8cO7kc1CU69YIDeU+7E0R/fL4FhBFyZZNFtlj6
ajDYJ7W7oIPqahKkc6GBiQ6OxHmhqSfm22CD6bKTS9200QYL1f9QwQCji7XW4uxD
z9Hp11htAv66Um3fFiNckmUMyoOvgFcAF+VVWiqO8yQDkkZAdGRwIGsSbUg5VFNL
/Rx94Hq0gF2/3PH1gQhMG25qjRyw0g==
=hEZi
-----END PGP SIGNATURE-----

--8Nh1FmRPxoeUxaIKUCkCW5kllMiXiW0us--
