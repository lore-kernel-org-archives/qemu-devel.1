Received: from eggs.gnu.org ([2001:4830:134:3::10]:52377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cjhDJ-0002KJ-Im
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 02:01:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cjhDI-0006zV-PX
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 02:01:17 -0500
Received: from 6.mo173.mail-out.ovh.net ([46.105.43.93]:33178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cjhDI-0006w3-JQ
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 02:01:16 -0500
Received: from player726.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 7788E16EA7
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 08:01:07 +0100 (CET)
Date: Fri, 3 Mar 2017 08:01:01 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170303080101.69703246@bahia.lan>
In-Reply-To: <20170303021109.GA11833@stefanha-x1.localdomain>
References: <20170301115026.22621-1-stefanha@redhat.com>
	<20170301222748.2c7a3ead@bahia.lan>
	<20170303021109.GA11833@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/A3tLBDEWTJ/TVLAd=A0bzUv";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 0/3] throttle: improve
 command-line parameter documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Nini Gu <ngu@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

--Sig_/A3tLBDEWTJ/TVLAd=A0bzUv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Mar 2017 10:11:09 +0800
Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Wed, Mar 01, 2017 at 10:27:48PM +0100, Greg Kurz wrote:
> > On Wed,  1 Mar 2017 11:50:23 +0000
> > Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >  =20
> > > v3:
> > >  * Added Patch 2 to fix invalid test parameters
> > >  * Switched to nicer max < avg check [Berto]
> > > v2:
> > >  * Fixed s/bps/iops/ copy-paste error in Patch 1 [Berto]
> > >  * Rephrased warning about guest hangs and errors [Berto]
> > >  * Added Patch 2 to hide the internal .max value from the monitor
> > >=20
> > > Patch 1 fleshes out the documentation for I/O throttling command-line
> > > parameters.
> > >=20
> > > Patch 2 hides an internal value that was being exposed to users via t=
he
> > > monitor and caused confusion.
> > >=20
> > > I ended up not adding QMP-style throttling.* names to the command-line
> > > documentation because the names are very long and unlikely to be used=
.  I
> > > couldn't see a nice way of adding them while still keeping the docume=
ntation
> > > readable.
> > >  =20
> >=20
> > I only see this series now and it's a bit unfortunate... throttling opt=
ions
> > are now also available for fsdev. Only QMP-style names were added thoug=
h,
> > and they appear in the documentation. I agree the names are long, and t=
he
> > result isn't pretty on 80 columns, but it is readable still.
> >=20
> > I don't really want to add code, just to have shorter names and a prett=
ier
> > output. But it would be a good thing for fsdev to benefit from this new
> > documentation... any suggestion how to do that ? =20
>=20
> I think another patch series would be good to:
> 1. Document QMP-style names for -drive
> 2. Reference throttling parameter documention in a common place for both
>    -fsdev and -drive.
>=20
> I'll do that.  This is QEMU 2.10 material anyway (it has missed the
> freeze deadline), so there's no time pressure.
>=20
> Stefan

Sure. Please Cc me when you do that.

Thanks.

--
Greg

--Sig_/A3tLBDEWTJ/TVLAd=A0bzUv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAli5FK0ACgkQAvw66wEB28Jd+QCeJcHNa5qUvSBn9JleX4s5iEvn
/4oAnijLmf1ZjUNhQI6FyKHUjd0y8BFi
=tTSI
-----END PGP SIGNATURE-----

--Sig_/A3tLBDEWTJ/TVLAd=A0bzUv--
