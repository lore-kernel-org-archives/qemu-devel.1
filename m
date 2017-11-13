Received: from eggs.gnu.org ([2001:4830:134:3::10]:48107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEJLy-0000S1-0N
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 13:21:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEJLx-0001qq-7a
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 13:21:02 -0500
References: <20171112013936.5942-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bd0484db-8eba-3cb3-9920-087c9b8474cf@redhat.com>
Date: Mon, 13 Nov 2017 12:20:49 -0600
MIME-Version: 1.0
In-Reply-To: <20171112013936.5942-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SDnmUExEqls0kOD8TL1IKwasJLWlWoWWF"
Subject: Re: [Qemu-devel] [PATCH for-2.11] nbd: Don't crash when server
 reports NBD_CMD_READ failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SDnmUExEqls0kOD8TL1IKwasJLWlWoWWF
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <bd0484db-8eba-3cb3-9920-087c9b8474cf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11] nbd: Don't crash when server
 reports NBD_CMD_READ failure
References: <20171112013936.5942-1-eblake@redhat.com>
In-Reply-To: <20171112013936.5942-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/11/2017 07:39 PM, Eric Blake wrote:
> If a server fails a read, for example with EIO, but the connection
> is still live, then we would crash trying to print a non-existent
> error message.  Bug introduced in commit f140e300.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/nbd-client.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Queued on my NBD tree; will be in 2.11 (I may do another pull request
prior to -rc1, otherwise it will be -rc2).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--SDnmUExEqls0kOD8TL1IKwasJLWlWoWWF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloJ4oEACgkQp6FrSiUn
Q2q+zggAk0eaLqBwSRNrtY+GS0MJYeQkCl/T25t05T/bfv9xyUG1SNlTURo9NeBl
iz+IUKXkoEhpbZpvkR/ZTUaR8UhG9YKFncq00W0KQIJ/7qdNrPe3l6v+6GGrE/+H
h6FHaHTyLZvupW8XG7YJEaIIOeZmVWK6Sr6PGb3lbUXdcf526t2T33WaBUQD4vMH
uQ+1vboSOdewYOVHErgx5eX29KghTT94mOVwZWkBp4SyqFYT9QlszXSoxQ1aDGyF
pitSdvhguSisWNYpgRcXPyY2w45lLvBxdETN1kmvP8soROrnFWLwppQiGVoPlSqL
EMCRoNVP1q439kZgsTeKYSdc5h50aA==
=xdbv
-----END PGP SIGNATURE-----

--SDnmUExEqls0kOD8TL1IKwasJLWlWoWWF--
