Received: from eggs.gnu.org ([2001:4830:134:3::10]:44168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cvih2-0006hD-QM
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 07:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cvigy-0002h2-L3
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 07:01:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1cvigy-0002gs-CU
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 07:01:36 -0400
Date: Wed, 5 Apr 2017 13:01:31 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170405110131.GA5161@noname.redhat.com>
References: <C885D0FF6A27744DB0B822E32DF6EF029B1CA14A@SESTOEX04.enea.se>
	<9b05e60a-f8c2-ea4f-6be4-f17c0adec510@redhat.com>
	<20170403081542.GA5036@noname.str.redhat.com>
	<33ced3d3-acd7-2945-518d-465a4621b151@redhat.com>
	<20170403130041.GD5036@noname.str.redhat.com>
	<20170403135012.GY26598@andariel.pipo.sk>
	<20170404121624.GA4536@noname.str.redhat.com>
	<d270f1a4-5814-9b23-61f6-745c73ecaadd@redhat.com>
	<20170404145348.GD4536@noname.str.redhat.com>
	<b58edec8-b383-5079-77f2-6f194701ce52@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <b58edec8-b383-5079-77f2-6f194701ce52@redhat.com>
Subject: Re: [Qemu-devel] nbd: Possible regression in 2.9 RCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>, svc-armband <armband@enea.com>, Markus Armbruster <armbru@redhat.com>, Jeff Cody <jcody@redhat.com>, Ciprian Barbu <Ciprian.Barbu@enea.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Alexandru Avadanii <Alexandru.Avadanii@enea.com>


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 04.04.2017 um 17:09 hat Paolo Bonzini geschrieben:
> On 04/04/2017 16:53, Kevin Wolf wrote:
> >> The big question is how this fits into release management.  We have
> >> another important regression from the op blocker work and only a week
> >> to go before the last rc.  Are we going to delay 2.9 arbitrarily?  Are
> >> we going to shorten the 2.10 development period correspondingly?  (I
> >> vote yes and yes, FWIW).
> > Which is the other regression?
>=20
> The assertion failure for snapshot_blkdev with iothreads.

Ah, right, I keep forgetting that this started appearing with the op
blocker series because the failure mode is completely different, so it
seems to have been a latent bug somewhere else that was uncovered by it.

If we're sure that the change of the order in bdrv_append() is what
caused the bug to appear, we can just undo that for 2.9, at the cost of
a messed up graph in the error case when bdrv_set_backing_hd() fails
(because we have no way to undo bdrv_replace_node()).

Kevin

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJY5M6LAAoJEH8JsnLIjy/WXG8QAJobcZmz/zc1EgfCH3nwumru
C/oiOI8RQkBUPPQftONbJRMBSoNu5I3omtxLc/06W6CqYbxUjyphQLL4U2tJAZDs
mWHBahk3B5Gp99PkcWEvhsXeP1mdBlNMuYRFfTbO8hxZzPPUCP2ig7sN90CZO5Ug
mzf1xVHU9L9pAVPzHh76tsaWHDlBt68p7KEsGl6cwbFBxL30XBuUKxlFSYu3/iGd
FcLY//FInXVREqCprk4KbjirVNMvhe0oVFSu5nE8q+7lnjEJKPfpHoS0LzfFtepe
IS2n53a2sRs+Ridj3VwK1UhefO/zTpZJmOF5Z7AbdpA/Z68HZ2OJAgtnOI/cnmW+
4815kK9oBKNMUkT+SfGNIKeqMtE6TSAvXVXJvXCU3RqzavleRIi0ThaxcziCHSI5
e7XUyKfOTt9FGRe4PYoD2Mrxd6AtlUW1uY0XDRjKSUDlkML0h/0xptboYyj3AlVu
qJp6qTXfe0DH0Nd8P8FXgNw/3AW7arWek/zE/in9/TT5MZ/ZSghAPPB+pJI/zPbd
5NSPJX++xdF0eKjPOPjR3+K1aPgeot91WbSYc1yLGhfh8zKpv3fLpP1HdaWhPLss
SAwkX+q5Jt1WKdEudYoj4r3itN4/4G5K/lWlWOsDKqErAxAt4tdi2hXUm9FvjHBp
BR0Vtw4KZGnhIx9jq9mE
=9CsH
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
