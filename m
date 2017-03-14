Received: from eggs.gnu.org ([2001:4830:134:3::10]:34056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andreas@grapentin.org>) id 1cnrLH-0000IC-MJ
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 14:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andreas@grapentin.org>) id 1cnrLG-00010u-LH
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 14:38:43 -0400
Date: Tue, 14 Mar 2017 19:38:34 +0100
From: Andreas Grapentin <andreas@grapentin.org>
Message-ID: <20170314183834.GA23093@parabola-pocket>
References: <20170314165953.18506-1-andreas@grapentin.org>
	<ddea3a8a-715e-c24d-e434-3fa55f5d81b2@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <ddea3a8a-715e-c24d-e434-3fa55f5d81b2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] use _Static_assert in QEMU_BUILD_BUG_ON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


The missing ! is because I generated the error messages by inverting the
condition and then forgot to change it back. I can send a v3 if you
like.

Thanks for being patient with me.

-A


On Tue, Mar 14, 2017 at 12:43:56PM -0500, Eric Blake wrote:
> On 03/14/2017 11:59 AM, Andreas Grapentin wrote:
> > QEMU_BUILD_BUG_ON should use C11's _Static_assert, if the compiler supp=
orts it,
> > to provide more readable messages on failure.
>=20
> >=20
> > with _Static_assert:
> >=20
> >> In file included from /qemu/include/qemu/osdep.h:36:0,
> >>                  from /qemu/qga/commands.c:13:
> >> /qemu/qga/commands.c: In function =E2=80=98qmp_guest_exec_status=E2=80=
=99:
> >> /qemu/include/qemu/compiler.h:94:30: error: static assertion failed: "=
not expecting: sizeof(*&gei->finished) > sizeof(void *)"
> >>  #define QEMU_BUILD_BUG_ON(x) _Static_assert((x), #x)
>=20
> Manual copy-and-paste? Because this is missing the ! present in the
> actual definition...
>=20
> >>                               ^
> >> /qemu/include/qemu/atomic.h:146:5: note: in expansion of macro =E2=80=
=98QEMU_BUILD_BUG_ON=E2=80=99
> >>      QEMU_BUILD_BUG_ON(sizeof(*ptr) > sizeof(void *));   \
> >>      ^~~~~~~~~~~~~~~~~
> >> /qemu/include/qemu/atomic.h:417:5: note: in expansion of macro =E2=80=
=98atomic_load_acquire=E2=80=99
> >>      atomic_load_acquire(ptr)
> >>      ^~~~~~~~~~~~~~~~~~~
> >> /qemu/qga/commands.c:160:21: note: in expansion of macro =E2=80=98atom=
ic_mb_read=E2=80=99
> >>      bool finished =3D atomic_mb_read(&gei->finished);
> >>                      ^~~~~~~~~~~~~~
> >=20
> > Signed-off-by: Andreas Grapentin <andreas@grapentin.org>
> > ---
>=20
> > +++ b/include/qemu/compiler.h
> > @@ -90,7 +90,9 @@
> >          int:(x) ? -1 : 1; \
> >      }
> > =20
> > -#ifdef __COUNTER__
> > +#if defined(CONFIG_STATIC_ASSERT)
> > +#define QEMU_BUILD_BUG_ON(x) _Static_assert(!(x), "not expecting: " #x)
>=20
> ...here.
>=20
> But that's trivial, if the maintainer would like to correct the commit
> message.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
>=20
> --=20
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
>=20




--=20

---------------------------------------------------------------------------=
---
my GPG Public Key:                 https://files.grapentin.org/.gpg/public.=
key
---------------------------------------------------------------------------=
---

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEv6gAioJlZ3BjsRv0cXGYbkt0VTYFAljIOKgACgkQcXGYbkt0
VTZlegf+LGR+KOHWD5Rg8q8N1eQFZXgVeigpLJdN18HU8aJfuos1AFFpp+mv+lRE
Otm57KyPui3/qKa21Z9fx5m22ClgU+9vOfkBtCVE7/FaicQwOr6Fc9VuZVMli3S4
Gw43jqXwgJvSELklHrzWfiqsey+NvYtqqTMZavB6Py9U1aRJYlmJuh11lxgmIaJX
hYPLeobNfH/M4Y/1BcBM79otd3P7lsugPpdZZKsQ9+hIinFzegd4KFkZJcjKvQi/
sacmpxqXyTzhTjWObMwtHd091sdHU2YOb9zOOAN8jhpJwBxu6aBTT9vO+y4Vu46a
W+wglylLL33tjahB1IpK0I1l9YJjSw==
=w2Bj
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
