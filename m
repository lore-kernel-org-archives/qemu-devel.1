Received: from eggs.gnu.org ([2001:4830:134:3::10]:53377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cijQn-0006uD-Mc
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:11:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cijQj-0003ZX-Ii
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:11:13 -0500
Received: from 16.mo6.mail-out.ovh.net ([87.98.139.208]:49275)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cijQj-0003Z0-CF
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:11:09 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 1671EAFFBC
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 16:11:08 +0100 (CET)
Date: Tue, 28 Feb 2017 16:11:04 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170228161104.3b3b4f12@bahia.lan>
In-Reply-To: <4e9eeab8-faca-b6ba-d53e-a8fbf5848c0f@msgid.tls.msk.ru>
References: <1488277840-18608-1-git-send-email-groug@kaod.org>
	<2a8da4e5-d66d-502c-322b-ec942f250f40@msgid.tls.msk.ru>
	<20170228152240.6efc1fbc@bahia.lan>
	<4e9eeab8-faca-b6ba-d53e-a8fbf5848c0f@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/G4LMCLjZHi/p1Barl3hrbT3";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PULL 00/28] 9p CVE-2016-9602 fixes 2017-02-28 for
 2.9 soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org

--Sig_/G4LMCLjZHi/p1Barl3hrbT3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Feb 2017 17:55:02 +0300
Michael Tokarev <mjt@tls.msk.ru> wrote:

> 28.02.2017 17:22, Greg Kurz wrote:
> > On Tue, 28 Feb 2017 17:02:44 +0300
> > Michael Tokarev <mjt@tls.msk.ru> wrote:
> >  =20
> >> 28.02.2017 13:30, Greg Kurz wrote: =20
> >>> The following changes since commit 9b9fbe8a4e9eec9072ee2697a6af591444=
42785f:
> >>>
> >>>   Merge remote-tracking branch 'remotes/kraxel/tags/pull-ui-20170227-=
1' into staging (2017-02-27 19:19:46 +0000)
> >>>
> >>> are available in the git repository at:
> >>>
> >>>   https://github.com/gkurz/qemu.git tags/cve-2016-9602-for-upstream
> >>>
> >>> for you to fetch changes up to c23d5f1d5bc0e23aeb845b1af8f996f16783ce=
98:   =20
> >>
> >> Greg, did you forget to push maybe? There's no tag "cve-2016-9602-for-=
upstream"
> >> and no object c23d5f1d5bc0e23aeb845b1af8f996f16783ce98.
> >> =20
> >=20
> > I had pushed actually and...
> >=20
> > https://github.com/gkurz/qemu/commits/cve-2016-9602-for-upstream
> > https://github.com/gkurz/qemu/commit/c23d5f1d5bc0e23aeb845b1af8f996f167=
83ce98 =20
>=20
> Interesting. Perhaps I've never worked with github before.
> It works when referring to particular commit like this.
> but the tag isn't visible in github UI, and neither the
> tag nor this commit ID is visible when cloning github
> repository locally. I wonder where's that.
>=20

Yeah I confirm that's the way it goes with github and I was pretty
surprised myself when I first realized that... but I must confess
I never tried to investigate.

> $ git remote -v | grep gkurz
> gkurz	git://github.com/gkurz/qemu.git (fetch)
> gkurz	git://github.com/gkurz/qemu.git (push)
> $ git remote update gkurz
> Fetching gkurz
> $ git show c23d5f1d5bc0e23aeb845b1af8f996f16783ce98
> fatal: bad object c23d5f1d5bc0e23aeb845b1af8f996f16783ce98
> $ git show cve-2016-9602-for-upstream --
> fatal: bad revision 'cve-2016-9602-for-upstream'
>=20
> that's now.  I'll dig into that later, there's apparently
> nothing wrong on your side, I'm sorry for the noise.
>=20

No problem. I've just verified I could merge these two pull
requests in a clean 'git clone' of master, and it works as
expected... phew! :)

Cheers.

--
Greg

> Thanks,
>=20
> /mjt


--Sig_/G4LMCLjZHi/p1Barl3hrbT3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAli1kwgACgkQAvw66wEB28Ix9gCeNXSapjvn7kIxI0700Wq6QjWE
pocAn00vX4Xa5s0ofzpCGxP1QEPsXSn2
=q4+9
-----END PGP SIGNATURE-----

--Sig_/G4LMCLjZHi/p1Barl3hrbT3--
