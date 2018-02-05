Received: from eggs.gnu.org ([2001:4830:134:3::10]:46361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1einov-0003UD-6i
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 15:56:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1einou-0007jH-8O
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 15:56:57 -0500
References: <20180205202232.19254-1-mreitz@redhat.com>
	<20180205204655.GQ2787@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <274e6e09-ff44-f8e0-b185-4247db58e5d6@redhat.com>
Date: Mon, 5 Feb 2018 21:56:47 +0100
MIME-Version: 1.0
In-Reply-To: <20180205204655.GQ2787@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="srb7kVrU8OvO7okW6h2aN09yoceMxWxYi"
Subject: Re: [Qemu-devel] [PATCH 0/2] block/ssh: Implement
 .bdrv_refresh_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--srb7kVrU8OvO7okW6h2aN09yoceMxWxYi
From: Max Reitz <mreitz@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Jeff Cody
 <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <274e6e09-ff44-f8e0-b185-4247db58e5d6@redhat.com>
Subject: Re: [PATCH 0/2] block/ssh: Implement .bdrv_refresh_filename()
References: <20180205202232.19254-1-mreitz@redhat.com>
 <20180205204655.GQ2787@redhat.com>
In-Reply-To: <20180205204655.GQ2787@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-05 21:46, Richard W.M. Jones wrote:
>=20
> I assume the context of all this is making relative backing file names =
work
> in qcow2 files?

Yes, mostly.  (https://bugzilla.redhat.com/show_bug.cgi?id=3D1528931)
But it's generally nice for block nodes to print a readable filename
when queried and not a json:{} monster all of the time.

Max


--srb7kVrU8OvO7okW6h2aN09yoceMxWxYi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp4xQ8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A7wwH/2mPnBFLOm2Nt7KMVRfmGRAo4SA01/wx
PjJHIwT4CAz/4j4+6oCPKGEuDNrPjRo1IKNZGQJZxIfOuMVwLFM7ATbcWLgaAKco
xJOvTNJtEZINXTZsTxLS5dJrgPABqrMV7MZi4bHQuorsZGFXbNR++yW0hmHYj1yw
dNcZ5ZEMTF3zq+xMN6++6SnH6albC6potSzOUpV9q3EX+2JIr4Ce6q4aTkzWX/at
YctjuYxcp9dMyB61WhJNefkL2/AjNH0lAr8tRWdRHXl28sg3mwaom8/3Rrq/Y5OJ
NbppO87oL/X3hrUOJsSEVwn/m7BkXpWjzanZ0DO7haStV4jxOtgkvas=
=Uj2a
-----END PGP SIGNATURE-----

--srb7kVrU8OvO7okW6h2aN09yoceMxWxYi--
