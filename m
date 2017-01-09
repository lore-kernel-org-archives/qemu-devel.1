Received: from eggs.gnu.org ([2001:4830:134:3::10]:55849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cQxdy-0001DG-Gp
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:43:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cQxdv-00062y-Ei
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:43:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cQxdv-00062e-8B
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:43:19 -0500
Date: Mon, 9 Jan 2017 16:38:54 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170109163854.GK30228@stefanha-x1.localdomain>
References: <148278746972.1404.10574428039766667311.stgit@fimbulvetr.bsc.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2WS97oupGEGbYNpW"
Content-Disposition: inline
In-Reply-To: <148278746972.1404.10574428039766667311.stgit@fimbulvetr.bsc.es>
Subject: Re: [Qemu-devel] [PATCH 0/3] trace: Fix event tracing during vCPU
 hot-unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org


--2WS97oupGEGbYNpW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 26, 2016 at 10:24:29PM +0100, Llu=EDs Vilanova wrote:
> The vCPU list needs to be locked to avoid memory corruption with concurre=
nt
> hot-(un)plugs, and per-vCPU events need to be disabled during vCPU hot-un=
plug.
>=20
> Also adds event "guest_cpu_exit" to track vCPU hot-unplugging.
>=20
> Signed-off-by: Llu=EDs Vilanova <vilanova@ac.upc.edu>
> ---
>=20
>=20
> Llu=EDs Vilanova (3):
>       trace: Lock vCPU list when initializing dynamic tracing state
>       trace: Fix dynamic event state on vCPU hot-unplug
>       trace: Add event "guest_cpu_exit"
>=20
>=20
>  qom/cpu.c              |    2 ++
>  trace-events           |    6 ++++++
>  trace/control-target.c |   11 ++++++++++-
>  trace/control.c        |   19 +++++++++++++++++++
>  trace/control.h        |    8 ++++++++
>  5 files changed, 45 insertions(+), 1 deletion(-)
>=20
>=20
> To: qemu-devel@nongnu.org
> Cc: Stefan Hajnoczi <stefanha@redhat.com>

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--2WS97oupGEGbYNpW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYc7yeAAoJEJykq7OBq3PIjKMIAJdq0osMNLfwauuffuHDnXAf
k5vLt5Mwget6ajcCaJAGVySg2OVyvCY8I3Q8Gjbp3wEPoOFFMvwk+lFpyeq6+Tc8
tHngVvorNXFKV1EBTlrhrNdQz4ClK9jGshZq6cfjtO36l0KdLrUBVFtL5v45QJJm
D1uDZOtNKGNMrnlCB59aTRHDfKjMXDMYQvEjKqC///P1x2RUT8EcQxqRHR34cKb7
yIVJFbx9Ap8vRnbvGb5Tpwcu60BYnm0I4WzJa37lTJpBvQ3jVpIgFwoYGELK8t/C
MPRIaR6m97+/gJTVhQ3npCKFr5zpMJmsZLy5+0PPbZxzQRkoQrt1n5rZbKxR+Fk=
=wYL/
-----END PGP SIGNATURE-----

--2WS97oupGEGbYNpW--
