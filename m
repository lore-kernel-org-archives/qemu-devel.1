Received: from eggs.gnu.org ([2001:4830:134:3::10]:42490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddhyk-0006Ky-3I
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 15:09:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddhyj-00059w-4O
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 15:09:46 -0400
References: <20170804151013.13057-1-den@openvz.org>
	<20170804151013.13057-3-den@openvz.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0192e144-427d-1d18-bc4d-688efbf41ed0@redhat.com>
Date: Fri, 4 Aug 2017 14:09:33 -0500
MIME-Version: 1.0
In-Reply-To: <20170804151013.13057-3-den@openvz.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="g3keFi2atFogjuiTEVdlak6RhUepvIotb"
Subject: Re: [Qemu-devel] [PATCH 2/3] parallels: respect error code of
 bdrv_getlength() in allocate_clusters()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g3keFi2atFogjuiTEVdlak6RhUepvIotb
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <0192e144-427d-1d18-bc4d-688efbf41ed0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] parallels: respect error code of
 bdrv_getlength() in allocate_clusters()
References: <20170804151013.13057-1-den@openvz.org>
 <20170804151013.13057-3-den@openvz.org>
In-Reply-To: <20170804151013.13057-3-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/04/2017 10:10 AM, Denis V. Lunev wrote:
> If we can not get the file length, the state of BDS is broken completel=
y.
> Return error to the caller.
>=20
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/parallels.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--g3keFi2atFogjuiTEVdlak6RhUepvIotb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmExm0ACgkQp6FrSiUn
Q2rDkgf9GJB6g6ge8fhFT5tVmnEeNLJhR5PrQNJLiD5uZGJSJbsW0FmnIhpcIxvI
GqX3YXXvJ0Pxoo5G+uAOZeVMlqB0Cv38Q6cBdrTNrpCQbx1rWPPnxUbpgmLc+WgF
kQxCBgJNndDexm3YMVlqpfDzsjAqpufEx6Ao6GnYli0H9Qc5emb8oztVXGEJse9D
UMmtTR+vgj80zkHamCsWzy27SAIY3XC6W6EKGuRnG5ZezzRcq1M+sMMgX9iv0SF9
VdnwA6xPQ4GimnUTCJBkp3p1GdwVWvcXApY8IQysIobXOvNRpcpX06hNvW09hMny
4UPn5yNJ5VyY6d9TSqt0VoZGRa5X6g==
=FJnt
-----END PGP SIGNATURE-----

--g3keFi2atFogjuiTEVdlak6RhUepvIotb--
