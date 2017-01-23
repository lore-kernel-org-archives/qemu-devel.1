Received: from eggs.gnu.org ([2001:4830:134:3::10]:45708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cVbrH-0001Hr-Ez
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:28:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cVbrD-0005hI-Hw
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:28:19 -0500
Received: from mail-wj0-x243.google.com ([2a00:1450:400c:c01::243]:33495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cVbrD-0005fe-Ba
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:28:15 -0500
Received: by mail-wj0-x243.google.com with SMTP id un2so1527625wjb.0
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 02:28:15 -0800 (PST)
Date: Mon, 23 Jan 2017 10:28:10 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170123102810.GD29186@stefanha-x1.localdomain>
References: <54F1DEE8.3010903@weilnetz.de>
	<20150302221228.GC4114@stefanha-thinkpad.redhat.com>
	<3763fa56-5bba-b060-6ee8-120c9cc50dbb@weilnetz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Km1U/tdNT/EmXiR1"
Content-Disposition: inline
In-Reply-To: <3763fa56-5bba-b060-6ee8-120c9cc50dbb@weilnetz.de>
Subject: Re: [Qemu-devel] QEMU website (wiki) improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>


--Km1U/tdNT/EmXiR1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 22, 2017 at 04:19:43PM +0100, Stefan Weil wrote:
> On 03/02/15 23:12, Stefan Hajnoczi wrote:
> > On Sat, Feb 28, 2015 at 04:29:44PM +0100, Stefan Weil wrote:
> > > * It does not support secure access (https), so each login is insecur=
e.
> > >   Can we get a free server certificate?
> >=20
> > This is on my todo list.  I'm travelling right now but will work on it
> > over the coming weeks.
> >=20
> > There are some gotchas:
> >=20
> > 1. qemu.org vs qemu-project.org.  Unless we get a SNI certificate, the
> >    certificate will only be valid for one or the other.  Users will get
> >    an untrusted certificate message if they go to the other domain name.
> >=20
> > 2. We use subdomains, so a wildcard certificate is necessary.  That's
> >    not always offered for free so I need to compare the certificate
> >    vendors.
> >=20
> > Stefan
>=20
>=20
> Although this discussion thread is rather old, its subject
> still applies.
>=20
> In the meantime there are free certificates available.
> We could add https support with a certificate from
> https://letsencrypt.org/. As long as there is only a
> small number of host names (*), I'd simply add them all
> to the primary certificate. In addition, SNI certificates
> for the different names can be installed.

Good idea, Jeff and I have discussed Let's Encrypt and have experience
setting it up.

> I can help with the installation if that is needed.
>=20
> Stefan
>=20
> (*)
>=20
> qemu.org
> qemu.osuosl.org
> qemu-project.org
> wiki.qemu.org
> wiki.qemu-project.org
> www.qemu.org
> www.qemu-project.org
>=20
> Are there more host names used?

git.qemu.org
git.qemu-project.org

--Km1U/tdNT/EmXiR1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYhdq6AAoJEJykq7OBq3PIgKcH/jvw0Bh1ZEP3r4fUA3xGrNIT
rSjUZndAun4MLqEbry2Hdy+bNMECdi8khWLQ9xzxF+jnwJewrs+O0r4haSEhkym3
uXCflXkg4QVV0wcooR4p1govGo6otWo6/yrVod1uCcj4qkie4aWTD2Qf7vghnqdu
nwbNxUycyrNGfSMnHiMyD+xZMZiRY8O1Nqb3rbNhdP3MQjZp/PeEFDw9qPYbewje
CP7Afx60WYBjMGJkgOgjG8YQGmtg3Xadg5HC8+AducLkTfSmicND1yIm8xYNwgfB
hht2i2rvEwAzAwxVFxf0L3Y2lZX5dxz8ID3f2bVhD/WaMWXwO63O2wAW+ZW7yWE=
=+bnT
-----END PGP SIGNATURE-----

--Km1U/tdNT/EmXiR1--
