Received: from eggs.gnu.org ([2001:4830:134:3::10]:58562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGccl-0000MM-Kv
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 22:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGcck-0003iy-GG
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 22:47:39 -0400
Date: Fri, 2 Jun 2017 12:00:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170602020007.GH13397@umbus.fritz.box>
References: <20170526052319.28096-1-david@gibson.dropbear.id.au>
	<20170530011416.01eea576@bahia.ttt.fr.ibm.com>
	<20170530061852.GE12163@umbus.fritz.box>
	<20170530100136.680ce96f@bahia.ttt.fr.ibm.com>
	<20170531025748.GG12163@umbus.fritz.box>
	<20170531105857.62a25a84@bahia.ttt.fr.ibm.com>
	<20170601065233.GD13397@umbus.fritz.box>
	<f353022f-6b48-ab18-f156-bd8fac8cf884@kaod.org>
	<20170601150915.2bb628f5@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ewQ5hdP4CtoTt3oD"
Content-Disposition: inline
In-Reply-To: <20170601150915.2bb628f5@bahia.lan>
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
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, agraf@suse.de, abologna@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, sursingh@redhat.com, sbobroff@redhat.com


--ewQ5hdP4CtoTt3oD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2017 at 03:09:15PM +0200, Greg Kurz wrote:
> On Thu, 1 Jun 2017 13:59:14 +0200
> C=E9dric Le Goater <clg@kaod.org> wrote:
>=20
> > On 06/01/2017 08:52 AM, David Gibson wrote:
> > > On Wed, May 31, 2017 at 10:58:57AM +0200, Greg Kurz wrote: =20
> > >> On Wed, 31 May 2017 12:57:48 +1000
> > >> David Gibson <david@gibson.dropbear.id.au> wrote: =20
> > >>> [...] =20
> > >>>> All old non-pseries machine types already complain when started wi=
th
> > >>>> a POWER7 or newer CPU. Providing the extra error message looks wei=
rd:
> > >>>>
> > >>>> qemu-system-ppc64 -machine ppce500 \
> > >>>>                   -cpu POWER7,compat=3Dpower6
> > >>>> qemu-system-ppc64: CPU 'compat' property is deprecated and has no =
effect;
> > >>>>  use max-cpu-compat machine property instead
> > >>>> MMU model 983043 not supported by this machine.
> > >>>>
> > >>>> but I guess it's better than crashing. :)   =20
> > >>>
> > >>> Well, sure POWER7 doesn't make sense for an e500 machine for other
> > >>> reasons.  But POWER7 or POWER8 _would_ make sense for powernv, where
> > >>> compat=3D doesn't.
> > >>> =20
> > >>
> > >> The powernv machine type doesn't even support CPU features at all:
> > >>
> > >>     chip_typename =3D g_strdup_printf(TYPE_PNV_CHIP "-%s", machine->=
cpu_model);
> > >>     if (!object_class_by_name(chip_typename)) {
> > >>         error_report("invalid CPU model '%s' for %s machine",
> > >>                      machine->cpu_model, MACHINE_GET_CLASS(machine)-=
>name);
> > >>         exit(1);
> > >>     } =20
> > >=20
> > > Ah, well, that's another bug, but not one that's in scope for this
> > > series. =20
> >=20
> > PowerNV is still work in progress. I would not worry about it too much.
> >=20
>=20
> Of course and this isn't the purpose of the discussion actually. We were
> talking about CPU features being relevant or not depending on the machine
> type.
>=20
> But I'm not even sure that CPU features are useful at all for ppc, not to
> say very confusing (otherwise this series wouldn't be needed for example).
>=20
> Speaking of PowerNV, just as an example, I guess the fix would be to
> forbid machine->cpu_model if it contains features. And probably the same
> for all other machine types, except pseries for backward compatibility
> reasons.

I don't think that's correct in principle.  I can imagine CPU
properties it might make sense to really set on the cpu, regardless of
machine type.  A quick look says we don't have any such at the moment,
but I don't think it's something we should prevent as a matter of policy.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ewQ5hdP4CtoTt3oD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZMManAAoJEGw4ysog2bOS60gQALkaViouWONg/Uw8dPN/VJKK
cH9YTMyN8twqpnpxZMTg+agEOgM4sExaaxP6kfA5J05u0Uj/z7Urp0qqa4K17IxQ
ZiEX2tcE7wL3xeS6WCFVxq3yCLv2PsGwmxFmzDcDxEtBmwde6wIRGAWR86WK9NWA
fRrHDQXfM7ykJRdof2d1RIaI3Hzzgj/8mtanzGQi2u9044Y7MPFg2R3k0aKJvZnx
yjPNp/0MMuTg5OkndZjBTzO3DmR/RiRjjgYuLabi3WEALfZzli9BPEAmrIDvRgbb
od8wLs5MyS+9UqWub9jq/BzBj1TqYuITdlqijff47/tTywuFtCKhmHno0IUaayzD
vJfZhkVeIaQPX8zK/0QyGh/Mr5iguSIAkBdDHxpSOET7nwI9TjxD7mqW2Jbf0uwv
5OC1Phb0ELGxZ7IAtPu4W+ZtqIfybTvLaH5XZgjwtYUQ3V2iMeay6aW2B8Ho3lyf
3DN7gYnyLZc+QE85Z8aaNOQt4EFKlFL6ksd5YhS2fgukzct4KhKzLJ0neCE01Kbl
vMDbzd+lqYogXowfyohlI6KsKgP99UWUdYFoK+Pp2IBkEFYMqvbTTWGZPfMUQhc9
ICu8CRwZOhw03qX2sUMeT5xIteIcdgWrE3fZ1c7vY6jORRDfRVyK8GtWjT3tl7qP
XV09PtzC9ivw7Shpsgwj
=Kf/t
-----END PGP SIGNATURE-----

--ewQ5hdP4CtoTt3oD--
