Received: from eggs.gnu.org ([2001:4830:134:3::10]:36719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRJfW-00086I-1N
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 09:14:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRJfS-0007aZ-1T
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 09:14:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cRJfR-0007aC-Ob
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 09:14:21 -0500
References: <148412457273.22750.983275587432075569.stgit@bahia>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fb7cb500-647e-ae96-d8a7-b124666b6c53@redhat.com>
Date: Wed, 11 Jan 2017 08:14:18 -0600
MIME-Version: 1.0
In-Reply-To: <148412457273.22750.983275587432075569.stgit@bahia>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MNbCEtXHN9t98CD9RHmPS8I0XDWJuPanv"
Subject: Re: [Qemu-devel] [PATCH] libqtest: handle zero length
 memwrite/memread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MNbCEtXHN9t98CD9RHmPS8I0XDWJuPanv
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <fb7cb500-647e-ae96-d8a7-b124666b6c53@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] libqtest: handle zero length
 memwrite/memread
References: <148412457273.22750.983275587432075569.stgit@bahia>
In-Reply-To: <148412457273.22750.983275587432075569.stgit@bahia>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2017 02:49 AM, Greg Kurz wrote:
> Some recently added tests pass a zero length to qtest_memwrite().
> Unfortunately, the qtest protocol doesn't implement an on-the-wire
> syntax for zero-length writes and the current code happily sends
> garbage to QEMU. This causes intermittent failures.
>=20
> It isn't worth the pain to enhance the protocol, so this patch
> simply fixes the issue by "just return, doing nothing". The same
> fix is applied to qtest_memread() since the issue also exists in
> the QEMU part of the "memread" command.
>=20
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  qtest.c          |    2 ++
>  tests/libqtest.c |   12 +++++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--MNbCEtXHN9t98CD9RHmPS8I0XDWJuPanv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYdj26AAoJEKeha0olJ0Nqe/EIAJuxpTGbpKVc/kovt9a/VTnZ
kQ561TZqc/mD7OwxMZ1UOeixZYAqGOEw3YWm2QAQtqDHfs7sadUh/jeBrwS4UDiN
OFcOgMrv1xgH6mjxyxrmb3yv5drEfCH5jB/7rvQsmezUIB9URoct94lofB88kIAg
so9nxUuYPbm/AP9QrCrvz8l6a0fhqhhJnMorJDiDpHx5G32BWGK7hAfifwlLzFCb
sdt4fjJgfup0gXp7RlUeLSPZieWP4c0/BdDxHphFru6Fchzd6CZjiptP79IZSWnl
RRqr9aGzRjbt6Dhp4ihVBTLaIvageux+piyiaA9krtwOHBLhIzr6IjaM97igrZo=
=CCrC
-----END PGP SIGNATURE-----

--MNbCEtXHN9t98CD9RHmPS8I0XDWJuPanv--
