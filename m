Received: from eggs.gnu.org ([2001:4830:134:3::10]:47199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f5Qs7-0002NB-RI
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 03:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f5Qs3-0002Xv-SR
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 03:05:47 -0400
Received: from mail-pl0-x234.google.com ([2607:f8b0:400e:c01::234]:34888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1f5Qs3-0002XJ-Lu
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 03:05:43 -0400
Received: by mail-pl0-x234.google.com with SMTP id 61-v6so4589038plb.2
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 00:05:43 -0700 (PDT)
Date: Mon, 9 Apr 2018 15:05:39 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180409070539.GF4848@stefanha-x1.localdomain>
References: <20180408030542.17855-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tmoQ0UElFV5VgXgH"
Content-Disposition: inline
In-Reply-To: <20180408030542.17855-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] iotests: fix wait_until_completed()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>


--tmoQ0UElFV5VgXgH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 08, 2018 at 11:05:42AM +0800, Peter Xu wrote:
> If there are more than one events, wait_until_completed() might return
> the 2nd event even if the 1st event is JOB_COMPLETED, since the for loop
> will continue to run even if completed is set to True.
>=20
> It never happened before, but it can be triggered when OOB is enabled
> due to the RESUME startup message. Fix that up.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--tmoQ0UElFV5VgXgH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJayxDDAAoJEJykq7OBq3PIdDQIAJR7kM4AR4Di+7qQIHSwbzHv
VPGks2DXDAi8SAuTHJav0OQer5CrPM+jVgOL5Ghl1PHlJ+OjV4r3Up3CBP67/fYk
WF4j6Tq9YIQ3xgoDbIpv2Jp08vik8Nxk7GqT60HTygFNsr1Zl97jLXBhGYX2Vzhg
CybCI+10jWfdaJWoq9QIXHHoVXtCSJ/vfD1TQlCn63IRdfFbrQlQYZGf76+qwYYi
8ocUTuXVW/u2lFZ3bWIvoTAmHtFIPe+swcz+Djl2opv13zajGRALunwj4idGF1C8
qSLEmlTU9JNeZgJaoe+NpR5Elaqbw/AHM6CdNpyt/TU9Ubij+S/3N0IuSmEbAek=
=MwWe
-----END PGP SIGNATURE-----

--tmoQ0UElFV5VgXgH--
