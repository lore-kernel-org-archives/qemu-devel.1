Received: from eggs.gnu.org ([2001:4830:134:3::10]:56346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqNxT-0000a2-Ad
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqNxP-0003Cg-W5
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:52:35 -0400
References: <20170317021739.16877-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1b5a71f6-6038-ac18-a3af-b2b75a4fd8ae@redhat.com>
Date: Tue, 21 Mar 2017 12:52:22 -0500
MIME-Version: 1.0
In-Reply-To: <20170317021739.16877-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7Q9hpVOUnAJt4UNbal6mUg0OfBncTEHUl"
Subject: Re: [Qemu-devel] [PATCH] block: Make 'replication_state' an enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7Q9hpVOUnAJt4UNbal6mUg0OfBncTEHUl
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Message-ID: <1b5a71f6-6038-ac18-a3af-b2b75a4fd8ae@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: Make 'replication_state' an enum
References: <20170317021739.16877-1-famz@redhat.com>
In-Reply-To: <20170317021739.16877-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/16/2017 09:17 PM, Fam Zheng wrote:
> BDRVReplicationState.replication_state is a name with a bit of
> duplication, plus it could be an enum like BDRVReplicationState.mode,
> which is be more readable and also more straightforward in a debuuger.

With the followup commit message cleanups,

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> Rename it, and improve the type while at it.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/replication.c | 44 ++++++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--7Q9hpVOUnAJt4UNbal6mUg0OfBncTEHUl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0WhWAAoJEKeha0olJ0NqakkH/1GnCSUhGWTKVWEHHfFFxcU6
7kyh+/MmADuliF2AgbJ8smfDx5Q1nM4/KHTDqvVPKhM/xZcARPBotxnYvtzl3D12
MXUyrf7AoXWxucTYCLxRBLEd2BlcDYPRktzrQiqXs8CYEkRyvjH9hTkb+GwBSqEp
6Aydwppabr1FvWyiHUVX7NT8p75wD5PmULTc0a1LIIyHTAA8EvEP78YX1dTHx7Vb
n84/7zXW4bzqjGAjqHvsXd+2pQ4BEapayzv286AGDX6vVBs1Fornh7J8jV7XpM3e
L1nP2yQQJ/LH1kD3su5S9+zbwvDXwaSp5mcVdycmgUz5eLq5vXG80hJ2piKaDEM=
=Wz62
-----END PGP SIGNATURE-----

--7Q9hpVOUnAJt4UNbal6mUg0OfBncTEHUl--
