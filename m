Received: from eggs.gnu.org ([2001:4830:134:3::10]:37583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dpHD4-0008TE-9K
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:00:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dpHCz-0002Jv-KW
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:00:22 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:42320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dpHCz-0002J5-DU
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:00:17 -0400
Received: from player157.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 90616AACE4
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 19:00:15 +0200 (CEST)
Date: Tue, 5 Sep 2017 19:00:10 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170905190010.0c84335f@bahia>
In-Reply-To: <150462482278.16876.9815938798442180307@loki>
References: <150451194093.7046.18254446012958612468.stgit@bahia>
	<1d5efdef-21b8-9b7b-6939-339b97fd9bce@redhat.com>
	<20170905162425.3a202a87@bahia>
	<150462482278.16876.9815938798442180307@loki>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/.nQxN3ZK3C7V0nWgTK58+FS";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] virtfs: error out gracefully when
 mandatory suboptions are missing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org

--Sig_/.nQxN3ZK3C7V0nWgTK58+FS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 05 Sep 2017 10:20:22 -0500
Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
[...]
> >=20
> > Well, it's been there forever and it isn't a critical fix... but the
> > thread on qemu-discuss the other day showed that it was confusing
> > people, and the fix is trivial. So I guess it doesn't hurt to have
> > this in stable. :)
> >=20
> > Michael,
> >=20
> > I'll send a pull req later today. If it's not too late, maybe you can a=
dd
> > this patch to 2.9.1 when it's merged in master? =20
>=20
> We're in freeze as of yesterday with release set for Thursday, so it's a
> bit late. OTOH I don't have test coverage for virtfs and the patch seems
> isolated enough that I don't see any harm in slipping it in if it
> lands in master by tomorrow. Otherwise it'll have to wait for 2.10.1,
> which I'm hoping to get out this month.
>=20

The fix just got merged.

commit 32b6943699948f7adc35ada233fbd25daffad5e9
Author: Greg Kurz <groug@kaod.org>
Date:   Mon Sep 4 09:59:01 2017 +0200

    virtfs: error out gracefully when mandatory suboptions are missing

Cheers,

--
Greg

--Sig_/.nQxN3ZK3C7V0nWgTK58+FS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWa7YGgAKCRAC/DrrAQHb
wlG6AJ9o7+EGTKLK1GX4nXPXvWicFU78RACffs/3c1YgnWIaPI6sDA1KapA5uzU=
=shm+
-----END PGP SIGNATURE-----

--Sig_/.nQxN3ZK3C7V0nWgTK58+FS--
