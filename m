Received: from eggs.gnu.org ([2001:4830:134:3::10]:44346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dDS41-00070n-AX
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:54:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dDS3x-0006gi-BR
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:54:41 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:53087)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dDS3x-0006gU-5E
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:54:37 -0400
Received: from player718.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 8244B8D27C
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 10:54:35 +0200 (CEST)
Date: Wed, 24 May 2017 10:54:32 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170524105432.264f2e43@bahia.ttt.fr.ibm.com>
In-Reply-To: <c3f72497-76d9-7400-d701-0a6446463600@gaspard.io>
References: <149554993519.23396.2947622015408783770.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<c3f72497-76d9-7400-d701-0a6446463600@gaspard.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/i5dhahILfu4lYKvFoGgcRUc";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2 0/4] 9pfs: local: fix metadata of
 mapped-file security mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leo Gaspard <leo@gaspard.io>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

--Sig_/i5dhahILfu4lYKvFoGgcRUc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 24 May 2017 00:59:29 +0200
Leo Gaspard <leo@gaspard.io> wrote:

> On 05/23/2017 04:32 PM, Greg Kurz wrote:
> > v2: - posted patch for CVE-2017-7493 separately
> >     - other changes available in each patch changelog
> >=20
> > Leo,
> >=20
> > If you find time to test this series, I'll gladly add your Tested-by: to
> > it before merging. =20
>=20
> Just tested with a base of 2.9.0 with patches [1] [2] (from my
> distribution), [3] (required to apply cleanly) and this patchset.
>=20
> Things appear to work as expected, and .virtfs_metadata{,_root} appear
> to be neither readable nor writable by any user.
>=20

Shall I add your Tested-by: to the patch then ?

> That said, one thing still bothering me with the fix in [3] is that it
> still "leaks" the host's uid/gid to the guest when a corresponding file
> in .virtfs_metadata is not present (while I'd have expected it to appear
> as root:root in the guest), but that's a separate issue, and I guess
> retro-compatibility prevents any fixing it.
>=20

Heh, I had a tentative patch to create root:root credentials and 0700 mode
bits by default... but this could indeed break some setups, so I decided
not to post it.

> Thanks for these patches!

Thanks for the testing! :)

Cheers,

--
Greg

> Leo
>=20
>=20
> [1]
> https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/virtualiza=
tion/qemu/force-uid0-on-9p.patch
>=20
> [2]
> https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/virtualiza=
tion/qemu/no-etc-install.patch
>=20
> [3] https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg03663.html
>=20


--Sig_/i5dhahILfu4lYKvFoGgcRUc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlklSkgACgkQAvw66wEB28KK5ACgmINFNR5IqIWXH5hsxncz16lL
S4YAnAub4xYBpQ4BBE07b3Hg9uGAA3SU
=60Xx
-----END PGP SIGNATURE-----

--Sig_/i5dhahILfu4lYKvFoGgcRUc--
