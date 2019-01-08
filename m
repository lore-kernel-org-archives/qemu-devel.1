Received: from eggs.gnu.org ([209.51.188.92]:43998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ggsjG-00072Y-ID
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:51:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ggsjE-0005f7-DQ
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:51:42 -0500
References: <20190103094728.31747-1-rjones@redhat.com>
	<20190103094728.31747-2-rjones@redhat.com>
	<cb7b80d8-e54f-5422-7029-47ee286dd25f@redhat.com>
	<741a5843-a47a-6a02-c378-b778f7ffe172@redhat.com>
	<f5aa2057-509b-28fa-d803-b18ca525ae73@redhat.com>
	<20190107184058.GN27120@redhat.com>
	<20190108121625.GA11492@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b6df06a8-4a68-e4ed-2101-d0e30759c8e0@redhat.com>
Date: Tue, 8 Jan 2019 08:51:30 -0600
MIME-Version: 1.0
In-Reply-To: <20190108121625.GA11492@linux.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Nna2W6e79BJRcfGOas4Wo5c6N0T9br0Aj"
Subject: Re: [Qemu-devel] [PATCH v2] qemu-io: Reinitialize optind to 1 (not
 0) before parsing inner command.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Nna2W6e79BJRcfGOas4Wo5c6N0T9br0Aj
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <b6df06a8-4a68-e4ed-2101-d0e30759c8e0@redhat.com>
Subject: Re: [PATCH v2] qemu-io: Reinitialize optind to 1 (not 0) before
 parsing inner command.
References: <20190103094728.31747-1-rjones@redhat.com>
 <20190103094728.31747-2-rjones@redhat.com>
 <cb7b80d8-e54f-5422-7029-47ee286dd25f@redhat.com>
 <741a5843-a47a-6a02-c378-b778f7ffe172@redhat.com>
 <f5aa2057-509b-28fa-d803-b18ca525ae73@redhat.com>
 <20190107184058.GN27120@redhat.com> <20190108121625.GA11492@linux.fritz.box>
In-Reply-To: <20190108121625.GA11492@linux.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/8/19 6:16 AM, Kevin Wolf wrote:


> Unconditionally setting optind =3D 1 looks fine. I would, however, quot=
e a
> different part of the glibc man page (in addition or instead of the
> paragraph you already quoted):
>=20
>     The  variable  optind is the index of the next element to be
>     processed in argv.  The system initializes this value to 1.  The
>     caller can reset it to 1 to restart scanning of the same argv, or
>     when scanning a new argument vector.
>=20
> This makes it pretty clear that optind =3D 1 is fine for our case with
> glibc. The FreeBSD man page still suggests that we need optreset =3D 1,=
 so
> I suppose we'd end up with something like:
>=20
> ...
> optind =3D 1;
> #ifdef __FreeBSD__
> optreset =3D 1;
> #endif

If you really want to set optreset for BSD systems, I'd do a configure
probe for whether optreset exists, and if so set it for ALL platforms
that have optreset, not just for __FreeBSD__.  (That, and checkpatch.pl
will gripe if you don't do it that way).

But I'm leaning towards not bothering with optreset UNLESS someone
proves they have a case where it actually matters.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Nna2W6e79BJRcfGOas4Wo5c6N0T9br0Aj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlw0uPIACgkQ3g5py3or
ov2x3AgAllPZCHwHSxy4Q9p67ETjqbdwzqKyYeYAKEog7L8fP4JNey0qyj9/qrji
8XereRd0KGj7JCCHk1sRpcQ9KzXYvTlQGHM6/XnQ+RubFkvTkG5Eh5XaXhkKqALD
p8idRHQrEVSQZ3kDqSoz+pc6f46t14cD6sana8Sm56dn3UAfD3j0IcEObKgI4J/z
z+onLQ8jd21NFRhcMVFMFLowphDgXzTN2nfy1ND9muNk52aOiW06LeJjsP5M7HmB
Nuw8IjNcuxhiXRXVJBC4qbNHVFzFKUrO6gmJ2xsrV+IBk9DtuWiVmdQofaMY1seP
oXqRwmuAXaMz/NWtpcWgfoz+UM0vdQ==
=tgkL
-----END PGP SIGNATURE-----

--Nna2W6e79BJRcfGOas4Wo5c6N0T9br0Aj--
