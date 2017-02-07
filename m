Received: from eggs.gnu.org ([2001:4830:134:3::10]:56488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cb8eK-0003Ve-Jg
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:29:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cb8eH-0004UV-Ca
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:29:48 -0500
Received: from 10.mo179.mail-out.ovh.net ([46.105.79.46]:34816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cb8eH-0004TY-6F
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:29:45 -0500
Received: from player732.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id B207D21A77
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 17:29:42 +0100 (CET)
Date: Tue, 7 Feb 2017 17:29:33 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170207172933.05574f60@bahia.lan>
In-Reply-To: <6b702369-7891-4e38-7240-57ad643657bd@redhat.com>
References: <1486123043-26493-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1486123043-26493-2-git-send-email-pradeep.jagadeesh@huawei.com>
	<71b1733d-7638-5e27-e828-fad57f76f507@redhat.com>
	<20170207001533.3f18e4ea@bahia.lan>
	<20170207113231.44e35be6@bahia.lan>
	<6b702369-7891-4e38-7240-57ad643657bd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/7nO+FYEDC9WBP+Ini.Z96S_";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 1/2 v16] fsdev: add IO throttle support to
 fsdev devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Alberto Garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

--Sig_/7nO+FYEDC9WBP+Ini.Z96S_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Cc'ing Stefan who reviewed patch 2/2.

On Tue, 7 Feb 2017 09:56:08 -0600
Eric Blake <eblake@redhat.com> wrote:

> On 02/07/2017 04:32 AM, Greg Kurz wrote:
> >>
> >> I'm not aware of anything related to fsdev in QMP... and libvirt seems=
 to
> >> only parse the output of -help to guess fsdev capabilities. =20
> >=20
> > Oops, reading some more libvirt code I now see that libvirt doesn't par=
se
> > -help anymore with QEMU >=3D 1.2.0... sorry for the noise :)
> >  =20
> >> And indeed,
> >> qemu-options.hx doesn't expose this new feature.
> >> =20
> >>> Please make sure we don't reach 2.9 with only a half-baked feature;
> >>> whether that means finishing the QMP work or temporarily disabling the
> >>> cli additions until a later release can finish the work.
> >>>    =20
> >>
> >> Would this be ok to add the missing bits in qemu-options.hx or do you
> >> expect more ? =20
>=20
> If it cannot be probed via QMP, then libvirt will most likely assume
> that it does not exist.  I guess we're okay having command line only in
> 2.9 if you can't get QMP working, because libvirt will just never drive
> the feature until 2.10 when QMP is available; but then we risk the
> command line subtly changing and breaking someone else that was using
> the command line without QMP.  Maybe the safest approach is to just use
> the 'x-' prefix to the command line portion, until the feature is complet=
e.
>=20

The semantics here are exactly the same as for block devices. The
command line options added to -fsdev are the very same already used
by -drive for years.

Patch 2/2 in this series even factors them out to a common header file
to be used by fsdev and blockdev. I really don't expect any modification
at all on the command line (nor the other people who reviewed that patch
obviously)... are you suggesting that we should put 2/2 on hold and
use the 'x-' prefix anyway ?

Cheers.

--
Greg

--Sig_/7nO+FYEDC9WBP+Ini.Z96S_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAliZ9e0ACgkQAvw66wEB28IKdgCgi1e6649v+OiwCHGtduPat9Gf
ilIAn1PwN+ZEQaCAGYB5RzosqedRDNYJ
=1XZX
-----END PGP SIGNATURE-----

--Sig_/7nO+FYEDC9WBP+Ini.Z96S_--
