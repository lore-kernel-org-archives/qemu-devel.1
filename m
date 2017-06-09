Received: from eggs.gnu.org ([2001:4830:134:3::10]:33168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dJG6Q-0003hQ-Im
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 05:21:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dJG6N-00055F-FC
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 05:21:10 -0400
Received: from 10.mo178.mail-out.ovh.net ([46.105.76.150]:52030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dJG6N-00054z-7x
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 05:21:07 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 6B3DA3EC96
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 11:21:05 +0200 (CEST)
Date: Fri, 9 Jun 2017 11:20:52 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170609112052.64d86e83@bahia.ttt.fr.ibm.com>
In-Reply-To: <09cf094d-55ce-ee3c-6dcc-dd0eee894d8a@huawei.com>
References: <1494405683-20877-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1494405683-20877-5-git-send-email-pradeep.jagadeesh@huawei.com>
	<6a035cd9-34f9-c1f5-e986-404daf941641@redhat.com>
	<57a24e21-0864-16d3-1bce-ad801875ea9f@huawei.com>
	<2c0e99ce-f3cb-90e8-baed-8fad9d39455b@redhat.com>
	<20170517182938.0c7f366e@bahia.lan>
	<6df407d5-4145-2e90-a7eb-b047819ceb75@redhat.com>
	<e1d5b2d3-bfe7-4fac-03f7-bbfbd5de10fe@huawei.com>
	<20170608184915.20056e6c@bahia.ttt.fr.ibm.com>
	<d08e5a11-0b75-a111-40c4-2f09f37404b1@huawei.com>
	<20170609110741.5ef3e49d@bahia.ttt.fr.ibm.com>
	<09cf094d-55ce-ee3c-6dcc-dd0eee894d8a@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/tyLN0CYXQtyvJ/F0K2Av7jQ";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v4 4/4] fsdev: QMP interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Cc: Eric Blake <eblake@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, alberto garcia <berto@igalia.com>, qemu-devel@nongnu.org, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>

--Sig_/tyLN0CYXQtyvJ/F0K2Av7jQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 9 Jun 2017 11:13:50 +0200
Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com> wrote:

> On 6/9/2017 11:07 AM, Greg Kurz wrote:
> >   GEN     qmp-commands.h
> > /tmp/qemu-test/src/qapi-schema.json:85: No such file or directory: qapi=
/fsdev.json
> > Makefile:438: recipe for target 'qmp-commands.h' failed
> >
> > Please fix that. =20
> Ho ok, I will have a look.
> How are you trying to compile, using "make docker" options?

=46rom the QEMU source tree I do:

mkdir build
cd build
../configure
make docker-test-mingw@fedora

>=20
>=20
> Thanks
> Pradeep
>=20


--Sig_/tyLN0CYXQtyvJ/F0K2Av7jQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlk6aHQACgkQAvw66wEB28JfbQCeLZld2kuW64l1X3cqALUhhA42
nhIAnijTMVFkl0D5L2RBk/DuvwV/YMj5
=+bn8
-----END PGP SIGNATURE-----

--Sig_/tyLN0CYXQtyvJ/F0K2Av7jQ--
