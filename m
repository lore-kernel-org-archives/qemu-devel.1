Received: from eggs.gnu.org ([2001:4830:134:3::10]:55686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dGhkR-0005qG-Gn
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:15:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dGhkM-0004KW-JC
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:15:55 -0400
Received: from 13.mo5.mail-out.ovh.net ([87.98.182.191]:38197)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dGhkM-0004Jw-Cp
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:15:50 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 25A28100E75
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 10:15:44 +0200 (CEST)
Date: Fri, 2 Jun 2017 10:15:25 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170602101525.3fa2aad9@bahia.lan>
In-Reply-To: <20170602020007.GH13397@umbus.fritz.box>
References: <20170526052319.28096-1-david@gibson.dropbear.id.au>
	<20170530011416.01eea576@bahia.ttt.fr.ibm.com>
	<20170530061852.GE12163@umbus.fritz.box>
	<20170530100136.680ce96f@bahia.ttt.fr.ibm.com>
	<20170531025748.GG12163@umbus.fritz.box>
	<20170531105857.62a25a84@bahia.ttt.fr.ibm.com>
	<20170601065233.GD13397@umbus.fritz.box>
	<f353022f-6b48-ab18-f156-bd8fac8cf884@kaod.org>
	<20170601150915.2bb628f5@bahia.lan>
	<20170602020007.GH13397@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/i9ecEWOZ1HQX.LSnOzxxkq_";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCHv4 0/5] Clean up compatibility mode handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, agraf@suse.de, abologna@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, sursingh@redhat.com, sbobroff@redhat.com

--Sig_/i9ecEWOZ1HQX.LSnOzxxkq_
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 2 Jun 2017 12:00:07 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Jun 01, 2017 at 03:09:15PM +0200, Greg Kurz wrote:
> > On Thu, 1 Jun 2017 13:59:14 +0200
> > C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >  =20
> > > On 06/01/2017 08:52 AM, David Gibson wrote: =20
> > > > On Wed, May 31, 2017 at 10:58:57AM +0200, Greg Kurz wrote:   =20
> > > >> On Wed, 31 May 2017 12:57:48 +1000
> > > >> David Gibson <david@gibson.dropbear.id.au> wrote:   =20
> > > >>> [...]   =20
> > > >>>> All old non-pseries machine types already complain when started =
with
> > > >>>> a POWER7 or newer CPU. Providing the extra error message looks w=
eird:
> > > >>>>
> > > >>>> qemu-system-ppc64 -machine ppce500 \
> > > >>>>                   -cpu POWER7,compat=3Dpower6
> > > >>>> qemu-system-ppc64: CPU 'compat' property is deprecated and has n=
o effect;
> > > >>>>  use max-cpu-compat machine property instead
> > > >>>> MMU model 983043 not supported by this machine.
> > > >>>>
> > > >>>> but I guess it's better than crashing. :)     =20
> > > >>>
> > > >>> Well, sure POWER7 doesn't make sense for an e500 machine for other
> > > >>> reasons.  But POWER7 or POWER8 _would_ make sense for powernv, wh=
ere
> > > >>> compat=3D doesn't.
> > > >>>   =20
> > > >>
> > > >> The powernv machine type doesn't even support CPU features at all:
> > > >>
> > > >>     chip_typename =3D g_strdup_printf(TYPE_PNV_CHIP "-%s", machine=
->cpu_model);
> > > >>     if (!object_class_by_name(chip_typename)) {
> > > >>         error_report("invalid CPU model '%s' for %s machine",
> > > >>                      machine->cpu_model, MACHINE_GET_CLASS(machine=
)->name);
> > > >>         exit(1);
> > > >>     }   =20
> > > >=20
> > > > Ah, well, that's another bug, but not one that's in scope for this
> > > > series.   =20
> > >=20
> > > PowerNV is still work in progress. I would not worry about it too muc=
h.
> > >  =20
> >=20
> > Of course and this isn't the purpose of the discussion actually. We were
> > talking about CPU features being relevant or not depending on the machi=
ne
> > type.
> >=20
> > But I'm not even sure that CPU features are useful at all for ppc, not =
to
> > say very confusing (otherwise this series wouldn't be needed for exampl=
e).
> >=20
> > Speaking of PowerNV, just as an example, I guess the fix would be to
> > forbid machine->cpu_model if it contains features. And probably the same
> > for all other machine types, except pseries for backward compatibility
> > reasons. =20
>=20
> I don't think that's correct in principle.  I can imagine CPU
> properties it might make sense to really set on the cpu, regardless of
> machine type.  A quick look says we don't have any such at the moment,
> but I don't think it's something we should prevent as a matter of policy.
>=20

Fair enough. Then maybe all machine should parse CPU features and check whi=
ch
one are valid before instantiating the CPUs ?

--Sig_/i9ecEWOZ1HQX.LSnOzxxkq_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkxHp0ACgkQAvw66wEB28IbaACdERUal8KQ0DtC9EsAWI9Ld27T
V+kAoJCPxqLDYSTEfn0gMR407R52g9kj
=zoSt
-----END PGP SIGNATURE-----

--Sig_/i9ecEWOZ1HQX.LSnOzxxkq_--
