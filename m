Received: from eggs.gnu.org ([2001:4830:134:3::10]:33054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cj1k6-0001An-Bq
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 05:44:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cj1k3-0006vs-8b
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 05:44:22 -0500
Date: Wed, 1 Mar 2017 10:44:15 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170301104415.GC29473@stefanha-x1.localdomain>
References: <20170228111935.10826-1-stefanha@redhat.com>
	<20170228111935.10826-3-stefanha@redhat.com>
	<w51innu5x1o.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
Content-Disposition: inline
In-Reply-To: <w51innu5x1o.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 2/2] throttle: make
 throttle_config(throttle_get_config()) symmetric
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Nini Gu <ngu@redhat.com>, qemu-block@nongnu.org


--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2017 at 01:17:55PM +0100, Alberto Garcia wrote:
> On Tue 28 Feb 2017 12:19:35 PM CET, Stefan Hajnoczi wrote:
> > +/* undo internal bucket parameter changes (see throttle_fix_bucket()) =
*/
> > +static void throttle_unfix_bucket(LeakyBucket *bkt)
> > +{
> > +    double min =3D bkt->avg / 10;
> > +
> > +    if (bkt->max =3D=3D min) {
> > +        bkt->max =3D 0;
> > +    }
> > +}
>=20
> I guess you could do the more general if (bkt->max < bkt->avg), but your
> solution is also fine with me.
>=20
> Reviewed-by: Alberto Garcia <berto@igalia.com>

I did that originally because I try to avoid floating-point equality.
The test case uses an invalid setting though (->max =3D 1, ->avg =3D 56)
which would be rejected if given on the command-line.

Thinking about this again, it's probably better to modify the test case
and use max < avg.

Will send a v3.

Stefan

--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYtqX/AAoJEJykq7OBq3PIC3YIAJi1COyOeGiFCKYwauFmi+hb
JHFLq0c9XlxZCXqS4HJgGfPQ+xMaCMbWaFqvfD3r1uYbtGHUYR49DavwklcAQy7Z
Uz74bbRGK6GS60x5OhBq0g224XfEf2kveYoMAa2G+piPKzGKNXsPlcG4KVBb26Q9
3kvOmhEWpHX1bKQ5rDyQ2by/Xx9DofGrJqL4J3YfeuFzZQ1UybFDUKHyJYtZ/DH2
h/jT9JkUxZmDMGuutiy990kSwj1PCWnVss0p7JNQbFR0GaoRJjHmfFb0cyHIrqkK
NWxor2bL2aCiQExEGsm3p+plq1hD0aSGrK68vENWMcfzRR/jrsj7aD+KE8N6NCc=
=/L0k
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--
