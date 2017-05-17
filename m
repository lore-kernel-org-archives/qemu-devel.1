Received: from eggs.gnu.org ([2001:4830:134:3::10]:48584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAvuN-0004cw-Ke
	for qemu-devel@nongnu.org; Wed, 17 May 2017 06:10:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAvuM-0005HG-PI
	for qemu-devel@nongnu.org; Wed, 17 May 2017 06:10:19 -0400
Received: from 11.mo3.mail-out.ovh.net ([87.98.184.158]:57649)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dAvuM-0005H7-JC
	for qemu-devel@nongnu.org; Wed, 17 May 2017 06:10:18 -0400
Received: from player797.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 66502D2254
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 12:10:17 +0200 (CEST)
Date: Wed, 17 May 2017 12:10:09 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170517121009.248fb4bc@bahia.lan>
In-Reply-To: <20170517063752.GI15596@umbus.fritz.box>
References: <20170426070034.10727-1-david@gibson.dropbear.id.au>
	<20170426070034.10727-20-david@gibson.dropbear.id.au>
	<0b2e2d1c-d7ba-7d43-42b5-04ba592bf3e8@redhat.com>
	<1a7e5576-6464-6d5b-f4a8-44dceb8a17af@kaod.org>
	<0dc5ffde-39b7-6fd4-dc88-d66789414e4e@redhat.com>
	<45db5bad-e1f3-d2d0-7014-878391638f6d@kaod.org>
	<20170516181004.624cf441@bahia.lan>
	<d8354004-1a76-bc67-cd9c-55a2b95ae142@kaod.org>
	<20170517063752.GI15596@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/tnGTLWUtdA3Su=M9rBZj_19";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 19/48] spapr: allocate the
 ICPState object from under sPAPRCPUCore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, Laurent Vivier <lvivier@redhat.com>, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>

--Sig_/tnGTLWUtdA3Su=M9rBZj_19
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 17 May 2017 16:37:52 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:
[...]
> > >>
> > >> Greg is looking at re-adding the ICPState array because of a=20
> > >> migration issue with older machines. We might need to do so=20
> > >> unconditionally ...
> > >> =20
> > >=20
> > > That would be a pity to carry on with the pre-allocated ICPStates for
> > > new machine types just because of that... What about keeping track
> > > of all the cap_irq_xics_enabled flags in a separate max_cpus sized
> > > static array ? =20
> >=20
> > Could we use 'cpu->unplug' instead ? =20
>=20
> I've only half followed this discussion, but fwiw I prefer the idea of
> "parking" in-kernel ICP objects, similarly to the way we do for
> removed VCPUs, rather than going back to keeping ICP objects around
> indefinitely and unconditionally.
>=20

I'll give a try.

Cheers,

--
Greg

--Sig_/tnGTLWUtdA3Su=M9rBZj_19
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkcIYEACgkQAvw66wEB28JTlACeJxKDfaEK5LJ1BzV3F5gGdpQQ
pMIAnjkm/0F8QPOslbExU3klUDM+7mCL
=EZyS
-----END PGP SIGNATURE-----

--Sig_/tnGTLWUtdA3Su=M9rBZj_19--
