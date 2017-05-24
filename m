Received: from eggs.gnu.org ([2001:4830:134:3::10]:42137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dDRuc-0003Fc-T2
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dDRuY-00024M-Sz
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:44:58 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:58392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dDRuY-00022A-M1
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:44:54 -0400
Received: from player718.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 6151984708
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 10:44:46 +0200 (CEST)
Date: Wed, 24 May 2017 10:44:42 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170524104442.0f5b0f45@bahia.ttt.fr.ibm.com>
In-Reply-To: <d74d2235-97e8-e529-9bf7-3e5c7b09830b@gaspard.io>
References: <149554993519.23396.2947622015408783770.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<149554996230.23396.14573553304393992709.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<5222368e-d0de-457b-7f07-5f104860ec56@redhat.com>
	<d74d2235-97e8-e529-9bf7-3e5c7b09830b@gaspard.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/g6SD=I81GApaF.w97UwfNMo";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2 4/4] 9pfs: local: metadata file for the
 VirtFS root
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leo Gaspard <leo@gaspard.io>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

--Sig_/g6SD=I81GApaF.w97UwfNMo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 24 May 2017 01:08:55 +0200
Leo Gaspard <leo@gaspard.io> wrote:

> On 05/23/2017 07:13 PM, Eric Blake wrote:> We have to block
> VIRTFS_META_DIR at any depth in the hierarchy, but
> > can/should we change the blocking of VIRTFS_META_ROOT_FILE to only
> > happen at the root directory, rather than at all directories?  On the
> > other hand, if you can simultaneously map /path/to/a for one mount
> > point, and /path/to/a/b for another, then the root file for B is visible
> > at a lower depth than the root file for A, and blocking the metafile
> > name everywhere means that the mount A can't influence the behavior on
> > the mount for B. =20
>=20
> If you take this kind of vulnerabilities into account, then you also
> have to consider a mix of mapped-file and mapped-attr mounts, or even
> worse a proxy with a mapped-file mount (which I think is currently
> vulnerable to this threat if the "proxy" path points above the
> "local,security_model=3Dmapped-file" path, as the check is done in
> "local_" functions, which are I guess not used for proxy-type virtfs)
>=20
> I'm clearly not saying it's an invalid attack (there is no explicit
> documentation stating it's insecure to "nest" virtual mounts"), just
> saying it's a much larger attack surface than one internal to virtfs
> mapped-file only. Then the question of what is reasonably possible to
> forbid to the user arises, and that's not one I could answer.
>=20

The attack surface is infinite. Untrusted code that could help a guest to
forge custom metadata may reside anywhere actually, not necessarily in
another QEMU-based guest...=20

My motivation to hide VIRTFS_META_ROOT_FILE everywhere was more for
consistency (ie. open(VIRTFS_META_ROOT_FILE) always fails, no matter
the cwd) and for simplicity.

Cheers,

--
Greg

> Cheers & HTH,
> Leo
>=20


--Sig_/g6SD=I81GApaF.w97UwfNMo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlklR/oACgkQAvw66wEB28KcPQCggWC0ExkMjY4Vcl6Jyz+pD+ch
O1oAn0m7pJ1n13h8G3/3qCmIbeiI9cBr
=yGyY
-----END PGP SIGNATURE-----

--Sig_/g6SD=I81GApaF.w97UwfNMo--
