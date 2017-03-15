Received: from eggs.gnu.org ([2001:4830:134:3::10]:41126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1co6BN-0001Xm-G4
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 06:29:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1co6BK-0002dB-BR
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 06:29:29 -0400
Received: from 8.mo68.mail-out.ovh.net ([46.105.74.219]:45212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1co6BK-0002cK-4k
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 06:29:26 -0400
Received: from player763.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 828BA4614B
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 11:29:24 +0100 (CET)
Date: Wed, 15 Mar 2017 11:29:17 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170315112917.7dddc8a4@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <CAFEAcA9nZszkmH7-P9jkxoGxLYHKspDiS-PFUyVZrrtDfgPNMA@mail.gmail.com>
References: <87tw6y8bs8.fsf@secure.mitica>
	<CAFEAcA978SJemCfYJPa8jwtuhhi6JGh9pEDGYNJ1npJA3nvEQA@mail.gmail.com>
	<20170314081312.GB13140@stefanha-x1.localdomain>
	<CAFEAcA9F2BPexRieaEhu+UpJxoOdEfw8eggW8b2SjuoMMTNgog@mail.gmail.com>
	<87wpbstesf.fsf@secure.mitica>
	<CAFEAcA9nZszkmH7-P9jkxoGxLYHKspDiS-PFUyVZrrtDfgPNMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/iQ4=7Yz5Va9YCup=rV7rXAq";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] KVM call for 2017-03-14
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Juan Quintela <quintela@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developer <qemu-devel@nongnu.org>, KVM devel mailing list <kvm@vger.kernel.org>, Laurent Vivier <laurent@vivier.eu>

--Sig_/iQ4=7Yz5Va9YCup=rV7rXAq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Mar 2017 11:56:36 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 14 March 2017 at 09:59, Juan Quintela <quintela@redhat.com> wrote:
> > Peter Maydell <peter.maydell@linaro.org> wrote: =20
> >> On 14 March 2017 at 09:13, Stefan Hajnoczi <stefanha@gmail.com> wrote:=
 =20
> >>> On Mon, Mar 13, 2017 at 11:02:01AM +0100, Peter Maydell wrote:
> >>> The minimum requirements for the new language:
> >>> 1. Does it support the host operating systems that QEMU runs on?
> >>> 2. Does it support the host architectures that QEMU runs on? =20
> >>
> >> Speaking of this, I was thinking that we should introduce
> >> a rule that for any host OS/arch we support we must have
> >> a build machine so we can at least do a compile test.
> >> For instance if you believe configure we support Solaris
> >> and AIX, but I bet they're bit-rotting. The ia64 backend
> >> has to be a strong candidate for being dumped too.
> >> Demanding "system we can test on or we drop support"
> >> would let us more clearly see what we're actually running
> >> on and avoid unnecessarily ruling things out because they
> >> don't support Itanium or AIX... =20
> >
> > YES, YES and YES.
> >
> > I demand an osX build machine NOW!!!!  Remote access is ok. =20
>=20
> OSX is actually in the set that's OK because I have a
> machine I can test on. The ones that are problems are
> all the BSDs, AIX, Solaris, Haiku, and architectures

The most relevant links I could find about AIX hosts only mention=20
QEMU 0.9.1:

http://www.perzl.org/aix/index.php?n=3DMain.Qemu
http://www.vivier.eu/Qemu/

I'm not aware of any effort within IBM to support newer versions
of QEMU on an AIX host (Cc'ing Laurent in case he would be aware
of a non-IBM initiative).

I can maybe try to grab an AIX system and see what happens. I'm
okay to run the deprecation process if we choose to go that way.

Cheers.

--
Greg

> sparc, mips, ia64, s390.
>=20
> thanks
> -- PMM
>=20


--Sig_/iQ4=7Yz5Va9YCup=rV7rXAq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljJF30ACgkQAvw66wEB28Il3wCbBJBVec/d9Y2xOnrjrQ9RhsJx
FkwAn2PzRYOo/wmcxLMlALq3/Ho8vPpm
=CflD
-----END PGP SIGNATURE-----

--Sig_/iQ4=7Yz5Va9YCup=rV7rXAq--
