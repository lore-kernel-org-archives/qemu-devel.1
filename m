Received: from eggs.gnu.org ([2001:4830:134:3::10]:51056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxvh3-0001qA-9B
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxvh2-0007Du-An
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:18:49 -0400
References: <20170410075451.21329-1-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <27018f96-0801-d9f5-50cb-6fb7af9ba2bc@redhat.com>
Date: Tue, 11 Apr 2017 15:18:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170410075451.21329-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iCmHtrrKHd5hBIjjGGtph7CEF3oMoolT1"
Subject: Re: [Qemu-devel] [PATCH for-2.9] iscsi: Fix iscsi_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iCmHtrrKHd5hBIjjGGtph7CEF3oMoolT1
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org,
 Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <27018f96-0801-d9f5-50cb-6fb7af9ba2bc@redhat.com>
Subject: Re: [PATCH for-2.9] iscsi: Fix iscsi_create
References: <20170410075451.21329-1-famz@redhat.com>
In-Reply-To: <20170410075451.21329-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.04.2017 09:54, Fam Zheng wrote:
> Since d5895fcb (iscsi: Split URL into individual options), creating
> qcow2 image on an iscsi LUN fails:
>=20
>     qemu-img create -f qcow2 iscsi://$SERVER/$IQN/0 1G
>     qemu-img: iscsi://$SERVER/$IQN/0: Could not create image: Invalid
>         argument
>=20
> The problem is iscsi_open now expects that transport_name, portal and
> target are already parsed into structured options by
> iscsi_parse_filename, but it is not called in iscsi_create.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/iscsi.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Thanks, dropped the qdict_put() for "filename" and applied to my block
branch:

https://github.com/XanClic/qemu/commits/block

Max


--iCmHtrrKHd5hBIjjGGtph7CEF3oMoolT1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljs16sSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A7fgIAJmcYzHldAewwCZDMFyQDgf/idDiJ/no
1tIsQ85VDpzFxCPeXPWIN89frjxAPIpVhXQxmdt9PWM11Xs8Vvp09ZwP/obxT9cM
NAdBER9DFrd/TuurHb/OorGziCMenEwMECLpyXQX76xywR5Wz4xXI2VzFGR8WlLj
UsWjGDhdLnAVQM0XK1P0JFaK7J6SiwUUfZoPQNrCdCNurR61ergJoezRUU+Mwu5z
982uFcveVTPyGScXTCBlYsWdAHnCwlXv1F3W8PIa1ciSqgGJhE/J9llfjfscIiTX
ScZxPTAAyiIsuN1OiQfpYDv4XElWTvrFkHWddQGVX6ftqB9rK66+460=
=9xND
-----END PGP SIGNATURE-----

--iCmHtrrKHd5hBIjjGGtph7CEF3oMoolT1--
