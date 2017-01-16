Received: from eggs.gnu.org ([2001:4830:134:3::10]:44500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTE95-0005QF-OW
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:44:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTE94-0002Va-UZ
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:44:51 -0500
References: <20170113205237.30386-1-mreitz@redhat.com>
	<20170113205237.30386-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a9a5704a-ffee-bf65-e7d2-dce528fba302@redhat.com>
Date: Mon, 16 Jan 2017 14:44:44 -0600
MIME-Version: 1.0
In-Reply-To: <20170113205237.30386-2-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UQFpXmtdJ3TPa1XNnMJvlx6uwHQtPexov"
Subject: Re: [Qemu-devel] [PATCH v6 1/9] block: Always set *file in
 get_block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UQFpXmtdJ3TPa1XNnMJvlx6uwHQtPexov
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <a9a5704a-ffee-bf65-e7d2-dce528fba302@redhat.com>
Subject: Re: [PATCH v6 1/9] block: Always set *file in get_block_status
References: <20170113205237.30386-1-mreitz@redhat.com>
 <20170113205237.30386-2-mreitz@redhat.com>
In-Reply-To: <20170113205237.30386-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/13/2017 02:52 PM, Max Reitz wrote:
> *file should always be set (to NULL, if nothing else) instead of leavin=
g
> it dangling sometimes. This should also be documented so callers can
> rely on this behavior.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/io.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--UQFpXmtdJ3TPa1XNnMJvlx6uwHQtPexov
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYfTC8AAoJEKeha0olJ0NqZuwH/3cqn9+lTBOLIUoCP2ofx1jd
Aq5WV1zjb6bIpcXaS9Ex60RshwldE1fWAKU55r9LXLyPfXXqtDsMPiQwbgKZgs+O
zuBt1ENF+FxjC6BLLUFsHGhbUWwUn0L4aD5XNatuTZ10SHT6aNb/dgddCVmcl3Qi
uINksa4RWy+LQx1m+rmmUC0IBTRUA4O2hrUtOh63xwA6pvUh8ER/iANJMM7GynX+
7AA9du1bmteTEO/2jdMl3yXHsAuPAGd/UbLKK7hoKYJgUOrDVl/TBDDt7RIytRIz
N+DiGYP8beUF/tTh6feNXqe69BWF5/999IWEi4ivZBvTDsCfMxWBuXkSkLt6y6s=
=SWeM
-----END PGP SIGNATURE-----

--UQFpXmtdJ3TPa1XNnMJvlx6uwHQtPexov--
