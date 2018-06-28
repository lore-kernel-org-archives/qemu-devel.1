Received: from eggs.gnu.org ([2001:4830:134:3::10]:47407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYO0m-0004p0-Vl
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:54:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYO0l-0006xD-PE
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:54:25 -0400
Date: Thu, 28 Jun 2018 13:54:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180628035409.GD23134@umbus.fritz.box>
References: <20180625091718.18544-1-clg@kaod.org>
	<20180626152733.5050d9e3@bahia.lan>
	<120947ab-6846-aded-b946-59908ca8c4ae@kaod.org>
	<20180627001415.GE14434@umbus.fritz.box>
	<28412acb-112e-829d-3a12-267d06a2138e@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ylS2wUBXLOxYXZFQ"
Content-Disposition: inline
In-Reply-To: <28412acb-112e-829d-3a12-267d06a2138e@kaod.org>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 0/5] rework the ICS classes
 inheritance tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 27, 2018 at 08:34:22AM +0200, C=E9dric Le Goater wrote:
> On 06/27/2018 02:14 AM, David Gibson wrote:
> > On Tue, Jun 26, 2018 at 06:37:12PM +0200, C=E9dric Le Goater wrote:
> > 1;5202;0c> On 06/26/2018 03:27 PM, Greg Kurz wrote:
> >>> On Mon, 25 Jun 2018 11:17:13 +0200
> >>> C=E9dric Le Goater <clg@kaod.org> wrote:
> >>>
> >>>> Hello,
> >>>>
> >>>
> >>> Hello,
> >>>
> >>> Sorry I didn't manage to look at this before it got merged :)
> >>>
> >>>> It makes the class hierarchy much cleaner and removes duplicated
> >>>> code. As we are touching the location of the objects states, migrati=
on
> >>>> compatibility was checked and the following tests were performed und=
er
> >>>> KVM :
> >>>>
> >>>>   qemu-3.0 (pseries-3.0)   -> qemu-3.0  (pseries-3.0)   OK
> >>>>   qemu-3.0 (pseries-2.12)  -> qemu-2.12 (pseries-2.12)  OK
> >>>>   qemu-3.0 (pseries-2.11)  -> qemu-2.11 (pseries-2.11)  OK
> >>>>   qemu-3.0 (pseries-2.10)  -> qemu-2.10 (pseries-2.10)  OK
> >>>>   qemu-3.0 (pseries-2.9)   -> qemu-2.9  (pseries-2.9)   OK
> >>>>   qemu-3.0 (pseries-2.8)   -> qemu-2.8  (pseries-2.8)   OK
> >>>>   qemu-3.0 (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   FAIL
> >>>
> >>> What's the failure ?
> >>
> >> qemu-system-ppc64: error while loading state for instance 0x0 of devic=
e 'cpu'
> >> qemu-system-ppc64: load of migration failed: Invalid argument
> >>
> >> and to be more precise :
> >>
> >>    qemu-3.0  (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   FAIL
> >>    qemu-2.12 (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   FAIL
> >>    qemu-2.11 (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   FAIL
> >>    qemu-2.10 (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   FAIL
> >>    qemu-2.9  (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   FAIL
> >>    qemu-2.8  (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   FAIL
> >>    qemu-2.7  (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   OK
> >>
> >>
> >> So it has been a while.
> >=20
> > Yeah, IIRC that's a known problem.  If you try 2.7.1, I think it will w=
ork.
>=20
> I was using a 2.7.1.

Huh.  Ok, I don't know what's going on then.  But your patches haven't
changed the behaviour, so, whatever.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls0W+EACgkQbDjKyiDZ
s5K7tw//TbmBbS9P0ZQiyOR4mzxGzaXECo00RsN4lUSm76yuQ7ioazfiUAToE6Kh
O4FLOTof1grF1cQay9kpqVvBnwRsxV7nlUk4mZryE6ZpNGyDaKt5S9k7eRm6rgta
JohdqfHDIWa85kG+Pbb+caRxR7EQ6AfQzFYFaWd13BKthWc4QedwzxdKZ7M2s5AR
FLsxLuEFGOyRAfKJP8Ce/AYY4RoqfM1yxQpsyLIXjfJMzRZ0R54KlQ7wbUjl3gER
t9nZXIxjBnk/wdOmgL5Fu+Qm63TuFXyoNGByUxTgSWsNlN4MbnuNo5/NaE1xVH24
w2j46sbI83CnpmKLa1WFOtW1jkAVKb2jU3gXD/YHRnhMXkwByXdpghbeagTJBy3u
o4ONTEeAqEZgLtQgbSHFK5ktj6qBQkWkpeY08zyCXJ+KWrjn0JJSlTmAfmmCLNWa
eNYF4eNEDrVR7lO/VNYZXZzOLbzK1HSc43IEw8gtk7HIBYniVUXIpCebH+HwiTKl
+2f3Q8le7EtOZ77v7h8uHcdv5rkL4t6xffT2fhUj3b53OcQrxOKWcmBywDw7AUWV
5i9WpjGZCljhDhsecik7jZTZrlpQUPpCHjfwtXFlVaCJjMrNXfugIS3oE3HE/l73
d5eKUfijB+D5S9QzoC111fVcAVCn7YwbZQgbMdrx9ZSnSs6xVC8=
=kmL6
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--
