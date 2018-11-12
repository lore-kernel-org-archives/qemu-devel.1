Received: from eggs.gnu.org ([2001:4830:134:3::10]:53072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gME71-000365-9T
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:26:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gME6z-0006mc-7h
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:26:51 -0500
References: <79c52867-2c10-401b-95d9-2d2edd8afa5e@redhat.com>
	<CAMRbyysA2h5MbJM8LyyYfFOOttH_D+Fc=Nb51vcvk=o+=hJsbA@mail.gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7e6da1d6-68bf-913d-6eaf-9acff0623218@redhat.com>
Date: Mon, 12 Nov 2018 16:25:47 +0100
MIME-Version: 1.0
In-Reply-To: <CAMRbyysA2h5MbJM8LyyYfFOOttH_D+Fc=Nb51vcvk=o+=hJsbA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cShhNqQjQ4BoVjltr3OeddLKXAHc7CtD2"
Subject: Re: [Qemu-devel] [Qemu-block] KVM Forum block no[td]es
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nsoffer@redhat.com>
Cc: qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cShhNqQjQ4BoVjltr3OeddLKXAHc7CtD2
From: Max Reitz <mreitz@redhat.com>
To: Nir Soffer <nsoffer@redhat.com>
Cc: qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 vsementsov@virtuozzo.com, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, den@openvz.org
Message-ID: <7e6da1d6-68bf-913d-6eaf-9acff0623218@redhat.com>
Subject: Re: [Qemu-block] KVM Forum block no[td]es
References: <79c52867-2c10-401b-95d9-2d2edd8afa5e@redhat.com>
 <CAMRbyysA2h5MbJM8LyyYfFOOttH_D+Fc=Nb51vcvk=o+=hJsbA@mail.gmail.com>
In-Reply-To: <CAMRbyysA2h5MbJM8LyyYfFOOttH_D+Fc=Nb51vcvk=o+=hJsbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.11.18 00:36, Nir Soffer wrote:
> On Mon, Nov 12, 2018 at 12:25 AM Max Reitz <mreitz@redhat.com
> <mailto:mreitz@redhat.com>> wrote:
>=20
>     This is what I=E2=80=99ve taken from two or three BoF-like get-toge=
thers on
>     blocky things.=C2=A0 Amendments are more than welcome, of course.
>=20
> ...=C2=A0
>=20
>     Bitmaps
>=20
>     =3D=3D=3D=3D=3D=3D=3D
>=20
>     (Got this section from sneaking into a BoF I wasn=E2=80=99t invited=
 to.=C2=A0 Oh
>     well.=C2=A0 Won=E2=80=99t hurt to include them here.)
>=20
>     Currently, when dirty bitmaps are loaded, all IN_USE bitmaps are ju=
st
>     not loaded at all and completely ignored.=C2=A0 That isn=E2=80=99t =
correct, though,
>     they should either still be loaded (and automatically treated and
>     written back as fully dirty), or at least qemu-img check should
>     =E2=80=9Crepair=E2=80=9D them (i.e. fully dirtying them).
>=20
>=20
> I'm not sure making bitmaps dirty is better.
>=20
> When bitmap is marked IN_USE, it means that we cannot use it for
> backup. Deleting the bitmap or making it as bad so it cannot be used
> for the next backup is the same. Making the bitmap as dirty will full
> the management layer that everything was fine when the next backup
> includes the entire disk. It is better to cause the next backup to fail=

> in a verbose way, since the backup software can recover by doing
> a full backup.

But making the dirty bitmap fully dirty will automatically enforce a
full backup.

>     Sometimes qemu (running in a mode as bare as possible) is better th=
an
>     using qemu-img convert, for instance.=C2=A0 It gives you more contr=
ol
>     (through QMP; you get e.g. better progress reporting), you get all =
of
>     the mirror optimizations (we do have optimizations for convert, too=
,
>     but whether it=E2=80=99s any good to write the same (or different?)=

>     optimizations twice is another question), and you get a common
>     interface for everything (online and offline).
>     Note that besides a bare qemu we=E2=80=99ve also always wanted to c=
onvert as
>     many qemu-img operations into frontends for block jobs as possible.=

>     We have only done this for commit, however, even though convert loo=
ked
>     like basically the ideal target.=C2=A0 It was just too hard with to=
o little
>     apparent gain, like always (and convert supports additional feature=
s
>     like concatenation which we don=E2=80=99t have in the runtime block=
 layer
>     yet).
>=20
>=20
> I'm not sure it is better to run qemu and use qemu-img as thin wrapper
> over qmp.
>=20
> For example, management system may ascociate qemu-img
> with a sanlock lease, and sanlock may try to terminate qemu-img when
> a lease is invalidated. In this case sanlock will succeed while qemu is=
 till
> accessing storage it should not access.
> ...

The point was not to run two processes, but to link the necessary bits
of qemu into qemu-img and then use them inside the single qemu-img
process itself.  As hinted at above, we've been doing this for qemu-img
commit for quite some time; that command actually runs a block job under
the hood (inside of qemu-img).

Max


--cShhNqQjQ4BoVjltr3OeddLKXAHc7CtD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvpm3wACgkQ9AfbAGHV
z0BQAggAiVFULxhjGsV9A/AhNcZRuSBgqqcY8FffM0HdCcG5nBUxxyf45NUCaaGb
gWk/aGo7d2zyxRkGJhv6OlX4iEVBtAIeXtdBt5dVrbaMSAagaBUst9LbtWgMUKB5
hlWtVQYoJdrxWuPwTVRI9OcvApIMvjHRhGzH0PiMqozCu9nB83tm+/W+LTG5B2GX
wO8Vq75omErgAim0TEUZp+Tqtb+I4J/qKwv/VPHW6Y7kDt4D3s7kVNDr31ziYzEc
Bm4ccN/gAkTiLjVjgXJ1Z5dF7qzkbA4wh0c3hHvhJT0Zo+vXeuR/pgbW0eoP2MDF
QtZXkamIKYMiFNhnQs6Oz1b3EBcyXA==
=X67E
-----END PGP SIGNATURE-----

--cShhNqQjQ4BoVjltr3OeddLKXAHc7CtD2--
