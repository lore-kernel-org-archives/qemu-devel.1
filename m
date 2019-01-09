Received: from eggs.gnu.org ([209.51.188.92]:38938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghD3J-0003WI-FH
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:33:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghD3I-0000Zz-Iq
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:33:45 -0500
References: <20190103094728.31747-1-rjones@redhat.com>
	<20190103094728.31747-2-rjones@redhat.com>
	<cb7b80d8-e54f-5422-7029-47ee286dd25f@redhat.com>
	<741a5843-a47a-6a02-c378-b778f7ffe172@redhat.com>
	<f5aa2057-509b-28fa-d803-b18ca525ae73@redhat.com>
	<20190107184058.GN27120@redhat.com>
	<20190108121625.GA11492@linux.fritz.box>
	<b6df06a8-4a68-e4ed-2101-d0e30759c8e0@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5a534d31-7ac8-6cc9-b641-ea1c5f9fae49@redhat.com>
Date: Wed, 9 Jan 2019 13:33:34 +0100
MIME-Version: 1.0
In-Reply-To: <b6df06a8-4a68-e4ed-2101-d0e30759c8e0@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="quTezFkZ3kqosIIkgJRviBChj1UxCgP8i"
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
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--quTezFkZ3kqosIIkgJRviBChj1UxCgP8i
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <5a534d31-7ac8-6cc9-b641-ea1c5f9fae49@redhat.com>
Subject: Re: [PATCH v2] qemu-io: Reinitialize optind to 1 (not 0) before
 parsing inner command.
References: <20190103094728.31747-1-rjones@redhat.com>
 <20190103094728.31747-2-rjones@redhat.com>
 <cb7b80d8-e54f-5422-7029-47ee286dd25f@redhat.com>
 <741a5843-a47a-6a02-c378-b778f7ffe172@redhat.com>
 <f5aa2057-509b-28fa-d803-b18ca525ae73@redhat.com>
 <20190107184058.GN27120@redhat.com> <20190108121625.GA11492@linux.fritz.box>
 <b6df06a8-4a68-e4ed-2101-d0e30759c8e0@redhat.com>
In-Reply-To: <b6df06a8-4a68-e4ed-2101-d0e30759c8e0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.01.19 15:51, Eric Blake wrote:
> On 1/8/19 6:16 AM, Kevin Wolf wrote:
>=20
>=20
>> Unconditionally setting optind =3D 1 looks fine. I would, however, quo=
te a
>> different part of the glibc man page (in addition or instead of the
>> paragraph you already quoted):
>>
>>     The  variable  optind is the index of the next element to be
>>     processed in argv.  The system initializes this value to 1.  The
>>     caller can reset it to 1 to restart scanning of the same argv, or
>>     when scanning a new argument vector.
>>
>> This makes it pretty clear that optind =3D 1 is fine for our case with=

>> glibc. The FreeBSD man page still suggests that we need optreset =3D 1=
, so
>> I suppose we'd end up with something like:
>>
>> ...
>> optind =3D 1;
>> #ifdef __FreeBSD__
>> optreset =3D 1;
>> #endif
>=20
> If you really want to set optreset for BSD systems, I'd do a configure
> probe for whether optreset exists, and if so set it for ALL platforms
> that have optreset, not just for __FreeBSD__.  (That, and checkpatch.pl=

> will gripe if you don't do it that way).

=2E..or you just make it a weak variable...

> But I'm leaning towards not bothering with optreset UNLESS someone
> proves they have a case where it actually matters.

I don't care in this case, but this is not a good argument.

As I said before, in general, if an interface description says to do X
for Y you cannot rely on doing Y without X just because it works right no=
w.

Max


--quTezFkZ3kqosIIkgJRviBChj1UxCgP8i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw16h4ACgkQ9AfbAGHV
z0Du0AgAkLyDHXtwGqalJjj4G0XK3njP8a/ZFpi15dAWVcBhZ7fhjtnfQpsz/kZ+
+/GLtIR7WcbwpcPo4aNl+IdY42kLkVvlrxKMQeG3BiMSXu6zOYrZFFXDXVC8T+Zq
jOgmEzjOm1mAGoNOpZI9nDXm3p9jCkwCsDa5cje5ebUzUkiM02HrKlMn3534+g9Q
+fa8QkbHyWyfK5SUPAqvvRQav2gXfRkbLnmo/8br5ANyQK3gwoss++fgoE4m4BCp
AMMF6uwweqyRGvdCoWTVg6zwvE24lSKYkBcmqa3PG20sUosyG2Yqs2MX9vwTlsbU
ralEute27f7Sr37RBu3BdRQvfvIyZQ==
=E1T4
-----END PGP SIGNATURE-----

--quTezFkZ3kqosIIkgJRviBChj1UxCgP8i--
