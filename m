Received: from eggs.gnu.org ([2001:4830:134:3::10]:40758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dGPrF-0002jN-0J
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 09:09:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dGPrB-0006lc-PO
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 09:09:44 -0400
Received: from 15.mo5.mail-out.ovh.net ([178.33.107.29]:54187)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dGPrB-0006hz-Ic
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 09:09:41 -0400
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id D132E100A38
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 15:09:32 +0200 (CEST)
Date: Thu, 1 Jun 2017 15:09:15 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170601150915.2bb628f5@bahia.lan>
In-Reply-To: <f353022f-6b48-ab18-f156-bd8fac8cf884@kaod.org>
References: <20170526052319.28096-1-david@gibson.dropbear.id.au>
	<20170530011416.01eea576@bahia.ttt.fr.ibm.com>
	<20170530061852.GE12163@umbus.fritz.box>
	<20170530100136.680ce96f@bahia.ttt.fr.ibm.com>
	<20170531025748.GG12163@umbus.fritz.box>
	<20170531105857.62a25a84@bahia.ttt.fr.ibm.com>
	<20170601065233.GD13397@umbus.fritz.box>
	<f353022f-6b48-ab18-f156-bd8fac8cf884@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/HtHEq1cfkuRnhF/UZgyqADN";
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
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, agraf@suse.de, abologna@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, sursingh@redhat.com, sbobroff@redhat.com

--Sig_/HtHEq1cfkuRnhF/UZgyqADN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 1 Jun 2017 13:59:14 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 06/01/2017 08:52 AM, David Gibson wrote:
> > On Wed, May 31, 2017 at 10:58:57AM +0200, Greg Kurz wrote: =20
> >> On Wed, 31 May 2017 12:57:48 +1000
> >> David Gibson <david@gibson.dropbear.id.au> wrote: =20
> >>> [...] =20
> >>>> All old non-pseries machine types already complain when started with
> >>>> a POWER7 or newer CPU. Providing the extra error message looks weird:
> >>>>
> >>>> qemu-system-ppc64 -machine ppce500 \
> >>>>                   -cpu POWER7,compat=3Dpower6
> >>>> qemu-system-ppc64: CPU 'compat' property is deprecated and has no ef=
fect;
> >>>>  use max-cpu-compat machine property instead
> >>>> MMU model 983043 not supported by this machine.
> >>>>
> >>>> but I guess it's better than crashing. :)   =20
> >>>
> >>> Well, sure POWER7 doesn't make sense for an e500 machine for other
> >>> reasons.  But POWER7 or POWER8 _would_ make sense for powernv, where
> >>> compat=3D doesn't.
> >>> =20
> >>
> >> The powernv machine type doesn't even support CPU features at all:
> >>
> >>     chip_typename =3D g_strdup_printf(TYPE_PNV_CHIP "-%s", machine->cp=
u_model);
> >>     if (!object_class_by_name(chip_typename)) {
> >>         error_report("invalid CPU model '%s' for %s machine",
> >>                      machine->cpu_model, MACHINE_GET_CLASS(machine)->n=
ame);
> >>         exit(1);
> >>     } =20
> >=20
> > Ah, well, that's another bug, but not one that's in scope for this
> > series. =20
>=20
> PowerNV is still work in progress. I would not worry about it too much.
>=20

Of course and this isn't the purpose of the discussion actually. We were
talking about CPU features being relevant or not depending on the machine
type.

But I'm not even sure that CPU features are useful at all for ppc, not to
say very confusing (otherwise this series wouldn't be needed for example).

Speaking of PowerNV, just as an example, I guess the fix would be to
forbid machine->cpu_model if it contains features. And probably the same
for all other machine types, except pseries for backward compatibility
reasons.

> C.=20
>=20


--Sig_/HtHEq1cfkuRnhF/UZgyqADN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkwEfsACgkQAvw66wEB28KpUgCgn6vejJ4aiY85k5s2FH9gF1ln
FjoAn1W6GgMu4xHJSereKBGxvBltQ3V0
=c7hu
-----END PGP SIGNATURE-----

--Sig_/HtHEq1cfkuRnhF/UZgyqADN--
