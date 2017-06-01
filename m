Received: from eggs.gnu.org ([2001:4830:134:3::10]:48398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGOiK-0004iS-Nu
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:56:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGOiJ-0006rm-BE
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:56:28 -0400
Date: Thu, 1 Jun 2017 16:52:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170601065233.GD13397@umbus.fritz.box>
References: <20170526052319.28096-1-david@gibson.dropbear.id.au>
	<20170530011416.01eea576@bahia.ttt.fr.ibm.com>
	<20170530061852.GE12163@umbus.fritz.box>
	<20170530100136.680ce96f@bahia.ttt.fr.ibm.com>
	<20170531025748.GG12163@umbus.fritz.box>
	<20170531105857.62a25a84@bahia.ttt.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qGV0fN9tzfkG3CxV"
Content-Disposition: inline
In-Reply-To: <20170531105857.62a25a84@bahia.ttt.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCHv4 0/5] Clean up compatibility mode handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: clg@kaod.org, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, agraf@suse.de, abologna@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, sursingh@redhat.com, sbobroff@redhat.com


--qGV0fN9tzfkG3CxV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 31, 2017 at 10:58:57AM +0200, Greg Kurz wrote:
> On Wed, 31 May 2017 12:57:48 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
> > [...]
> > > All old non-pseries machine types already complain when started with
> > > a POWER7 or newer CPU. Providing the extra error message looks weird:
> > >=20
> > > qemu-system-ppc64 -machine ppce500 \
> > >                   -cpu POWER7,compat=3Dpower6
> > > qemu-system-ppc64: CPU 'compat' property is deprecated and has no eff=
ect;
> > >  use max-cpu-compat machine property instead
> > > MMU model 983043 not supported by this machine.
> > >=20
> > > but I guess it's better than crashing. :) =20
> >=20
> > Well, sure POWER7 doesn't make sense for an e500 machine for other
> > reasons.  But POWER7 or POWER8 _would_ make sense for powernv, where
> > compat=3D doesn't.
> >=20
>=20
> The powernv machine type doesn't even support CPU features at all:
>=20
>     chip_typename =3D g_strdup_printf(TYPE_PNV_CHIP "-%s", machine->cpu_m=
odel);
>     if (!object_class_by_name(chip_typename)) {
>         error_report("invalid CPU model '%s' for %s machine",
>                      machine->cpu_model, MACHINE_GET_CLASS(machine)->name=
);
>         exit(1);
>     }

Ah, well, that's another bug, but not one that's in scope for this
series.



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qGV0fN9tzfkG3CxV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZL7mvAAoJEGw4ysog2bOSA44P/iIOBoP3hndqr1b0Aw0ukLyN
SYxXXKGqL0dgvqpQAEuv3luYNolptQrzF0yWVDziBrMFbc2RlPJ/2TRhKuyPA7Vn
9H9HUKmzo/JM1zABF+4SGYlF0dwOHLuQy50gPaHJxzz6GFNzVKkn6j9N3MwqvItu
TPzruznCDJsQXwlnt8BnmSOPdlwkOlC3wkjGL4itlt8zDtaqobmx+5nq530GR/lF
bf5CJInJ1HUJSE5ZAy8ol7iTo4QxHfmE9CmBSIVgwjQzfyhTVDt5YaVfOP1Dta6P
UBebjCkXvhuvSBEW7kNLyjuhb2KQNtWj2KxBUG6nr4nKZrCSrMRB7t3vHUb7xWon
R4EhdXCK9dMRxZi1GzKHvSTd+S/xtCpWNxixNtWBPWs2nsZ2TzxMXbZ771l0gQQs
HkEMQ1Z4s2kv8Z1k5AxHWgItnUh/8zpSW1cMWYqE1b80imX7yJDV0mDU+7uDX9+2
Hnv9YyV28H7E9fWt7Ag5/mk7u5ORIfYQkggos35QpovpAiba/3erbRbSQlvctnxh
qdaSBaAcbaUE1IOb/uhMk1zmBLckrhUk6bJMuVrlMwv6VtngkpSlXz4m6FHi83IN
LmEYyLG6G0Xq5FCfZOEJ/Flj2f2NK6cmnmFOz/g1XJKyEQIa/1WsTZzDyjslwRFt
ed+FyfpswsalPiGGyvdT
=Q0Ri
-----END PGP SIGNATURE-----

--qGV0fN9tzfkG3CxV--
