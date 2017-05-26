Received: from eggs.gnu.org ([2001:4830:134:3::10]:48693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dEN8y-0006XV-RP
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:51:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dEN8x-0005jt-TM
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:51:36 -0400
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-9-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1c80010d-1131-2a8a-360c-b8414e310a2a@redhat.com>
Date: Fri, 26 May 2017 16:51:26 -0500
MIME-Version: 1.0
In-Reply-To: <1495830130-30611-9-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HgD7vgV1liBKWv6dkEOWV9LEPcv211dhL"
Subject: Re: [Qemu-devel] [PATCH 08/29] qed: Remove callback from
 qed_copy_from_backing_file()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HgD7vgV1liBKWv6dkEOWV9LEPcv211dhL
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 mreitz@redhat.com
Message-ID: <1c80010d-1131-2a8a-360c-b8414e310a2a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/29] qed: Remove callback from
 qed_copy_from_backing_file()
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
 <1495830130-30611-9-git-send-email-kwolf@redhat.com>
In-Reply-To: <1495830130-30611-9-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/26/2017 03:21 PM, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed.c | 57 +++++++++++++++++++++++------------------------------=
----
>  1 file changed, 23 insertions(+), 34 deletions(-)
>=20

>  /**
> - * Populate back untouched region of new data cluster
> + * Populate untouched regions of new data cluster
>   */
> -static void qed_aio_write_postfill(void *opaque, int ret)
> +static void qed_aio_write_cow(void *opaque, int ret)
>  {

It may be worth a mention in the commit message that you are renaming
things to use more common terminology in the process (in part because
you reduced a chained callback into one: qed_aio_write_alloc called
qed_aio_write_prefill called qed_aio_write_postfill).  Up to you.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--HgD7vgV1liBKWv6dkEOWV9LEPcv211dhL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZKKNeAAoJEKeha0olJ0NqiTYIAJjb1FbfI8qVgYCXUI1jwMBj
nDhFa35bm9HmqV7fNrwdQLuAsMJJ3TROOVnnB3MNr3HBjdsaUumBSueebD/WuQFu
FAZlCzKxeDbKESdVCI4BBl2rw2ZK61qpYe2tBorOlUbEph0fihbQDQ5o7eCkaa+q
xZuWKI+CbJIWViINBr3oz/PhlFGeF0Vs4yM48krR6UM5gReZFWnfN6PkDUYV5egJ
saHbNbThV7hjPi9/ZLQUZ+oN6qv1bJINS5nViwbJp1cMmyYaUhu01pomAPNNDvwz
rYIdJYVyPQ+yaFJjzB1WZM7GU1XKOBTX9c/Kx7do0smv43xCBh+/CauuFXkXJWo=
=VZlS
-----END PGP SIGNATURE-----

--HgD7vgV1liBKWv6dkEOWV9LEPcv211dhL--
