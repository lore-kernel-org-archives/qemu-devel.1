Received: from eggs.gnu.org ([2001:4830:134:3::10]:36009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eqHJO-0002pm-R1
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 06:51:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eqHJN-0003UI-Vq
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 06:51:18 -0500
References: <151949532854.973.14187903904976853026@bdbb90650ae5>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <cff2322c-8a11-e174-ccf1-2631e467bc68@redhat.com>
Date: Mon, 26 Feb 2018 12:50:59 +0100
MIME-Version: 1.0
In-Reply-To: <151949532854.973.14187903904976853026@bdbb90650ae5>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dSHLuW5OERaHSEI6Bs7WFI1ZqRterUNA5"
Subject: Re: [Qemu-devel] [PATCH v3 0/7] block: Handle null backing link
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, berto@igalia.com, mdroth@linux.vnet.ibm.com, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dSHLuW5OERaHSEI6Bs7WFI1ZqRterUNA5
From: Max Reitz <mreitz@redhat.com>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, berto@igalia.com,
 mdroth@linux.vnet.ibm.com, armbru@redhat.com
Message-ID: <cff2322c-8a11-e174-ccf1-2631e467bc68@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/7] block: Handle null backing link
References: <151949532854.973.14187903904976853026@bdbb90650ae5>
In-Reply-To: <151949532854.973.14187903904976853026@bdbb90650ae5>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-24 19:02, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed build test on s390x host. Please find the details be=
low.

[...]

> In file included from /var/tmp/patchew-tester-tmp-wr4zoy33/src/include/=
qemu/osdep.h:36:0,
>                  from /var/tmp/patchew-tester-tmp-wr4zoy33/src/block.c:=
25:
> /var/tmp/patchew-tester-tmp-wr4zoy33/src/block.c: In function =E2=80=98=
bdrv_open_inherit=E2=80=99:
> /var/tmp/patchew-tester-tmp-wr4zoy33/src/include/qemu/compiler.h:63:34:=
 error: dereferencing pointer to incomplete type =E2=80=98QNull {aka stru=
ct QNull}=E2=80=99
>          const typeof(((type *) 0)->member) *__mptr =3D (ptr);     \
>                                   ^
> /var/tmp/patchew-tester-tmp-wr4zoy33/src/include/qapi/qmp/qobject.h:65:=
5: note: in expansion of macro =E2=80=98container_of=E2=80=99
>      container_of(qobject_check_type(obj, glue(QTYPE_CAST_TO_, type)) ?=
: \
>      ^~~~~~~~~~~~
> /var/tmp/patchew-tester-tmp-wr4zoy33/src/block.c:2603:9: note: in expan=
sion of macro =E2=80=98qobject_to=E2=80=99
>      if (qobject_to(qdict_get(options, "backing"), QNull) !=3D NULL ||
>          ^~~~~~~~~~
> In file included from /usr/include/sched.h:29:0,
>                  from /usr/include/pthread.h:23,
>                  from /usr/include/glib-2.0/glib/deprecated/gthread.h:1=
28,
>                  from /usr/include/glib-2.0/glib.h:108,
>                  from /var/tmp/patchew-tester-tmp-wr4zoy33/src/include/=
glib-compat.h:19,
>                  from /var/tmp/patchew-tester-tmp-wr4zoy33/src/include/=
qemu/osdep.h:107,
>                  from /var/tmp/patchew-tester-tmp-wr4zoy33/src/block.c:=
25:
> /var/tmp/patchew-tester-tmp-wr4zoy33/src/include/qemu/compiler.h:64:37:=
 error: invalid use of incomplete typedef =E2=80=98QNull {aka struct QNul=
l}=E2=80=99
>          (type *) ((char *) __mptr - offsetof(type, member));})
>                                      ^
> /var/tmp/patchew-tester-tmp-wr4zoy33/src/include/qapi/qmp/qobject.h:65:=
5: note: in expansion of macro =E2=80=98container_of=E2=80=99
>      container_of(qobject_check_type(obj, glue(QTYPE_CAST_TO_, type)) ?=
: \
>      ^~~~~~~~~~~~
> /var/tmp/patchew-tester-tmp-wr4zoy33/src/block.c:2603:9: note: in expan=
sion of macro =E2=80=98qobject_to=E2=80=99
>      if (qobject_to(qdict_get(options, "backing"), QNull) !=3D NULL ||
>          ^~~~~~~~~~

I guess I missed 6b67395762a4c8b.  Oops.

Max


--dSHLuW5OERaHSEI6Bs7WFI1ZqRterUNA5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqT9KMSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AM4IH/39NZk2bxYG5EXkd2wC3xJAiQWcaBqs4
WGNXe9EdPeP8Iq+zDfbY+Tl1Ch2oQhrq+ai0MU+0LsEXQwJ/TEDf8n8M1HYc0Xa6
Y01x++hSiofdaf/4P6Brdixcd3xF7556P0RpsjoegZibtQgE84W3HNJtSiyifxYx
nVjHXMXuVe3K+eOqGMrrrmewhKCUhODzb7aLXcIztGJ6ZqrVO6DEHIAwhh//UVWf
sK2yElj6Ozf+YTXbXyQlW9lnSBpkoziyNQlFOiBu3a4/V/lfRaq7zGKuBmSh7w3/
QPdPU4UGIKK2SDrmotAooMvGL9DPiKVJaKTvENeiHNJkv3WpAFTNCkA=
=OxwB
-----END PGP SIGNATURE-----

--dSHLuW5OERaHSEI6Bs7WFI1ZqRterUNA5--
