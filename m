Received: from eggs.gnu.org ([2001:4830:134:3::10]:43773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef9q1-0004nI-V9
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 14:39:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef9q1-0000Qt-0v
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 14:39:01 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<0c81220cf2141a5b720629fb6eaff04f833e77a4.1516978645.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6255be09-1726-6be8-b588-28b16ec0e913@redhat.com>
Date: Fri, 26 Jan 2018 13:38:51 -0600
MIME-Version: 1.0
In-Reply-To: <0c81220cf2141a5b720629fb6eaff04f833e77a4.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5k1gsm0nsuteOA5aUN0FhAwrVYjqGcmoU"
Subject: Re: [Qemu-devel] [PATCH v3 26/39] qcow2: Prepare
 qcow2_update_snapshot_refcount() for adding L2 slice support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5k1gsm0nsuteOA5aUN0FhAwrVYjqGcmoU
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <6255be09-1726-6be8-b588-28b16ec0e913@redhat.com>
Subject: Re: [PATCH v3 26/39] qcow2: Prepare qcow2_update_snapshot_refcount()
 for adding L2 slice support
References: <cover.1516978645.git.berto@igalia.com>
 <0c81220cf2141a5b720629fb6eaff04f833e77a4.1516978645.git.berto@igalia.com>
In-Reply-To: <0c81220cf2141a5b720629fb6eaff04f833e77a4.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/26/2018 08:59 AM, Alberto Garcia wrote:
> Adding support for L2 slices to qcow2_update_snapshot_refcount() needs
> (among other things) an extra loop that iterates over all slices of
> each L2 table.
>=20
> Putting all changes in one patch would make it hard to read because
> all semantic changes would be mixed with pure indentation changes.
>=20
> To make things easier this patch simply creates a new block and
> changes the indentation of all lines of code inside it. Thus, all
> modifications in this patch are cosmetic. There are no semantic
> changes and no variables are renamed yet. The next patch will take
> care of that.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-refcount.c | 140 ++++++++++++++++++++++++++---------------=
--------
>  1 file changed, 73 insertions(+), 67 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--5k1gsm0nsuteOA5aUN0FhAwrVYjqGcmoU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlprg8sACgkQp6FrSiUn
Q2qAJAgAjSplouTkEa3HLn46czWuibIG9fS/Myct6uYytZ9KMorhBeEm0lPvfUdu
CePpp01lQPRUBq6a6u5482U/dbXabcWCuF0SaRnxpRoFRJSbBpDdXTGT3xttnf5/
yzb8YUPI3aE4IoMalu5d/Awpz6cgYD4Ch2js6SMSLkfuq4X4AbJ2tCpD/U6pjdIf
g5L4JmN0FKTyrSPsIJHciSumXsawuYI7/1ILOhAMGnSloWT+aiaYaPh7W19a/iUs
mFxj2winuVPHEHNXtGL2ZPnUhx7MJDh6jKWSfCs6SPlbpdumYFCuzUUNXID7ECwR
E1OIQnLjUvvNJc0xh++gMu+CctYUXw==
=eCRu
-----END PGP SIGNATURE-----

--5k1gsm0nsuteOA5aUN0FhAwrVYjqGcmoU--
