Received: from eggs.gnu.org ([2001:4830:134:3::10]:57004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cv1bR-0004W8-LG
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:01:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cv1bN-0007vY-LO
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:01:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1cv1bN-0007ty-CX
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:00:57 -0400
Date: Mon, 3 Apr 2017 15:00:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170403130041.GD5036@noname.str.redhat.com>
References: <C885D0FF6A27744DB0B822E32DF6EF029B1CA14A@SESTOEX04.enea.se>
	<9b05e60a-f8c2-ea4f-6be4-f17c0adec510@redhat.com>
	<20170403081542.GA5036@noname.str.redhat.com>
	<33ced3d3-acd7-2945-518d-465a4621b151@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Content-Disposition: inline
In-Reply-To: <33ced3d3-acd7-2945-518d-465a4621b151@redhat.com>
Subject: Re: [Qemu-devel] nbd: Possible regression in 2.9 RCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Ciprian Barbu <Ciprian.Barbu@enea.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, pkrempa@redhat.com, Alexandru Avadanii <Alexandru.Avadanii@enea.com>, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, svc-armband <armband@enea.com>


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 03.04.2017 um 14:39 hat Max Reitz geschrieben:
> On 03.04.2017 10:15, Kevin Wolf wrote:
> > Am 31.03.2017 um 19:43 hat Max Reitz geschrieben:
>=20
> [...]
>=20
> >> So in theory all that's necessary is to set share-rw=3Don for the devi=
ce
> >> in the management layer. But I'm not sure whether that's practical.
> >=20
> > Yes, libvirt needs to provide this option if the guest supports sharing.
> > If it doesn't support sharing, rejecting a read-write NBD client seems
> > correct to me.
> >=20
> > Peter, Eric, what is the status on the libvirt side here?
> >=20
> >> As for just allowing the NBD server write access to the device... To me
> >> that appears pretty difficult from an implementation perspective. We
> >> assert that nobody can write without having requested write access and
> >> we make sure that nobody can request write access without it being
> >> allowed. Making an exception for NBD seems very difficult and would
> >> probably mean we'd have to drop the assertion for write accesses altog=
ether.
> >=20
> > Making an exception would simply be wrong.
>=20
> Indeed. That is why it would be so difficult.
>=20
> The question remains whether it is practical not to make an exception.
> As far as I know, libvirt is only guaranteed to support older qemu
> versions, not necessarily future ones. So we should be allowed to break
> existing use cases here until libvirt is updated (assuming it is
> possible for libvirt to express "guest device allows shared writes" as
> an option for its next release).

If I understand correctly, this is a case of incoming live migration,
i.e. the virtio-blk device which is blocking the writes to the image
doesn't really belong to a running guest yet.

So if we need to make an exception (and actually reading the context
makes it appear so), I guess it would have to be that devices actually
can share the write permission during incoming migration, but not any
more later (unless the share-rw flag is set).

Kevin

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJY4kd4AAoJEH8JsnLIjy/W9o4P/RUqjBEhMbYj2bSeUmRVAYmp
0JUtIUiggO21DIr14CXzcRAi3ZNV1eMReWeRtV7WeC+oBioIzFr+p8QPp98C6JfP
+kvBedh7aJ/2IaqgOR0IjUdfmWewjg4yfdal+afyoRRTpFP7XMWoyjx/D5DJiStt
YXiplkn5pOqTGSy4+nhKOPc36a/8qemkLnfq4zRluLLz19voaXaDAy7FLcoF/n2K
blIw+77P3Mi1XG0LzaQCWZUl2py9xaqgC7l2/f09lm3pZ19+MGh3k5Jr2dISIy/u
KQ4sLBrhsB8CgeT1YjjiBlESyUblo7vQ9X0GAcHveDIMt4UQUZED1rz+08jpXY/A
y/04Hr7z3vKnzD96E/VUHdSkMPDHRl1FYC46XFxEyCYMSxhYiBBmHlMUibpLfmqQ
VRPD/9wOzg6RHhEuwL9jK9sPqQfEmaUfukEbQ0GEiW5a24m+2EbBo5/NnORuEvyG
KFMnEbnlsslpLKWkiAzroNMYk21sAsSIn6G4d3vc+7D6aFLA9wH2975W41sM3tmh
G/oOt3kVGAU2S0ioqMkMT0nHS1F7w1OG68t/UvYfhvgI/c7/1+3V4WnrrXRh/Gwt
guXP6WRkP0XMIFCoFwGAMAUNXu3dcTe1sl/5WS7ANwot2pWU4pCYFypfpDRAbfxo
FIh8y56Sg/XRp6Ogck4i
=DOEa
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
