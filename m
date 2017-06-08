Received: from eggs.gnu.org ([2001:4830:134:3::10]:55900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dItFo-0006A0-B2
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 04:57:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dItFl-0008F6-7U
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 04:57:20 -0400
Received: from 7.mo178.mail-out.ovh.net ([46.105.58.91]:53494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dItFl-0008Ei-0k
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 04:57:17 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 6CADA3E907
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 10:57:15 +0200 (CEST)
Date: Thu, 8 Jun 2017 10:57:04 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170608105704.20097fca@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170608041739.GY13397@umbus.fritz.box>
References: <20170602031507.29881-1-david@gibson.dropbear.id.au>
	<20170608041739.GY13397@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/YGSCRyi.qqORE9_BY53/va.";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCHv5 0/4] Clean up compatibility mode handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: clg@kaod.org, mdroth@linux.vnet.ibm.com, sursingh@redhat.com, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, abologna@redhat.com, sbobroff@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

--Sig_/YGSCRyi.qqORE9_BY53/va.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 8 Jun 2017 14:17:39 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Jun 02, 2017 at 01:15:03PM +1000, David Gibson wrote:
> > This is a rebased and revised version of my patches revising CPU
> > compatiblity mode handling on ppc, last posted in November.  Since
> > then, many of the patches have already been merged (some for 2.9, some
> > since).  This is what's left.
> >=20
> >  * There was conceptual confusion about what a compatibility mode
> >    means, and how it interacts with the machine type.  This cleans
> >    that up, clarifying that a compatibility mode (as an externally set
> >    option) only makes sense on machine types that don't permit the
> >    guest hypervisor privilege (i.e. 'pseries')
> >=20
> >  * It was previously the user's (or management layer's) responsibility
> >    to determine compatibility of CPUs on either end for migration.
> >    This uses the compatibility modes to check that properly during an
> >    incoming migration. =20
>=20
> Anyone willing to give some review and/or testing, particularly for
> patch 2/4.
>=20

I'm planning to re-run all the tests when migration of pre-2.10 machine
types is fixed.

--Sig_/YGSCRyi.qqORE9_BY53/va.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlk5EWAACgkQAvw66wEB28KkzgCeNTsuLCX3nAfgMmvbGGwYDH0O
9UoAn3o1a+putKVPmNTpZOlpQeobMGOc
=yzgq
-----END PGP SIGNATURE-----

--Sig_/YGSCRyi.qqORE9_BY53/va.--
