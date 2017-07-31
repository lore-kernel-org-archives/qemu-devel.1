Received: from eggs.gnu.org ([2001:4830:134:3::10]:40281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcG5w-0005KY-Cz
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 15:11:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcG5v-0006rv-Fx
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 15:11:12 -0400
References: <1501518125-29851-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1501518125-29851-5-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fd53908c-006c-4c8e-e7aa-388bd832e642@redhat.com>
Date: Mon, 31 Jul 2017 14:11:01 -0500
MIME-Version: 1.0
In-Reply-To: <1501518125-29851-5-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ujtA0stXjSv6A3AWHdvmL6Jhp9GRTsC1b"
Subject: Re: [Qemu-devel] [PATCH v3 04/13] block: support BDRV_REQ_ALLOCATE
 in passthrough drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ujtA0stXjSv6A3AWHdvmL6Jhp9GRTsC1b
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, kwolf@redhat.com,
 mreitz@redhat.com
Message-ID: <fd53908c-006c-4c8e-e7aa-388bd832e642@redhat.com>
Subject: Re: [PATCH v3 04/13] block: support BDRV_REQ_ALLOCATE in passthrough
 drivers
References: <1501518125-29851-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1501518125-29851-5-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1501518125-29851-5-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/31/2017 11:21 AM, Anton Nefedov wrote:
> Support the flag if the underlying BDS supports it
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  block/blkdebug.c   | 3 ++-
>  block/raw-format.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)

What about blkverify, commit, and mirror?  Should they also pass through
various flags?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ujtA0stXjSv6A3AWHdvmL6Jhp9GRTsC1b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll/gMUACgkQp6FrSiUn
Q2r9lggAlOJwbL/w0Uw6YT0oZUD+TuqlfEySLnA5zPzn15WgYcIqb8tptUmCCV4l
2blvjnGvyXDqXc60aMNHE6pR8weHBs9AXLxkKNudpkwlDtg4iXW+qb/9xvVNLXuB
kctEdsSZayjEDa+DlOwXiKSlfl4P/jpgufQGqw7B9Ruhcpu805ghSu5Vc4/z4dl6
dtluETWm43bd1T5M13NkK13o5U8/ykMVtU4k619Xx51JE53rQ+sWrvf/eqJstS5R
DrlLkUm2LJx+zcbs9KvnuURjj9h8r8V97zlYAVYwRlNnQGGqU0d5ADLCXoS1moFK
WpdPoV0diGGzo0O2hN1AHScvIDK9CQ==
=6mcM
-----END PGP SIGNATURE-----

--ujtA0stXjSv6A3AWHdvmL6Jhp9GRTsC1b--
