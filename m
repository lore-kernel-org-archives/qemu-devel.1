Received: from eggs.gnu.org ([2001:4830:134:3::10]:59578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eqjAz-0003LB-H2
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:36:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eqjAv-0003Gz-Ix
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:36:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54750 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eqjAv-0003Go-Ee
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:36:25 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 07E5387ABA
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 17:36:25 +0000 (UTC)
Received: from localhost (ovpn-117-84.ams2.redhat.com [10.36.117.84])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A8AEC111DCF0
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 17:36:24 +0000 (UTC)
Date: Tue, 27 Feb 2018 17:36:23 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180227173623.GK32480@stefanha-x1.localdomain>
References: <20180222163901.14095-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Tv3+oRj6D9L8lW+H"
Content-Disposition: inline
In-Reply-To: <20180222163901.14095-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] simpletrace: fix timestamp argument type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org


--Tv3+oRj6D9L8lW+H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2018 at 04:39:01PM +0000, Stefan Hajnoczi wrote:
> The timestamp argument to a trace event method is documented as follows:
>=20
>   The method can also take a timestamp argument before the trace event
>   arguments:
>=20
>     def runstate_set(self, timestamp, new_state):
>         ...
>=20
>   Timestamps have the uint64_t type and are in nanoseconds.
>=20
> In reality methods with a timestamp argument actually receive a tuple
> like (123456789,) as the timestamp argument.  This is due to a bug in
> simpletrace.py.
>=20
> This patch unpacks the tuple so that methods receive the correct
> timestamp argument type.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  scripts/simpletrace.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The patchew error was bogus.

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--Tv3+oRj6D9L8lW+H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJalZcXAAoJEJykq7OBq3PI5WsIAK7hxtFBPInKd32mMQB1BdX4
bx3HBqUFxmTN4Dk6ONzHgMptlGRmKyCD/K8rU0BQSD9FiZpHdExLtEZPxZ2csvF/
NLHzQO6pqD8G4Tcium9ukXZz0kTg14f/mLBbbWGTDoAt5BxTyLe0CGqfUBxYhrDI
tyE4Xtjw5DfS4u/GtxNEtSaskkFrUXoHqBt/odB4TNJzMc4PDGwbD7Fi5NTx0vJT
HIzhzeei7chJZ052pC6PMHt7cy907qsH02BGOVDz5wzRFvmZ3PObo2dw6ACsdiLc
UwyqKXiOebMU0r0NnLvingNE+HdrQ5pNQ1GsMP0ivUMCT4cloGz0y4Kr7Gz+PZQ=
=q1Qd
-----END PGP SIGNATURE-----

--Tv3+oRj6D9L8lW+H--
