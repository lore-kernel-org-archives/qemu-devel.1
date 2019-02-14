Received: from eggs.gnu.org ([209.51.188.92]:51068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gu7Gg-0007i5-NU
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:00:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gu7Ay-0008OF-R9
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 21:55:02 -0500
References: <20190213232356.21034-1-jsnow@redhat.com>
	<20190213232356.21034-2-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7a33b8e6-95bb-e6d4-d4e7-8fd62d3400e0@redhat.com>
Date: Wed, 13 Feb 2019 20:54:38 -0600
MIME-Version: 1.0
In-Reply-To: <20190213232356.21034-2-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Byr68ZADeWltFnFF79cMOlHM7V5JQqhXX"
Subject: Re: [Qemu-devel] [PATCH v2 1/6] block/dirty-bitmap: add recording
 and busy properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, vsementsov@virtuozzo.com, Fam Zheng <fam@euphon.net>, libvir-list@redhat.com, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Byr68ZADeWltFnFF79cMOlHM7V5JQqhXX
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, vsementsov@virtuozzo.com,
 Fam Zheng <fam@euphon.net>, libvir-list@redhat.com,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <7a33b8e6-95bb-e6d4-d4e7-8fd62d3400e0@redhat.com>
Subject: Re: [PATCH v2 1/6] block/dirty-bitmap: add recording and busy
 properties
References: <20190213232356.21034-1-jsnow@redhat.com>
 <20190213232356.21034-2-jsnow@redhat.com>
In-Reply-To: <20190213232356.21034-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/13/19 5:23 PM, John Snow wrote:
> The current API allows us to report a single status, which we've define=
d as:
>=20
> Frozen: has a successor, treated as qmp_locked, may or may not be enabl=
ed.
> Locked: no successor, qmp_locked. may or may not be enabled.
> Disabled: Not frozen or locked, disabled.
> Active: Not frozen, locked, or disabled.
>=20
> The problem is that both "Frozen" and "Locked" mean nearly the same thi=
ng,
> and that both of them do not intuit whether they are recording guest wr=
ites
> or not.
>=20
> This patch deprecates that status field and introduces two orthogonal
> properties instead to replace it.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/dirty-bitmap.c       |  9 +++++++++
>  qapi/block-core.json       | 10 +++++++++-
>  qemu-deprecated.texi       |  6 ++++++
>  tests/qemu-iotests/236.out | 28 ++++++++++++++++++++++++++++
>  4 files changed, 52 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Byr68ZADeWltFnFF79cMOlHM7V5JQqhXX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxk2G4ACgkQp6FrSiUn
Q2rb/gf9GM0s9fQJZLjVWqZ3EKtCWLsgBY3zaCLOEXnSTm9aW+EQHod4gIBB0hlo
te7dr3/DlJl4uNGi0aMy6oyRVKP6UJLiJkwNr5LhwtGbeg5QiYc+4g6VngWLHyQ5
31GxgnEEox1l3j7+9q+gxonfndqvpQqjzbhPv68nZkGy22ZrNAWwzo/+NgicsglH
QuLFQ45TQDgk2tHg3uXP41tN0U2nIfz4/3zNdJ5Sth900pC/S655k2LbGuc/E3Yj
+WasxWaMkjz0XD4yA0bB0jNJcg1U4+dkzPzWG/fL0StAlrEmm78zNrGCeKVp3nPI
daD0jURhdsRFH2L1S7voGjHzMEUVyA==
=MbIs
-----END PGP SIGNATURE-----

--Byr68ZADeWltFnFF79cMOlHM7V5JQqhXX--
