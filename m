Received: from eggs.gnu.org ([2001:4830:134:3::10]:56435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1cvOTP-000606-JP
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:26:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1cvOTL-0007uv-KV
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:26:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1cvOTL-0007tv-Bm
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:26:11 -0400
Date: Tue, 4 Apr 2017 15:27:05 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20170404132705.GE26598@andariel.pipo.sk>
References: <C885D0FF6A27744DB0B822E32DF6EF029B1CA14A@SESTOEX04.enea.se>
	<9b05e60a-f8c2-ea4f-6be4-f17c0adec510@redhat.com>
	<20170403081542.GA5036@noname.str.redhat.com>
	<20170403125148.GX26598@andariel.pipo.sk>
	<20170404131902.GB4536@noname.str.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mew6/suNvUayQDfo"
Content-Disposition: inline
In-Reply-To: <20170404131902.GB4536@noname.str.redhat.com>
Subject: Re: [Qemu-devel] nbd: Possible regression in 2.9 RCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, Ciprian Barbu <Ciprian.Barbu@enea.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Alexandru Avadanii <Alexandru.Avadanii@enea.com>, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, svc-armband <armband@enea.com>


--mew6/suNvUayQDfo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 04, 2017 at 15:19:02 +0200, Kevin Wolf wrote:
> Am 03.04.2017 um 14:51 hat Peter Krempa geschrieben:
> > On Mon, Apr 03, 2017 at 10:15:42 +0200, Kevin Wolf wrote:
> > > Am 31.03.2017 um 19:43 hat Max Reitz geschrieben:
> > > > On 31.03.2017 18:03, Ciprian Barbu wrote:

[...]

> > > Peter, Eric, what is the status on the libvirt side here?
> >=20
> > Libvirt currently uses the NBD server only for non-shared storage
> > migration. At that point the disk is not shared (while qemu may think
> > so) since the other side is not actually running until the mirror
> > reaches synchronized state.
>=20
> Yes, I misunderstood the situation at first.
>=20
> Anyway, is there already a libvirt patch for the cases where the image
> is actually shared?

As said, we use the nbd server only for migration. There's no other
usage I know of and thus no patch.

--mew6/suNvUayQDfo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAljjnyYACgkQHGwCByjY
1Gog8g//YsjchQIfWEH+ukA7b7SEMlVCTmJnJFXOkwFFG8ARUHOBdQ22kkA4s9lV
bjMuQQ6hSpRe3V1qLkAm9pJPx87WR8kdFTQgFhvXM2v2fpmmCG8bjOafLo1vouvH
RaFz1TWlmKyTXxwl8Ytb0ne/MBNjL2nzytqCVijScHK3BgoTcmQ3yvAPcgRXZ+TA
uZpmyTklFREpcQx6P3ju45mZ9LmU71olGFxxfdUR1iDCXNUvLP1fTvVIz6a+UO6M
lUmEzPOp2Pc2hN86yFOlEjQjmL+aF0xKYQX7wjpile9btsWVt087X4DriS535d2n
5+8ltuJMuUoZ3kLghgTGmiPf8+1aTDZD3nqA1nLYZF/bT79WjRLvENnYmyvTfsuO
E0+V7sB4354vnHQbM2sXrZyTh302QPW5/ZSO+iygkHs85UO8COwmtjJXQR7yNUgL
kTW/evA1RKQCnIojyBrR6TqRpw1mzFKE/IVjhj0/1i60SahxufciNFKIgDaHwISZ
Xr9KXToNmpSroy2FNdYF8OJqkCkAjuPd4RR/nQT3Z3IXPnf4GGJ1tlPCcFAZz7+f
XfSshbkOSQZtabX+vuKQl8qNGTQHX9SPXM/t1JyLZ20VguesgVQx1Zm/IPkbFzZa
Oj8qdbX4K75bLsYS5jnRX88s4IoiwNxWtPdMYnepKmJ/JnzHvvc=
=rPRz
-----END PGP SIGNATURE-----

--mew6/suNvUayQDfo--
