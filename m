Received: from eggs.gnu.org ([2001:4830:134:3::10]:56688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwKS-0005bn-J3
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:23:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwK5-00018z-En
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:23:40 -0500
Date: Mon, 18 Dec 2017 14:22:22 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171218142222.GI16653@stefanha-x1.localdomain>
References: <20171214005953.8898-1-jsnow@redhat.com>
	<20171214005953.8898-2-jsnow@redhat.com>
	<fad7ac35-e2be-a7b0-078c-4aa4c3dd2905@redhat.com>
	<cba92745-25c7-0838-8df4-1d8b3881ad93@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/8E7gjuj425jZz9t"
Content-Disposition: inline
In-Reply-To: <cba92745-25c7-0838-8df4-1d8b3881ad93@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/7] blockjob: record time of last yield
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com


--/8E7gjuj425jZz9t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2017 at 10:55:22AM -0500, John Snow wrote:
>=20
>=20
> On 12/14/2017 03:38 AM, Paolo Bonzini wrote:
> > On 14/12/2017 01:59, John Snow wrote:
> >>      qemu_coroutine_yield();
> >> +    job->last_yield_ns =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> >=20
> > This is not the time the job has yielded control, but the time the job
> > has gotten it back.  Is it intended?
> >=20
> > Thanks,
> >=20
> > Paolo
> >=20
>=20
> Yes, since that matches how mirror recorded last_sleep_ns, except for
> where it records the 0ns sleep, then it records it beforehand (close
> enough.)
>=20
> I intended for this valuable to count how long we haven't yielded,
> basically. Thought being that any time we are yielded, we're being
> cooperative.
>=20
> This is the selfishness counter :)

Maybe last_enter_ns is a clearer name.

--/8E7gjuj425jZz9t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaN88eAAoJEJykq7OBq3PIW7AH/2c9ej64XTURpEFsJ+UjH9I/
erqTRO9c+pVPZcOyOppr2oZeUGl+/Upqo/ZbvET31BoSZePw9URBpm8InRrnGlQ3
r1ifz0jF506P5PpmxRtk06Bn7Z8nZJS50UdUEOtNS0mFt/7rasNxS5J1QPvtwF1O
IavKjTAr0EF8ekjFcM5av28vcTCmRsddjuYXr+AZ6uBYjwR1jOtp6et5YAY/u0j6
b+srU2b9o9GtmrBXxw1vGjt7cWVH8a/x2HdcmKN3obgYglvfbWsv2C6KcBOylKJp
4O1yeg8QVwAHp0bCgH6dPbqkVPqOQWvVh/JoAMdcWygs7GmgTdBh4iPm7r+sZEA=
=Yiyo
-----END PGP SIGNATURE-----

--/8E7gjuj425jZz9t--
