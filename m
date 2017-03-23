Received: from eggs.gnu.org ([2001:4830:134:3::10]:56335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr5Kg-0003Rp-29
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 12:11:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr5Ka-0002UZ-9E
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 12:11:26 -0400
References: <20170322144525.18964-1-eblake@redhat.com>
	<20170322144525.18964-3-eblake@redhat.com>
	<20170323153753.GF13825@redhat.com> <877f3gf053.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <50095670-2512-37fd-a651-e1cbeb19e474@redhat.com>
Date: Thu, 23 Mar 2017 11:11:17 -0500
MIME-Version: 1.0
In-Reply-To: <877f3gf053.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="m4FdPCo5kch0rw3LU2fUvnw6j84gk0MN0"
Subject: Re: [Qemu-devel] Possible regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>
Cc: lvivier@redhat.com, qemu-stable@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m4FdPCo5kch0rw3LU2fUvnw6j84gk0MN0
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 "Richard W.M. Jones" <rjones@redhat.com>
Cc: lvivier@redhat.com, qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <50095670-2512-37fd-a651-e1cbeb19e474@redhat.com>
Subject: Re: [Qemu-devel] Possible regression
References: <20170322144525.18964-1-eblake@redhat.com>
 <20170322144525.18964-3-eblake@redhat.com>
 <20170323153753.GF13825@redhat.com> <877f3gf053.fsf@dusky.pond.sub.org>
In-Reply-To: <877f3gf053.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/23/2017 11:06 AM, Markus Armbruster wrote:

> Does the appended patch fix it for you?
>=20
>=20
> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> index 9c271ad..4d03665 100644
> --- a/qom/object_interfaces.c
> +++ b/qom/object_interfaces.c
> @@ -134,6 +134,7 @@ Object *user_creatable_add_opts(QemuOpts *opts, Err=
or **errp)
>      visit_free(v);
> =20
>      qemu_opts_set_id(opts, (char *) id);
> +    qemu_opt_set(opts, "qom-type", type, &error_abort);

See my posting, which covers both exit paths, rather than just the
successful exit path.


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--m4FdPCo5kch0rw3LU2fUvnw6j84gk0MN0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0/OlAAoJEKeha0olJ0NqSfsH/i+KcT2YrSpJJ5RP+Y5j+HOl
P9NOFur3KCGtYFSpxGnEe8in7eZqS4TVNb4CIIUwIxeOFos/op1oGibGzOo28nNl
tRtuTKC6ayHMZLa75NFNe7DvsVqQjrmlOJJ1vBg1JH6gKAJoKERtvYiEKlyXjK5Q
KOuY36wNayaM9s5pQ/UYb/+tc08BHc7Lgr0tgu9YviIOck6lN7VjzHBshvO43Dj5
0cBdIwsrFK+OuogH4jD4wlyrqIEiOCa0gO6DtQe8z4i7j2JUErFnJAxTnrRIZcOG
GG77MzFX8xVVsmoKnvQr8V4iPIuXvkjwQgISY5ZvK75BHc4i47mokqdJJJuM26A=
=UnK4
-----END PGP SIGNATURE-----

--m4FdPCo5kch0rw3LU2fUvnw6j84gk0MN0--
