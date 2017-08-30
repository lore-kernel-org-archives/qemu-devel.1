Received: from eggs.gnu.org ([2001:4830:134:3::10]:45278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dn3zX-0007WB-4v
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:29:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dn3zT-0001MM-SC
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:29:15 -0400
Received: from 17.mo6.mail-out.ovh.net ([46.105.36.150]:59851)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dn3zT-0001Lw-LI
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:29:11 -0400
Received: from player735.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 145381086E8
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 16:29:09 +0200 (CEST)
Date: Wed, 30 Aug 2017 16:28:59 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170830162859.16b5a8a3@bahia>
In-Reply-To: <w51fuc98di8.fsf@maestria.local.igalia.com>
References: <1504016587-39779-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<w51fuc98di8.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/iJ8gq0Fa_.u+/FoGimXAt/f";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v8 0/6] fsdev: qmp interface for io
 throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, eric blake <eblake@redhat.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

--Sig_/iJ8gq0Fa_.u+/FoGimXAt/f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Aug 2017 14:07:59 +0200
Alberto Garcia <berto@igalia.com> wrote:

> On Tue 29 Aug 2017 04:23:01 PM CEST, Pradeep Jagadeesh wrote:
> > These patches provide the qmp interface, to query the io throttle=20
> > status of the all fsdev devices that are present in a vm. =20
>=20
> I'm trying to read from an 9p share that has limits set with hmp
> fsdev_set_io_throttle and I'm having some problems.
>=20
> For example if I'm reading a large file and I change the I/O limits
> while the file is still being read then the guest process freezes.
>=20
> Can you try to reproduce that scenario?
>=20
> Berto

Thanks Berto for the review and the testing ! I'm on vacation but I'll
jump in next week when I'm back and Pradeep has posted the next version.

Cheers,

--
Greg

--Sig_/iJ8gq0Fa_.u+/FoGimXAt/f
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWabLqwAKCRAC/DrrAQHb
wkm9AKCknPAF+Irex25ZBVvDONDhN13YAQCdGHcZ1T9D0fZ8VpsZlyFIULwj2sc=
=r7J4
-----END PGP SIGNATURE-----

--Sig_/iJ8gq0Fa_.u+/FoGimXAt/f--
