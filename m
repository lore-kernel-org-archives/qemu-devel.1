Received: from eggs.gnu.org ([2001:4830:134:3::10]:36065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cvOug-0006QS-4s
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cvOud-0003fJ-34
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:54:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1cvOuc-0003eu-O6
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:54:23 -0400
Date: Tue, 4 Apr 2017 15:54:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170404135414.GC4536@noname.str.redhat.com>
References: <C885D0FF6A27744DB0B822E32DF6EF029B1CA14A@SESTOEX04.enea.se>
	<9b05e60a-f8c2-ea4f-6be4-f17c0adec510@redhat.com>
	<20170403081542.GA5036@noname.str.redhat.com>
	<20170403125148.GX26598@andariel.pipo.sk>
	<20170404131902.GB4536@noname.str.redhat.com>
	<20170404132705.GE26598@andariel.pipo.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
Content-Disposition: inline
In-Reply-To: <20170404132705.GE26598@andariel.pipo.sk>
Subject: Re: [Qemu-devel] nbd: Possible regression in 2.9 RCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, Ciprian Barbu <Ciprian.Barbu@enea.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Alexandru Avadanii <Alexandru.Avadanii@enea.com>, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, svc-armband <armband@enea.com>


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 04.04.2017 um 15:27 hat Peter Krempa geschrieben:
> On Tue, Apr 04, 2017 at 15:19:02 +0200, Kevin Wolf wrote:
> > Am 03.04.2017 um 14:51 hat Peter Krempa geschrieben:
> > > On Mon, Apr 03, 2017 at 10:15:42 +0200, Kevin Wolf wrote:
> > > > Am 31.03.2017 um 19:43 hat Max Reitz geschrieben:
> > > > > On 31.03.2017 18:03, Ciprian Barbu wrote:
>=20
> [...]
>=20
> > > > Peter, Eric, what is the status on the libvirt side here?
> > >=20
> > > Libvirt currently uses the NBD server only for non-shared storage
> > > migration. At that point the disk is not shared (while qemu may think
> > > so) since the other side is not actually running until the mirror
> > > reaches synchronized state.
> >=20
> > Yes, I misunderstood the situation at first.
> >=20
> > Anyway, is there already a libvirt patch for the cases where the image
> > is actually shared?
>=20
> As said, we use the nbd server only for migration. There's no other
> usage I know of and thus no patch.

I mean two VMs sharing the same image file, and both expose it as a
guest device. The situation for which we discussed before that libvirt
needs to pass share-rw=3Don. I understand that this isn't related to this
report, but I want to make sure that it's not forgotten.

Kevin

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJY46WGAAoJEH8JsnLIjy/WdD0P/10xh6ngPQE0Wn4x7JtgwEwh
hAOJOMfJ7V3hcbUVDnp00rVJc636cXpTUXLyX6OtNDGlOrMOXBBJ01UqLrcqkdUX
rMMsp2urMScG9WLiEm7YF9BYdvtIUL70EXS1ro1RbFw/aXpsfC8VdG1ZfVvi4Vt4
6GCV39O71n1KkP9HD5897vArox+4DZa8XzfNcxB8aNkXthstpvDm3+OAXJt24nuL
uRPIwc8i8nTIhdhb2GfHBRgP4e6UESR5RHilmQpPRAkcGg38PJGnoArUiBgDiMSG
JcBWhNk4gFGneWJ4jwMkh2oSzvITh08mFboBbwbxMhoEP7xvUQSpnz26FdHlJhnh
iI0iA5akxkz7+OMTd62LjhyVcS85PPyjWHQoWZS3lErOmnukQ+KbyvaqvHP8kSpw
PCotWIIDcHUvgmcsfdxNsoke+CWlIQ8tG6sEJW/iqOfQ5DdtwVktMI1Gl6M7Yj4f
ZSeDfvLYnGmlLWYCAm02obaAh++8t5Ce8ZYkaEi/fLdDSajHF1WS/5q+FhyDXGEY
tJ5bFdqLoxRP9BgrfsrfhK7a3PvUm7NWhqYobMAzQzWpNPQ84LSreIVmLXq34Mab
aT6YjJDafGo9lXv2gCIJoYrGzoIIZrArA93lDV7r4Z1hRGmZqXaCto5EKBvjuy+q
sFQV0njgUvWu9oLLk1Ru
=B1JR
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--
