Received: from eggs.gnu.org ([2001:4830:134:3::10]:54484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1coBtv-0006LK-R1
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 12:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1coBts-0005ii-Nx
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 12:35:51 -0400
Received: from 4.mo68.mail-out.ovh.net ([46.105.59.63]:58756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1coBts-0005gJ-Gx
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 12:35:48 -0400
Received: from player763.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id A05C2460E9
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 17:35:45 +0100 (CET)
Date: Wed, 15 Mar 2017 17:35:37 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170315173537.4e0eb980@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <d354a388-b7ae-09f6-356e-6555d136b5d8@vivier.eu>
References: <87tw6y8bs8.fsf@secure.mitica>
	<CAFEAcA978SJemCfYJPa8jwtuhhi6JGh9pEDGYNJ1npJA3nvEQA@mail.gmail.com>
	<20170314081312.GB13140@stefanha-x1.localdomain>
	<CAFEAcA9F2BPexRieaEhu+UpJxoOdEfw8eggW8b2SjuoMMTNgog@mail.gmail.com>
	<87wpbstesf.fsf@secure.mitica>
	<CAFEAcA9nZszkmH7-P9jkxoGxLYHKspDiS-PFUyVZrrtDfgPNMA@mail.gmail.com>
	<20170315112917.7dddc8a4@bahia.lab.toulouse-stg.fr.ibm.com>
	<d354a388-b7ae-09f6-356e-6555d136b5d8@vivier.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/TGT0SwXDzqe743Z9Clp0coC";
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
To: Laurent Vivier <laurent@vivier.eu>
Cc: Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developer <qemu-devel@nongnu.org>, KVM devel mailing list <kvm@vger.kernel.org>

--Sig_/TGT0SwXDzqe743Z9Clp0coC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Mar 2017 12:25:38 +0100
Laurent Vivier <laurent@vivier.eu> wrote:

> Le 15/03/2017 =C3=A0 11:29, Greg Kurz a =C3=A9crit :
> > On Tue, 14 Mar 2017 11:56:36 +0100
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >  =20
> >> On 14 March 2017 at 09:59, Juan Quintela <quintela@redhat.com> wrote: =
=20
> >>> Peter Maydell <peter.maydell@linaro.org> wrote:   =20
> >>>> On 14 March 2017 at 09:13, Stefan Hajnoczi <stefanha@gmail.com> wrot=
e:   =20
> >>>>> On Mon, Mar 13, 2017 at 11:02:01AM +0100, Peter Maydell wrote:
> >>>>> The minimum requirements for the new language:
> >>>>> 1. Does it support the host operating systems that QEMU runs on?
> >>>>> 2. Does it support the host architectures that QEMU runs on?   =20
> >>>>
> >>>> Speaking of this, I was thinking that we should introduce
> >>>> a rule that for any host OS/arch we support we must have
> >>>> a build machine so we can at least do a compile test.
> >>>> For instance if you believe configure we support Solaris
> >>>> and AIX, but I bet they're bit-rotting. The ia64 backend
> >>>> has to be a strong candidate for being dumped too.
> >>>> Demanding "system we can test on or we drop support"
> >>>> would let us more clearly see what we're actually running
> >>>> on and avoid unnecessarily ruling things out because they
> >>>> don't support Itanium or AIX...   =20
> >>>
> >>> YES, YES and YES.
> >>>
> >>> I demand an osX build machine NOW!!!!  Remote access is ok.   =20
> >>
> >> OSX is actually in the set that's OK because I have a
> >> machine I can test on. The ones that are problems are
> >> all the BSDs, AIX, Solaris, Haiku, and architectures =20
> >=20
> > The most relevant links I could find about AIX hosts only mention=20
> > QEMU 0.9.1:
> >=20
> > http://www.perzl.org/aix/index.php?n=3DMain.Qemu
> > http://www.vivier.eu/Qemu/
> >=20
> > I'm not aware of any effort within IBM to support newer versions
> > of QEMU on an AIX host (Cc'ing Laurent in case he would be aware
> > of a non-IBM initiative).
> > =20
>=20
> At this time it was a personal initiative, made possible because I have
> worked at Bull on the port of GNOME to AIX and had access to some Bull
> AIX Servers.
>=20
> Now this effort has been moved to the AIX Toolbox for Linux Applications:
>=20
> http://www-03.ibm.com/systems/power/software/aix/linux/
>=20

Heh :)

> Perhaps you can try to contact someone inside IBM about this toolbox?
>=20

Not even sure if it's worth the pain as I could not find any trace of QEMU
in the download pages:

http://www-03.ibm.com/systems/power/software/aix/linux/toolbox/alpha.html
https://ftp.software.ibm.com/aix/freeSoftware/aixtoolbox/RPMS/ppc/

Cheers.

--
Greg

> Laurent
>=20
>=20

--Sig_/TGT0SwXDzqe743Z9Clp0coC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljJbVkACgkQAvw66wEB28I+zgCffFvhP+oKhUpSFVlSJxDFgkU1
3EIAnRZC/l2IVy87iuaiiPgz+Qj66hR6
=YRlU
-----END PGP SIGNATURE-----

--Sig_/TGT0SwXDzqe743Z9Clp0coC--
