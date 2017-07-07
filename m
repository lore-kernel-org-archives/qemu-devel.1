Received: from eggs.gnu.org ([2001:4830:134:3::10]:51241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTa5b-00020w-J1
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 16:43:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTa5a-0002sL-OR
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 16:42:59 -0400
References: <20170707203049.534-1-eblake@redhat.com>
	<20170707203049.534-7-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <606ef9a2-3f54-86f4-b07e-ceed58ff4ac6@redhat.com>
Date: Fri, 7 Jul 2017 15:42:48 -0500
MIME-Version: 1.0
In-Reply-To: <20170707203049.534-7-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7eM3hJWpoUN2ptla8BVWN9PuI4Omo5PNK"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 6/9] nbd: Implement
 NBD_OPT_GO on server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com, qemu-block@nongnu.org, marcandre.lureau@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7eM3hJWpoUN2ptla8BVWN9PuI4Omo5PNK
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com,
 qemu-block@nongnu.org, marcandre.lureau@redhat.com
Message-ID: <606ef9a2-3f54-86f4-b07e-ceed58ff4ac6@redhat.com>
Subject: Re: [Qemu-block] [PATCH v5 6/9] nbd: Implement NBD_OPT_GO on server
References: <20170707203049.534-1-eblake@redhat.com>
 <20170707203049.534-7-eblake@redhat.com>
In-Reply-To: <20170707203049.534-7-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/07/2017 03:30 PM, Eric Blake wrote:
> NBD_OPT_EXPORT_NAME is lousy: per the NBD protocol, any failure
> requires us to close the connection rather than report an error.
> Therefore, upstream NBD recently added NBD_OPT_GO as the improved
> version of the option that does what we want [1], along with
> NBD_OPT_INFO that returns the same information but does not
> transition to transmission phase.
>=20
> [1] https://github.com/NetworkBlockDevice/nbd/blob/extension-info/doc/p=
roto.md

Unless review turns up a reason for me to respin, I will update this URL
to the point where the extension was merged into mainline NBD:

https://github.com/NetworkBlockDevice/nbd/commit/e6b56c12f8

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--7eM3hJWpoUN2ptla8BVWN9PuI4Omo5PNK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZX/JIAAoJEKeha0olJ0NqlfAH/i52yZm/D3I0kSnjkhJ4Gq9Y
wUKli15CcCyt9cdSvjxsQ6p5OqiQ7rqiOcjV3J3zfyLJzHoXXjk9ZDOl/P9TerNw
0Ln/0jf7q6J/HbB58NaCPBXyzuxfO1q1YHUCxocE/nK3LCg8i09jJXjQyEP2aJi8
agyAWqGRL+TImKywKZTRu2qJsplZcUnIBKEE/u7nLgOoh4kBAEDt5gnXu+AcBUqG
KS0P297Uk0CbhtjijbFbXrmSkTVs+c8AOjsT176Vp5MexIgwRfZSpKRf2YMV0AXa
9iYvpkwZw/s1AOx9GWf7zgaN/OGf5Sb/ysS4/OOk8yxSOj5weiKv/q47qkfXeGM=
=7/Ag
-----END PGP SIGNATURE-----

--7eM3hJWpoUN2ptla8BVWN9PuI4Omo5PNK--
